// File name : sub_bytes.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1 ns/10 ps
module sub_bytes
#
(
 parameter DATA_WIDTH = 512,            //data width
 parameter NO_BYTES = DATA_WIDTH >> 3  //no of bytes = data width / 8
)
(
input                   clk,       //system clock
input                   reset,     //asynch active low reset
input                   valid_in,  //input valid signal  
input [DATA_WIDTH-1:0]  data_in,   //input data
output reg              valid_out, //output valid signal
output [DATA_WIDTH-1:0] data_out   //output data
);


genvar i;
generate                      
for (i=0; i< NO_BYTES ; i=i+1) begin : ROM
  sbox ROM(clk,reset,valid_in,data_in[(i*8)+7:(i*8)],data_out[(i*8)+7:(i*8)]);   
end
endgenerate

assign valid_out = valid_in;

endmodule

