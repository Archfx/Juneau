`timescale 1 ns / 1 ps

module rom #(
    parameter ADDR_BITS = 10,
    parameter FILENAME = "../fw/otp.mem"
) (
    input clk,
    input valid,
    input [31:0] addr,
    output [31:0] dout,
    output ready
);

wire [ADDR_BITS-3:0] idx = addr[ADDR_BITS-1:2];
reg [31:0] rom [(2**(ADDR_BITS-2))-1:0];

// note: with Yosys, need to read this file in with `-defer` for the
// parameter to work
// see
// https://www.reddit.com/r/yosys/comments/f92bke/whats_the_right_way_to_load_a_verilog_module_that/
initial begin
    $readmemh(FILENAME, rom, 0, (2**(ADDR_BITS-2))-1);
end

// workaround to make Yosys output better
wire [ADDR_BITS-3:0] xaddr;
assign xaddr = 0;
always @(posedge clk) begin
    rom[xaddr] <= rom[xaddr];
end

assign dout = rom[idx];
assign ready = valid; // always ready

endmodule
