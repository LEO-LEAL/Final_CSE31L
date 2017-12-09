`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 03:56:01 PM
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter#(
// Parameters
    parameter DATA_WIDTH = 8, // number of bits in the internal counter register
    parameter COUNT_FROM = 0, // start with this number
    parameter COUNT_TO = 2**( DATA_WIDTH -1) , // value to count to
    parameter STEP = 1 // negative ( STEP = -1) or positive ( STEP = 1)
    ) (
    // Inputs
    input clk , // clock
    input en , // enable signal . When it is asserted (en =1) , counter can count
    input rst , // synchronous reset . if it is asserted ( rst =1) , counter is reseted to COUNT_FROM
    input preload ,// if prload =1 , input_data is loaded into the counter register
    input [ DATA_WIDTH -1:0] input_data , // if prload =1 , input_data is loaded into the counter register
    // Output
    output logic [ DATA_WIDTH -1:0] out_data // counter register : it stores value of the counter
);

logic [ DATA_WIDTH -1:0] temp = COUNT_FROM;

always @(posedge clk) begin
    temp <= preload ? input_data : temp;
    if(rst)
        temp <= COUNT_FROM;
    else if(temp == COUNT_TO)
        temp <= COUNT_FROM;
    else if(en)
        temp <= temp + STEP;
end

assign out_data =  temp;

endmodule
