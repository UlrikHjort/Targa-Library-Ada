EXE = tga_test
ADA_VERSION = -gnat05
SRC = Tga_test.adb
FLAGS = -gnato -gnatwa -fstack-check
AR = ar
LIB_SRC = Tga_Lib.adb
OBJ_OUT = tga_lib.o
LIB = libtarga.a
LIB_FLAGS = rcs

all: test

obj:
	gnatmake -c $(LIB_SRC) $(FLAGS) -o $(OBJ_OUT)

lib: obj
	$(AR) $(LIB_FLAGS) $(LIB) $(OBJ_OUT) 


test: lib
	gnatmake $(FLAGS) -L. -ltarga $(SRC) -o $(EXE)

ada83: 
	gnatmake -gnat83 $(FLAGS) $(SRC)

ada95: 
	gnatmake -gnat95 $(FLAGS) $(SRC)

ada2005: 
	gnatmake -gnat05 $(FLAGS) $(SRC)

ada2012: 
	gnatmake -gnat12 $(FLAGS) $(SRC)

clean:
	rm *.ali *~ *.o *.a *.tga $(EXE)