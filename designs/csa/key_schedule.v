// this key_schedule module
module key_schedule(clk,rst,start,i_ck,busy,done,o_kk);
        input             clk;
        input             rst;
        input             start;
        input  [ 8*8-1:0] i_ck;
        output            busy;
        output            done;
        output [56*8-1:0] o_kk;

        reg    [56*8-1:0] o_kk;
        reg    [     2:0] cnt;

        wire   [ 8*8-1:0] ik;
        wire   [ 8*8-1:0] okd;
        wire   [ 8*8-1:0] oki;
        reg    [ 8*8-1:0] ok_d;
        reg               done;
        reg               busy;

        key_perm kpo(.i_key(ok_d), .o_key(okd));
        key_perm kpi(.i_key(i_ck), .o_key(oki));

        always @(posedge clk)
        begin
                done <= 1'h0;
                if(rst)
                begin
                        o_kk <= 448'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
                        cnt  <= 3'h0;
                        ok_d <= 64'h0000000000000000;
                        busy <= 1'h0;
                end
                else 
                begin
                        if(cnt==3'h0 && busy)
                        begin
                                busy <= 1'h0;
                                done <= 1'h1;
                        end


                        if(start & ~busy)
                        begin
                                cnt  <= 3'h5;
                                o_kk <= {o_kk [(6*8)*8-1:8*0], i_ck};
                                busy <= 1'h1;
                                ok_d <= oki;
                                o_kk <= {o_kk [(6*8)*8-1:8*0],
                                                oki ^ 64'h0606060606060606};
                        end

                        if(busy)
                        begin
                                o_kk <= {o_kk [(6*8)*8-1:8*0],
                                                ok_d ^ { 
                                                        5'h00, cnt,
                                                        5'h00, cnt,
                                                        5'h00, cnt,
                                                        5'h00, cnt,
                                                        5'h00, cnt,
                                                        5'h00, cnt,
                                                        5'h00, cnt,
                                                        5'h00, cnt 
                                                      } 
                                         };
                                if(cnt!=3'h0)
                                        cnt  <= cnt - 3'h1;
                                ok_d <= okd;
                        end
                end
        end


//        wire   [64*8-1:0] kb;
//        assign kb[(8*8)*8-1:(7*8)*8] = i_ck;
//
//        key_perm k1( .i_key(kb[(8*8)*8-1:(7*8)*8]) ,.o_key(kb[(7*8)*8-1:(6*8)*8]));
//        key_perm k2( .i_key(kb[(7*8)*8-1:(6*8)*8]) ,.o_key(kb[(6*8)*8-1:(5*8)*8]));
//        key_perm k3( .i_key(kb[(6*8)*8-1:(5*8)*8]) ,.o_key(kb[(5*8)*8-1:(4*8)*8]));
//        key_perm k4( .i_key(kb[(5*8)*8-1:(4*8)*8]) ,.o_key(kb[(4*8)*8-1:(3*8)*8]));
//        key_perm k5( .i_key(kb[(4*8)*8-1:(3*8)*8]) ,.o_key(kb[(3*8)*8-1:(2*8)*8]));
//        key_perm k6( .i_key(kb[(3*8)*8-1:(2*8)*8]) ,.o_key(kb[(2*8)*8-1:(1*8)*8]));
//        key_perm k7( .i_key(kb[(2*8)*8-1:(1*8)*8]) ,.o_key(kb[(1*8)*8-1:(0*8)*8]));
//
//        assign o_kk [(1*8)*8-1:(0*8)*8] = kb[(2*8)*8-1:(1*8)*8] ^ 64'h0000000000000000;
//        assign o_kk [(2*8)*8-1:(1*8)*8] = kb[(3*8)*8-1:(2*8)*8] ^ 64'h0101010101010101;
//        assign o_kk [(3*8)*8-1:(2*8)*8] = kb[(4*8)*8-1:(3*8)*8] ^ 64'h0202020202020202;
//        assign o_kk [(4*8)*8-1:(3*8)*8] = kb[(5*8)*8-1:(4*8)*8] ^ 64'h0303030303030303;
//        assign o_kk [(5*8)*8-1:(4*8)*8] = kb[(6*8)*8-1:(5*8)*8] ^ 64'h0404040404040404;
//        assign o_kk [(6*8)*8-1:(5*8)*8] = kb[(7*8)*8-1:(6*8)*8] ^ 64'h0505050505050505;
//        assign o_kk [(7*8)*8-1:(6*8)*8] = kb[(8*8)*8-1:(7*8)*8] ^ 64'h0606060606060606;


endmodule
