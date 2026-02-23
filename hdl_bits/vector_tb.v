`timescale  1ns/1ps
module vector_tb;

wire [31:0]out;
reg [7:0]in;



vector_1 mut(.out(out),.in(in));

initial begin
    $display("Time\t input | output");
    $monitor("%g\t%b | %b", $time, in , out);

    in = 8'd8; #10;
    in = 8'b10001000 ;#10;
    in = 8'b10001010 ;#10;

end


initial begin
    $dumpfile("vector.vcd");
    $dumpvars(0,vector_tb);

end

endmodule