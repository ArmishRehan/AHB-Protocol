`timescale 1ns/1ps

module ahb_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input logic hclk,
    input logic hresetn
);

    logic [ADDR_WIDTH-1:0] haddr;
    logic [1:0]            htrans;
    logic                  hwrite;
    logic [2:0]            hsize;
    logic [DATA_WIDTH-1:0] hwdata;
    logic [DATA_WIDTH-1:0] hrdata;
    logic                  hready;
    logic                  hresp;

    ahb_master #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) u_master (
        .hclk    (hclk),
        .hresetn (hresetn),
        .haddr   (haddr),
        .htrans  (htrans),
        .hwrite  (hwrite),
        .hsize   (hsize),
        .hwdata  (hwdata),
        .hrdata  (hrdata),
        .hready  (hready),
        .hresp   (hresp)
    );

    ahb_slave #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .MEM_DEPTH (16)
    ) u_slave (
        .hclk    (hclk),
        .hresetn (hresetn),
        .hsel    (1'b1),     
        .haddr   (haddr),
        .htrans  (htrans),
        .hwrite  (hwrite),
        .hsize   (hsize),
        .hwdata  (hwdata),
        .hrdata  (hrdata),
        .hready  (hready),
        .hresp   (hresp)
    );

endmodule