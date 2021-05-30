sudo dd bs=4M if=$1 of=$2 conv=fsync oflag=direct status=progress
