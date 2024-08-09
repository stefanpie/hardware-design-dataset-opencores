 // List in First out (LIFO)
 
 module lifo(din, dout, clk, enable, push_pop, reset_n);
 
 parameter dw = 8;		// data width
 
 input	[dw-1: 0] din;
 output	wire [dw-1: 0] dout;
 
 input clk;
 input enable;
 input push_pop;			// high to push, low to pop
 input reset_n;
 
 wire [dw-1:0] m1o, m2o, m3o, r2o, r3o;
 
 mux2 		#(.dw(dw)) mux3(m3o, {dw{1'b0}}, r2o, push_pop);
 register_e	#(.dw(dw)) reg3(m3o, r3o, clk, reset_n, enable);
 mux2 		#(.dw(dw)) mux2(m2o, r3o, dout, push_pop);
 register_e	#(.dw(dw)) reg2(m2o, r2o, clk, reset_n, enable);
 mux2 		#(.dw(dw)) mux1(m1o, r2o, din, push_pop);
 register_e	#(.dw(dw)) reg1(m1o, dout, clk, reset_n, enable);
 

 endmodule