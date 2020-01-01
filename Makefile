COMPILER ?= gcc
UNAME ?= $(shell uname)

SRCS = \
  dap.c \
  edbg.c \
  target.c \
  target_atmel_cm0p.c \
  target_atmel_cm3.c \
  target_atmel_cm4.c \
  target_atmel_cm7.c \
  target_atmel_cm4v2.c \
  target_mchp_cm23.c \
  target_st_stm32g0.c \
  target_gd_gd32f4xx.c \

HDRS = \
  dap.h \
  dbg.h \
  edbg.h \
  target.h

ifeq ($(UNAME), Linux)
  BIN = edbg
  SRCS += dbg_lin.c
  LIBS += -ludev
else
  ifeq ($(UNAME), Darwin)
    BIN = edbg
    SRCS += dbg_mac.c
    LIBS += hidapi/mac/.libs/libhidapi.a
    LIBS += -framework IOKit
    LIBS += -framework CoreFoundation
    HIDAPI = hidapi/mac/.libs/libhidapi.a
    CFLAGS += -Ihidapi/hidapi
  else
    BIN = edbg.exe
    SRCS += dbg_win.c
    LIBS += -lhid -lsetupapi
  endif
endif

CFLAGS += -W -Wall -Wextra -O2 -std=gnu11

all: $(BIN)

$(BIN): $(SRCS) $(HDRS)
	$(COMPILER) $(CFLAGS) $(SRCS) $(LIBS) -o $(BIN)

clean:
	rm -rvf $(BIN)

