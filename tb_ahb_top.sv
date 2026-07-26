// ============================================================
// tb_ahb_top.sv - Testbench for ahb_top
// Generates clock/reset, runs the simulation, dumps a VCD.
// All checking (write/read PASS-FAIL) is printed by the master.
// ============================================================

`timescale 1ns/1ps

module tb_ahb_top;

    logic hclk;
    logic hresetn;

    // ---- Clock generation: 10ns period ----
    initial hclk = 0;
    always #5 hclk = ~hclk;

    // ---- Reset generation ----
    initial begin
        hresetn = 0;
        #20;
        hresetn = 1;
    end

    // ---- DUT instance ----
    ahb_top #(
        .ADDR_WIDTH(32),
        .DATA_WIDTH(32)
    ) dut (
        .hclk    (hclk),
        .hresetn (hresetn)
    );

    // ---- Waveform dump ----
    initial begin
        $dumpfile("tb_ahb_top.vcd");
        $dumpvars(0, tb_ahb_top);
    end

    // ---- Run for a fixed number of cycles then finish ----
    initial begin
        #500;
        $display("=================================================");
        $display("Simulation finished.");
        $display("=================================================");
        $finish;
    end

endmodule