# UART Transmitter

## Description
A UART (Universal Asynchronous Receiver Transmitter) Transmitter 
designed in Verilog. Converts parallel 8-bit data into a serial 
bit stream with start and stop bits.

## Specifications
- Data bits: 8
- Start bit: 1 (logic low)
- Stop bit: 1 (logic high)
- LSB transmitted first
- Active low reset

## Ports
| Signal | Direction | Description |
|--------|-----------|-------------|
| clk | Input | Clock |
| rst_n | Input | Active low reset |
| tx_start | Input | Begin transmission |
| data_in | Input | 8-bit parallel data |
| tx | Output | Serial output line |
| tx_busy | Output | High during transmission |

## FSM States
| State | Description |
|-------|-------------|
| IDLE | Line held high, waiting for tx_start |
| START | Sends 1 low bit (start bit) |
| DATA | Sends 8 data bits LSB first |
| STOP | Sends 1 high bit, returns to IDLE |

## How to Simulate
1. Open [EDA Playground](https://www.edaplayground.com/x/g9dW)
2. Paste uart_tx.sv in the Design tab
3. Paste tb_uart_tx.sv in the Testbench tab
4. Select Icarus Verilog
