
CC = arm-linux-gnueabihf-gcc
CXX = arm-linux-gnueabihf-g++
STRIP = arm-linux-gnueabihf-strip

DEP_DIR ?=$(shell pwd)/../dependency


LIBRARY_INC = $(DEP_DIR)/release/include/cust_inc
LIBRARY_DIR = $(DEP_DIR)/release/nvr/i2m/common/glibc/8.2.1/cust_libs


TARGET = sdlpal
#HOST = arm-linux-
SOURCES = . ./adplug
CFILES = $(foreach dir, $(SOURCES), $(wildcard $(dir)/*.c))
CPPFILES = $(foreach dir, $(SOURCES), $(wildcard $(dir)/*.cpp))
OFILES = $(CFILES:.c=.o) $(CPPFILES:.cpp=.o)


CFLAGS = -Wall -g -DDINGOO -mtune=arm926ej-s -march=armv5te
CFLAGS+=-I$(LIBRARY_INC) -I$(LIBRARY_INC)/SDL 

CXXFLAGS = $(CFLAGS)

LDFLAGS += -lm -lz -lstdc++ -lSDL #-lssgfx 
LDFLAGS += -lmi_common -lmi_sys -lmi_disp -lmi_panel -lmi_gfx -lmi_divp -lmi_ao -lmad

LDFLAGS+= -L$(DEP_DIR)/release/nvr/i2m/common/glibc/8.2.1/mi_libs/dynamic
LDFLAGS+= -L$(DEP_DIR)/release/nvr/i2m/common/glibc/8.2.1/ex_libs/dynamic
LDFLAGS+=-L$(LIBRARY_DIR)/dynamic/

$(TARGET): $(OFILES)
	$(CXX) $(OFILES) -g -o $@ $(LDFLAGS)
	#$(STRIP) $@

%.o: %.c
	$(CC) $(CFLAGS) -g -c $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -g -c $< -o $@

clean:
	rm -f $(TARGET) $(OFILES)


install:
	echo do nothing for install
