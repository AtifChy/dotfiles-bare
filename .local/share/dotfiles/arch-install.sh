#!/bin/sh

set -e

printf "Do you wish to install this program? [y/n] "
read -r input
case $input in
        [Yy]*) echo "Ok, Let's continue" ;;
        [Nn]*) exit ;;
        *) echo "Please answer yes or no." ;;
esac

printf "user name (lower case) = "
read -r user_name

printf "country (for mirror) [e.g. Bangladesh] = "
read -r country

printf "time zome [e.g. Asia/Dhaka] = "
read -r time_zone

printf "Do you wish to create new partitions? [y/n] "
read -r partition
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
printf "root partition [e.g. /dev/sda2] = "
read -r root_disk
printf "efi partition [e.g. /dev/sda1] = "
read -r efi_disk

printf "Do you want to create home partition? [y/n] "
read -r home_ask
case $home_ask in
        [Yy]*)
                printf "home partition [e.g. /dev/sda3] = "
                read -r home_disk
                ;;
        *) echo 'skipping' ;;
esac

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

# get mirror
reflector -c "$country" --save /etc/pacman.d/mirrorlist

echo "Starting Installation. Press Enter to Continue..."
read -r
pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware reflector git neovim xclip networkmanager intel-ucode

genfstab -U /mnt >>/mnt/etc/fstab

arch-chroot /mnt ln -sf /usr/share/zoneinfo/"$time_zone" /etc/localtime
arch-chroot /mnt hwclock --systohc
sed -i '/#en_US.UTF-8/s/^#//g' /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" >/mnt/etc/locale.conf
echo "KEYMAP=us" >/mnt/etc/vconsole.conf
echo "archlinux" >/mnt/etc/hostname
tee -a <<END >>/mnt/etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1 	archlinux.localdomain 	archlinux
END

arch-chroot /mnt passwd

arch-chroot /mnt useradd -mG wheel,network,audio,kvm,optical,storage,video "$user_name"
arch-chroot /mnt passwd "$user_name"
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /mnt/etc/sudoers

arch-chroot /mnt pacman -Syu --noconfirm efibootmgr dialog mtools dosfstools openssh wget curl nano pacman-contrib bash-completion usbutils lsof dmidecode zip unzip unrar p7zip lzop rsync traceroute bind-tools ntfs-3g exfat-utils gptfdisk fuse2 fuse3 fuseiso alsa-utils alsa-plugins xorg-server xorg-xinit gsfonts sdl_ttf ttf-bitstream-vera ttf-dejavu ttf-liberation xorg-fonts-type1 ttf-fira-code ttf-fira-sans ttf-hack xf86-input-libinput xf86-video-amdgpu gst-plugins-base gst-plugins-good gst-plugins-ugly gst-libav ttf-nerd-fonts-symbols ttf-jetbrains-mono --needed

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
                        exit 1
                        ;;
        esac
done

arch-chroot /mnt mkinitcpio -P

echo "Reboot"
