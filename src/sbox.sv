// File name : sbox.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1 ns/10 ps
module sbox               
(
input       clk_i,          //system clock
input       rstn_i,         //asynch active low reset
input       valid_in,       //valid input signal
input [7:0] state_i,        //SBox input byte
output reg [7:0] state_o    //SBox output
);

always_comb
case (state_i)       //substitution table
8'h00              : state_o = 8'hfc;
8'h01              : state_o = 8'hee;
8'h02              : state_o = 8'hdd;
8'h03              : state_o = 8'h11;
8'h04              : state_o = 8'hcf;
8'h05              : state_o = 8'h6e;
8'h06              : state_o = 8'h31;
8'h07              : state_o = 8'h16;
8'h08              : state_o = 8'hfb;
8'h09              : state_o = 8'hc4;
8'h0a              : state_o = 8'hfa;
8'h0b              : state_o = 8'hda;
8'h0c              : state_o = 8'h23;
8'h0d              : state_o = 8'hc5;
8'h0e              : state_o = 8'h04;
8'h0f              : state_o = 8'h4d;
///////////////////////////////////////
8'h10              : state_o = 8'he9;
8'h11              : state_o = 8'h77;
8'h12              : state_o = 8'hf0;
8'h13              : state_o = 8'hdb;
8'h14              : state_o = 8'h93;
8'h15              : state_o = 8'h2e;
8'h16              : state_o = 8'h99;
8'h17              : state_o = 8'hba;
8'h18              : state_o = 8'h17;
8'h19              : state_o = 8'h36;
8'h1a              : state_o = 8'hf1;
8'h1b              : state_o = 8'hbb;
8'h1c              : state_o = 8'h14;
8'h1d              : state_o = 8'hcd;
8'h1e              : state_o = 8'h5f;
8'h1f              : state_o = 8'hc1;
///////////////////////////////////////
8'h20              : state_o = 8'hf9;
8'h21              : state_o = 8'h18;
8'h22              : state_o = 8'h65;
8'h23              : state_o = 8'h5a;
8'h24              : state_o = 8'he2;
8'h25              : state_o = 8'h5c;
8'h26              : state_o = 8'hef;
8'h27              : state_o = 8'h21;
8'h28              : state_o = 8'h81;
8'h29              : state_o = 8'h1c;
8'h2a              : state_o = 8'h3c;
8'h2b              : state_o = 8'h42;
8'h2c              : state_o = 8'h8b;
8'h2d              : state_o = 8'h01;
8'h2e              : state_o = 8'h8e;
8'h2f              : state_o = 8'h4f;
///////////////////////////////////////
8'h30              : state_o = 8'h05;
8'h31              : state_o = 8'h84;
8'h32              : state_o = 8'h02;
8'h33              : state_o = 8'hae;
8'h34              : state_o = 8'he3;
8'h35              : state_o = 8'h6a;
8'h36              : state_o = 8'h8f;
8'h37              : state_o = 8'ha0;
8'h38              : state_o = 8'h06;
8'h39              : state_o = 8'h0b;
8'h3a              : state_o = 8'hed;
8'h3b              : state_o = 8'h98;
8'h3c              : state_o = 8'h7f;
8'h3d              : state_o = 8'hd4;
8'h3e              : state_o = 8'hd3;
8'h3f              : state_o = 8'h1f;
///////////////////////////////////////
8'h40              : state_o = 8'heb;
8'h41              : state_o = 8'h34;
8'h42              : state_o = 8'h2c;
8'h43              : state_o = 8'h51;
8'h44              : state_o = 8'hea;
8'h45              : state_o = 8'hc8;       
8'h46              : state_o = 8'h48;
8'h47              : state_o = 8'hab;
8'h48              : state_o = 8'hf2;
8'h49              : state_o = 8'h2a;
8'h4a              : state_o = 8'h68;
8'h4b              : state_o = 8'ha2;
8'h4c              : state_o = 8'hfd;
8'h4d              : state_o = 8'h3a;
8'h4e              : state_o = 8'hce;
8'h4f              : state_o = 8'hcc;
///////////////////////////////////////
8'h50              : state_o = 8'hb5;
8'h51              : state_o = 8'h70;
8'h52              : state_o = 8'h0e;
8'h53              : state_o = 8'h56;
8'h54              : state_o = 8'h08;
8'h55              : state_o = 8'h0c;
8'h56              : state_o = 8'h76;
8'h57              : state_o = 8'h12;
8'h58              : state_o = 8'hbf;
8'h59              : state_o = 8'h72;
8'h5a              : state_o = 8'h13;
8'h5b              : state_o = 8'h47;
8'h5c              : state_o = 8'h9c;
8'h5d              : state_o = 8'hb7;
8'h5e              : state_o = 8'h5d;
8'h5f              : state_o = 8'h87;
///////////////////////////////////////
8'h60              : state_o = 8'h15;
8'h61              : state_o = 8'ha1;
8'h62              : state_o = 8'h96;
8'h63              : state_o = 8'h29;
8'h64              : state_o = 8'h10;
8'h65              : state_o = 8'h7b;
8'h66              : state_o = 8'h9a;
8'h67              : state_o = 8'hc7;
8'h68              : state_o = 8'hf3;
8'h69              : state_o = 8'h91;
8'h6a              : state_o = 8'h78;
8'h6b              : state_o = 8'h6f;
8'h6c              : state_o = 8'h9d;
8'h6d              : state_o = 8'h9e;
8'h6e              : state_o = 8'hb2;
8'h6f              : state_o = 8'hb1;
///////////////////////////////////////  
8'h70              : state_o = 8'h32;
8'h71              : state_o = 8'h75;
8'h72              : state_o = 8'h19;
8'h73              : state_o = 8'h3d;
8'h74              : state_o = 8'hff;
8'h75              : state_o = 8'h35;
8'h76              : state_o = 8'h8a;
8'h77              : state_o = 8'h7e;
8'h78              : state_o = 8'h6d;
8'h79              : state_o = 8'h54;
8'h7a              : state_o = 8'hc6;
8'h7b              : state_o = 8'h80;
8'h7c              : state_o = 8'hc3;
8'h7d              : state_o = 8'hbd;
8'h7e              : state_o = 8'h0d;
8'h7f              : state_o = 8'h57;
///////////////////////////////////////
8'h80              : state_o = 8'hdf;
8'h81              : state_o = 8'hf5;
8'h82              : state_o = 8'h24;
8'h83              : state_o = 8'ha9;
8'h84              : state_o = 8'h3e;
8'h85              : state_o = 8'ha8;
8'h86              : state_o = 8'h43;
8'h87              : state_o = 8'hc9;
8'h88              : state_o = 8'hd7;
8'h89              : state_o = 8'h79;
8'h8a              : state_o = 8'hd6;
8'h8b              : state_o = 8'hf6;
8'h8c              : state_o = 8'h7c;
8'h8d              : state_o = 8'h22;
8'h8e              : state_o = 8'hb9;
8'h8f              : state_o = 8'h03;
///////////////////////////////////////
8'h90              : state_o = 8'he0;
8'h91              : state_o = 8'h0f;
8'h92              : state_o = 8'hec;
8'h93              : state_o = 8'hde;
8'h94              : state_o = 8'h7a;
8'h95              : state_o = 8'h94;
8'h96              : state_o = 8'hb0;
8'h97              : state_o = 8'hbc;
8'h98              : state_o = 8'hdc;
8'h99              : state_o = 8'he8;
8'h9a              : state_o = 8'h28;
8'h9b              : state_o = 8'h50;
8'h9c              : state_o = 8'h4e;
8'h9d              : state_o = 8'h33;
8'h9e              : state_o = 8'h0a;
8'h9f              : state_o = 8'h4a;
///////////////////////////////////////
8'ha0              : state_o = 8'ha7;
8'ha1              : state_o = 8'h97;
8'ha2              : state_o = 8'h60;
8'ha3              : state_o = 8'h73;
8'ha4              : state_o = 8'h1e;
8'ha5              : state_o = 8'h00;
8'ha6              : state_o = 8'h62;
8'ha7              : state_o = 8'h44;
8'ha8              : state_o = 8'h1a;
8'ha9              : state_o = 8'hb8;
8'haa              : state_o = 8'h38;
8'hab              : state_o = 8'h82;
8'hac              : state_o = 8'h64;
8'had              : state_o = 8'h9f;
8'hae              : state_o = 8'h26;
8'haf              : state_o = 8'h41;
///////////////////////////////////////
8'hb0              : state_o = 8'had;
8'hb1              : state_o = 8'h45;
8'hb2              : state_o = 8'h46;
8'hb3              : state_o = 8'h92;
8'hb4              : state_o = 8'h27;
8'hb5              : state_o = 8'h5e;
8'hb6              : state_o = 8'h55;
8'hb7              : state_o = 8'h2f;
8'hb8              : state_o = 8'h8c;
8'hb9              : state_o = 8'ha3;
8'hba              : state_o = 8'ha5;
8'hbb              : state_o = 8'h7d;
8'hbc              : state_o = 8'h69;
8'hbd              : state_o = 8'hd5;
8'hbe              : state_o = 8'h95;
8'hbf              : state_o = 8'h3b;
///////////////////////////////////////
8'hc0              : state_o = 8'h07;
8'hc1              : state_o = 8'h58;
8'hc2              : state_o = 8'hb3;
8'hc3              : state_o = 8'h40;
8'hc4              : state_o = 8'h86;
8'hc5              : state_o = 8'hac;
8'hc6              : state_o = 8'h1d;
8'hc7              : state_o = 8'hf7;
8'hc8              : state_o = 8'h30;
8'hc9              : state_o = 8'h37;
8'hca              : state_o = 8'h6b;
8'hcb              : state_o = 8'he4;
8'hcc              : state_o = 8'h88;
8'hcd              : state_o = 8'hd9;
8'hce              : state_o = 8'he7;
8'hcf              : state_o = 8'h89;
///////////////////////////////////////
8'hd0              : state_o = 8'he1;
8'hd1              : state_o = 8'h1b;
8'hd2              : state_o = 8'h83;
8'hd3              : state_o = 8'h49;
8'hd4              : state_o = 8'h4c;
8'hd5              : state_o = 8'h3f;
8'hd6              : state_o = 8'hf8;
8'hd7              : state_o = 8'hfe;
8'hd8              : state_o = 8'h8d;
8'hd9              : state_o = 8'h53;
8'hda              : state_o = 8'haa;
8'hdb              : state_o = 8'h90;
8'hdc              : state_o = 8'hca;
8'hdd              : state_o = 8'hd8;
8'hde              : state_o = 8'h85;
8'hdf              : state_o = 8'h61;
///////////////////////////////////////
8'he0              : state_o = 8'h20;
8'he1              : state_o = 8'h71;
8'he2              : state_o = 8'h67;
8'he3              : state_o = 8'ha4;
8'he4              : state_o = 8'h2d;
8'he5              : state_o = 8'h2b;
8'he6              : state_o = 8'h09;
8'he7              : state_o = 8'h5b;
8'he8              : state_o = 8'hcb;
8'he9              : state_o = 8'h9b;
8'hea              : state_o = 8'h25;
8'heb              : state_o = 8'hd0;
8'hec              : state_o = 8'hbe;
8'hed              : state_o = 8'he5;
8'hee              : state_o = 8'h6c;
8'hef              : state_o = 8'h52;
///////////////////////////////////////
8'hf0              : state_o = 8'h59;
8'hf1              : state_o = 8'ha6;
8'hf2              : state_o = 8'h74;
8'hf3              : state_o = 8'hd2;
8'hf4              : state_o = 8'he6;
8'hf5              : state_o = 8'hf4;
8'hf6              : state_o = 8'hb4;
8'hf7              : state_o = 8'hc0;
8'hf8              : state_o = 8'hd1;
8'hf9              : state_o = 8'h66;
8'hfa              : state_o = 8'haf;
8'hfb              : state_o = 8'hc2;
8'hfc              : state_o = 8'h39;
8'hfd              : state_o = 8'h4b;
8'hfe              : state_o = 8'h63;
8'hff              : state_o = 8'hb6;
default            : state_o = 8'h00;
endcase

endmodule 

