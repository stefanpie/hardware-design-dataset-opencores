module mux4( mux_out, data_0, data_1, data_2, data_3, select);

	parameter dw = 32;
	
	input [dw-1:0] data_3, data_2, data_1, data_0;
	input [1:0] select;
	output reg [dw-1:0] mux_out;
	
	 // choose between the four inputs
	always @ ( data_3 or data_2 or data_1 or data_0 or select)
	case (select)//  (* synthesis parallel_case *)
		2'd0:		mux_out = data_0;
		2'd1:		mux_out = data_1;
		2'd2:		mux_out = data_2;
		2'd3:		mux_out = data_3;
		default:	mux_out = {dw{1'bx}};
    endcase
endmodule
