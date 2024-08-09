module trisc(cond, out_sig, clk, reset_n);

//independent parameters
parameter ncs = 3;			//number of bits to select cw+1 inputs i.e 2^ncs = (cw+1)
parameter aw = 8;		//address width
parameter dw = 20;		//data width for internal control
parameter ow = 28;		//control output size

//dependant parameters (based on independant parameters
parameter cw = (1<<ncs)-1;		//number of conditional inputs (cw+1 must be a power of 2)
parameter pms = (1<<aw);	// program memory size. depends on address width ( pms = 2 ^ aw )

//  ow  + dw defines the width of one memory block of program memory

input [cw-1:0] cond;		// one conditional input is from down counter
input [0:0] clk, reset_n;
output [ow-1:0] out_sig;

//output of program memory
wire [aw-1:0] prog_ctr_a;		// program counte address
wire [aw-1:0] sub_a;		// subroutine address
wire [aw-1:0] branch_a;		// branch address
wire [ncs-1:0] cond_sel;
wire [3:0] nal_sel;
wire [0:0] pp;				// push/pop_n
wire [0:0] cl;				//count/load_n
wire [0:0] ce;				//counter enable
wire [0:0] sse;				// subroutine stack enable
wire [0:0] cse;				// counter stack enable

wire [0:0] cc;				// output of conditinal select mux

//output of NAL
wire [aw-1:0] next_inst_a;	//address of next instruction to execute

wire [aw:0]	dc;				// down counter
wire [aw:0]	lc;				// output of loop counter lifo
wire [aw:0]	cm;				// output of counter mux
wire [aw:0]	ctr_o;			// output of down counter register

wire [aw-1:0] inc_o;		// output of incrementer

// program memory
prog_mem mem (.addr(next_inst_a),.clk(clk),.dout({out_sig, nal_sel, cond_sel, cse, sse, ce, cl, pp, branch_a})); 

nal			#(.dw(aw)) next_addr(next_inst_a, ctr_o[aw-1:0], branch_a, sub_a, prog_ctr_a, cc, nal_sel[1:0], nal_sel[3:2], reset_n);


lifo		#(.dw(aw+1)) loop_cnt(ctr_o, lc, clk, cse, pp, reset_n);
mux2		#(.dw(aw+1)) counter_m(cm, {1'b0, branch_a}, lc, cl);

down_counter #(.dw(aw+1)) dn_ctr(cm, dc);
register_e #(.dw(aw+1)) ctr(dc, ctr_o, clk, reset_n, ce);

mux8		#(.dw(1))	cond_m(cc, ctr_o[aw], cond[0], cond[1], cond[2], cond[3], cond[4], cond[5], cond[6], cond_sel); 


incrementer #(.dw(aw)) inc(next_inst_a, inc_o);
register #(.dw(aw)) prog_ctr(inc_o, prog_ctr_a, clk, reset_n);

lifo #(.dw(aw)) sub(prog_ctr_a, sub_a, clk, sse, pp, reset_n);

endmodule
