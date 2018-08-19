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

# UDP library
FREERTOS_UPD_DIR	:= $(MIDDLEWARE_DIR)/FreeRTOS-Plus-UDP

# list folder contains C language files
CC_DIRS				+= $(FREERTOS_UPD_DIR)
CC_DIRS				+= $(FREERTOS_UPD_DIR)/portable/BufferManagement
CC_DIRS				+= $(FREERTOS_UPD_DIR)/portable/NetworkInterface/enc28j60

# include folders:
INC_DIRS			+= $(FREERTOS_UPD_DIR)/include
INC_DIRS			+= $(FREERTOS_UPD_DIR)/portable/Compiler/GCC

# setting compiler option
CC_OPT			+= -DH1DR5 -D_module=1
ASM_OPT			+=
LD_OPT			+=
