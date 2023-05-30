#! /bin/sh

BASE_DIR=$PWD/initramfs
FILE=`realpath $1`

if [ $# -lt 1 ]
then
	echo "Usage `basename $0` <source_initrd>"
	exit 1
fi

rm -rf $BASE_DIR

mkdir $BASE_DIR

cd $BASE_DIR

echo  "#include <stdio.h>
	int main() {printf(\"Hello from custom initramfs\n \");		\
	return 0;}\
	" >> hello.c
gcc -o hello hello.c

rm hello.c

cp $FILE initramfs.gz

#mv initramfs-`uname -r`.img initramfs.gz
if gzip -t initramfs.gz; 
then
	echo 'file is gzip archive'
	gunzip initramfs.gz
else 
	echo 'file is not gzip assuming cpio archive'
	mv initramfs.gz initramfs
fi

mkdir tmp

cd tmp

cpio -id < ../initramfs

mv ../hello usr/bin/

tree usr/bin

find . | cpio --create --format='newc' > ../newinitramfs

cd ..

gzip newinitramfs

mv newinitramfs.gz ../newinitramfs.img


rm -rf ../initramfs
