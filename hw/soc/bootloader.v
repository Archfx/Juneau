`timescale 1 ns / 1 ps

module bootloader #(
    parameter ADDR_BITS = 10,
    parameter FILENAME = "fw/otp.mem"
) (
    input clk,
    input valid,
    input reset_n,
    input dfu_enable,
    input [31:0] addr,
    output [31:0] dout,
    output reg verified,
    output ready
);

wire [ADDR_BITS-3:0] idx = addr[ADDR_BITS-1:2];
// reg [31:0] rom [(2**(ADDR_BITS-2))-1:0];
reg [31:0] rom [1154:0];

// reg verified;


// note: with Yosys, need to read this file in with `-defer` for the
// parameter to work
// see
// https://www.reddit.com/r/yosys/comments/f92bke/whats_the_right_way_to_load_a_verilog_module_that/
initial begin
    // $readmemh(FILENAME, rom, 0, (2**(ADDR_BITS-2))-1);
    $readmemh(FILENAME, rom, 0, 1154);
    // verified = 0;
end

// workaround to make Yosys output better
wire [ADDR_BITS-3:0] xaddr;
assign xaddr = 0;
always @(posedge clk) begin

    if (!reset_n) begin
		// xaddr <= 0;
		verified <= 0;
        $display("Bootloader reset");
    end

    // if (dfu_enable)
    //     xaddr <= xaddr + 1;

    // if (rom[xaddr] == 32'hffffffff) 
    //     verified = 1'b1;

    // if (verified)
    //     rom[xaddr] <= rom[xaddr];   
    //     $writememh("memory_hex.txt", rom); 
end

// assign dout = rom[idx];
// assign ready = valid; // always ready

// // Flash for Bootloader Authentication
// wire rom_valid = mem_valid && mem_addr[31:24] == 8'h00;
// wire [31:0] rom_rdata;
// wire rom_ready;

// rom #(
//     .ADDR_BITS (ADDR_BITS),
//     .FILENAME (FILENAME)
// ) eeprom (
//     .clk (clk),
//     .valid (rom_valid),
//     .addr (mem_addr),
//     .dout (rom_rdata),
//     .ready (rom_ready)
// );


endmodule
