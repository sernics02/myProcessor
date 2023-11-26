module uc (
  output reg s_inc, s_inm, we, wez,
  output reg [2:0] AluOp,
  input wire clk, zero,
  input wire [5:0] Opcode
);

always @(negedge clk or posedge Opcode) begin
  if (Opcode[5:2] == 4'b1100) begin
    s_inm = 1'b0;
    we = 1'b0;
    wez = 1'b0;
    AluOp = 3'b000;
    case (Opcode[1:0])
      2'b00: s_inc = 1'b0; // Jump
      2'b01: s_inc = ~zero; // Jump zero
      2'b10: s_inc = zero; // Jump if not zero
    endcase
  end else if (Opcode[5] == 1'b0) begin // ALU
    s_inc = 1'b1;
    s_inm = 1'b0;
    we = 1'b1;
    wez = 1'b1;
    AluOp = Opcode[4:2];
  end else if (Opcode[5] == 1'b1) begin // Inmediato
    s_inc = 1'b1;
    s_inm = 1'b1;
    we = 1'b1;
    wez = 1'b1;
    AluOp = Opcode[4:2];
  end
end

endmodule