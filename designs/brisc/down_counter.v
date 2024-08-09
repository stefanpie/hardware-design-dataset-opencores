module down_counter(in, out);
	parameter dw = 8;
	
	input [dw-1:0] in;
	output [dw-1:0] out;
	
	assign out = in - 1;
endmodule
