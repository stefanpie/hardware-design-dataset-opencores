module stimulus_trisc();

parameter ncs = 3;
parameter cw = (1<<ncs)-1;		//number of conditional inputs (cw+1 must be a power of 2)

parameter ow = 28;		//control output size

reg [cw-1:0] cond;
wire [ow-1:0] out_sig;
reg clk;
reg reset_n;

trisc processor(cond, out_sig, clk, reset_n);

initial
begin
clk = 0;
reset_n = 1;
cond = 0;
 
#1
reset_n = 0;

#1
reset_n = 1;

cond = 1;
end

always
#5 clk = ~clk;



endmodule
