`timescale 1ns/10ps

module microc_tb;
  // Señales, salidas
  wire[5:0] Opcode;
  wire zero;

  // Señales, entradas
  reg reset, clk, s_inc, s_inm, we, wez;
  reg[2:0] ALUOp;
  
  // Módulo
  microc microc_instanste(Opcode, zero, clk, reset, s_inc, s_inm, we, wez, ALUOp);
  
  // Reloj
  always
    begin
      clk <= 1'b1;
      #20;
      clk <= 1'b0;
      #20;
    end

  initial
    begin
      reset <= 1'b1;
      #3;
      reset <= 1'b0;
      #2;
    end

  // Pruebas
  initial
    begin
      $monitor("AluOP(%b) inc(%b) inm(%b) we(%b) wez(%b)", Opcode, s_inc, s_inm, we, wez);
      $dumpfile("micro_tb.vcd");
      $dumpvars;

      #20;
      #40;
      $finish;
    end

endmodule