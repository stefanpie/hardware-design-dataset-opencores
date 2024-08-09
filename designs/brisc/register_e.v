module register_e(in, out, clk, reset_n, enable);

parameter dw = 8 ;

input [dw-1:0] in;
input clk;
input reset_n;
input enable;

output reg [dw-1:0] out;

always @(posedge clk or negedge reset_n)
begin
	if (!reset_n)
		out <= 0;
	else if (enable)
		out <= in;
//	else
//		out <= {dw{1'bx}};
end

endmodule