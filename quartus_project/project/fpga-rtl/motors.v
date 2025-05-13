`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:11:28 05/29/2020 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module motors #(
    parameter ANGLE = 90  // Угол по умолчанию (можно переопределить)
) (input mclk,
    input control_input,  //Use this as the control input
    input reset,
    input main_program,
    output servo
    );

//50 MHz clock onBoard
//20 ms counter.
//		1/50,000,000  Hz 			= 20  ns (every posedge)
//		(20,000,000 ns)/(20 ns) = 1,000,000
//
//    (20 bits) (2^(20)-1) 	= 1,048,575 (from 0 to 1,048,575)
//				Therefore, counter needs 20 bits [19:0]
//				Count up to 999,999 (0 included)

//Assumed Max (180 deg) 2 ms 			= 100,000*20 ns (100,000 clks)
//Assumed Min (0   deg) 1 ms 			=  50,000*20 ns ( 50,000 clks)
//Positions  100,000 - 50,000 		= 50,000
//Resolution (180 degrees)/50,000 	= 0.0036 degrees

//essential registers
reg [19:0] counter;
reg        servo_reg;

// Фиксированные значения для углов

localparam ANGLE_90  = 25000 + ANGLE * 416 ;   // 1.25 мс (90 градусов)
localparam ANGLE_0   = ANGLE_90 - 37400;   // 0.5 мс (0 градусов)

reg [19:0] control;

always @* begin
  if (control_input == 1'b0) 
    control = ANGLE_0;
  else
    control = ANGLE_90;
end

always @(posedge mclk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        servo_reg <= 0;
    end else if (main_program) begin
        //Servo algorithm
        counter <= counter + 1;
        
        if (counter == 'd999999)
            counter <= 0;

        // Генерация PWM-сигнала
        if (counter < control)
            servo_reg <= 1;  // Высокий уровень
        else
            servo_reg <= 0;  // Низкий уровень
    end else begin
        // Если main_program == 0, сбросить счётчик и servo_reg
        counter <= 0;
        servo_reg <= 0;
    end
end

assign servo = servo_reg;

endmodule