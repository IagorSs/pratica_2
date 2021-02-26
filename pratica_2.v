module pratica_2(MClock, PClock, Resetn, Run, Bus, Done);
	input MClock, PClock, Resetn, Run;
	output [15:0]Bus;
	output Done;

	wire [4:0] n;
	
	wire [15:0] memoryOut;
	
	upcount_5 count(Resetn, MClock, n);
	memory mem(n, MClock, memoryOut);
	processor proc(memoryOut, Resetn, PClock, Run, Done, Bus);
endmodule
