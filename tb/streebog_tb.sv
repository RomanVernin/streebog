// File name : streebog_tb.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1ns/10ps
module streebog_tb();

    logic                    clk_i       = 1'b1;
    logic                    rstn_i      = 1'b0; 
    logic 			         valid_i     = 1'b0;
    logic   [511:0]          message     = 512'h0;
    logic                    len_message = 1'b0;
    wire 			         hash_valid_o;
    wire   [511:0]           hash_o;
    logic                    mes_last      = '0;
    logic   [9:0]            mes_last_len  = '0;
    logic                    hash_length   = '0;
    logic                    fsm_start_req = '0;
    wire                     fsm_start_ack;
    wire                     mes_ready;
    wire                     hash_valid;

    localparam  DATA_WIDTH =512;

    streebog_top #(
    .DATA_WIDTH         (512)
) u_streebog_top (
 
    // system
    .clk_i              (clk_i),
    .rstn_i             (rstn_i),
    //message
    .mes_last_i         (mes_last     ),
    .mes_last_len_i     (mes_last_len ),
    //
    .mes_valid_i        (valid_i),
    .mes_ready_o        (mes_ready),
    .message_i          (message),
    .hash_len_i         (hash_length),
    // 0 - 512; 1 - 256
    //req fsm
    .fsm_start_req_i    (fsm_start_req),
    .fsm_start_ack_o    (fsm_start_ack),
    .hash_o             (hash_o       ),
    .hash_valid_o       (hash_valid   ),
    .hash_ready_i       ('1           )
);


task check_1_message;
input [DATA_WIDTH-1:0] mes_last_len_i;
input  hash_length_i;
input [DATA_WIDTH-1:0] message_i;
input [DATA_WIDTH-1:0] hash_ref;
@(posedge clk_i)
begin
fsm_start_req <= 1;
end
$display("TEST STARTED");
wait(mes_ready)
@(posedge clk_i)
begin
 mes_last     <= 1;
 mes_last_len <= mes_last_len_i; 
 hash_length  <= hash_length_i; 
 valid_i      <= 1; 
 message      <= message_i;
end 
@(posedge clk_i)
valid_i      <= 0; 
wait(fsm_start_ack);
@(posedge clk_i)
fsm_start_req <= 0;
if(hash_length_i)
begin
$display("Hash out =%h ",hash_o);
$display("Hash ref =%h ",hash_ref);
if(hash_o == hash_ref)
  $display("HASH MATCHED");
else
  begin
   $display("HASH MISMATCHED");
   $display("TEST FAILED");
   $stop;
  end
end
else
begin
$display("Hash out =%h ",hash_o[DATA_WIDTH-1:256]);
$display("Hash ref =%h ",hash_ref[255:0]);  
if(hash_o[DATA_WIDTH-1:256] == hash_ref[255:0])
  $display("HASH MATCHED");
else
  begin
   $display("HASH MISMATCHED");
   $display("TEST FAILED");
   $stop;
  end
end

endtask

task check_2_message;
input [DATA_WIDTH-1:0] mes_last_len_i;
input  hash_length_i;
input [DATA_WIDTH-1:0] message1_i;
input [DATA_WIDTH-1:0] message2_i;
input [DATA_WIDTH-1:0] hash_ref;
@(posedge clk_i)
begin
fsm_start_req <= 1;
end
$display("TEST STARTED");
wait(mes_ready)
@(posedge clk_i)
begin
 mes_last     <= 0;
 mes_last_len <= mes_last_len_i; 
 hash_length  <= hash_length_i; 
 valid_i      <= 1; 
 message      <= message1_i;
end 
@(posedge clk_i)
valid_i      <= 0; 

@(posedge clk_i)

@(posedge clk_i)
begin
 mes_last     <= 1;
 mes_last_len <= mes_last_len_i; 
 hash_length  <= hash_length_i; 
 valid_i      <= 1; 
 message      <= message2_i;
end 
wait(mes_ready)
@(posedge clk_i)
valid_i      <= 0; 

wait(fsm_start_ack);
@(posedge clk_i)
fsm_start_req <= 0;
if(hash_length_i)
begin
$display("Hash out =%h ",hash_o);
$display("Hash ref =%h ",hash_ref);  
if(hash_o == hash_ref)
  $display("HASH MATCHED");
else
  begin
   $display("HASH MISMATCHED");
   $display("TEST FAILED");
   $stop;
  end
end
else
begin
$display("Hash out =%h ",hash_o[DATA_WIDTH-1:256]);
$display("Hash ref =%h ",hash_ref[255:0]);  
if(hash_o[DATA_WIDTH-1:256] == hash_ref[255:0])
  $display("HASH MATCHED");
else
  begin
   $display("HASH MISMATCHED");
   $display("TEST FAILED");
   $stop;
  end
end

endtask

always #1 clk_i = ~clk_i;

initial begin
#2 rstn_i = 1'b0;
#2 rstn_i = 1'b1;
@(posedge clk_i)
@(posedge clk_i)

$display("TEST STARTED");
$display("EXAMPLE 1.1");
$display("HASH LENGTH = 512   MESSAGE LENGTH = 504");  
check_1_message(512'd504,1,512'h01323130393837363534333231303938373635343332313039383736353433323130393837363534333231303938373635343332313039383736353433323130,512'h486f64c1917879417fef082b3381a4e211c324f074654c38823a7b76f830ad00fa1fbae42b1285c0352f227524bc9ab16254288dd6863dccd5b9f54a1ad0541b);
$display("EXAMPLE 1.2");
$display("HASH LENGTH = 256   MESSAGE LENGTH = 504"); 
check_1_message(512'd504,0,512'h01323130393837363534333231303938373635343332313039383736353433323130393837363534333231303938373635343332313039383736353433323130,512'h00557be5e584fd52a449b16b0251d05d27f94ab76cbaa6da890b59d8ef1e159d);
$display("EXAMPLE 2.1");
$display("HASH LENGTH = 512   MESSAGE LENGTH = 576"); 
check_2_message(512'd64,1,512'hfbeafaebef20fffbf0e1e0f0f520e0ed20e8ece0ebe5f0f2f120fff0eeec20f120faf2fee5e2202ce8f6f3ede220e8e6eee1e8f0f2d1202ce8f0f2e5e220e5d1,512'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fbe2e5f0eee3c820,512'h28fbc9bada033b1460642bdcddb90c3fb3e56c497ccd0f62b8a2ad4935e85f037613966de4ee00531ae60f3b5a47f8dae06915d5f2f194996fcabf2622e6881e);
$display("EXAMPLE 2.1");
$display("HASH LENGTH = 256   MESSAGE LENGTH = 576"); 
check_2_message(512'd64,0,512'hfbeafaebef20fffbf0e1e0f0f520e0ed20e8ece0ebe5f0f2f120fff0eeec20f120faf2fee5e2202ce8f6f3ede220e8e6eee1e8f0f2d1202ce8f0f2e5e220e5d1,512'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fbe2e5f0eee3c820,512'h508f7e553c06501d749a66fc28c6cac0b005746d97537fa85d9e40904efed29d);                                                                                                                                              
#1000
$stop;
end
endmodule
