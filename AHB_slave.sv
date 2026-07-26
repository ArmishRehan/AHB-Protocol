`timescale 1ns/1ps


module ahb_slave #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter MEM_DEPTH  = 16   
)(
    input  logic                  hclk,
    input  logic                  hresetn,

    input  logic                  hsel,
    input  logic [ADDR_WIDTH-1:0] haddr,
    input  logic [1:0]            htrans,
    input  logic                  hwrite,
    input  logic [2:0]            hsize,
    input  logic [DATA_WIDTH-1:0] hwdata,

    output logic [DATA_WIDTH-1:0] hrdata,
    output logic                  hready,
    output logic                  hresp
);

    localparam [1:0] TRANS_NONSEQ = 2'b10;

    logic [DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];

    localparam int IDX_HI = $clog2(MEM_DEPTH) + 1;
    localparam int IDX_LO = 2;
    logic                  sel_reg;
    logic                  write_reg;
    logic [ADDR_WIDTH-1:0] addr_reg;

    integer i;
    initial begin
        for (i = 0; i < MEM_DEPTH; i = i + 1)
            mem[i] = 32'h0;
    end

    always_ff @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            sel_reg   <= 1'b0;
            write_reg <= 1'b0;
            addr_reg  <= '0;
        end else begin
            sel_reg   <= hsel && (htrans == TRANS_NONSEQ);
            write_reg <= hwrite;
            addr_reg  <= haddr;
        end
    end

    always_ff @(posedge hclk) begin
        if (sel_reg && write_reg)
            mem[addr_reg[IDX_HI:IDX_LO]] <= hwdata;
    end

    always_comb begin
        hrdata = mem[addr_reg[IDX_HI:IDX_LO]];
    end
    
    assign hready = 1'b1;
    assign hresp  = 1'b0;

endmodule