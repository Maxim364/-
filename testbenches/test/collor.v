module collor (
    input wire [1:0] input_value, // 2-битный вход: 0, 1, 2, 3
    input wire main_program,      // Управляющий сигнал
    output reg red_led,           // Красный светодиод
    output reg green_led,         // Зелёный светодиод
    output reg blue_led           // Синий светодиод
);

always @(*) begin
    // Инициализация всех светодиодов выключенными
    red_led = 1'b0;
    green_led = 1'b0;
    blue_led = 1'b0;
  if (main_program) begin
    // Включение светодиодов в зависимости от input_value
    case (input_value)
        2'b00: begin
            // Вход 0: Никакой светодиод не горит
            red_led = 1'b0;
            green_led = 1'b0;
            blue_led = 1'b0;
        end
        2'b01: begin
            // Вход 1: Зелёный светодиод
            red_led = 1'b0;
            green_led = 1'b1;
            blue_led = 1'b0;
        end
        2'b10: begin
            // Вход 2: Жёлтый светодиод (красный + зелёный)
            red_led = 1'b1;
            green_led = 1'b1;
            blue_led = 1'b0;
        end
        2'b11: begin
            // Вход 3: Синий светодиод
            red_led = 1'b0;
            green_led = 1'b0;
            blue_led = 1'b1;
        end
        default: begin
            // По умолчанию: Никакой светодиод не горит
            red_led = 1'b0;
            green_led = 1'b0;
            blue_led = 1'b0;
        end
    endcase
  end
end

endmodule