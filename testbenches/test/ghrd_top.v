module ghrd_top(

    input              CLOCK_50,
    input               reset_n,
    input      GPIO,
    output     [22:0]   GPIO_0,
    output     [23:0]   GPIO_1,
    output     [6:0]    HEX2,
    output     [6:0]    HEX3,
    output     [6:0]    HEX4,
    output     [6:0]    HEX5,
    input wire [31:0]   HPS_CLOCK
);

// Инстанцируем модуль ntp_clock с именем экземпляра clock_instance
ntp_clock clock_instance (
    .clk(CLOCK_50),
    .reset_n(reset_n),
    .HPS_CLOCK(HPS_CLOCK),
    .GPIOdetection(GPIO),
    .GPIO1(GPIO_0[22:0]),
    .GPIO2(GPIO_1[23:0]),
    .hex2(HEX2),
    .hex3(HEX3),
    .hex4(HEX4),
    .hex5(HEX5)
);

endmodule
