module pratica_2(MClock, PClock, Resetn, Run, Bus, Done);
	input MClock, PClock, Resetn, Run;
	output [15:0]Bus;
	output Done;
	
	wire [15:0] memoryOut;
	
	processor proc(memoryOut, Resetn, Clock, Run, Done, Bus);
	memory mem();
	counter count();
endmodule

module counter(clock, reset, n)
	
endmodule
