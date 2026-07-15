module uart_tx(
  input clk,
  input rst_n,
  input [7:0] data_in,
  input tx_start,
  output reg tx,
  output reg tx_busy
);
//States  
  parameter IDLE=2'b00;
  parameter START=2'b01;
  parameter DATA=2'b10;
  parameter STOP=2'b11;
  
  reg [1:0] state;
  reg [2:0] bit_count;
  reg [7:0] shift_reg;
//FSM logic  
  always @ (posedge clk)
    begin
      if(!rst_n)
        begin
          state<=IDLE;
          tx<=1;
          tx_busy<=0;
          bit_count<=0;
          shift_reg<=0;
        end
      else
        begin
          case(state)
            IDLE:begin
              tx<=1;
              tx_busy<=0;
              if(tx_start)
                begin
                  state<=START;
                  shift_reg<=data_in;
                  tx_busy<=1;
                end
            end
            START:begin
              tx<=0;
              state<=DATA;
              bit_count<=0;
            end
            DATA:begin
              tx<=shift_reg[0];
              shift_reg<=shift_reg>>1;
              bit_count<=bit_count+1;
              if (bit_count==7)
                state<=STOP;
            end
            STOP:begin
              tx<=1;
              state<=IDLE;
              tx_busy<=0;
            end
          endcase
        end
    end
endmodule
