obj-m += applespi.o

KVERSION := $(KERNELRELEASE)
ifeq ($(origin KERNELRELEASE), undefined)
KVERSION := $(shell uname -r)
endif
KDIR := $(KERNEL_DIR)
ifeq ($(origin KERNEL_DIR), undefined)
KDIR := /lib/modules/$(KVERSION)/build
endif
PWD := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

install:
	$(MAKE) -C $(KDIR) M=$(PWD) modules_install

test: all
	sync
	-rmmod applespi
	insmod ./applespi.ko
