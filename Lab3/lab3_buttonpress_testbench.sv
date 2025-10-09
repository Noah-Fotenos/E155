// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 testbench for lab2 button press module
`timescale 10ps/1ps

`define test(keypressed, value1, num, value2) \
	assert(keypressed !== value1) begin \
		$display("ASSERTION FAILED for keypressed in %m: expected: %b, actual is : %b", value1, keypressed); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(num !== value2) begin \
		$display("ASSERTION FAILED for num in %m: expected: %b, actual is : %b", value2, num); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end 

module lab3_buttonpress_testbench();
	logic clk, reset;
	logic [3:0] cols, rows, lastnum;
	logic keypressed;
	logic [3:0] num;
	logic [3:0]async_row;

assign async_row = {rows[1], rows[0], rows[3], rows[2]}; // adjust for syncronzer
//define clk
	always begin
		clk =1; #5; clk =0; #5;
	end
	lab3_buttonpress DUT(clk, reset, cols, async_row, lastnum, keypressed, num);
	initial begin
		reset = 0; cols = 4'b0000; rows = 4'b0000; lastnum = 4'b0000; #15;
		`test(keypressed, 1'b0, num, 4'b0000); //TEST1
		//TEST2
		cols = 4'b0001; rows = 4'b0001; lastnum = 4'b0000; #10;
		`test(keypressed, 1'b1, num, 4'b1010);
		//TEST3
		cols = 4'b0010; rows = 4'b0001; lastnum = 4'b1010; #10;
		`test(keypressed, 1'b1, num, 4'b0000);
		//TEST4
		cols = 4'b0100; rows = 4'b0001; lastnum = 4'b0000; #10;
		`test(keypressed, 1'b1, num, 4'b1011);
		//TEST5	
		cols = 4'b1000; rows = 4'b0001; lastnum = 4'b1011; #10;
		`test(keypressed, 1'b1, num, 4'b1111);
		//TEST6	
		cols = 4'b0001; rows = 4'b0010; lastnum = 4'b1111; #10;
		`test(keypressed, 1'b1, num, 4'b0111);
		//TEST7	
		cols = 4'b0010; rows = 4'b0010; lastnum = 4'b0111; #10;
		`test(keypressed, 1'b1, num, 4'b1000);
		//TEST8	
		cols = 4'b0100; rows = 4'b0010; lastnum = 4'b1000;#10;
		`test(keypressed, 1'b1, num, 4'b1001)
		//TEST9	
		cols = 4'b1000; rows = 4'b1000; lastnum = 4'b1001; #10;
		`test(keypressed, 1'b1, num, 4'b1100);
		//TEST10	
		cols = 4'b1010; rows = 4'b0001; lastnum = 4'b1100; #10;
		`test(keypressed, 1'b1, num, 4'b1100); //multiple buttons pressed go back to last result
		//TEST11	
		cols = 4'b0000; rows = 4'b0100; lastnum = 4'b1100; #10;
		`test(keypressed, 1'b0, num, 4'b0000); // buttons released
		$finish;


		
	end

endmodule