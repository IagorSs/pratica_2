module ULA(sinal_ULA, A,  BusWires, G);
	input [2:0] sinal_ULA;
	input [15:0] A, BusWires;
	output reg [15:0] G;
	
	/*
	000 = add
	001 = sub
	010 = or
	011 = slt
	100 = sll
	101 = srl	
	*/
	
	always@(*)begin
		case(sinal_ULA)
		3'b000: G = A + BusWires; 
		3'b001: G = A - BusWires; 
		3'b010: G = A | BusWires; 
		3'b011: begin 
					if(A < BusWires) 
							G = 16'b1;
					else
							G = 16'b0;
				  end
		3'b100: G = A << BusWires;
		3'b101: G = A >> BusWires;
			endcase
	end
	
endmodule
