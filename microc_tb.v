`timescale 1ns/10ps

module microc_tb;
  wire[5:0] Opcode;
  wire zero;
  reg reset, clk, s_inc, s_inm, we, wez;
  reg[2:0] ALUOp;

  microc microc_instanste(Opcode, zero, clk, reset, s_inc, s_inm, we, wez, ALUOp);
  
  always
  begin
    clk = 1;
    #20;
    clk = 0;
    #20;
  end

  initial
  begin
    reset = 1'b1;
    #5;
    reset = 1'b0;
  end

  initial
  begin
    $dumpfile("microc_tb.vcd");
    $dumpvars;
    // Mostrar tiempo, opcode, zero, clk, reset, s_inc, s_inm, we, wez, ALUOp
    $monitor("%t %b %b %b %b %b %b %b %b %b", $time, Opcode, zero, clk, reset, s_inc, s_inm, we, wez, ALUOp);
    #20

    $finish;
  end

endmodule