// File name : g_function.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1 ns/10 ps
module g_function#(
     parameter DATA_WIDTH = 512
    )  
  (
// system
input   wire                  clk_i,          //system clock
input   wire                  rstn_i,         //asynch active low reset
// n data
input [DATA_WIDTH-1:0]        n_data_i,
// m data
input [DATA_WIDTH-1:0]        m_data_i,
// h data
input [DATA_WIDTH-1:0]        h_data_i,
input                         g_valid_i,
// hash data out
output logic [DATA_WIDTH-1:0] hash_data_o,
output logic                  hash_data_valid_o


);

logic [0:11] [DATA_WIDTH-1:0] c;
always_comb
  begin
 c = {   512'hb1085bda1ecadae9ebcb2f81c0657c1f_2f6a76432e45d016714eb88d7585c4fc_4b7ce09192676901a2422a08a460d315_05767436cc744d23dd806559f2a64507, 	
         512'h6fa3b58aa99d2f1a4fe39d460f70b5d7_f3feea720a232b9861d55e0f16b50131_9ab5176b12d699585cb561c2db0aa7ca_55dda21bd7cbcd56e679047021b19bb7,
         512'hf574dcac2bce2fc70a39fc286a3d8435_06f15e5f529c1f8bf2ea7514b1297b7b_d3e20fe490359eb1c1c93a376062db09_c2b6f443867adb31991e96f50aba0ab2, 
         512'hef1fdfb3e81566d2f948e1a05d71e4dd_488e857e335c3c7d9d721cad685e353f_a9d72c82ed03d675d8b71333935203be_3453eaa193e837f1220cbebc84e3d12e,    	
         512'h4bea6bacad4747999a3f410c6ca92363_7f151c1f1686104a359e35d7800fffbd_bfcd1747253af5a3dfff00b723271a16_7a56a27ea9ea63f5601758fd7c6cfe57,	       
         512'hae4faeae1d3ad3d96fa4c33b7a3039c0_2d66c4f95142a46c187f9ab49af08ec6_cffaa6b71c9ab7b40af21f66c2bec6b6_bf71c57236904f35fa68407a46647d6e,  	
         512'hf4c70e16eeaac5ec51ac86febf240954_399ec6c7e6bf87c9d3473e33197a93c9_0992abc52d822c3706476983284a0504_3517454ca23c4af38886564d3a14d493,   	   	
         512'h9b1f5b424d93c9a703e7aa020c6e4141_4eb7f8719c36de1e89b4443b4ddbc49a_f4892bcb929b069069d18d2bd1a5c42f_36acc2355951a8d9a47f0dd4bf02e71e,
         512'h378f5a541631229b944c9ad8ec165fde_3a7d3a1b258942243cd955b7e00d0984_800a440bdbb2ceb17b2b8a9aa6079c54_0e38dc92cb1f2a607261445183235adb,	   	
         512'habbedea680056f52382ae548b2e4f3f3_8941e71cff8a78db1fffe18a1b336103_9fe76702af69334b7a1e6c303b7652f4_3698fad1153bb6c374b4c7fb98459ced,   	
         512'h7bcd9ed0efc889fb3002c6cd635afe94_d8fa6bbbebab07612001802114846679_8a1d71efea48b9caefbacd1d7d476e98_dea2594ac06fd85d6bcaa4cd81f32d1b,	   	
         512'h378ee767f11631bad21380b00449b17a_cda43c32bcdf1d77f82012d430219f9b_5d80ef9d1891cc86e71da4aa88e12852_faf417d5d9b21b9948bc924af11bd720
 };
  end


logic [DATA_WIDTH-1:0] h_a_in;
logic [DATA_WIDTH-1:0] k_a;
logic                  a_in_valid;
logic [DATA_WIDTH-1:0] h_a_out;
logic                  h_a_out_valid;

logic [DATA_WIDTH-1:0] h_b_in;
logic [DATA_WIDTH-1:0] k_b;
logic                  b_in_valid;
logic [DATA_WIDTH-1:0] h_b_out;
logic                  h_b_out_valid;


//`define PRECALC

`ifdef PRECALC
        
lpsx_precalc #(
    .DATA_WIDTH         (512)
) u_lpsx_a (
    //
    .clk_i   (clk_i         ),
    .rstn_i  (rstn_i        ),
    //
    .valid_i (a_in_valid    ),  
    .lps_n_i (h_a_in        ),
    .lps_m_i (k_a           ),   
     //
    .valid_o (h_a_out_valid ),        
    .lps_o   (h_a_out       )  
);                  

lpsx_precalc #(
    .DATA_WIDTH         (512)
) u_lpsx_b (
    //
    .clk_i   (clk_i         ),    
    .rstn_i  (rstn_i        ),
    //
    .valid_i (b_in_valid    ),      
    .lps_n_i (h_b_in        ),    
    .lps_m_i (k_b           ), 
    //
    .valid_o (h_b_out_valid ),       
    .lps_o   (h_b_out       )     
);

`else

lpsx #(
    .DATA_WIDTH         (512)
) u_lpsx_a (
    //system clock
    .clk_i              (clk_i         ),    
    .rstn_i             (rstn_i        ),  
    //input
    .data_ab_valid_i    (a_in_valid    ),     
    .data_a_i           (h_a_in        ),    
    .data_b_i           (k_a           ),
    // output
    .l_valid_o          (h_a_out_valid ),
    .l_data_o           (h_a_out       )
);


lpsx #(
    .DATA_WIDTH         (512)
) u_lpsx_b (
     //system clock
    .clk_i              (clk_i         ),
    .rstn_i             (rstn_i        ),
    ///input
    .data_ab_valid_i    (b_in_valid    ),    
    .data_a_i           (h_b_in        ),    
    .data_b_i           (k_b           ),
    //output
    .l_valid_o          (h_b_out_valid ),
    .l_data_o           (h_b_out       )
);

`endif


// c column

enum {IDLE,WAIT_OUT_H} state,state_m; 

localparam CNT_C_MAX = 12;
logic [3:0] cnt_c;

logic [12:0][DATA_WIDTH-1:0] k_data;
//logic [12:0]                 k_valid;
logic                  k_valid;
logic [DATA_WIDTH-1:0] hm_xor;

localparam CNT_M_MAX = 11;
logic [3:0] cnt_m;

always@(posedge clk_i or negedge rstn_i)
if(!rstn_i)
  begin
   k_data     <= '0;
   k_valid    <= '0;   
   k_b        <= '0; 
   h_b_in     <= '0;
   b_in_valid <= '0;  
   state    <= IDLE;
   cnt_c      <= '0;
  end
else case (state)
      IDLE :        if(g_valid_i)
                      begin                     
                       k_b        <= n_data_i;                                       
                       h_b_in     <= h_data_i;
                       hm_xor     <= m_data_i ^ h_data_i;
                       b_in_valid <= '1;                  
                       state      <= WAIT_OUT_H;                                 
                      end
       WAIT_OUT_H : if(h_b_out_valid)  
                      begin
                       k_data[cnt_c]  <= h_b_out;
                       k_valid        <= '1;
                       h_b_in         <= h_b_out;
                       if(cnt_c < CNT_C_MAX)
                         k_b <= c[cnt_c]; 
                       if(cnt_c == CNT_C_MAX)
                         b_in_valid <= '0;
                       else
                         b_in_valid <= '1;                              
                       cnt_c <= cnt_c + 1'b1;  
                      end
                    else
                     begin
                      b_in_valid <= '0;
                      if((cnt_c == CNT_C_MAX+1)&(cnt_m == CNT_M_MAX))
                        begin
                         cnt_c <= '0;                  
                         state <= IDLE;  
                         k_valid <= '0;              
                        end
                     end
      default state <= IDLE;               
      endcase
                    



always@(posedge clk_i or negedge rstn_i)
if(!rstn_i)
  begin
   k_a               <= '0;
   h_a_in            <= '0;
   a_in_valid        <= '0;    
   state_m           <= IDLE;  
   cnt_m             <= '0; 
   hash_data_o       <= '0;
   hash_data_valid_o <= '0;
   hm_xor            <= '0; 
  end
else case(state_m)
       IDLE :          begin 
                        hash_data_valid_o <= '0;
                        if(g_valid_i)                                                       
                          h_a_in    <= m_data_i;                          
                        if(k_valid)
                          begin
                           k_a        <= k_data[0];
                           a_in_valid <= '1;
                           state_m    <= WAIT_OUT_H;
                          end                        
                        end       
        
        WAIT_OUT_H :    if(h_a_out_valid)  
                          begin
                           h_a_in <= h_a_out;
                           k_a    <= k_data[cnt_m + 1];
                           if(cnt_m == CNT_M_MAX) 
                             a_in_valid <= '0;
                           else
                             a_in_valid <= '1;                                
                           cnt_m <= cnt_m + 1'b1;  
                          end
                        else
                         begin
                          a_in_valid    <= '0;
                          if(cnt_m == CNT_M_MAX+1)
                            begin
                             cnt_m             <= '0;                  
                             hash_data_o       <= h_a_out ^ k_data[12] ^ hm_xor ;
                             hash_data_valid_o <= '1;                            
                             state_m           <= IDLE;                   
                            end
                         end
        default state_m <= IDLE;
       endcase

endmodule