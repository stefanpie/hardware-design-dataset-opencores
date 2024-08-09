/////////////////////////////////////////////////////////////////////
////                                                             ////
////  High Speed Adder for Large Bitsize Computation (256 Bits)  ////
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
//// Note: The verilog file is written based on 256 bits.        //// 
//// The 256 bits adder was tested on a 0.35                     ////
//// micron technology and synthesis results yielded a 11%       ////
//// speed improvement over conventional carry look ahead adder  ////
//// and 91% improvement compared to conventional ripple adder.  ////
////                                                             ////
//// The verilog code can be expanded using the same concept     ////
//// for 512 bits or beyond.                                     ////
//// When expanded to 512 bits and implemented on 0.35 micron    ////
//// technology, synthesized circuit yielded a 18% speed         ////
//// improvement over conventional carry look ahead adder        ////
//// and 95% improvement compared to conventional ripple adder.  ////
/////////////////////////////////////////////////////////////////////

module adder_256bit (A, B, Sum);

input [255:0] A,B;
output [256:0] Sum;
wire [256:0] Sum;

wire [8:0] tempSum1, tempSum2, tempSum3, tempSum4, tempSum5, tempSum6, tempSum7, tempSum8;
wire [8:0] tempSum9, tempSum10, tempSum11, tempSum12, tempSum13, tempSum14, tempSum15, tempSum16;
wire [8:0] tempSum17, tempSum18, tempSum19, tempSum20, tempSum21, tempSum22, tempSum23, tempSum24;
wire [8:0] tempSum25, tempSum26, tempSum27, tempSum28, tempSum29, tempSum30, tempSum31, tempSum32;

wire tempCarry1, tempCarry2, tempCarry3, tempCarry4, tempCarry5, tempCarry6, tempCarry7, tempCarry8;
wire tempCarry9, tempCarry10, tempCarry11, tempCarry12, tempCarry13, tempCarry14, tempCarry15, tempCarry16;
wire tempCarry17, tempCarry18, tempCarry19, tempCarry20, tempCarry21, tempCarry22, tempCarry23, tempCarry24;
wire tempCarry25, tempCarry26, tempCarry27, tempCarry28, tempCarry29, tempCarry30, tempCarry31, tempCarry32;

wire f2, f3, f4, f5, f6, f7, f8;
wire f9, f10, f11, f12, f13, f14, f15, f16;
wire f17, f18, f19, f20, f21, f22, f23;
wire f24, f25, f26, f27, f28, f29, f30, f31, f32;

wire c1, c2, c3, c4, c5, c6, c7, c8;
wire c9, c10, c11, c12, c13, c14, c15, c16;
wire c17, c18, c19, c20, c21, c22, c23, c24;
wire c25, c26, c27, c28, c29, c30, c31, c32;

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
assign tempSum17 = A[135:128] + B[135:128];
assign tempSum18 = A[143:136] + B[143:136];
assign tempSum19 = A[151:144] + B[151:144];
assign tempSum20 = A[159:152] + B[159:152];
assign tempSum21 = A[167:160] + B[167:160];
assign tempSum22 = A[175:168] + B[175:168];
assign tempSum23 = A[183:176] + B[183:176];
assign tempSum24 = A[191:184] + B[191:184];
assign tempSum25 = A[199:192] + B[199:192];
assign tempSum26 = A[207:200] + B[207:200];
assign tempSum27 = A[215:208] + B[215:208];
assign tempSum28 = A[223:216] + B[223:216];
assign tempSum29 = A[231:224] + B[231:224];
assign tempSum30 = A[239:232] + B[239:232];
assign tempSum31 = A[247:240] + B[247:240];
assign tempSum32 = A[255:248] + B[255:248];

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
assign tempCarry17 = tempSum17[8];
assign tempCarry18 = tempSum18[8];
assign tempCarry19 = tempSum19[8];
assign tempCarry20 = tempSum20[8];
assign tempCarry21 = tempSum21[8];
assign tempCarry22 = tempSum22[8];
assign tempCarry23 = tempSum23[8];
assign tempCarry24 = tempSum24[8];
assign tempCarry25 = tempSum25[8];
assign tempCarry26 = tempSum26[8];
assign tempCarry27 = tempSum27[8];
assign tempCarry28 = tempSum28[8];
assign tempCarry29 = tempSum29[8];
assign tempCarry30 = tempSum30[8];
assign tempCarry31 = tempSum31[8];
assign tempCarry32 = tempSum32[8];

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
assign f17 = (tempSum17[7:0] == 8'hff);
assign f18 = (tempSum18[7:0] == 8'hff);
assign f19 = (tempSum19[7:0] == 8'hff);
assign f20 = (tempSum20[7:0] == 8'hff);
assign f21 = (tempSum21[7:0] == 8'hff);
assign f22 = (tempSum22[7:0] == 8'hff);
assign f23 = (tempSum23[7:0] == 8'hff);
assign f24 = (tempSum24[7:0] == 8'hff);
assign f25 = (tempSum25[7:0] == 8'hff);
assign f26 = (tempSum26[7:0] == 8'hff);
assign f27 = (tempSum27[7:0] == 8'hff);
assign f28 = (tempSum28[7:0] == 8'hff);
assign f29 = (tempSum29[7:0] == 8'hff);
assign f30 = (tempSum30[7:0] == 8'hff);
assign f31 = (tempSum31[7:0] == 8'hff);
assign f32 = (tempSum32[7:0] == 8'hff);

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
assign c17 = (c16 & f17) | tempCarry17;
assign c18 = (c17 & f18) | tempCarry18;
assign c19 = (c18 & f19) | tempCarry19;
assign c20 = (c19 & f20) | tempCarry20;
assign c21 = (c20 & f21) | tempCarry21;
assign c22 = (c21 & f22) | tempCarry22;
assign c23 = (c22 & f23) | tempCarry23;
assign c24 = (c23 & f24) | tempCarry24;
assign c25 = (c24 & f25) | tempCarry25;
assign c26 = (c25 & f26) | tempCarry26;
assign c27 = (c26 & f27) | tempCarry27;
assign c28 = (c27 & f28) | tempCarry28;
assign c29 = (c28 & f29) | tempCarry29;
assign c30 = (c29 & f30) | tempCarry30;
assign c31 = (c30 & f31) | tempCarry31;
assign c32 = (c31 & f32) | tempCarry32;


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

assign Sum[135:128] = c16 ? (tempSum17[7:0] + 1) : tempSum17[7:0];

assign Sum[143:136] = c17 ? (tempSum18[7:0] + 1) : tempSum18[7:0];

assign Sum[151:144] = c18 ? (tempSum19[7:0] + 1) : tempSum19[7:0];

assign Sum[159:152] = c19 ? (tempSum20[7:0] + 1) : tempSum20[7:0];

assign Sum[167:160] = c20 ? (tempSum21[7:0] + 1) : tempSum21[7:0];

assign Sum[175:168] = c21 ? (tempSum22[7:0] + 1) : tempSum22[7:0];

assign Sum[183:176] = c22 ? (tempSum23[7:0] + 1) : tempSum23[7:0];

assign Sum[191:184] = c23 ? (tempSum24[7:0] + 1) : tempSum24[7:0];

assign Sum[199:192] = c24 ? (tempSum25[7:0] + 1) : tempSum25[7:0];

assign Sum[207:200] = c25 ? (tempSum26[7:0] + 1) : tempSum26[7:0];

assign Sum[215:208] = c26 ? (tempSum27[7:0] + 1) : tempSum27[7:0];

assign Sum[223:216] = c27 ? (tempSum28[7:0] + 1) : tempSum28[7:0];

assign Sum[231:224] = c28 ? (tempSum29[7:0] + 1) : tempSum29[7:0];

assign Sum[239:232] = c29 ? (tempSum30[7:0] + 1) : tempSum30[7:0];

assign Sum[247:240] = c30 ? (tempSum31[7:0] + 1) : tempSum31[7:0];

assign Sum[255:248] = c31 ? (tempSum32[7:0] + 1) : tempSum32[7:0];

assign Sum[256] = c32;

endmodule

