module reg_file (Read_Addr_1, Data_Out_1, Clock);

   
	parameter aw = 8;		//address bus width
	parameter dw = 48;	//size of each memory element
	parameter size = (1<<aw);
	
	output	   [dw-1:0]  Data_Out_1;
	input 	   [aw-1:0]    Read_Addr_1;
	input 	   Clock;
	reg 	   [dw-1:0]  Reg_File [0:size-1];
   /*
	always @ (posedge Clock) begin
		Data_Out_1 <= Reg_File[Read_Addr_1];
	end
	*/
	//assign Data_Out_a = {{dw-aw{1'b0}}, Read_Addr_1};
endmodule  
