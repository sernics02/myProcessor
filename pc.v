// pc.v
module pc (
  output reg clk,
  output reg reset
);

wire [5:0] Opcode;
wire zero;
wire s_inc, s_inm, we, wez;
wire [2:0] AluOp;

// Generación de la señal de reloj
always
    begin
      clk <= 1'b1;
      #20;
      clk <= 1'b0;
      #20;
    end

// Generación de la señal de reset
initial
    begin
      reset <= 1'b1;
      #5;
      reset <= 1'b0;
    end

// Instancia del módulo uc
uc uc1 (
  .clk(clk),
  .zero(zero),
  .Opcode(Opcode),
  .s_inc(s_inc),
  .s_inm(s_inm),
  .we(we),
  .wez(wez),
  .AluOp(AluOp)
);

// Instancia del módulo microc
microc microc1 (
  .clk(clk),
  .reset(reset),
  .Opcode(Opcode),
  .zero(zero),
  .s_inc(s_inc),
  .s_inm(s_inm),
  .we(we),
  .wez(wez),
  .ALUOp(AluOp)
);

endmodule