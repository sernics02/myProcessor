// pc_tb.v
module pc_tb;

wire clk, reset;

// Instancia del módulo pc
pc pc1 (clk, reset);

// Inicio de la simulación
initial begin
  $monitor("At time %t, clk = %b, reset = %b", $time, clk, reset);
  $dumpfile("pc_tb.vcd");
  $dumpvars;
  #880 $finish; // Termina la simulación después de 200 unidades de tiempo
end

endmodule