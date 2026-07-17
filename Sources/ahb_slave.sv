module ahb_slave(

input logic clk,
input logic rst,


input logic [31:0] HADDR,
input logic HWRITE,
input logic [1:0] HTRANS,
input logic [31:0] HWDATA,


output logic [31:0] HRDATA,
output logic HREADY,
output logic HRESP


);


logic [31:0] memory [0:31];


always_ff @(posedge clk or posedge rst)
begin


if(rst)
begin

    HREADY <= 1'b1;
    HRESP  <= 1'b0;
    HRDATA <= 0;


end


else
begin


    if(HTRANS == 2'b10)
    begin


        if(HWRITE)
        begin

            memory[HADDR[6:2]] <= HWDATA;

            $display("WRITE : Addr=%h Data=%h",
                    HADDR,HWDATA);

        end


        else
        begin

            HRDATA <= memory[HADDR[6:2]];

            $display("READ : Addr=%h",
                    HADDR);

        end


    end


end


end



endmodule