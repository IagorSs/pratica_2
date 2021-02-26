module multiplex(In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, Out, Control);
	input [9:0] Control;
	input [15:0] In1, In2, In3, In4, In5, In6, In7, In8, In9, In10;
	output reg [15:0] Out;
	
	always@(*) begin
		case(Control)
			10'b1000000000: Out = In1;
			10'b0100000000: Out = In2;
			10'b0010000000: Out = In3;
			10'b0001000000: Out = In4;
			10'b0000100000: Out = In5;
			10'b0000010000: Out = In6;
			10'b0000001000: Out = In7;
			10'b0000000100: Out = In8;
			10'b0000000010: Out = In9;
			10'b0000000001: Out = In10;
		endcase
	end
	
endmodule
