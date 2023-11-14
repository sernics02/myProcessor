module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
    //Microcontrolador sin memoria de datos de un solo ciclo

    // Left side of the microcontroller
    reg[9:0] ZERO = 10'b0000000000;
    reg[9:0] ONE = 10'b0000000001;
    wire[9:0] PC, newPC, outPCSum;
    wire[15:0] Instruction;
    wire[9:0] DirSalto;
    // module mux2 #(parameter WIDTH = 8)
    //          (output wire [WIDTH-1:0] Y,      // Salida del multiplexor
    //           input  wire [WIDTH-1:0] D0, D1, // Entradas del multiplexor
    //           input  wire             s);     // Selección

    sum sumPC(outPCSum, PC, ONE);
    assign Opcode = [15:10] Instruction;
    assign DirSalto = [9:0] Instruction;
    mux muxPC(newPC, DirSalto, outPCSum, s_inc);

    // Right side of the microcontroller
    wire[3:0] RA1, WA3, RA2;
    wire[7:0] Inm;
    wire[3:0] outMuxRA1WA3;
    wire[7:0] RD1, RD2;
    mux muxRegistro(outMuxRA1WA3, RA1, WA3, s_inm);
    regfile bancoRegistros(RD1, RD2);
endmodule
