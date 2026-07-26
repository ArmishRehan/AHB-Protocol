
`timescale 1ns/1ps
module ahb_master #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  logic                    hclk,
    input  logic                    hresetn,
    output logic [ADDR_WIDTH-1:0]   haddr,
    output logic [1:0]              htrans,
    output logic                    hwrite,
    output logic [2:0]              hsize,
    output logic [DATA_WIDTH-1:0]   hwdata,
    
    input  logic [DATA_WIDTH-1:0]   hrdata,
    input  logic                    hready,
    input  logic                    hresp
);
    localparam [1:0] TRANS_IDLE   = 2'b00;
    localparam [1:0] TRANS_NONSEQ = 2'b10;
    localparam int NUM_TX = 8;
    
    logic [ADDR_WIDTH-1:0] addr_list [0:NUM_TX-1];
    logic                  wr_list   [0:NUM_TX-1];
    logic [DATA_WIDTH-1:0] wdata_list[0:NUM_TX-1];

    initial begin
        addr_list[0] = 32'h0; wr_list[0] = 1'b1; wdata_list[0] = 32'hAAAA_0000;
        addr_list[1] = 32'h4; wr_list[1] = 1'b1; wdata_list[1] = 32'hAAAA_0001;
        addr_list[2] = 32'h8; wr_list[2] = 1'b1; wdata_list[2] = 32'hAAAA_0002;
        addr_list[3] = 32'hC; wr_list[3] = 1'b1; wdata_list[3] = 32'hAAAA_0003;
        addr_list[4] = 32'h0; wr_list[4] = 1'b0; wdata_list[4] = 32'hAAAA_0000;
        addr_list[5] = 32'h4; wr_list[5] = 1'b0; wdata_list[5] = 32'hAAAA_0001;
        addr_list[6] = 32'h8; wr_list[6] = 1'b0; wdata_list[6] = 32'hAAAA_0002;
        addr_list[7] = 32'hC; wr_list[7] = 1'b0; wdata_list[7] = 32'hAAAA_0003;
    end

    int idx;
    always_ff @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            idx    <= 0;
            haddr  <= addr_list[0];
            hwrite <= wr_list[0];
            htrans <= TRANS_NONSEQ;
            hwdata <= '0;
            hsize  <= 3'b010; 
   
        end else if (hready) begin

            if (idx < NUM_TX && wr_list[idx]) begin
                hwdata <= wdata_list[idx];
                $display("[%0t] MASTER: WRITE addr=0x%0h data=0x%0h",
                          $time, addr_list[idx], wdata_list[idx]);
            end
            if (idx >= 1 && (idx-1) < NUM_TX && !wr_list[idx-1]) begin
                if (hrdata === wdata_list[idx-1])
                    $display("[%0t] MASTER: READ  addr=0x%0h data=0x%0h  -> PASS",
                              $time, addr_list[idx-1], hrdata);
                else
                    $display("[%0t] MASTER: READ  addr=0x%0h data=0x%0h expected=0x%0h -> FAIL",
                              $time, addr_list[idx-1], hrdata, wdata_list[idx-1]);
            end
            if (idx + 1 < NUM_TX) begin
                haddr  <= addr_list[idx+1];
                hwrite <= wr_list[idx+1];
                htrans <= TRANS_NONSEQ;
            end else begin
                htrans <= TRANS_IDLE;
            end

            idx <= idx + 1;
        end
    end

endmodule
