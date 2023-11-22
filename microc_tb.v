`timescale 1ns/10ps

module microc_tb;
  // Señales, salidas
  wire[5:0] Opcode;
  wire zero;

  // Señales, entradas
  reg reset, clk, s_inc, s_inm, we, wez;
  reg[2:0] AluOP;
  
  // Módulo
  microc microc_instanste(Opcode, zero, clk, reset, s_inc, s_inm, we, wez, AluOP);
  
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
      $dumpfile("microc_tb.vcd");
      $dumpvars;
      #15;
      // LI #15 R1
      // 1000 0000 1111 0001
      AluOP = Opcode[4:2];
      s_inc = 1'b1;
      s_inm = 1'b1;
      we = 1'b1;
      wez = 1'b0;
      #40;

      // LI #1 R2
      // 1000_0000_0001_0010
      AluOP = Opcode[4:2];
      s_inc = 1'b1;
      s_inm = 1'b1;
      we = 1'b1;
      wez = 1'b1;
      #40;

      // ADD R1 R2 R3
      // 0010_0001_0010_0011
      AluOP = Opcode[4:2];
      s_inc = 1'b1;
      s_inm = 1'b0; 
      we = 1'b1;
      wez = 1'b1;
      #40;

      // Salto
      AluOP = Opcode[4:2];
      s_inc = 1'b0;
      s_inm = 1'b0;
      we = 0;
      wez = 0;
      #40;

      // LI #1 R4
      AluOP = Opcode[4:2];
      s_inc = 1'b1;
      s_inm = 1'b1;
      we = 1'b1;
      wez = 1'b0;
      #40;
      $finish;
    end

endmodule