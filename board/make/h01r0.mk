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

# setting compiler option
CC_OPT			+= -DH01R0 -D_module=1
# -D_TIME_T_DECLARED
ASM_OPT			+=
LD_OPT			+=

# general setting compiler option
# linker file
LINKER_FILE			:= $(BUILD_SYSTEM_DIR)/board/linker/STM32F091CBTx_FLASH.ld

# setting compiler option
CC_OPT			+= -march=armv6-m -mcpu=cortex-m0 -c -g -O0 -mthumb -std=c99 -Wall $(INC_DIR) -DUSE_HAL_DRIVER -DSTM32F091xC
ASM_OPT			+= -march=armv6-m -mcpu=cortex-m0 -c -mthumb --defsym __STARTUP_CLEAR_BSS=1 --defsym __STACK_SIZE=0x200 --defsym __HEAP_SIZE=0x100
LD_OPT			+= -T $(LINKER_FILE) -Map $(BUILD_DIR)/bin/$(BINARY_NAME).map $(OBJECT_FILE) -L $(COMPILER_DIR)/arm-none-eabi/lib/thumb/v6-m -lc_nano -lnosys -L $(COMPILER_DIR)/lib/gcc/arm-none-eabi/7.3.1/thumb/v6-m -lgcc
