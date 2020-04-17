#Makefile
CC = gcc
INCLUDE = /usr/lib
LIBS = -lcrypto -lssl
OBJS = 
CFLAGS = -g 
all: clean dfs dfc start run

dfs:
	$(CC) -o bin/dfs -Iheaders headers/*.c dfs.c $(CFLAGS) $(LIBS)

dfc:
	$(CC) -o bin/dfc -Iheaders headers/*.c dfc.c $(CFLAGS) $(LIBS)

kill:
	fuser -k {9001,9002,9003,9004}/tcp

clear:
	rm -rf DFS*/*

clean:
	rm -rf bin
	mkdir -p bin

start:
	bin/dfs /DFS1 9001 &> logs/dfs1.log &
	bin/dfs /DFS2 9002 &> logs/dfs2.log &
	bin/dfs /DFS3 9003 &> logs/dfs3.log &
	bin/dfs /DFS4 9004 &> logs/dfs4.log &
	
run:
	tail -f logs/dfs*

dc:
	rm bin/dfc
	$(CC) -o bin/dfc -Iheaders headers/*.c dfc.c $(CFLAGS) $(LIBS)
	gdb -tui bin/dfc --args bin/dfc conf/dfc.conf 2> logs/client.log

ds:
	rm bin/dfs
	$(CC) -o bin/dfs -Iheaders headers/*.c dfs.c $(CFLAGS) $(LIBS)
	gdb -tui bin/dfs --args bin/dfs /DFS1 10001

client:
	rm bin/dfc
	$(CC) -o bin/dfc -Iheaders headers/*.c dfc.c $(CFLAGS) $(LIBS)
	bin/dfc conf/dfc.conf 2> logs/dfc.log

