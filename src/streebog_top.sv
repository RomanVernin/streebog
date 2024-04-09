// File name : streebog_top.sv
// Version : 1.0
// Date : 1.03.2024
// URL : https://github.com/RomanVernin/streebog
// Author : Roman Vernin
`timescale 1ns/10ps
module streebog_top #(
parameter DATA_WIDTH = 512 

)

(
// system
input   wire                        clk_i,
input   wire                        rstn_i,
//message
input                               mes_last_i,
input [9:0]                         mes_last_len_i,  
input 	wire 						mes_valid_i,
output  reg                         mes_ready_o,
input   wire    [DATA_WIDTH-1:0]    message_i,
input	wire                        hash_len_i, // 1 - 512; 0 - 256
//req fsm
input                               fsm_start_req_i,
output  reg                         fsm_start_ack_o, 

output  logic   [DATA_WIDTH-1:0]    hash_o,
output  logic                       hash_valid_o,
input                               hash_ready_i
);



localparam N_FULL = 512;

logic [DATA_WIDTH-1:0] n_data;
logic [DATA_WIDTH-1:0] m_data;
logic [DATA_WIDTH-1:0] h_data;
logic                  g_valid;


logic [DATA_WIDTH-1:0] hash_data;
logic                  hash_data_valid;
logic [DATA_WIDTH-1:0] v_0;

assign v_0 = !hash_len_i ? {64{8'h01}} :'0;

g_function
#(.DATA_WIDTH(DATA_WIDTH))
 u_g_function (
    // system
    .clk_i                (clk_i),
    .rstn_i               (rstn_i),
    // n data
    .n_data_i             (n_data),     
    .m_data_i             (m_data),    
    .h_data_i             (h_data),
    .g_valid_i            (g_valid),// n h m valid    
    // hash data out
    .hash_data_o          (hash_data),
    .hash_data_valid_o    (hash_data_valid) 
);

logic [DATA_WIDTH-1:0] nsum_in;
logic                  nsum_in_valid;

logic [DATA_WIDTH-1:0] nsum_out;
logic                  nsum_out_valid;

logic clear_sum;

sc #(
    .DATA_WIDTH         (512)
) u_sc_n (
    .clk_i              (clk_i),
    .rstn_i             (rstn_i),
	.clear_i            (clear_sum),
   //
	.data_valid_i       (nsum_in_valid),
    .data_i             (nsum_in),
   //
    .data_valid_o       (nsum_out_valid),
    .data_o             (nsum_out)
);

logic [DATA_WIDTH-1:0] msum_in;
logic                  msum_in_valid;

logic [DATA_WIDTH-1:0] msum_out;
logic                  msum_out_valid;


sc #(
    .DATA_WIDTH         (512)
) u_sc_m (
    .clk_i              (clk_i),
    .rstn_i             (rstn_i),
	.clear_i            (clear_sum),
   //
	.data_valid_i       (msum_in_valid),
    .data_i             (msum_in),
   //
    .data_valid_o       (msum_out_valid),
    .data_o             (msum_out)
);

logic mes_last_reg;
enum {INIT, RECURSIVE, ADD_N_SUM, ADD_M_SUM, HASH_WAIT, WAIT_FSM_REQ,ADD_EXTRA_M } state;
enum {WAIT_VALID_HASM_AND_MES, LATCHED_M,LATCHED_H} state_1;
always@(posedge clk_i or negedge rstn_i)
if(!rstn_i)
  begin   
   mes_ready_o     <= '0;
   g_valid         <= '0;
   n_data          <= '0; 
   m_data          <= '0; 
   h_data          <= '0;
   nsum_in_valid   <= '0;
   nsum_in         <= '0;
   msum_in         <= '0;
   msum_in_valid   <= '0; 
   hash_o          <= '0;
   fsm_start_ack_o <= '1;
   state           <= INIT;    
   clear_sum       <= '0;
   state_1         <= WAIT_VALID_HASM_AND_MES;
   mes_last_reg    <= '1;
   hash_valid_o    <= '0;
  end
else case (state)

INIT : begin
	    hash_valid_o    <= '0;
        if(fsm_start_req_i)
          begin
		   //fsm_start_ack_o   <= '0;		 	         
		   if(mes_valid_i) 
		     begin
		 	 //next rx mes
		 	 if(mes_ready_o)	  
		 	   mes_ready_o <= '0;	
		 	 else
		 	  mes_ready_o <= '1;	
		 	 //g function fill  
		 	 g_valid     <= '1;
		 	 n_data      <= '0;
		 	 m_data      <= message_i;
		 	 h_data      <= v_0;			   
		 	 // n sum
		 	 nsum_in_valid <= mes_valid_i;			 
		 	 // m summ
		 	 msum_in       <= message_i;
		 	 msum_in_valid <= mes_valid_i;
		 	 // state switch 
		 	 if(mes_last_i)
		 	   begin
                nsum_in <= {502'h0,mes_last_len_i};
				if(mes_last_len_i == N_FULL)
				  state <= ADD_EXTRA_M;
				else  
		 	    state   <= ADD_N_SUM;
		 	   end
		 	 else
		 	   begin
		 		nsum_in <= N_FULL;   	  
		 	    state   <= RECURSIVE;		 		
		 		mes_ready_o <= '1; 
		 	   end	
		 	end
		 	else
		 	 begin
		 	  mes_ready_o   <= '1;	 
		 	  g_valid       <= '0;  
              nsum_in_valid <= '0;
		 	  msum_in_valid <= '0;
		 	 end		      
	      end
		 else
		  begin
		   mes_ready_o     <= '0;
		   fsm_start_ack_o <= '0;
		  end 
       end  	  

RECURSIVE : case (state_1)
             WAIT_VALID_HASM_AND_MES :  begin	         
                                         if(nsum_out_valid)
		                                   n_data  <= nsum_out;
                                         if(hash_data_valid & mes_valid_i)
                                           begin
			                            	if(mes_last_i)
		 		                             begin
								              if(mes_last_len_i == N_FULL)
				                                state <= ADD_EXTRA_M;
				                              else  
		 	                                    state <= ADD_N_SUM;		 
									         end  
		 		                            else  				
		 	                                 state <= RECURSIVE;			                            	                    
			                                mes_ready_o <= '1;		      
			                                g_valid     <= '1;				
			                                m_data      <= message_i;
			                                h_data      <= hash_data;			   
			                                // n sum
			                                nsum_in_valid <= '1;
			                            	if(mes_last_i)
                                              nsum_in      <= mes_last_len_i;
			                            	else
			                                 nsum_in       <= N_FULL;
			                                // m summ
			                                msum_in       <= message_i;
			                                msum_in_valid <= '1;			  
			                               end
			                             else if(hash_data_valid) 
					        	                begin
												 msum_in_valid   <= '0;	
								                 h_data          <= hash_data;                                  
								                 state_1         <= LATCHED_H;
												 nsum_in_valid   <= '0;
                  				                end  
											  else if(mes_valid_i)
							                         begin
							                          mes_ready_o   <= '0;
							                          m_data        <= message_i;
							                          state_1       <= LATCHED_M ;
													  mes_last_reg  <= mes_last_i;      
							                          msum_in       <= message_i;
			                                          msum_in_valid <= '1;
													  if(mes_last_i)
                                                        nsum_in <= mes_last_len_i;
			                                          else
			                                           nsum_in  <= N_FULL;													  	    	
							                         end 	  
										           else
			                                        begin			  	  
			                                         mes_ready_o     <= '1;										                                                   	   
			                                         g_valid         <= '0;  
                                                     nsum_in_valid   <= '0;
			                                         msum_in_valid   <= '0;
			                                        end
                                        end
             LATCHED_M :       begin
				                msum_in_valid <= '0;
								nsum_in_valid <= '0;
				                if(nsum_out_valid)
		                          n_data  <= nsum_out;
			                    if(hash_data_valid) 
					        	  begin
								   nsum_in_valid <= '1;
								   h_data        <= hash_data;
								   g_valid       <= '1;
								   state_1       <=  WAIT_VALID_HASM_AND_MES;								   							    								 								 
								   if(mes_last_reg)
								     begin
								      if(mes_last_len_i == N_FULL)
				                        state <= ADD_EXTRA_M;
				                      else  
		 	                            state <= ADD_N_SUM;		 
									 end  
		 		                   else  				
		 	                        state <= RECURSIVE;				  
							   	  end
			                    end

			LATCHED_H :    begin
				            if(nsum_out_valid)
		                      n_data  <= nsum_out;	 
			                if(mes_valid_i)
							  begin
							   state_1       <=  WAIT_VALID_HASM_AND_MES;	  
							   mes_ready_o   <= '0;
							   m_data        <= message_i;
							   g_valid       <= '1; 
							   msum_in_valid <= '1;
							   msum_in       <= message_i;
							   nsum_in_valid <= '1;
							   if(mes_last_i)
                                 nsum_in     <= mes_last_len_i;
			                   else
			                    nsum_in      <= N_FULL;
							   if(mes_last_i)
		 		                 begin
								  if(mes_last_len_i == N_FULL)
				                    state <= ADD_EXTRA_M;
				                  else  
		 	                        state <= ADD_N_SUM;		 
								 end  
		 		                else  				
		 	                     state <= RECURSIVE;                  	
							  end 
							else
							 mes_ready_o <= '1;
			               end   					  

	     default state_1 <= WAIT_VALID_HASM_AND_MES;  
          endcase

ADD_EXTRA_M : if(hash_data_valid)
               begin
			    //			     
			    g_valid       <= '1;				
			    m_data        <= 512'd1;
			    h_data        <= hash_data;
				n_data        <= nsum_out;
				msum_in_valid <= '1;
				msum_in       <= 512'd1;
				nsum_in_valid <= '1;
				nsum_in       <= 512'd0;   
			    // state switch                 
				state <= ADD_N_SUM;							
			   end
			  else
			    begin
				 nsum_in_valid   <= '0;
			     msum_in_valid   <= '0;
				 g_valid         <= '0;
				end	 	 

ADD_N_SUM : begin	         
             nsum_in_valid   <= '0;
			 msum_in_valid   <= '0;
			 n_data          <= '0;			
             if(hash_data_valid)
               begin
			    //			     
			    g_valid     <= '1;				
			    m_data      <= nsum_out;
			    h_data      <= hash_data;	   
			    // state switch                 
				state <= ADD_M_SUM;							
			   end
			 else
			  begin	
			   g_valid       <= '0;
			              
			  end
            end  	  

ADD_M_SUM : begin 
             if(hash_data_valid)
               begin
			    //			     
			    g_valid     <= '1;				
			    m_data      <= msum_out;
			    h_data      <= hash_data;	   
			    // state switch                 
				state <= HASH_WAIT;							
			   end
			 else
			  begin	     
			   g_valid         <= '0;		             
			  end
            end  	  

HASH_WAIT : begin 
	         g_valid <= '0;
             if(hash_data_valid)
               begin
			    //		    				
			    hash_o          <= hash_data;                
				hash_valid_o    <= '1;			    	   
			    // state switch 
				if(!fsm_start_req_i & hash_ready_i )
				  begin                
				   state           <= INIT;				 
				   clear_sum       <= '0;
				   fsm_start_ack_o <= '0;
				  end
 				else if(fsm_start_req_i & hash_ready_i)                       
                        begin                
				         state           <= WAIT_FSM_REQ;				         
				         clear_sum       <= '1;
						 fsm_start_ack_o <= '1;
				        end
					 else
					   begin	
				        clear_sum       <= '1;
						fsm_start_ack_o <= '1;
					   end	   
               end 
             end  

WAIT_FSM_REQ : begin
	            hash_valid_o    <= '0;	
	            if(!fsm_start_req_i )
				  begin                
				   state           <= INIT;				   
				   fsm_start_ack_o <= '0;
				   clear_sum       <= '0;
				  end
               end


default state <= INIT;
endcase

endmodule

