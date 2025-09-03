// Noah Fotenos
// nfotenos@g.hmc.edu
//8_28_2025
// E155 lab_1_testbench

`timescale 1ns/1ps

module testbench();
	logic clk, reset;
	logic [3:0]in;
	logic [6:0]seg, segexpected;
	logic [2:0]led, ledexpected;
	logic [31:0] vectornum, errors;
	logic [13:0] testvectors[1000:0];
	//generate testbench clk 
	always
		begin
			clk=1; #5; clk=0; #5;
		end

	lab1_nf DUT(in, led, seg); //DUT
	
	
	//at start of test, load vectors
	//pulse reset
	initial 
		begin
			$readmemb("lab_1_tests.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
	//apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1; {in, segexpected, ledexpected} = testvectors[vectornum];
		end
		
	always @(negedge clk) 
			if(~reset) begin //skip if reset
				if(seg !== segexpected)begin //compare to expected result
					$display("ERROR: inputs = %b",{in});
					$display("seg outputs = %b (%b expected)", seg, segexpected);
					errors = errors+1;
					end
				if(led !== ledexpected)begin  //compare to expected result
					$display("ERROR: inputs = %b",{in});
					$display("led outputs = %b (%b expected)", led, ledexpected);
					errors = errors+1;
					end
				vectornum = vectornum +1; 
				if (testvectors[vectornum] === 14'bx) begin  //stop at end of file
					$display("%d test completed with %d errors", vectornum, errors);
					$stop;
				end
			end
	endmodule

