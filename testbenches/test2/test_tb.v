`timescale 1ns / 1ps

module motors_tb;

    // Тестовые сигналы
    reg mclk;
    reg control_input;
    reg reset;
    reg main_program;
    wire servo;

    // Экземпляр модуля motors
    motors uut (
        .mclk(mclk),
        .control_input(control_input),
        .reset(reset),
        .main_program(main_program),
        .servo(servo)
    );

    // Генерация тактового сигнала (50 МГц)
    initial begin
        mclk = 0;
        forever #10 mclk = ~mclk; // Такт 50 МГц (период 20 нс)
    end

    // Инициализация входных сигналов
    initial begin
        // Инициализация сигналов
        reset = 1;
        control_input = 0;
        main_program = 0;

        // Снятие сброса через 20 нс
        #20 reset = 0;
        #20 main_program = 1;

        // Тестовые сценарии
        #100000 control_input = 1;  // Устанавливаем control_input в 1

        // Завершение симуляции через 500 нс
        #20000000 $finish;
    end

    // Мониторинг сигналов
    initial begin
        $monitor("Time: %0t | mclk: %b | reset: %b | control_input: %b | main_program: %b | servo: %b | Counter: %d",
                 $time, mclk, reset, control_input, main_program, servo, uut.counter);
    end

endmodule