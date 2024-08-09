
//this moudule preform the s-boxes transform

module sboxes(A, s1, s2, s3, s4, s5, s6, s7);
input [9*4-1:0] A;

output [2-1:0] s1;
output [2-1:0] s2;
output [2-1:0] s3;
output [2-1:0] s4;
output [2-1:0] s5;
output [2-1:0] s6;
output [2-1:0] s7;

sbox1 b1({A[(4-1)*4+0], A[(1-1)*4+2], A[(6-1)*4+1], A[(7-1)*4+3], A[(9-1)*4+0]}, s1);
sbox2 b2({A[(2-1)*4+1], A[(3-1)*4+2], A[(6-1)*4+3], A[(7-1)*4+0], A[(9-1)*4+1]}, s2);
sbox3 b3({A[(1-1)*4+3], A[(2-1)*4+0], A[(5-1)*4+1], A[(5-1)*4+3], A[(6-1)*4+2]}, s3);
sbox4 b4({A[(3-1)*4+3], A[(1-1)*4+1], A[(2-1)*4+3], A[(4-1)*4+2], A[(8-1)*4+0]}, s4);
sbox5 b5({A[(5-1)*4+2], A[(4-1)*4+3], A[(6-1)*4+0], A[(8-1)*4+1], A[(9-1)*4+2]}, s5);
sbox6 b6({A[(3-1)*4+1], A[(4-1)*4+1], A[(5-1)*4+0], A[(7-1)*4+2], A[(9-1)*4+3]}, s6);
sbox7 b7({A[(2-1)*4+2], A[(3-1)*4+0], A[(7-1)*4+1], A[(8-1)*4+2], A[(8-1)*4+3]}, s7);

endmodule
