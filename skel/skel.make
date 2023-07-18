# make

CC = gcc
CFLAGS += -Wall
CFLAGS += -g
#CFLAGS += -O3
OBJS = *
TARGET = *

.SUFFIXES: .c .o

all: $(TARGET)

$(TARGET) : $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(CFLAGS)

.c.o : $*.c
	$(CC) -c $*.c $(CFLAGS)

clean:
	rm -f $(OBJS)

# Local Variables:
# mode: Makefile
# End:
