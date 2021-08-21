#!/bin/sh

set -euo pipefail

read -rp "Do you wish to install this program? [y/n] " input
case $input in
        [Yy]*) echo "Ok, Let's continue" ;;
        [Nn]*) exit ;;
        *) echo "Please answer yes or no." ;;
esac

read -rp "user name (lower case) = " user_name

read -rp "host name (lower case) [e.g. archlinux] = " _hostname

read -rp "country (for mirror) [e.g. Bangladesh] = " country

read -rp "time zome [e.g. Asia/Dhaka] = " time_zone

read -rp "Do you wish to create new partitions? [y/n] " partition
case $partition in
        [Yy]*)
                echo "Don't forget to set proper type for EFI partition!"
                cfdisk
                ;;
        [Nn]*) echo 'skipping' ;;
        *)
                echo "Please answer yes or no."
                exit
                ;;
esac

lsblk
read -rp "root partition [e.g. /dev/sda2] = " root_disk
read -rp "efi partition [e.g. /dev/sda1] = " efi_disk

read -rp "Do you want to create home partition? [y/n] " home_ask
[ "$home_ask" = 'y' ] && read -rp "home partition [e.g. /dev/sda3] = " home_disk

mkfs.ext4 -L 'Archlinux' "$root_disk"
mount "$root_disk" /mnt

if [ "$home_disk" ]; then
        mkfs.ext4 -L "Home" "$home_disk"
        mkdir /mnt/home
        mount "$home_disk" /mnt/home
fi

mkfs.fat -F32 -n 'EFI' "$efi_disk"
mkdir /mnt/boot
mount "$efi_disk" /mnt/boot

read -rp "Do you want to create a swapfile? [y/n]" swapfile
if [ "$swapfile" ]; then
        mkdir /mnt/swap
        dd if=/dev/zero of=/mnt/swap/swapfile bs=1M count=4096 status=progress
        chmod 600 /mnt/swap/swapfile
        mkswap /mnt/swap/swapfile
fi

# get mirror
reflector -c "$country" --save /etc/pacman.d/mirrorlist

echo "Starting Installation. Press \033[1;34mEnter\033[0m to Continue..."
read -r _

# trap
trap 'echo "\n\033[1;33mWARNING: \033[1;39mLet the script finish..."' SIGINT
pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware reflector git neovim xclip networkmanager intel-ucode

genfstab -U /mnt >>/mnt/etc/fstab
[ "$swapfile" ] && tee -a /mnt/etc/fstab >/dev/null <<'END'

#swapfile
/swap/swapfile 		none 		swap 		defaults 	0 0
END

arch-chroot /mnt ln -sf /usr/share/zoneinfo/"$time_zone" /etc/localtime
arch-chroot /mnt hwclock --systohc
sed -i '/#en_US.UTF-8/s/^#//g' /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" >/mnt/etc/locale.conf
echo "KEYMAP=us" >/mnt/etc/vconsole.conf
echo "${_hostname}" >/mnt/etc/hostname
tee -a /mnt/etc/hosts >/dev/null <<END
127.0.0.1	localhost
::1		localhost
127.0.1.1 	${_hostname}.localdomain 	${_hostname}
END

arch-chroot /mnt passwd

arch-chroot /mnt useradd -mG wheel,network,audio,kvm,optical,storage,video "$user_name"
arch-chroot /mnt passwd "$user_name"
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /mnt/etc/sudoers

arch-chroot /mnt pacman -Syu --noconfirm efibootmgr dialog mtools dosfstools wget curl nano pacman-contrib bash-completion usbutils lsof dmidecode p7zip ntfs-3g alsa-utils sx xorg-server xorg-xinit gsfonts sdl_ttf ttf-bitstream-vera ttf-dejavu ttf-liberation xorg-fonts-type1 ttf-fira-code ttf-fira-sans ttf-hack xf86-input-libinput xf86-video-amdgpu gst-plugins-base gst-plugins-good gst-plugins-ugly gst-libav ttf-nerd-fonts-symbols ttf-jetbrains-mono zsh --needed

tee /mnt/etc/zsh/zshenv >/dev/null <<'END'
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh
END

tee -a /mnt/etc/ssh/ssh_config >/dev/null <<END
Host *
   IdentityFile ~/.config/ssh/id_rsa
   IdentityFile ~/.config/ssh/id_dsa
   IdentityFile ~/.config/ssh/id_ecdsa
   IdentityFile ~/.config/ssh/id_ed25519
   UserKnownHostsFile ~/.config/ssh/known_hosts
END

tee /mnt/etc/sysctl.d/99-swappiness.conf >/dev/null <<END
vm.swappiness=10
END

###########################################################
##############          Bootloader          ###############
###########################################################
while :; do
        printf "Choose your bootloader\n1) systemd-boot\n2) grub\n?#"
        read -r input
        case $input in
                1 | systemd-boot)
                        arch-chroot /mnt bootctl --esp-path=/boot install

                        tee /mnt/boot/loader/loader.conf >/dev/null <<-END
			default 	arch-1.conf
			#timeout 	5
			#console-mode 	keep
			editor 		yes
			END

                        tee /mnt/boot/loader/entries/arch-1.conf >/dev/null <<-END
			title 		Arch Linux, with linux-zen
			linux 		/vmlinuz-linux-zen
			initrd 		/intel-ucode.img
			initrd 		/initramfs-linux-zen.img
			options 	root="LABEL=Archlinux" rw
			END

                        tee /mnt/boot/loader/entries/arch-2.conf >/dev/null <<-END
			title 		Arch Linux, with linux-zen (fallback initramfs)
			linux 		/vmlinuz-linux-zen
			initrd 		/intel-ucode.img
			initrd 		/initramfs-linux-zen-fallback.img
			options 	root="LABEL=Archlinux" rw
			END

                        echo "Setting up Pacman hook for automatic systemd-boot updates"
                        mkdir -p /mnt/etc/pacman.d/hooks/
                        tee /mnt/etc/pacman.d/hooks/100-systemd-boot.hook >/dev/null <<-END
			[Trigger]
			Type = Package
			Operation = Upgrade
			Target = systemd

			[Action]
			Description = Updating systemd-boot
			When = PostTransaction
			Exec = /usr/bin/bootctl update
			END

                        break
                        ;;
                2 | grub)
                        arch-chroot /mnt pacman -Syu --noconfirm grub os-prober
                        arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
                        arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
                        break
                        ;;
                *)
                        echo "Invalid option"
                        ;;
        esac
done

arch-chroot /mnt mkinitcpio -P

echo "Reboot"
