BINARYNAME = fsbl
BUILDDIR = build

OPTFLAG = -O0

EXTLIBDIR = ../../third-party
SHAREDDIR = ../../shared

SOURCES = startup_stm32mp15x_ca7_azurertos.c \
		  system_stm32mp15x_A7_azurertos.c \
		  syscalls.c \
		  main.cc \
		  tx_initialize_low_level.S \
		  $(wildcard $(EXTLIBDIR)/threadx/common/src/*.c) \
		  $(wildcard $(EXTLIBDIR)/threadx/ports/cortex_a7/gnu/src/*.S) \
		  $(SHAREDDIR)/system/mmu_ca7.c \
		  $(SHAREDDIR)/system/libc_stub.c \
		  $(SHAREDDIR)/system/libcpp_stub.cc \
		  $(SHAREDDIR)/print.cc \
		  $(EXTLIBDIR)/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_usart.c \
		  $(EXTLIBDIR)/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_rcc.c \
		  $(EXTLIBDIR)/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal.c \
		  $(EXTLIBDIR)/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_sdmmc.c \
		  $(EXTLIBDIR)/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_sd.c \
		  $(EXTLIBDIR)/CMSIS/Core_A/Source/irq_ctrl_gic.c \
		  ddr/stm32mp1_ddr.cc \
		  ddr/stm32mp1_ram.cc \
		  ddr/ram_tests.cc \
		  uboot-port/common/memsize.c \
		  uboot-port/lib/crc32.c \
		  
		 

INCLUDES = -I. \
		   -I$(EXTLIBDIR)/STM32MP1xx_HAL_Driver/Inc \
		   -I$(EXTLIBDIR)/CMSIS/Core_A/Include \
		   -I$(EXTLIBDIR)/CMSIS/Device/ST/STM32MP1xx/Include \
		   -I$(SHAREDDIR) \
		   -I$(SHAREDDIR)/system \
		   -Iddr/ \
		   -Iuboot-port/include \
		   -Iuboot-port/arch/arm/include \
		   -I$(EXTLIBDIR)/threadx/common/inc \
		   -I$(EXTLIBDIR)/threadx/ports/cortex_a7/gnu/inc \
		   -I$(EXTLIBDIR)/CMSIS/Device/ST/STM32MP1xx/Include \
		   

all: image

include $(SHAREDDIR)/makefile-common.mk

SD_DISK_DEV ?= /dev/sdc

image: $(BIN)
	python3 fsbl_header.py $(BUILDDIR)/$(BINARYNAME).bin $(BUILDDIR)/$(BINARYNAME).stm32
	@ls -l $(BUILDDIR)/$(BINARYNAME).stm32

load: image
	@read -p "What is the disk device (Enter for $(SD_DISK_DEV)): " DISK && \
	DISK=$${DISK:-$(SD_DISK_DEV)} && \
	echo "Writing to $${DISK}1 and $${DISK}2" && \
	sudo dd if=$(BUILDDIR)/$(BINARYNAME).stm32 of=$${DISK}1 && \
	sudo dd if=$(BUILDDIR)/$(BINARYNAME).stm32 of=$${DISK}2 && \
	sudo umount $${DISK}1 $${DISK}2


