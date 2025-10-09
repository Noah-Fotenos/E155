// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 testbench for lab2 rowswitch module
`timescale 10ps/1ps

`define test(row, value1) \
	assert(row !== value1) begin \
		$display("ASSERTION FAILED for row in %m: expected: %b, actual is : %b", value1, row); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end


module lab3_rowswitch_testbench();
	logic clk, reset, en;
	logic [3:0] row;

//define clk
	always begin
		clk =1; #5; clk =0; #5;
	end
	lab3_rowswitch DUT(clk, reset, en, row);
	initial begin
		reset = 0; en = 1'b0; #5;
		`test(row, 4'b0001); //TEST1
		//TEST2
        reset = 1; en = 1'b0; #5;
        `test(row, 4'b0010); //TEST2
        //TEST3
        reset = 1; en = 1'b0; #10;
        `test(row, 4'b0100); //TEST3
        //TEST4
        reset = 1; en = 1'b0; #10;
        `test(row, 4'b1000); //TEST4
        //TEST5
        reset = 1; en = 1'b0; #10;
        `test(row, 4'b0001); //TEST5
        //TEST6
        reset = 1; en = 1'b1; #10;
        `test(row, 4'b0100); //TEST6
        //TEST7
        reset = 1; en = 1'b1; #10;
        `test(row, 4'b0100); //TEST7
        //TEST8
        reset = 1; en = 1'b0; #10;
        `test(row, 4'b1000); //TEST8
        //TEST9
        reset = 1; en = 1'b0; #10;
        `test(row, 4'b0001); //TEST9
		$finish;
		
	end
endmodule