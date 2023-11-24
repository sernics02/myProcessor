module uc (
  output reg s_inc, s_inm, we, wez,
  output reg [2:0] AluOp,
  input wire clk, zero,
  input wire [5:0] Opcode
);

  always @(negedge clk) begin
    casez (Opcode)
      // Los que empiezan por 0
      6'b0????? : begin
        AluOp = Opcode[4:2];
        we = 1'b1;
        wez = 1'b1;
        s_inm = 1'b0;
        s_inc = 1'b0;

      end
      // Los que empiezan por 1
      6'b1????? : begin
        AluOp = Opcode[4:2];
        we = 1'b1;
        wez = 1'b1;
        s_inm = 1'b0;
        s_inc = 1'b0;

      end
      6'b1100?? : begin
        AluOp = 3'b000;
        we = 1'b0;
        wez = 1'b0;
        s_inm = 1'b1;
        case(Opcode[1:0])
          00: s_inc = 1'b0;
          01: s_inc = ~zero;
          10: s_inc = zero;
        endcase
      end
    endcase
  end
endmodule
