module memprog(output wire [15:0] Datum, input  wire clk, input  wire [9:0] Address);  

  reg [15:0] Mem[0:1023]; //memoria de 1024 palabras de 16 bits de ancho

  initial
  begin
    $readmemb("progfile.dat", Mem); // inicializa la memoria del fichero en texto binario
  end
  assign Datum = Mem[Address];
endmodule


