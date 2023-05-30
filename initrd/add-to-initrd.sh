#! /bin/sh

BASE_DIR=$PWD/initrd

mkdir $BASE_DIR

cd $BASE_DIR

echo  "#include <stdio.h>
	int main() {printf(\"Hello from custom initramfs\n \");		\
	return 0;}\
	" >> hello.c
gcc -o hello hello.c

rm hello.c

cp /boot/initramfs-`uname -r`.img initramfs.gz

#mv initramfs-`uname -r`.img initramfs.gz

gunzip initramfs.gz

mkdir tmp

cd tmp

cpio -id < ../initramfs

mv ../hello usr/bin/

find . | cpio --create --format='newc' > ../newinitramfs

cd ..

gzip newinitramfs

mv newinitramfs.gz newinitramfs.img
