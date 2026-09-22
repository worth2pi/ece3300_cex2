`timescale 1ns / 1ps

module adder4_tb;

    // Testbench signals
    reg [3:0] a;
    reg [3:0] b;
    wire [4:0] result;
    integer    i;
    reg [4:0]  expected [7:0];
    reg [3:0]  testa [7:0];
    reg [3:0]  testb [7:0];
    reg        test_fail;

    // Instantiate the DUT (Device Under Test)
    adder4 dut (
        .a (a),
        .b (b),
        .result (result)
    );

    initial begin
        // Provided test cases [0..3]
        expected[0] = 5'd0;    testa[0] = 4'd0;   testb[0] = 4'd0;   // 0 + 0 = 0
        expected[1] = 5'd2;    testa[1] = 4'd1;   testb[1] = 4'd1;   // 1 + 1 = 2
        expected[2] = 5'd30;   testa[2] = 4'd15;  testb[2] = 4'd15;  // 15 + 15 = 30
        expected[3] = 5'd15;   testa[3] = 4'd7;   testb[3] = 4'd8;   // 7 + 8 = 15

        // New test cases [4..7]
        expected[4] = 5'd9;    testa[4] = 4'd4;   testb[4] = 4'd5;   // 4 + 5 = 9
        expected[5] = 5'd15;   testa[5] = 4'd10;  testb[5] = 4'd5;   // 10 + 5 = 15 (1010 + 0101)
        expected[6] = 5'd21;   testa[6] = 4'd12;  testb[6] = 4'd9;   // 12 + 9 = 21 (Carry-out set)
        expected[7] = 5'd16;   testa[7] = 4'd1;   testb[7] = 4'd15;  // 1 + 15 = 16 (Ripple carry through all bits)
    end

    initial begin
       test_fail = 0;

       // Display header
       $display("Time\t| a   | b   | result");
       $display("------\t|-----|-------");

       // Use a loop to test 
       for (i = 0; i < 8; i = i + 1) begin
           a = testa[i];
           b = testb[i];
           #10; // wait 10 time units
           if (result == expected[i]) begin
               \(display("%0dns\t| %d | %d | %d | Pass",\)time, a, b, result);
           end else begin
               \(display("%0dns\t| %d | %d | %d | Fail",\)time, a, b, result);
               test_fail = 1;
           end
       end

       // End simulation
       $finish_and_return(test_fail);
    end

endmodule
