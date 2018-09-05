1. Introduction:
- Hexabitz's build system will use Makefile and GCC compiler.
- It will support all Hexabitz modules.

2. Structure of Hexabitz's build system:

board           : will include board specific such as: linker file/ header and source of board
    |- inc      :
    |- linker   :
    |- make     :
    |- src      :
common          : just include common makefile of the system, it will contain all of rules to build
                    for Hexabitz board.
Makefile        : define list of boards will be supported in the build system.
                    You need to update variable of Makfile "HEXABITZ_DIR" corresponding the hexabitz folder in your PC. The folder will contain modules: h0br4, h01r0, h0ar9, h07r3,h23r0, h1dr5, ...



