module motion_detector(
    input wire clk,          // Системный тактовый сигнал
	 input wire reset,
    input wire motion,      // Сигнал от датчика движения
    output reg main_program  // Сигнал для основной программы
);

// Параметры для реализации счётчика
parameter CLK_FREQ = 50_000_000;  // Частота тактового сигнала (50 МГц)
parameter TIMER_LIMIT = 0.00002;       // Ограничение по времени (120 секунд)

// Сигналы для счётчика времени
reg [31:0] counter;  // Счётчик времени
reg motion_detected; // Флаг, показывающий обнаружение движения

// Процесс обработки сигнала обнаружения движения
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        motion_detected <= 0;
        main_program <= 0;
    end else begin
        // Детектирование движения
        if (motion) begin
            motion_detected <= 1;      // Движение обнаружено
            counter <= 0;              // Сбросить счётчик
	    main_program <= 1;
        end else if (motion_detected) begin
            counter <= counter + 1;    // Увеличиваем счётчик каждое тактирование

            // Проверка времени работы программы (2 минуты = 120 секунд)
            if (counter >= CLK_FREQ * TIMER_LIMIT) begin
                main_program <= 0;     // Останавливаем основную программу после 2 минут
                motion_detected <= 0;  // Сбрасываем флаг движения
            end else begin
                main_program <= 1;     // Основная программа активна
            end
        end
    end
end

endmodule
