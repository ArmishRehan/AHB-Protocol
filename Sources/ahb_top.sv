module ahb_top(

input logic clk,
input logic rst

);



wire [31:0] HADDR;
wire [31:0] HWDATA;
wire [31:0] HRDATA;

wire HWRITE;
wire [1:0] HTRANS;

wire HREADY;
wire HRESP;



ahb_master master(

.clk(clk),
.rst(rst),

.HADDR(HADDR),
.HWRITE(HWRITE),
.HTRANS(HTRANS),
.HWDATA(HWDATA),

.HRDATA(HRDATA),
.HREADY(HREADY)

);



ahb_slave slave(

.clk(clk),
.rst(rst),

.HADDR(HADDR),
.HWRITE(HWRITE),
.HTRANS(HTRANS),
.HWDATA(HWDATA),

.HRDATA(HRDATA),
.HREADY(HREADY),
.HRESP(HRESP)

);



endmodule