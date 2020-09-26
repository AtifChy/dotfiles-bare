# Ibus KDE
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# start ibus-deamon on boot
ibus-daemon -drx
