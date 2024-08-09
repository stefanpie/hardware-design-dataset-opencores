
// this module will do csa decrypt work

module decrypt(clk,rst,ck,key_en,even_odd,en,encrypted,decrypted,invalid);
input             clk;
input             rst;
input             key_en;    // signal high valid,
input             even_odd;  // indiate the input ck is even or odd, 0 --- even odd ---odd
input             en;        // decrypted
input  [8*8-1:0]  ck;        // input ck
input  [  8-1:0]  encrypted; // input ts stream
output [  8-1:0]  decrypted; // decrypt ts stream
output            invalid;   // thsi output data is invalid


// key register 
reg  [56*8-1 : 0] even_kk;
reg  [56*8-1 : 0] odd_kk;
reg  [ 8*8-1 : 0] even_ck;
reg  [ 8*8-1 : 0] odd_ck;
reg               even_odd_d;

wire [56*8-1 : 0] kk;
wire              ks_busy;
wire              ks_done;

key_schedule ks( 
                        .clk  (clk)
                      , .rst  (rst)
                      , .start(key_en)
                      , .busy (ks_busy)
                      , .done (ks_done)
                      , .i_ck (ck)
                      , .o_kk (kk)
               );

always @(posedge clk)
begin
        if(rst)
        begin
                even_kk <=  448'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;       
                odd_kk <=  448'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;       
                even_ck <=  64'h0000000000000000;
                odd_ck <=  64'h0000000000000000;
        end
        else
        begin
                if(key_en & ~ks_busy)
                begin
                        even_odd_d <= even_odd;
                        if(even_odd)
                        begin
                                odd_ck <= ck;
                        end
                        else
                        begin
                                even_ck <= ck;
                        end
                end
                else if (ks_done)
                        if(even_odd_d)
                                odd_kk <= kk;
                        else
                                even_kk <= kk;
        end
end

// word grouper
reg  [8*8-1:0] group;    // 32bits
reg            sync;     // find sync
reg  [8-1:0]   ts_cnt;   // ts packet count
reg            using_even_odd_key; // 0 --- using even key; 1 --- using odd key
reg            need_dec;
reg            group_valid;
reg            group_valid_d;
reg            head;
reg   [5:0]    group_id;
reg [4*8-1:0] group_d;


always @(posedge clk)
        if (rst)
        begin
                group  <= 64'h00000000;
                sync   <= 1'h0;
                ts_cnt <= 8'h00;
                using_even_odd_key <= 1'h0;
                need_dec <= 1'h0;
                group_valid_d <=1'h0; 
                head <= 1'h0;
        end
        else
        begin
                group_valid <=1'h0;
                group_valid_d <= group_valid;
                head <= 1'h0;
                group_d <= group;
                if(sync)
                begin
                        if(en)
                                ts_cnt <= ts_cnt + 8'h01;
                        if(ts_cnt == 8'hb7 ) // 0xb8=188-4
                        begin
                                sync <= 1'h0;
                                ts_cnt<=8'h0;
                                group_valid<=1'h1;
                                group_id<=ts_cnt[7:3];
                        end
                        if(ts_cnt[2:0]==3'h7 && en )
                        begin
                                group_valid<=1'h1;
                                group_id<=ts_cnt[7:3];
                        end
                end
                if(en)
                begin
                        group  <= {  encrypted, group [8*8-1:1*8] };
                        if(group[5*8-1:4*8]==8'h47)
                        begin
                                sync   <= 1;
                                ts_cnt <= 8'h00;
                                using_even_odd_key <= group[62];
                                head  <= 1'h1;
                                group_d <= {1'h0,group[62:32]};
                        end
                end
        end

// decrypt
reg  [8*8-1:0] db;
reg            db_valid;

wire [56*8-1:0]kk_decrypt;
wire [ 8*8-1:0]ck_decrypt;

assign   kk_decrypt = (using_even_odd_key) ? odd_kk : even_kk ; 
assign   ck_decrypt = (using_even_odd_key) ? odd_ck : even_ck ; 

wire [8*8-1:0] sc_sb;
wire [8*8-1:0] sc_cb;
wire           init;
wire           sc_en;
wire           last;

assign sc_sb = group;
assign init  = group_id == 5'h00;
assign last  = group_id == 5'd22;
reg     [2:0] last_cnt;
reg     last_run;
assign sc_en = group_valid;

stream_cypher sc(  
                    .clk   (clk)
                  , .rst   (rst)
                  , .en    (sc_en)
                  , .init  (init)
                  , .ck    (ck_decrypt)
                  , .sb    (sc_sb)
                  , .cb    (sc_cb)
                  );

wire [ 8*8-1:0]   bco;
reg  [ 8*8-1:0]   bc;
reg  [ 8*8-1:0]   ib;
block_decypher bcm(
                          .kk (kk_decrypt)
                        , .ib (ib[8*8-1:0])
                        , .bd (bco)
                        );


always @(posedge clk)
if(rst)
begin
        db <= 64'h00;
        ib <= 128'h00000000000000000000000000000000;
        bc <= 64'hffffffffffffffff;
        last_cnt<=3'h0;
        last_run<=1'h0;
end
else
begin
        db_valid<=1'h0;                        
        if(group_valid_d)
        begin
                bc<=bco;
                if(init)
                begin
                        ib<={ ib[8*8-1:0],sc_cb };
                        db<=bco^sc_cb;
                end
                else
                begin
                        ib<={ ib[8*8-1:0],sc_cb^sc_sb };
                        db<=bco^sc_cb^sc_sb;
                end
                if(group_id>1'h0)
                begin
                        db_valid<=1'h1;                        
                end

                if(last)
                        last_run<=1'h1;

        end
        if(last_run)
        begin
                last_cnt<=last_cnt+3'h1;
                if(last_cnt==3'h7)
                begin
                        db_valid<=1'h1;                        
                        db<=bco;
                        last_run<=1'h0;
                end

        end
end

// degrouper
reg [2:0]     cnt;
reg           invalid;
reg [7:0]     decrypted;
reg [7*8-1:0] dec_group_ouput;

always @(posedge clk)
        if(rst)
        begin
                dec_group_ouput <= 32'h00000000;
                cnt <= 2'h0;
        end
        else
        begin
                invalid <= 1'h0;
                if(db_valid)
                begin
                        dec_group_ouput <= db[8*8-1:1*8];
                        decrypted <= db[7:0];
                        cnt <= 3'h7;
                        invalid <= 1'h1;
                end
                if(cnt)
                begin
                        invalid <= 1'h1;
                        dec_group_ouput <= {dec_group_ouput [7:0],dec_group_ouput[7*8-1:1*8]};
                        decrypted <= dec_group_ouput [ 7:0 ];
                        cnt <= cnt - 2'h1;
                end
                if(head)
                begin
                        dec_group_ouput <= group_d[4*8-1:1*8];
                        decrypted <= group_d[7:0];
                        cnt <= 2'h3;
                        invalid <= 1'h1;
                end
        end



endmodule
