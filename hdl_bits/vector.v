`timescale 1ns/1ps
module vector_1(
    output [31:0]out,
    input [7:0]in);

    assign out ={{24{in[7]}},in};


endmodule