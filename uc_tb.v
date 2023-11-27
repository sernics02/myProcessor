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
      $monitor("Opcode(%b) inc(%b) inm(%b) we(%b) wez(%b)", Opcode, s_inc, s_inm, we, wez);
      $dumpfile("uc_tb.vcd");
      $dumpvars;
      // Declarar una variable e igualarla a 5 con el nombre, instrucciones
      instrucciones = 5;
      #40 * instrucciones;
      $finish;
    end

endmodule