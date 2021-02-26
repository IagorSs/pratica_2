module upcount(Clear, Clock, Q, length);
	input Clear, Clock;
	output reg [1:0] Q;
	
	always @(posedge Clock)
		if (Clear) Q <= 2'b0;
		else Q <= Q + 1'b1;
endmodule

module upcount_5(Clear, Clock, Q, length);
	input Clear, Clock;
	output reg [4:0] Q;
	
	always @(posedge Clock)
		if (Clear) Q <= 2'b0;
		else Q <= Q + 1'b1;
endmodule
