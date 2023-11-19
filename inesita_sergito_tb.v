`timescale 1ns/10ps

module estrellita_tb;
    reg clk;
    always
    begin
        clk = 1;
        #20;
        clk = 0;
        #40;
    end

endmodule