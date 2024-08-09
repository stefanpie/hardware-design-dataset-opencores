module mux8( mux_out, data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7, select);

	parameter dw = 8;
		
	input [dw-1:0] data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7;
	input [2:0] select;
	output reg [dw-1:0] mux_out;
	
	 // choose between the two inputs
	always @ ( data_0 or data_1 or data_2 or data_3 or data_4 or data_5 or data_6 or data_7 or select)
	case (select)//  (* synthesis parallel_case *)
		3'd0:		mux_out = data_0;
		3'd1:		mux_out = data_1;
		3'd2:		mux_out = data_2;
		3'd3:		mux_out = data_3;
		3'd4:		mux_out = data_4;
		3'd5:		mux_out = data_5;
		3'd6:		mux_out = data_6;
		3'd7:		mux_out = data_7;
		default:	mux_out = {dw{1'bx}};
    endcase
endmodule
