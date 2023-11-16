module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
    //Microcontrolador sin memoria de datos de un solo ciclo

    wire[15:0] instruction;
    wire[9:0] new_pc, actual_pc, jump_addr, add_value, value_one;
    wire[7:0] inmediate, WD3, RD1, RD2;
    wire[3:0] RA1, RA2, WA3;

    // Program Counter Changes
    assign value_one = 10'b0000000001;
    sum increment_pc(add_value, value_one, actual_pc);
    mux2 mux_pc(new_pc, jump_addr, add_value, s_inc);

    // Program Counter
    registro pc(actual_pc, clk, reset, new_pc);

    // Instruction Memory
    memprog ProgramMemory(instruction, clk, actual_pc);

    // Values Assignations
    assign Opcode = instruction[15:10];
    assign RA1 = instruction[11:8];
    assign RA2 = instruction[7:4];
    assign WA3 = instruction[3:0];
    assign inmediate = instruction[11:4];

    // Selection first register
    wire[3:0] out_mux_reg;
    mux2 outMuxReg(out_mux_reg, RA1, WA3, s_inm);

    // Register bank
    regfile regfile(RD1, RD2, clk, we, wez, out_mux_reg, RA2, WA3, WD3);

    // ALU
    wire[7:0] out_alu_mux;
    wire zero;
    mux mux_alu(out_alu_mux, RD2, inmediate, s_inm);
    alu estrellita(WD3, zero, RD1, out_alu_mux, ALUOp);
endmodule 