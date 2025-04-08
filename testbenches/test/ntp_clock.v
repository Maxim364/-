module ntp_clock (
    input wire clk,               // Тактовый сигнал (50 МГц)
    input wire reset_n,           // Сброс (активный низкий уровень)
	 input [31:0] HPS_CLOCK,
	 input GPIOdetection,
	 output [9:0] LEDR,
	 output [22:0] GPIO1,
	 output [23:0] GPIO2,
    output wire [6:0] hex2,       // Семисегментный индикатор (минуты, единицы)
    output wire [6:0] hex3,       // Семисегментный индикатор (минуты, десятки)
    output wire [6:0] hex4,       // Семисегментный индикатор (часы, единицы)
    output wire [6:0] hex5        // Семисегментный индикатор (часы, десятки)
);

// Внутренние сигналы для семисегментных индикаторов
	wire [6:0] seg_minutes_units;
	wire [6:0] seg_minutes_tens;
	wire [6:0] seg_hours_units;
	wire [6:0] seg_hours_tens;
	
	wire main_program;


// Преобразуем секунды, минуты и часы в семисегментный код
seven_segment seg_minutes_u (
    .digit( HPS_CLOCK[3:0] ),  // Единицы минут
    .seg(seg_minutes_units)
);

seven_segment seg_minutes_t (
    .digit( HPS_CLOCK[7:4] ),  // Десятки минут
    .seg(seg_minutes_tens)
);

seven_segment seg_hours_u (
    .digit( HPS_CLOCK[11:8] ),    // Единицы часов
    .seg(seg_hours_units)
);

seven_segment seg_hours_t (
    .digit( HPS_CLOCK[15:12] ),    // Десятки часов
    .seg(seg_hours_tens)
);

motion_detector motion_detector_inst(
    .clk(clk),          // Системный тактовый сигнал
    .motion(GPIOdetection),      // Сигнал от датчика движения
	 .reset(reset_n),
    .main_program(main_program)  // Сигнал для основной программы
);



			motors seg11(
				 .mclk(clk),
				 .control_input(seg_minutes_units[0]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[0])
				 
			);

			motors seg12(
				 .mclk(clk),
				 .control_input(seg_minutes_units[1]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[1])	 
			);

			motors seg13(
				 .mclk(clk),
				 .control_input(seg_minutes_units[2]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[2])
			);

			motors seg14(
				 .mclk(clk),
				 .control_input(seg_minutes_units[3]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[3])
			);

			motors seg15(
				 .mclk(clk),
				 .control_input(seg_minutes_units[4]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[4])
			);

			motors seg16(
				 .mclk(clk),
				 .control_input(seg_minutes_units[5]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[5])
			);


			motors seg17(
				 .mclk(clk),
				 .control_input(seg_minutes_units[6]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[6])
			);


			motors seg21(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[0]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[7])
			);


			motors seg22(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[1]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[8])
			);


			motors seg23(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[2]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[9])
			);

			motors seg24(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[3]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[10])
			);

			motors seg25(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[4]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[11])
			);

			motors seg26(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[5]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[12])
			);


			motors seg27(
				 .mclk(clk),
				 .control_input(seg_minutes_tens[6]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO2[13])
			);

			motors seg31(
				 .mclk(clk),
				 .control_input(seg_hours_units[0]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[0])
			);

			motors seg32(
				 .mclk(clk),
				 .control_input(seg_hours_units[1]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[1])
			);

			motors seg33(
				 .mclk(clk),
				 .control_input(seg_hours_units[2]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[2])
			);

			motors seg34(
				 .mclk(clk),
				 .control_input(seg_hours_units[3]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[3])
			);

			motors seg35(
				 .mclk(clk),
				 .control_input(seg_hours_units[4]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[4])
			);


			motors seg36(
				 .mclk(clk),
				 .control_input(seg_hours_units[5]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[5])
			);

			motors seg37(
				 .mclk(clk),
				 .control_input(seg_hours_units[6]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[6])
			);

			motors seg41(
				 .mclk(clk),
				 .control_input(seg_hours_tens[0]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[7])
			);

			motors seg42(
				 .mclk(clk),
				 .control_input(seg_hours_tens[1]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[8])
			);

			motors seg43(
				 .mclk(clk),
				 .control_input(seg_hours_tens[2]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[9])
			);

			motors seg44(
				 .mclk(clk),
				 .control_input(seg_hours_tens[3]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[10])
			);

			motors seg45(
				 .mclk(clk),
				 .control_input(seg_hours_tens[4]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[11])
			);

			motors seg46(
				 .mclk(clk),
				 .control_input(seg_hours_tens[5]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[12])
			);

			motors seg47(
				 .mclk(clk),
				 .control_input(seg_hours_tens[6]),  //Use this as the control input
				 .reset(reset_n),
				 .main_program(main_program),
				 .servo(GPIO1[13])
			);
			
			blink_led lamp1(
				 .clk(clk),       
				 .rst(reset_n),
				 .main_program(main_program),         
				 .led(GPIO2[22])          
			);
			blink_led lamp2(
				 .clk(clk),       
				 .rst(reset_n),
				 .main_program(main_program),         
				 .led(GPIO2[23])          
			);

			collor RGB(
				.input_value(HPS_CLOCK[17:16]), // 2-битный вход: 0, 1, 2, 3
				.main_program(main_program),
				.red_led(GPIO1[22]),           // Красный светодиод
				.green_led(GPIO1[21]),         // Зелёный светодиод
				.blue_led(GPIO1[20])           // Синий светодиод
			);


// Назначаем выходные сигналы
assign hex2 = seg_minutes_units;
assign hex3 = seg_minutes_tens;
assign hex4 = seg_hours_units;
assign hex5 = seg_hours_tens;
assign LEDR[1] = GPIOdetection;
assign LEDR[2] = main_program;

endmodule