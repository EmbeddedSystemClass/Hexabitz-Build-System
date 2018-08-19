#
# The MIT License (MIT)
#
# Copyright (c) 2018 Anh Vo Tuan <votuananhs@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
# is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies
# or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
# AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#

# board support
board 			:= h1dr5
list_board		:= h0br4 h01r0 h0ar9 h07r3 h23r0 h1dr5

ifeq ($(filter $(board),$(list_board)),)
$(error Undefined board selection '$(board)', select one from list: $(list_board))
endif

BUILD_SYSTEM_DIR	:= .
HEXABITZ_DIR		:= ..
BOARD_NAME			:= $(board)
BINARY_NAME			:= $(BOARD_NAME)_gcc

# User
USER_DIR			:= $(HEXABITZ_DIR)/$(BOARD_NAME)/User

# specific source code for a board
BOARD_DIR			:= $(HEXABITZ_DIR)/$(BOARD_NAME)/$(BOARD_NAME)

# BOS
BOS_DIR				:= $(HEXABITZ_DIR)/$(BOARD_NAME)/BOS

# Thirdparty
THIRDPARTY_DIR		:= $(HEXABITZ_DIR)/$(BOARD_NAME)/Thirdparty

# middleware
MIDDLEWARE_DIR		:= $(THIRDPARTY_DIR)/Middleware
FREERTOS_DIR 		:= $(MIDDLEWARE_DIR)/FreeRTOS/Source
FREERTOS_DIR_ 		:= $(BUILD_SYSTEM_DIR)/freertos/FreeRTOSV8.2.1/FreeRTOS/Source

# hal library
HAL_DIR				:= $(THIRDPARTY_DIR)/STM32F0xx_HAL_Driver

# CMSIS
CMSIS_DIR			:= $(THIRDPARTY_DIR)/CMSIS

# output building folder
BUILD_DIR 			:= $(BUILD_SYSTEM_DIR)/output

# list folder contains C language files
CC_DIRS				+= $(BOS_DIR)
CC_DIRS				+= $(BOARD_DIR)
CC_DIRS				+= $(HAL_DIR)/Src
CC_DIRS				+= $(USER_DIR)
CC_DIRS				+= $(FREERTOS_DIR)
CC_DIRS				+= $(FREERTOS_DIR)/CMSIS_RTOS
CC_DIRS				+= $(FREERTOS_DIR_)/portable/GCC/ARM_CM0
CC_DIRS				+= $(CMSIS_DIR)/Device/ST/STM32F0xx/Source

# select heap file for FreeRTOS
FREERTOS_HEAP_DIR	:= $(FREERTOS_DIR)/portable/MemMang
CC_FILES			+= $(FREERTOS_HEAP_DIR)/heap_4.c

# list folder contains ASM language files
ASM_DIRS			+= $(BUILD_SYSTEM_DIR)/src

# include folders:
INC_DIRS			+= $(COMPILER_DIR)/arm-none-eabi/include
INC_DIRS			+= $(BOS_DIR)
INC_DIRS			+= $(BOARD_DIR)
INC_DIRS			+= $(HAL_DIR)/Inc
INC_DIRS			+= $(USER_DIR)
INC_DIRS			+= $(FREERTOS_DIR)/include
INC_DIRS			+= $(FREERTOS_DIR)/CMSIS_RTOS
INC_DIRS			+= $(FREERTOS_DIR_)/portable/GCC/ARM_CM0
INC_DIRS			+= $(CMSIS_DIR)/Device/ST/STM32F0xx/Include
INC_DIRS			+= $(CMSIS_DIR)/Include

# linker file
LINKER_FILE			:= $(BUILD_SYSTEM_DIR)/board/linker/STM32F091CBTx_FLASH.ld


# setting compiler option
CC_OPT			+= -march=armv6-m -mcpu=cortex-m0 -c -g -mthumb $(INC_DIR) -DUSE_HAL_DRIVER -DSTM32F091xC -D_module=1
ASM_OPT			+= -march=armv6-m -mcpu=cortex-m0 -c -mthumb --defsym __STARTUP_CLEAR_BSS=1 --defsym __STACK_SIZE=0x200 --defsym __HEAP_SIZE=0x100
LD_OPT			+= -T $(LINKER_FILE) -Map $(BUILD_DIR)/bin/$(BINARY_NAME).map $(OBJECT_FILE) -L $(COMPILER_DIR)/arm-none-eabi/lib/thumb/v6-m -lc_nano -lnosys -L $(COMPILER_DIR)/lib/gcc/arm-none-eabi/7.3.1/thumb/v6-m -lgcc

# include board setting
include $(BUILD_SYSTEM_DIR)/board/make/$(BOARD_NAME).mk

# include build system to use common taget rules:
BUILD_SYSTEM		:= $(BUILD_SYSTEM_DIR)/common_make
include	$(BUILD_SYSTEM)/common.mk
