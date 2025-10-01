// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 testbench for lab3 top  module
`timescale 1ms/100ns

`define test(row, value1, seg, value2, anode, value3) \
	assert(row !== value1) begin \
		$display("ASSERTION FAILED for row in %m: expected: %b, actual is : %b", value1, row); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(seg !== value2) begin \
		$display("ASSERTION FAILED for seg in %m: expected: %b, actual is : %b", value2, seg); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(anode !== value3) begin \
		$display("ASSERTION FAILED for anode in %m: expected: %b, actual is : %b", value3, anode); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end

module lab3_testbench();
    logic reset;
    logic [3:0] col, row;
    logic [6:0] seg;
    logic [1:0] anode;

    //define clk
    lab3_nf DUT(reset, col, row, seg, anode);

initial begin
    //initialize inputs
    //#7 if off 7ms to switch clk
	reset = 0; #5; reset =1; 
	#10000;
    col = 4'b0000; reset = 0; #7;
    `test(row, 4'b0001, seg, 7'b1000000, anode, 2'b01); //TEST1
    reset = 1; #7; //pulse reset
    `test(row, 4'b0010, seg, 7'b1000000, anode, 2'b10); //TEST2
    col = 4'b0001; #13;
    `test(row, 4'b1000, seg, 7'b1111001, anode, 2'b10); //TEST3
    col = 4'b0010; #12;
    `test(row, 4'b0010, seg, 7'b0100100, anode, 2'b10); //TEST4
    $finish;
    end
endmodule