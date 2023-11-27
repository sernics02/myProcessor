CC=iverilog
PROGNAME=program

OBJS = pc_tb.v pc.v microc.v uc.v alu.v memprog.v componentes.v
all: ${OBJS}
	$(CC) -o $(PROGNAME) ${OBJS}

clean:
	rm -rf *.vcd $(PROGNAME)