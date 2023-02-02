module tb();

    // Generated top module signals
    reg  clk;
    reg  resetn;
    reg  uart_rx = 1'b0;
    reg  uart_cts = 1'b0;
    reg  dfu = 1'b0;
    wire uart_tx;
    wire uart_rts;

    // Generated top module instance
    wrapper _ra_top_inst(
            .clk       ( clk ),
            .resetn    ( resetn ),
            .uart_rx   ( uart_rx ),
            .uart_cts  ( uart_cts ),
            .dfu       ( dfu ),
            .uart_tx   ( uart_tx ),
            .uart_rts  ( uart_rts ));

    // Generated internal use signals
    reg  [31:0] _ra_pc;
    reg  [2:0] _ra_opcode;
    reg  [2:0] _ra_ram[0:1000];


    // Generated clock pulse
    always begin
        #30 clk = ~clk;
    end

    // Generated program counter
    // always @(posedge clk) begin
    //     _ra_opcode = _ra_ram[_ra_pc];
    //     dfu <= #5 _ra_opcode[2];
    //     uart_cts <= #5 _ra_opcode[1];
    //     uart_rx <= #5 _ra_opcode[0];
    //     _ra_pc = _ra_pc + 32'b1;
    //     // $strobe(";_C %d", _ra_pc);
    // end

    // Generated initial block
    initial begin
        clk = 1'b0;
        resetn = 1'b1;
        _ra_pc = 32'b0;
        // $readmemb("data.mem", _ra_ram);
        #2 clk = 1'b1;
        resetn = 1'b0;
        #5 resetn = 1'b1;
        #60000 $finish;
    end

endmodule
