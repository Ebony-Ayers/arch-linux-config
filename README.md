# arch-linux-config

Set of scripts to automate the installation of arch linux.

Run the following list of commands to download the scripts
```
$ pacman -Sy
$ pacman -S git
$ cd /tmp
$ git clone https://github.com/Ebony-Ayers/arch-linux-config/
$ cd arch-linux-config
```

### 01_initial_commands.sh
Set's ntp and disables swap

### 02_create_btrfs_partitions.sh
First command line argument is the partitian for the system. Warning: all data in it will be deleted.

Creates and mounts main btrfs partitions.

### 05_pacstrap.sh
Pacstrap, genfstab, and chroot into the new install.

### 06_update_pacman.sh
Enable multilib and local pacman data.

### 07_setup_time.sh
First command line argument is the time zone.

Set's time zone and generated locale

### 08_machine_name_and_network.sh
First command line argument is the machine name.

Set's machine's name and installs network manager.

### 09_initial_ram_disk.sh
Generates initial ram disk

### 10_grub.sh
First command line argument is the efi partition.

Installs grub.

### 11_graphics.sh
First command line argument is which CPU vendor to install micro code for. Options are "amd" or "intel".

Installs generic pacages: gcc, make, cmake, ccahce, base-devel, python

### 12_users.sh
First argument is username

Adds username as a user.

### 13_unmount_and_finish.sh
Unmounts all partitions.
