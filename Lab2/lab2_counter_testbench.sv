// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 2 testbench for lab2 counter

`timescale 10ps/1ps
module lab2_counter_testbench();
	logic clk, reset;
	logic[23:0] counter;
	//define clk
	always begin
		clk =1; #5; clk =0; #5;
	end
	lab2_counter DUT(clk, reset, counter);
	initial begin
		reset=0; #5;
		assert(counter == '0) begin
			$display("ASSERTION SUCCEDED1");  //check reset
			end
			else begin
				$display("ASSERTION FAILED1 in %m: expected: %b, actual is : %b", 1'b0, counter); 
			end
		 reset = 1; #6 //pulse reset and first clock cycle
		 assert(counter === 28)  begin
			 $display("ASSERTION SUCCEDED2");  //check its counting
			end
			else begin
				$display("ASSERTION FAILED2 in %m: expected: %d, actual is : %b", 2'd28, counter); 
			end
		#5830110; // turn on counter[23]
		assert(counter[23] == 1'b1)begin
			$display("ASSERTION SUCCEDED3");  //check its counting
			end
			else begin
				$display("ASSERTION FAILED3 in %m: expected: %b, actual is : %b", 1'b1, counter[23]); 
			end
		$finish; 
		end
	
	endmodule