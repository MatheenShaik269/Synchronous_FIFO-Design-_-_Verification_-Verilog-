`timescale 1ns / 1ps
module fifo_sync_tb();
    parameter fifo_depth=8,
              data_width=32;
    reg clk;
    reg rst;
    reg cs;
    reg w_enable;
    reg r_enable;
    reg [data_width-1:0] data_in;
    wire [data_width-1:0] data_out;
    wire full;
    wire empty;
    integer i =0;
    
fifo_sync dut (
                    .clk(clk),
                    .rst(rst),
                    .cs(cs),
                    .w_enable(w_enable),
                    .r_enable(r_enable),
                    .data_in(data_in),
                    .data_out(data_out),
                    .full(full),
                    .empty(empty)
              );
    
    task write_operation (input [data_width-1:0] d_in);
        begin
                @(posedge clk);
                        cs=1'b1 ; w_enable=1'b1;
                        data_in=d_in;
                @(posedge clk);
                $display("data_in = %0d",data_in);
                     cs=1'b0 ; w_enable=1'b0;
                    
        
        end
    endtask
    
    task read_operation ();
        begin
            //@(posedge clk);
                cs=1'b1 ; r_enable=1'b1;
            @(posedge clk);
            $display("data_out = %0d ",data_out);
            cs=1'b0 ; r_enable=1'b0;
            
        end
   endtask
   //Clock generation
   initial
        begin
            clk=0;
            forever
            #5 clk=~clk;
        end
   initial
        begin
            //@(posedge clk);
            rst=1'b1; w_enable=1'b0 ; r_enable=1'b0; data_in=0 ; cs=0;
            @(posedge clk);
            rst=1'b0;
            $display("============Test case 1 : no.of.write operations == no.of.read operation===========");
            read_operation();
            write_operation(10);//if you write a number without base specifier then it takes it as decimal write_operation(10);          // Decimal (default)
                                //write_operation(32'd10);      // 32-bit decimal
                                //write_operation(32'hA);       // 32-bit hexadecimal
                                //write_operation(32'b1010);    // 32-bit binary
                                //write_operation(32'o12);      // 32-bit octal
            write_operation(20);
            write_operation(30);
            read_operation();
            read_operation();
            read_operation();
            rst=1'b1;
            @(posedge clk);
            rst=1'b0;
            $display("===========Test Case 2 : writing and reading at a time===========");
            //here it will write all operations bcz we are writing and immidiately reading data so fifo is becoming empty
            for(i=0 ; i<=fifo_depth ;i=i+1)
                begin
                    write_operation(2**i);
                    read_operation();
                    $display("------- empty = %b  full = %b -------",empty,full);
                end
            rst=1'b1;
            @(posedge clk);
            rst=1'b0;
            $display("============Test case 3 : No.of write operations are greater than fifo depth===========");
            //successfully written but we need to verify seperately that it written greater than fifos depth or not
             for(i=0 ; i<=fifo_depth+1 ;i=i+1)
                begin
                    write_operation(2*i);
                   
                    $display("------- empty = %b  full = %b -------",empty,full);
                end
                
            $display("Test case 3 sub case : Reading content of fifo");
            //No checking wheter it written excess data beyond the fifo depth or not
             for(i=0 ; i<=fifo_depth+1 ;i=i+1)
                begin
                    read_operation();
                   
                    $display("------ empty = %b  full = %b -------",empty,full);
                end
                
                //here data is written upto fifo depth only after the exceeding of fifo depth it gives data_out as previous value only repeatedly
           
           
          
            
            #10
            $finish;
        end
        
endmodule
