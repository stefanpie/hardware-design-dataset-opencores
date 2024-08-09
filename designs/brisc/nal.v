module nal(out, in1, in2, in3, in4, cond, sel1, sel2, reset_n);

parameter dw = 8;

input [dw-1:0] in1, in2, in3, in4;
input cond;
input [1:0] sel1, sel2;
input reset_n;

output [dw-1:0] out;

wire [dw-1:0] m1o, m2o;

mux4 #(.dw(dw)) mux1(m1o, in1, in2, in3, in4, sel1);
mux4 #(.dw(dw)) mux2(m2o, in1, in2, in3, in4, sel2);
mux2r #(.dw(dw)) mux3(out, m1o, m2o, cond, reset_n);

endmodule