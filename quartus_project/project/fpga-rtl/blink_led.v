module blink_led (
    input wire clk,          // Тактовый сигнал
    input wire rst,          // Сброс (активный уровень высокий)
	 input main_program,
    output reg led          // Светодиод
);

    // Параметры для счетчика
    parameter CLOCK_FREQ = 50_000_000; // Частота тактового сигнала (50 МГц)
    parameter ONE_SECOND = CLOCK_FREQ;  // Количество тактов в секунду

    reg [31:0] counter;      // 32-битный счетчик

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Сброс счетчика и светодиода
            counter <= 0;
            led <= 0;
		  end else if (!main_program) begin
            // Если main_program == 0, выключаем светодиод и сбрасываем счетчик
            led <= 0;
            counter <= 0;
        end else begin
            // Увеличение счетчика
            if (counter >= ONE_SECOND - 1) begin
                counter <= 0;           // Сброс счетчика
                led <= ~led;            // Инвертирование состояния светодиода
            end else begin
                counter <= counter + 1; // Увеличение счетчика
            end
        end
    end

endmodule