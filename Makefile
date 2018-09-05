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
board 			:= h01r0
list_board		:= h0br4 h01r0 h0ar9 h07r3 h23r0 h1dr5 h1dr6

ifeq ($(filter $(board),$(list_board)),)
$(error Undefined board selection '$(board)', select one from list: $(list_board))
endif

BUILD_SYSTEM_DIR	:= .
HEXABITZ_DIR		:= ..
BOARD_NAME			:= $(board)
BINARY_NAME			:= $(BOARD_NAME)_gcc

# user code
USER_DIR			:= $(HEXABITZ_DIR)/$(BOARD_NAME)/User

# specific source code for a board
BOARD_DIR			:= $(HEXABITZ_DIR)/$(BOARD_NAME)/$(BOARD_NAME)

# BOS
BOS_DIR				:= $(HEXABITZ_DIR)/$(BOARD_NAME)/BOS

# thirdparty
THIRDPARTY_DIR		:= $(HEXABITZ_DIR)/$(BOARD_NAME)/Thirdparty

# middleware
MIDDLEWARE_DIR		:= $(THIRDPARTY_DIR)/Middleware
FREERTOS_DIR 		:= $(MIDDLEWARE_DIR)/FreeRTOS/Source

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
CC_DIRS				+= $(FREERTOS_DIR)/portable/GCC/ARM_CM0
CC_DIRS				+= $(CMSIS_DIR)/Device/ST/STM32F0xx/Source
CC_DIRS				+= $(CMSIS_DIR)/Device/ST/STM32F0xx/Source/Templates

# select heap file for FreeRTOS
FREERTOS_HEAP_DIR	:= $(FREERTOS_DIR)/portable/MemMang
CC_FILES			+= $(FREERTOS_HEAP_DIR)/heap_4.c

# list folder contains ASM language files
ASM_DIRS			+= $(BUILD_SYSTEM_DIR)/board/src

# include folders:
INC_DIRS			+= $(USER_DIR)
INC_DIRS			+= $(BOARD_DIR)
INC_DIRS			+= $(BOS_DIR)
INC_DIRS			+= $(FREERTOS_DIR)/CMSIS_RTOS
INC_DIRS			+= $(FREERTOS_DIR)/include
INC_DIRS			+= $(FREERTOS_DIR)/portable/GCC/ARM_CM0
INC_DIRS			+= $(HAL_DIR)/Inc/Legacy
INC_DIRS			+= $(HAL_DIR)/Inc
INC_DIRS			+= $(CMSIS_DIR)/Device/ST/STM32F0xx/Include
INC_DIRS			+= $(CMSIS_DIR)/Include

#INC_DIRS			+= $(COMPILER_DIR)/arm-none-eabi/include

# include board setting
include $(BUILD_SYSTEM_DIR)/board/make/$(BOARD_NAME).mk

# include build system to use common taget rules:
BUILD_SYSTEM		:= $(BUILD_SYSTEM_DIR)/common
include	$(BUILD_SYSTEM)/common.mk
