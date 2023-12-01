
# installation

### Adnvanced options -> Expert install
### Manual partitioning ( UEFI only )
create empty partition table: gpt  
512M partition | EFI system partition | 
Free space     | btrfs partition
### before install base system
1 - alt + f2

2 - df -h

/dev/sda2   /target

/dev/sda1   /target/boot/efi

3 

umount /target/boot/efi/
umount /target/

4 

mount /dev/sda2 /mnt/

cd mnt/

5 

mv @rootfs @

btrfs subvolume create @home

6

mount -o noatime,compress=zstd,subvol=@ /dev/sda2 /target/

7

mkdir -p /target/boot/efi/

mkdir -p /target/home

8

mount -o noatime,compress=zstd,subvol=@home /dev/sda2 /target/home

9

mount /dev/sda1 /target/boot/efi/

10

nano /target/etc/fstab

first UUID

add options noatime,compress=zstd,subvol=@

### back to installation alt + f1

### install the base system + ...

# console
dpkg-reconfigure console-setup
# zram + timeshift

sudo apt install zram-tools micro timeshift -y
timeshift --create --comments "base OS"

# Patches dwm

1 - create patches folder inside dwm
2 - download patches files (.diff)
3 - patch
```
patch -i patches/PATCH-FILE.diff
```
4 - rebuild
```
sudo make clean install
```
5 - quit dwm (Alt+shift+q) and login again


