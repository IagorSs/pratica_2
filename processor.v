module regn(R, Rin, Clock, Q);
	parameter n = 16;
	input [n-1:0] R;
	input Rin, Clock;
	output reg [n-1:0] Q;
	
	always @(posedge Clock) 
		if (Rin) 
			Q = R;
endmodule

module processor(DIN, Resetn, Clock, Run, Done, BusWires);
	input [15:0] DIN;
	input Resetn, Clock, Run;
	output reg Done;
	output [15:0] BusWires;
	
	// Registradores
	wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7, A, G, saidaULA;
		
	// Declare variables
	reg [8:0] IR;
	wire [1:0] Tstep_Q;
	
	reg [2:0] sinal_ULA;
	
	wire [0:7] Xreg, Yreg;
		
	reg [0:7] regIn, regOut;
	reg aIn, gIn, gOut, dinOut, Clear;
	
	assign I = IR[8:6];
	
	initial Clear = 1'b1;
	
	dec3to8 decX(IR[5:3], 1'b1, Xreg);
	dec3to8 decY(IR[2:0], 1'b1, Yreg);
	
	upcount Tstep(Clear, Clock, Tstep_Q);
	
	always @(Tstep_Q or I or Xreg or Yreg) begin
		aIn = 1'b0;
		gIn = 1'b0;
		gOut = 1'b0;
		dinOut = 1'b0;
		
		regIn = 8'b0;
		regOut = 8'b0;
		
		Clear = 1'b1;
		
		if(Run) begin
			Done = 1'b0;
			
			Clear = 1'b0;
			
			case (Tstep_Q)
				// STEP 0
				2'b00: IR = DIN[15:7];
				
				// STEP 1
				2'b01: case(I)
					3'b000: begin				//Instrucao mv
							regOut = Yreg;
							regIn = Xreg;
							Done = 1'b1;
							Clear = 1'b1;
						end
					3'b001: begin				//Instrucao mvi
							dinOut = 1'b1;
							regIn = Xreg;
							Done = 1'b1;
							Clear = 1'b1;
						end
					3'b010: begin				//Instrucao add
							aIn = 1'b1;
							regOut = Xreg;
						end
					3'b011: begin				//Instrucao sub
							aIn = 1'b1;
							regOut = Xreg; 							
						end
					3'b100: begin				//Instrucao or 
							aIn = 1'b1;
							regOut = Xreg;
						end
					3'b101: begin 				//Instrucao slt
							aIn = 1'b1;
							regOut = Xreg;
						end
					3'b110: begin 				//Instrucao sll
							aIn = 1'b1;
							regOut = Xreg;
						end
					3'b111: begin				//Instrucao srl
							aIn = 1'b1;
							regOut = Xreg;
						end
				endcase
				
				// STEP 2
				2'b10: if(I > 3'b001) begin
						gIn = 1'b1;
						regOut = Yreg;
						
						case(I)
							3'b010: sinal_ULA = 3'b000;
							3'b011: sinal_ULA = 3'b001;
							3'b100: sinal_ULA = 3'b010;
							3'b101: sinal_ULA = 3'b011;
							3'b110: sinal_ULA = 3'b100;
							3'b111: sinal_ULA = 3'b101;
						endcase
					end
				
				// STEP 3
				2'b11: if(I > 3'b001) begin
						gOut = 1'b1;
						regIn = Xreg;
						Done = 1'b1;
						Clear = 1'b1;
					end
			endcase
		end
	end
	
	ULA moduloULA(sinal_ULA, A, BusWires, saidaULA);
	
	multiplex mult(DIN, R0, R1, R2, R3, R4, R5, R6, R7, G, BusWires, {dinOut, regOut, gOut});
	
	// Aribuição aos registradores
	regn reg_0(BusWires, regIn[0], Clock, R0);
	regn reg_1(BusWires, regIn[1], Clock, R1);
	regn reg_2(BusWires, regIn[2], Clock, R2);
	regn reg_3(BusWires, regIn[3], Clock, R3);
	regn reg_4(BusWires, regIn[4], Clock, R4);
	regn reg_5(BusWires, regIn[5], Clock, R5);
	regn reg_6(BusWires, regIn[6], Clock, R6);
	regn reg_7(BusWires, regIn[7], Clock, R7);
	regn reg_A(BusWires, aIn, Clock, A);
	regn reg_G(saidaULA, gIn, Clock, G);
	
endmodule
