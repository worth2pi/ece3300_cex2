`timescale 1ns / 1ps

module adder4(
    input [3:0]       a,
    input [3:0]       b,
    output [4:0] result);

    // Internal carry wires between full adder stages
    wire c1, c2, c3;

    // Instantiate four 1-bit full adders (LSB to MSB)
    fulladd fa0 (.x(a[0]), .y(b[0]), .cin(1'b0), .sum(result[0]), .cout(c1));
    fulladd fa1 (.x(a[1]), .y(b[1]), .cin(c1),   .sum(result[1]), .cout(c2));
    fulladd fa2 (.x(a[2]), .y(b[2]), .cin(c2),   .sum(result[2]), .cout(c3));
    fulladd fa3 (.x(a[3]), .y(b[3]), .cin(c3),   .sum(result[3]), .cout(result[4]));

endmodule

module fulladd(
       input  x,
       input  y,
       input  cin,
       output sum,
       output cout);

   assign sum = x ^ y ^ cin;
   assign cout = (x & y) | (x & cin) | (y & cin);

endmodule
