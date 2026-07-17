module ahb_master(

    input  logic clk,
    input  logic rst,

    // AHB signals
    output logic [31:0] HADDR,
    output logic HWRITE,
    output logic [1:0] HTRANS,
    output logic [31:0] HWDATA,

    input logic [31:0] HRDATA,
    input logic HREADY

);


    parameter IDLE = 2'b00;
    parameter WRITE = 2'b01;
    parameter READ = 2'b10;


    logic [1:0] state;


    always_ff @(posedge clk or posedge rst)
    begin

        if(rst)
        begin
            state <= IDLE;

            HADDR  <= 0;
            HWRITE <= 0;
            HTRANS <= 0;
            HWDATA <= 0;

        end

        else
        begin

            case(state)


            IDLE:
            begin

                // Write transaction
                HADDR  <= 32'h00000010;
                HWRITE <= 1'b1;
                HWDATA <= 32'hABCD1234;
                HTRANS <= 2'b10;

                state <= WRITE;

            end



            WRITE:
            begin

                if(HREADY)
                begin

                    // Read same address
                    HADDR <= 32'h00000010;
                    HWRITE <= 1'b0;
                    HTRANS <= 2'b10;

                    state <= READ;

                end

            end



            READ:
            begin

                if(HREADY)
                begin

                    $display("READ DATA = %h",HRDATA);

                    HTRANS <= 2'b00;

                    state <= IDLE;

                end

            end


            endcase

        end


    end


endmodule