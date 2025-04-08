#
TARGET = my_first_hps-fpga

#
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = /mnt/c/intelFPGA/17.1/embedded/ip/altera/hps/altera_hps/hwlib/include
CROSS_COMPILE = /mnt/c/Users/01/cross/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
CFLAGS = -nostartfiles -g -Wall  -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)
LDFLAGS =  -g -Wall
CC = $(CROSS_COMPILE)gcc
ARCH= arm

build: $(TARGET)
$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@  
%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~ 
