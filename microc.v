module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
    //Microcontrolador sin memoria de datos de un solo ciclo

    wire[15:0] instruction;
    wire[9:0] new_pc, actual_pc, jump_dir;
    wire[7:0] inmediate, WD3;
    wire[3:0] RA1, RA2, WA3;

    // Program Counter Increment
    wire[9:0] outSumPC;
    sum sumPC(outSumPC, actual_pc, 10'b0000000001);

    // Mux PC
    assign jump_dir = instruction[9:0];
    mux2 #(10) muxPC(new_pc, outSumPC, jump_dir, s_inc);

    // Program Counter
    registro #(10) pc(actual_pc, clk, reset, new_pc);

    // Instruction Memory
    memprog ProgramMemory(instruction, clk, actual_pc);

    // Values Assignations
    assign Opcode = instruction[15:10];
    assign RA1 = instruction[11:8];
    assign RA2 = instruction[7:4];
    assign WA3 = instruction[3:0];
    assign inmediate = instruction[11:4];

    // Selection first register
    wire[3:0] out_mux_files;
    mux2 #(4) mux_files(out_mux_files, RA1, WA3, s_inm);

    // Register bank
    wire[7:0] RD1, RD2;
    regfile registerBank(RD1, RD2, clk, we, out_mux_files, WA3, RA2, WD3);

    // ALU
    wire[7:0] out_alu_mux;
    mux2 #(8) mux_alu(out_alu_mux, RD2, inmediate, s_inm);
    wire z_alu;
    alu program_alu(WD3, z_alu, RD1, out_alu_mux, ALUOp);

    // Zero Flag
    ffd flag(zero, clk, reset, z_alu, wez);
endmodule 
