module register(in, out, clk, reset_n);

parameter dw = 8;

input [dw-1:0] in;
input clk;
input reset_n;

output reg [dw-1:0] out;


always @(posedge clk or negedge reset_n)
begin
	if (!reset_n)
		out <= 0;
	else
		out <= in;
end

endmodule