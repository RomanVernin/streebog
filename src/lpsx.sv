// File name : lpsx.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1 ns/10 ps
module lpsx #(
    parameter DATA_WIDTH = 512      
)
(
input   wire                        clk_i,          //system clock
input   wire                        rstn_i,         //asynch active low reset
input   wire                        data_ab_valid_i, //input valid A  
input   wire  [DATA_WIDTH-1:0]      data_a_i,       //input data  A
input   wire  [DATA_WIDTH-1:0]      data_b_i,       //input data  B

output  logic                       l_valid_o,     //output valid signal
output  logic [DATA_WIDTH-1:0]      l_data_o      //output data

);
        
logic [DATA_WIDTH-1:0]      s_data_out;
logic [DATA_WIDTH-1:0]      p_data_out;
logic [DATA_WIDTH-1:0]      data_in;   
   
assign data_in = data_a_i ^ data_b_i;  

sub_bytes
#(.DATA_WIDTH(DATA_WIDTH))
 u_sub_byses
(
    .clk        (clk_i           ),                    
    .reset      (rstn_i          ),                  
    .valid_in   (data_ab_valid_i ),                
    .data_in    (data_in         ),    
    .valid_out  (valid_out       ),      
    .data_out   (s_data_out      )   
);

p_permutation  
#(.DATA_WIDTH(DATA_WIDTH))
    u_p_permutation	
    (
    .clk_i      (clk_i      ),
    .rstn_i     (rstn_i     ),
    .valid_in   (valid_out ),
    .i_data     (s_data_out ),
    .o_data     (p_data_out ) ,
    .valid_out  (valid_out_p  )
    );
 
l_transformation 
    #(.DATA_WIDTH(DATA_WIDTH))
u_l_transformation 
    (
    .clk_i          (clk_i      ),
    .rstn_i         (rstn_i     ),
    .valid_in       (valid_out_p),
    .l_data_i       (p_data_out ),
    .l_data_o       (l_data_o    ),          
    .l_valid_out_o  (l_valid_o)
    );
  
endmodule