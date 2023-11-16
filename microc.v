module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
    //Microcontrolador sin memoria de datos de un solo ciclo

    wire[15:0] instruction;
    wire[9:0] new_pc, actual_pc, jump_addr, add_value, value_one;
    wire[7:0] inmediate, WD3, RD1, RD2, out_mux_inm;
    wire[3:0] RA1, RA2, WA3;

    // Program Counter Changes
    assign value_one = 10'b0000000001;
    sum increment_pc(add_value, value_one, actual_pc);
    mux2 mux_pc(new_pc, jump_addr, add_value, s_inc);
    
endmodule 