// File name : p_permutation.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1ns / 10ps
module p_permutation #(
parameter DATA_WIDTH = 512
)
(
input  wire                        clk_i,
input  wire                        rstn_i,
input  wire                        valid_in,
input  wire     [DATA_WIDTH-1:0]   i_data,
output logic    [DATA_WIDTH-1:0]   o_data, 
output logic                       valid_out  
);
  

always_comb
begin
o_data [511:504] = i_data [511:504]; 
o_data [447:440] = i_data [503:496]; 
o_data [383:376] = i_data [495:488];
o_data [319:312] = i_data [487:480]; 
o_data [255:248] = i_data [479:472]; 
o_data [191:184] = i_data [471:464]; 
o_data [127:120] = i_data [463:456]; 
o_data [63:56]	 = i_data [455:448];  
//-- second  row in the second column ----
o_data [503:496] = i_data [447:440]; 
o_data [439:432] = i_data [439:432]; 
o_data [375:368] = i_data [431:424]; 
o_data [311:304] = i_data [423:416]; 
o_data [247:240] = i_data [415:408];
o_data [183:176] = i_data [407:400]; 
o_data [119:112] = i_data [399:392]; 
o_data [55:48] 	 = i_data [391:384]; 
//---- third row to third column -----
o_data [495:488] = i_data [383:376]; 
o_data [431:424] = i_data [375:368]; 
o_data [367:360] = i_data [367:360]; 
o_data [303:296] = i_data [359:352]; 
o_data [239:232] = i_data [351:344]; 
o_data [175:168] = i_data [343:336];  
o_data [111:104] = i_data [335:328];
o_data [47:40] 	 = i_data [327:320];  
//--  fourth row to fourth column -------
o_data [487:480] = i_data [319:312]; 
o_data [423:416] = i_data [311:304]; 
o_data [359:352] = i_data [303:296]; 
o_data [295:288] = i_data [295:288]; 
o_data [231:224] = i_data [287:280]; 
o_data [167:160] = i_data [279:272]; 
o_data [103:96]  = i_data [271:264];  
o_data [39:32]   = i_data [263:256];  
//---  line five to column five ---------
o_data [479:472] = i_data [255:248]; 
o_data [415:408] = i_data [247:240]; 
o_data [351:344] = i_data [239:232]; 
o_data [287:280] = i_data [231:224];  
o_data [223:216] = i_data [223:216]; 
o_data [159:152] = i_data [215:208]; 
o_data [95:88]   = i_data [207:200]; 
o_data [31:24]   = i_data [199:192];  
//---  row six to column six ------------
o_data [471:464] = i_data [191:184]; 
o_data [407:400] = i_data [183:176]; 
o_data [343:336] = i_data [175:168]; 
o_data [279:272] = i_data [167:160]; 
o_data [215:208] = i_data [159:152]; 
o_data [151:144] = i_data [151:144]; 
o_data [87:80]   = i_data [143:136]; 
o_data [23:16]   = i_data [135:128];  
//--- line seven to column seven --------
o_data [463:456] = i_data [127:120]; 
o_data [399:392] = i_data [119:112];  
o_data [335:328] = i_data [111:104]; 
o_data [271:264] = i_data [103:96];  
o_data [207:200] = i_data [95:88]; 
o_data [143:136] = i_data [87:80];  
o_data [79:72]   = i_data [79:72]; 
o_data [15:8]    = i_data [71:64];  
//---  row eight to column eight ----------
o_data [455:448] = i_data [63:56]; 
o_data [391:384] = i_data [55:48]; 
o_data [327:320] = i_data [47:40]; 
o_data [263:256] = i_data [39:32]; 
o_data [199:192] = i_data [31:24]; 
o_data [135:128] = i_data [23:16];  
o_data [71:64]   = i_data [15:8]; 
o_data [7:0]     = i_data [7:0];
end

assign valid_out = valid_in;

endmodule
