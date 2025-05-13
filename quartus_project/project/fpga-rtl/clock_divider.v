module clock_divider (
    input wire clk,          // Вход: тактовый сигнал (50 МГц)
    input wire reset_n,      // Вход: сброс (активный низкий уровень)
    output reg slow_clk      // Выход: медленный тактовый сигнал
);

reg [25:0] counter;  // Счетчик для деления частоты

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        slow_clk <= 0;
    end else begin
        if (counter == 26'd49999999) begin  // Делитель для 1 Гц (50 МГц / 50M = 1 Гц)
            counter <= 0;
            slow_clk <= ~slow_clk;  // Инвертируем сигнал
        end else begin
            counter <= counter + 1;
        end
    end
end

endmodule