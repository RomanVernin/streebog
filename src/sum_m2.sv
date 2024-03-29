// File name : sum_m2.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1 ns/10 ps
module sum_m2#(
     parameter DATA_WIDTH = 512
    )  
(
input   wire                        clk_i,         
input   wire                        rstn_i, 

input                               clear_i,

input   wire                        data_valid_i, //input valid A  
input   wire  [DATA_WIDTH-1:0]      data_i,       //input data  A

output  logic                       data_valid_o,  //output valid signal
output  logic [DATA_WIDTH-1:0]      data_o        //output data

);

always@(posedge clk_i or negedge rstn_i)
if(!rstn_i)
  begin
   data_valid_o <= '0;
   data_o       <= '0;
  end
else if(clear_i)
       begin
        data_valid_o <= '0;
        data_o       <= '0;
       end
     else
      if(data_valid_i)
        begin
         data_valid_o <= '1;   
         for(int i = 0; i < 64 ; i++)
            data_o <= data_o + data_i;
        end 
      else
        data_valid_o <= '0;

endmodule
