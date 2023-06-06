#include <linux/module.h>  
#include <linux/kernel.h>  
#include <linux/init.h>
#include <linux/kexec.h>


MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Kimage Manipulation");

static int __init kimage_init(void)
{
	struct kimage *image;
	image = kexec_image;
	if(!image) {
		printk(KERN_INFO "Image Found\n");
	}
	image = kexec_crash_image;
	if(!image) {
		printk(KERN_INFO "Crash Image Found\n");
	}
	printk(KERN_INFO "Hello world\n");
	return 0;
}

static void __exit kimage_exit(void)
{
    printk(KERN_INFO "bye bye world\n");
}

module_init(kimage_init);
module_exit(kimage_exit);
