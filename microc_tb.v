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
      #3;
      reset <= 1'b0;
      #2;
    end

  // Pruebas
  initial
    begin
      $monitor("AluOP(%b) inc(%b) inm(%b) we(%b) wez(%b)", Opcode, s_inc, s_inm, we, wez);
      $dumpfile("microc_tb.vcd");
      $dumpvars;

      #20;
      // LI #8 R4
      // 1000 0000 1111 0100
      // Comprobar que la variable Opcode sea 100000
      AluOP = Opcode[5:3];
      s_inc = 1'b1;
      s_inm = 1'b1;
      we = 1'b1;
      wez = 1'b1;
      #20;

      // // ADD R1 R2 R3
      // // 0010 0001 0010 0011
      // AluOP = Opcode[4:2];
      // s_inc = 1'b1;
      // s_inm = 1'b0;
      // we = 1'b0;
      // wez = 1'b1;
      $finish;
    end

endmodule