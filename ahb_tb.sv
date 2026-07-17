module ahb_tb;


logic clk;
logic rst;


// expose AHB signals

wire [31:0] HADDR;
wire [31:0] HWDATA;
wire [31:0] HRDATA;

wire HWRITE;
wire [1:0] HTRANS;

wire HREADY;
wire HRESP;



ahb_top DUT(

.clk(clk),
.rst(rst)

);


// access internal signals

assign HADDR  = DUT.HADDR;
assign HWDATA = DUT.HWDATA;
assign HRDATA = DUT.HRDATA;

assign HWRITE = DUT.HWRITE;
assign HTRANS = DUT.HTRANS;

assign HREADY = DUT.HREADY;
assign HRESP  = DUT.HRESP;



initial begin

clk = 0;

forever #5 clk = ~clk;

end



initial begin

rst = 1;

#20;

rst = 0;

#200;

$finish;

end


endmodule