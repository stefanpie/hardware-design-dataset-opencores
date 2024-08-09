module mux2( mux_out, data_0, data_1, select);

	parameter dw = 8;
		
	input [dw-1:0] data_1, data_0;
	input [0:0] select;
	output reg [dw-1:0] mux_out;
	
	 // choose between the two inputs
	always @ ( data_1 or data_0 or select)
	case (select)//  (* synthesis parallel_case *)
		1'd0:		mux_out = data_0;
		1'd1:		mux_out = data_1;
		default:	mux_out = {dw{1'bx}};
    endcase
endmodule
