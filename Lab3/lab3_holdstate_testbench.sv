// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 testbench for lab3 holdstate module
`timescale 10ps/1ps

`define test(numout, value1, anodes, value2) \
	assert(numout !== value1) begin \
		$display("ASSERTION FAILED for keypressed in %m: expected: %b, actual is : %b", value1, keypressed); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(anodes !== value2) begin \
		$display("ASSERTION FAILED for num in %m: expected: %b, actual is : %b", value2, num); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end 

module lab3_holdstate_testbench();
    logic clk, reset, en;
    logic [3:0] num_in, num_out;
    logic [1:0] anodes;

    //define clk
    always begin
		clk =1; #5; clk =0; #5;
	end
    lab3_holdstate DUT(clk, reset, en, num_in, num_out, anodes);
    initial begin
        #1; reset = 0; en = 1'b0; num_in = 4'b0000; #5; //clk =0
        `test(num_out, 4'b0000, anodes, 2'b10); //TEST1  
        //TEST2
        reset = 1; en = 1'b1; num_in = 4'b1010; #5; //clk = 1
        `test(num_out, 4'b1010, anodes, 2'b01); 
        //TEST3
        reset = 1; en = 1'b0; num_in = 4'b0111; #5; //clk = 0
        `test(num_out, 4'b0000, anodes, 2'b10); 
        //TEST4
        reset = 1; en = 1'b1; num_in = 4'b0111; #5; //clk = 1
        `test(num_out, 4'b0111, anodes, 2'b01); 
        //TEST5
        reset = 1; en = 1'b0; num_in = 4'b1111; #5; //clk = 0
        `test(num_out, 4'b1010, anodes, 2'b10); 
        #5; //clk = 1
        `test(num_out, 4'b0111, anodes, 2'b01);
        //TEST6
        reset = 1; en = 1'b1; num_in = 4'b0000; #5; //clk = 0
        `test(num_out, 4'b0111, anodes, 2'b10); 
        $finish;
    end
endmodule