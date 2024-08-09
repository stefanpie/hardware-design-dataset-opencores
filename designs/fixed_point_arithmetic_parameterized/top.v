`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:23 08/25/2011 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
    input [31:0] a,
    input [31:0] b,
    output [31:0] c1,
    output [31:0] c2,
    output [31:0] c3,
	 input clk,
	 input start
    );
	// Inputs
	reg [31:0] a_sig;
	reg [31:0] b_sig;

	// Outputs
	reg [31:0] c_sig;
		
	// Instantiate the Unit Under Test (UUT)
	qadd #(23,32) uut_0 (a, b, c1);
	qmult #(23,32) uut_1 (a, b, c2);
	qdiv #(15,32)	uut_2 (a, b, start, clk, c3);
endmodule
