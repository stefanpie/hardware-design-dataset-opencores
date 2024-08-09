/////////////////////////////////////////////////////////////////////
////                                                             ////
////  High Speed Adder for Large Bitsize Computation (128 Bits)  ////
////                                                             ////
////  Authors: seanlee (seanlee@opencores.org)                   ////
////                                                             ////
////  http://www.opencores.org/projects/adder                    ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2005 Sean Lee                                 ////
////                         seanlee@opencores.org               ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Note: The verilog file is written based on 128 bits.        //// 
//// The 128 bits adder was tested on a 0.35                     ////
//// micron technology and synthesis results yielded a 18%       ////
//// speed improvement over conventional carry look ahead adder  ////
//// and 85% improvement compared to conventional ripple adder.  ////
////                                                             ////
//// The verilog code can be expanded using the same concept     ////
//// for 256 bits, 512 bits or beyond.                           ////
/////////////////////////////////////////////////////////////////////

module adder_128bit (A, B, Sum);

input [127:0] A,B;
output [128:0] Sum;
wire [128:0] Sum;

wire [8:0] tempSum1, tempSum2, tempSum3, tempSum4, tempSum5, tempSum6, tempSum7, tempSum8;
wire [8:0] tempSum9, tempSum10, tempSum11, tempSum12, tempSum13, tempSum14, tempSum15, tempSum16;

wire tempCarry1, tempCarry2, tempCarry3, tempCarry4, tempCarry5, tempCarry6, tempCarry7, tempCarry8;
wire tempCarry9, tempCarry10, tempCarry11, tempCarry12, tempCarry13, tempCarry14, tempCarry15, tempCarry16;

wire f2, f3, f4, f5, f6, f7, f8;
wire f9, f10, f11, f12, f13, f14, f15, f16;

wire c1, c2, c3, c4, c5, c6, c7, c8;
wire c9, c10, c11, c12, c13, c14, c15, c16;

assign tempSum1 = A[7:0]      + B[7:0];
assign tempSum2 = A[15:8]     + B[15:8];
assign tempSum3 = A[23:16]    + B[23:16];
assign tempSum4 = A[31:24]    + B[31:24];
assign tempSum5 = A[39:32]    + B[39:32];
assign tempSum6 = A[47:40]    + B[47:40];
assign tempSum7 = A[55:48]    + B[55:48];
assign tempSum8 = A[63:56]    + B[63:56];
assign tempSum9 = A[71:64]    + B[71:64];
assign tempSum10 = A[79:72]   + B[79:72];
assign tempSum11 = A[87:80]   + B[87:80];
assign tempSum12 = A[95:88]   + B[95:88];
assign tempSum13 = A[103:96]  + B[103:96];
assign tempSum14 = A[111:104] + B[111:104];
assign tempSum15 = A[119:112] + B[119:112];
assign tempSum16 = A[127:120] + B[127:120];

assign tempCarry1 = tempSum1[8];
assign tempCarry2 = tempSum2[8];
assign tempCarry3 = tempSum3[8];
assign tempCarry4 = tempSum4[8];
assign tempCarry5 = tempSum5[8];
assign tempCarry6 = tempSum6[8];
assign tempCarry7 = tempSum7[8];
assign tempCarry8 = tempSum8[8];
assign tempCarry9 = tempSum9[8];
assign tempCarry10 = tempSum10[8];
assign tempCarry11 = tempSum11[8];
assign tempCarry12 = tempSum12[8];
assign tempCarry13 = tempSum13[8];
assign tempCarry14 = tempSum14[8];
assign tempCarry15 = tempSum15[8];
assign tempCarry16 = tempSum16[8];

assign f2 = (tempSum2[7:0] == 8'hff);
assign f3 = (tempSum3[7:0] == 8'hff);
assign f4 = (tempSum4[7:0] == 8'hff);
assign f5 = (tempSum5[7:0] == 8'hff);
assign f6 = (tempSum6[7:0] == 8'hff);
assign f7 = (tempSum7[7:0] == 8'hff);
assign f8 = (tempSum8[7:0] == 8'hff);
assign f9 = (tempSum9[7:0] == 8'hff);
assign f10 = (tempSum10[7:0] == 8'hff);
assign f11 = (tempSum11[7:0] == 8'hff);
assign f12 = (tempSum12[7:0] == 8'hff);
assign f13 = (tempSum13[7:0] == 8'hff);
assign f14 = (tempSum14[7:0] == 8'hff);
assign f15 = (tempSum15[7:0] == 8'hff);
assign f16 = (tempSum16[7:0] == 8'hff);

assign c1 = tempCarry1;
assign c2 = (c1 & f2) | tempCarry2;
assign c3 = (c2 & f3) | tempCarry3;
assign c4 = (c3 & f4) | tempCarry4;
assign c5 = (c4 & f5) | tempCarry5;
assign c6 = (c5 & f6) | tempCarry6;
assign c7 = (c6 & f7) | tempCarry7;
assign c8 = (c7 & f8) | tempCarry8;
assign c9 = (c8 & f9) | tempCarry9;
assign c10 = (c9 & f10) | tempCarry10;
assign c11 = (c10 & f11) | tempCarry11;
assign c12 = (c11 & f12) | tempCarry12;
assign c13 = (c12 & f13) | tempCarry13;
assign c14 = (c13 & f14) | tempCarry14;
assign c15 = (c14 & f15) | tempCarry15;
assign c16 = (c15 & f16) | tempCarry16;

assign Sum[7:0] = tempSum1[7:0];

assign Sum[15:8] = c1 ? (tempSum2[7:0] + 1) : tempSum2[7:0];

assign Sum[23:16] = c2 ? (tempSum3[7:0] + 1) : tempSum3[7:0];

assign Sum[31:24] = c3 ? (tempSum4[7:0] + 1) : tempSum4[7:0];

assign Sum[39:32] = c4 ? (tempSum5[7:0] + 1) : tempSum5[7:0];

assign Sum[47:40] = c5 ? (tempSum6[7:0] + 1) : tempSum6[7:0];

assign Sum[55:48] = c6 ? (tempSum7[7:0] + 1) : tempSum7[7:0];

assign Sum[63:56] = c7 ? (tempSum8[7:0] + 1) : tempSum8[7:0];

assign Sum[71:64] = c8 ? (tempSum9[7:0] + 1) : tempSum9[7:0];

assign Sum[79:72] = c9 ? (tempSum10[7:0] + 1) : tempSum10[7:0];

assign Sum[87:80] = c10 ? (tempSum11[7:0] + 1) : tempSum11[7:0];

assign Sum[95:88] = c11 ? (tempSum12[7:0] + 1) : tempSum12[7:0];

assign Sum[103:96] = c12 ? (tempSum13[7:0] + 1) : tempSum13[7:0];

assign Sum[111:104] = c13 ? (tempSum14[7:0] + 1) : tempSum14[7:0];

assign Sum[119:112] = c14 ? (tempSum15[7:0] + 1) : tempSum15[7:0];

assign Sum[127:120] = c15 ? (tempSum16[7:0] + 1) : tempSum16[7:0];

assign Sum[128] = c16;

endmodule

