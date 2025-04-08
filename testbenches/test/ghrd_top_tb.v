`timescale 1ns / 1ps

module ghrd_top_tb;

  // Тестовые сигналы
  reg CLOCK_50;
  reg reset_n;
  reg GPIO;  // Входной сигнал GPIO
  reg [31:0] HPS_CLOCK;
  wire [22:0] GPIO_0;
  wire [23:0] GPIO_1;
  wire [6:0] HEX2;
  wire [6:0] HEX3;
  wire [6:0] HEX4;
  wire [6:0] HEX5;
  
  // Экземпляр модуля ghrd_top
  ghrd_top uut (
    .CLOCK_50(CLOCK_50),
    .reset_n(reset_n),
    .GPIO(GPIO),
    .GPIO_0(GPIO_0),
    .GPIO_1(GPIO_1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5),
    .HPS_CLOCK(HPS_CLOCK)
  );

  // Генерация тактового сигнала CLOCK_50
  initial begin
    CLOCK_50 = 0;
    forever #10 CLOCK_50 = ~CLOCK_50; // Такт 50 МГц (период 10 нс)
  end

  // Инициализация входных сигналов
  initial begin
    // Инициализация сигналов
    reset_n = 1;  // Активный низкий уровень сброса
    GPIO = 0;
    HPS_CLOCK = 32'h00025789;

    // Снятие сброса через 20 нс
    #20 reset_n = 0;
  #100000 GPIO = 1;  
    // Тестовые сценарии
    #100000000 GPIO = 0;
    #100000 HPS_CLOCK = 32'h00039231; // Устанавливаем значение HPS_CLOCK


    // Завершение симуляции через 200 нс
    #200000 $finish;
  end

  // Мониторинг сигналов
  initial begin
    $monitor(" reset_n: %b | GPIO: %b | HPS_CLOCK: %h | detection %b | seg_hours_units %b |GPIO2[4] %b | counter %d | motion %b | GPIO_0: %b | GPIO_1: %b  | HEX2: %b | HEX3: %b | HEX4: %b | HEX5: %b",
              reset_n, GPIO, HPS_CLOCK, uut.clock_instance.main_program, uut.clock_instance.seg_hours_units[4],uut.clock_instance.GPIO2[4], uut.clock_instance.motion_detector_inst.counter, uut.clock_instance.motion_detector_inst.motion,  GPIO_0, GPIO_1, HEX2, HEX3, HEX4, HEX5);
  end

  initial begin
    $dumpfile("ghrd_top_tb.vcd");
    $dumpvars(0, ghrd_top_tb);
  end

endmodule