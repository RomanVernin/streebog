// File name : l_transformation.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1ns/10ps
module l_transformation #(
 parameter DATA_WIDTH = 512
)  
(
input       wire                            clk_i,
input       wire                            rstn_i,
input       wire                            valid_in,  
input       wire        [DATA_WIDTH-1:0]    l_data_i,
output      logic       [DATA_WIDTH-1:0]    l_data_o,            
output      logic                           l_valid_out_o
);                  


logic [7:0] [DATA_WIDTH/8-1:0]  internal_in;
logic [7:0] [DATA_WIDTH/8-1:0]  internal_out;

always @(posedge clk_i or negedge rstn_i)
if (!rstn_i)
 internal_in     <= 'h0;
else 
 if(valid_in)
   begin    
    internal_in[7] <= l_data_i[63:0];
    internal_in[6] <= l_data_i[127:64];
    internal_in[5] <= l_data_i[191:128];
    internal_in[4] <= l_data_i[255:192];
    internal_in[3] <= l_data_i[319:256];
    internal_in[2] <= l_data_i[383:320];
    internal_in[1] <= l_data_i[447:384];
    internal_in[0] <= l_data_i[511:448];
   end

logic l_valid;
always @(posedge clk_i or negedge rstn_i)
if(!rstn_i)
  begin
   l_valid_out_o <= '0;
   l_valid       <= '0;
  end
else 
  begin
   l_valid       <= valid_in;    
   l_valid_out_o <= l_valid;
  end  


logic [DATA_WIDTH/8-1:0][DATA_WIDTH/8-1:0] A = {    
    64'h641c314b2b8ee083,
    64'hc83862965601dd1b,
    64'h8d70c431ac02a736,
    64'h07e095624504536c,
    64'h0edd37c48a08a6d8,
    64'h1ca76e95091051ad,
    64'h3853dc371220a247,
    64'h70a6a56e2440598e,
    64'ha48b474f9ef5dc18,
    64'h550b8e9e21f7a530,
    64'haa16012142f35760,
    64'h492c024284fbaec0,
    64'h9258048415eb419d,
    64'h39b008152acb8227,
    64'h727d102a548b194e,
    64'he4fa2054a80b329c,
    64'hf97d86d98a327728,
    64'heffa11af0964ee50,
    64'hc3e9224312c8c1a0,
    64'h9bcf4486248d9f5d,
    64'h2b838811480723ba,
    64'h561b0d22900e4669,
    64'hac361a443d1c8cd2,
    64'h456c34887a3805b9, 
    64'h5b068c651810a89e,
    64'hb60c05ca30204d21,
    64'h71180a8960409a42,
    64'he230140fc0802984,
    64'hd960281e9d1d5215,
    64'hafc0503c273aa42a,
    64'h439da0784e745554,
    64'h86275df09ce8aaa8,
    64'h0321658cba93c138,
    64'h0642ca05693b9f70,
    64'h0c84890ad27623e0,
    64'h18150f14b9ec46dd,
    64'h302a1e286fc58ca7,
    64'h60543c50de970553,
    64'hc0a878a0a1330aa6,
    64'h9d4df05d5f661451,
    64'haccc9ca9328a8950,
    64'h4585254f64090fa0,
    64'h8a174a9ec8121e5d,
    64'h092e94218d243cba,
    64'h125C354207487869,
    64'h24b86a840e90f0d2,
    64'h486dd4151c3dfdb9,
    64'h90dab52a387ae76f,
    64'h46b60f011a83988e,
    64'h8c711e02341b2d01,
    64'h05e23c0468365a02,
    64'h0ad97808d06cb404,
    64'h14aff010bdd87508,
    64'h2843fd2067adea10,
    64'h5086e740ce47c920,
    64'ha011d380818e8f40,
    64'h83478b07b2468764,
    64'h1b8e0b0e798c13c8, 
    64'h3601161cf205268d, 
    64'h6c022c38f90a4c07,
    64'hd8045870ef14980e,
    64'had08b0e0c3282d1c,
    64'h47107ddd9b505a38,
    64'h8e20faa72ba0b470
};   


always_comb
if(l_valid)
  begin
   for(int i = 7; i >= 0; i--)
     for(int j = 63; j >= 0; j--)
        if(internal_in[i][j]) 
          internal_out[i] = internal_out[i] ^ A[63 - j];
  end
else
internal_out = '0;


always @(posedge clk_i or negedge rstn_i)
if(!rstn_i)
  l_data_o   <= '0;                
else if(l_valid)
       l_data_o <= {internal_out[0],internal_out[1],internal_out[2],internal_out[3],internal_out[4],internal_out[5],internal_out[6],internal_out[7]};

endmodule

