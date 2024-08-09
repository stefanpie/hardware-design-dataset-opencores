module mux2r( mux_out, data_0, data_1, select, reset_n);

	parameter dw = 8;
		
	input [dw-1:0] data_1, data_0;
	input [0:0] select;
	input reset_n;
	output reg [dw-1:0] mux_out;
	
	 // choose between the two inputs
	always @ ( data_1 or data_0 or select or reset_n)
	if(!reset_n)
	begin
	   mux_out = 0;
	end
	else
	begin
   	case (select)//  (* synthesis parallel_case *)
		   1'd0:		mux_out = data_0;
		   1'd1:		mux_out = data_1;
		   default:	mux_out = {dw{1'bx}};
       endcase
   end
endmodule
