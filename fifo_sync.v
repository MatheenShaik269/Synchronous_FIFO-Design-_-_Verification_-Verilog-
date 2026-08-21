`timescale 1ns / 1ps
module fifo_sync 
        //parameters declaration
        #(parameter fifo_depth=8,
                    data_width=32
         )
        //input and output ports
        (
            input clk,
            input rst,
            input cs,  //if chip set==1 then only fifo works 
            input w_enable, //write_enable
            input r_enable, //read_enable
            input [data_width-1:0] data_in,
            output reg [data_width-1:0] data_out,
            output full,
            output empty
      
        );
       localparam fifo_depth_log=$clog2(fifo_depth); //gives no.of.bits for fifo_depth
       //declaring write and read pointers
       // here write pointer and read pointer are 1 bit extra than bits of fifo depth,bcz we need to write full condition
       reg [fifo_depth_log:0] write_pointer ; 
       reg [fifo_depth_log:0] read_pointer ;  
       //declaring by dimensional array called fifo
       reg [data_width-1:0] fifo [0:fifo_depth-1] ; //reg [width of data] fifo [depth of fifo]
      
       
       //write operation
       
       always @(posedge clk or posedge rst)
        begin
            if(rst)
                write_pointer<=0;
            else if(cs && !full && w_enable  )
                begin
                    fifo[write_pointer[fifo_depth_log-1:0]]<=data_in ;
                    write_pointer<=write_pointer+1 ; //automatically it changes 1 to required no.of.bits
                end       
        end
        
        //read operation
        
        always @(posedge clk or posedge rst)
            begin
                if(rst)
                    begin
                    read_pointer<=0;
                    data_out<=0;
                    end
                else if(cs && !empty && r_enable )
                    begin
                        data_out<=fifo[read_pointer[fifo_depth_log-1:0]]; //automatically it changes 1 to required no.of.bits
                        read_pointer<=read_pointer+1; 
                    end
            end
            
            assign empty=(read_pointer==write_pointer);
            assign full=(read_pointer=={~write_pointer[fifo_depth_log],write_pointer[fifo_depth_log-1:0]});
       
endmodule
