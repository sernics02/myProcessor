`timescale 1ns/10ps

module uc_tb;
  // Señales, salidas
  wire[5:0] Opcode;
  wire zero;

  // Señales, entradas
  reg reset, clk;
  wire s_inc, s_inm, we, wez;
  wire[2:0] AluOP;
  
  // Módulo
  microc microc_instance(Opcode, zero, clk, reset, s_inc, s_inm, we, wez, AluOP);
  uc uc_instance(s_inc, s_inm, we, wez, AluOP, clk, zero, Opcode);
  
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
      #5;
      reset <= 1'b0;
    end

  // Pruebas
  initial
    begin
      $monitor("AluOP(%b) inc(%b) inm(%b) we(%b) wez(%b)", Opcode, s_inc, s_inm, we, wez);
      $dumpfile("uc_tb.vcd");
      $dumpvars;
      #15;
      // LI #15 R1
      // 1000 0000 1111 0001
      #40;

      // LI #1 R2
      // 1000_0000_0001_0010
      #40;

      // ADD R1 R2 R3
      // 0010_0001_0010_0011
      #40;

      // Salto 15
      #40;

      // LI #1 R4
      #40;
      $finish;
    end

endmodule