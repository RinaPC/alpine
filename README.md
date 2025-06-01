# Alpine
Alpine Linux install (BTRFS + EFI Boot Stub)

```
setup-alpine
```

```
apk add btrfs-progs efibootmgr
modprobe btrfs
```

```
mkfs.vfat -F 32 /dev/sda1
mkfs.btrfs -L alpine /dev/sda2
mount /dev/sda2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshot
umount /mnt
mount -o noatime,compress=zstd,space_cache=v2,subvol=@ /dev/sda2 /mnt
mkdir /mnt/home /mnt/snapshot /mnt/boot
mount -o noatime,compress=zstd,space_cache=v2,subvol=@home /dev/sda2 /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,subvol=@snapshot /dev/sda2 /mnt/snapshot
mount /dev/sda1 /mnt/boot
```

```
vi /etc/apk/repositories
BOOTLOADER=none setup-disk -s 0 -k edge /mnt
```

```
params="root=/dev/sda2 rootfstype=btrfs rootflags=subvol=@ rw modules=sd-mod,usb-storage,btrfs initrd=\intel-ucode.img initrd=\initramfs-edge"
efibootmgr --create --disk /dev/sda --part 1 --loader /vmlinuz-edge --label "Alpine Linux" --unicode "${params}" --verbose
```

```
wget https://raw.githubusercontent.com/RinaPC/alpine/main/efi.sh
```

```
btrfs subvolume snapshot / /snapshot/install
```

```
vi /etc/doas.conf
permit persist :wheel
```

setup-wayland-base (Installs and enables elogind, enable udev)
```
// setup-wayland-base
setup-devd udev
```

```
apk add sway seatd font-dejavu foot
apk add nano nano-syntax e2fsprogs dosfstools mesa-dri-gallium mesa-va-gallium intel-media-driver dbus
apk add bash bash-completion fastfetch lm-sensors btop openssh-client-default
apk add pipewire pipewire-pulse wireplumber mpv firefox fcitx5-hangul fuzzel swaybg swayidle swaylock font-awesome adwaita-icon-theme
apk add mousepad thunar exo xarchiver 7zip galculator grim slurp
```

```
rc-update add seatd
adduser $USER seat
```

```
wget https://raw.githubusercontent.com/RinaPC/alpine/main/.profile
```

```
apk add bash bash-completion syncthing bluez rtkit pcituils
```
