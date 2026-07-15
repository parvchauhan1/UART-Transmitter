module tb_uart_tx;

  reg clk, rst_n, tx_start;
  reg [7:0] data_in;
  wire tx, tx_busy;

  // Connect to UART Tx
  uart_tx dut (
    .clk(clk),
    .rst_n(rst_n),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx),
    .tx_busy(tx_busy)
  );

  // Clock
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Initialise
    clk=0; rst_n=0; tx_start=0; data_in=0;

    // Reset
    #10 rst_n=1;

    // Send 0xA5 = 10100101
    #10;
    data_in  = 8'hA5;
    tx_start = 1;
    #10;
    tx_start = 0;

    // Wait enough time for full transmission
    // 1 start + 8 data + 1 stop = 10 bits x 10 time units
    #120;

    // Send another byte 0x37 = 00110111
    data_in  = 8'h37;
    tx_start = 1;
    #10;
    tx_start = 0;
    #120;

    $finish;
  end

endmodule
