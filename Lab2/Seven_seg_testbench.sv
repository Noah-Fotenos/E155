// Noah Fotenos
// nfotenos@g.hmc.edu
//8_28_2025
// E155 lab_1_seg_testbench
module Seven_seg_testbench();
	logic clk, reset;
	logic [3:0]in;
	logic [6:0]seg, segexpected;
	logic [31:0] vectornum, errors;
	logic [10:0] testvectors[1000:0];
	//generate testbench clk 
	always
		begin
			clk=1; #5; clk=0; #5;
		en
		
	nf_seven_seg_disp DUT(in, seg); //DUT
	
	
	//at start of test, load vectors
	//pulse reset
	initial 
		begin
			$readmemb("lab_1_tests_seg.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
	//apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1; {in, segexpected, ledexpected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		begin 
			if(~reset) begin //skip if reset
				if(seg !== segexpected)begin  //compare to expected result
					$display("ERROR: inputs = %b",{in});
					$display("seg outputs = %b (%b expected)", seg, segexpected);
					errors = errors+1;
					end
				vectornum = vectornum +1; 
				if (testvectors[testvectornum] === 4'bx) begin  //stop at end of file
					$display("%d test completed with %d errors", vectornum, errors);
					$stop;
				end
			end
endmodule