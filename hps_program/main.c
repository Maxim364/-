#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <arpa/inet.h>
#include <netdb.h>
#include "hwlib.h"
#include "soc_cv_av/socal/socal.h"
#include "soc_cv_av/socal/hps.h"
#include "soc_cv_av/socal/alt_gpio.h"
#include "hps_0.h"

// Константы для работы с FPGA
#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )




int main() {
    void *virtual_base;
    int fd;
    void *h2p_lw_time_addr;
    printf("1111111");

    
    // Открытие /dev/mem для доступа к памяти
    if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
        printf("ERROR: could not open \"/dev/mem\"...\n");
        return 1;
    }

    printf("222222");

    // Маппинг памяти FPGA в пользовательское пространство
    virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
    if (virtual_base == MAP_FAILED) {
        printf("ERROR: mmap() failed...\n");
        close(fd);
        return 1;
    }

    printf("333333");

    // Адрес для записи времени в FPGA (замените на актуальный)
    h2p_lw_time_addr = virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + PIO_LED_BASE) & (unsigned long)(HW_REGS_MASK));

    printf("4444444");

    while (1) {

        printf("6666666");
        // Переменные для хранения времени
        time_t raw_time;
        struct tm *time_info;

        printf("555555");

        // Получаем текущее время
        time(&raw_time);
        time_info = localtime(&raw_time);

        printf("777777");

        // Извлекаем часы и минуты
        int hours = (time_info->tm_hour) + 3;
        int minutes = time_info->tm_min;

        printf("8888888");

        // Разделяем часы и минуты на цифры:
        uint32_t tens_hours = hours / 10;  // Десятки часов
        uint32_t ones_hours = hours % 10;  // Единицы часов
        uint32_t tens_minutes = minutes / 10;  // Десятки минут
        uint32_t ones_minutes = minutes % 10;  // Единицы минут

        printf("99999999");

        // Формируем 4 цифры для записи в FPGA
        uint32_t time_digits = ((uint32_t)tens_hours << 24) | ((uint32_t)ones_hours << 16) | ((uint32_t)tens_minutes << 8) | (uint32_t)ones_minutes;

        printf("101010010101");

        // Записываем время в память FPGA (в 32-битном формате)
        *(uint32_t *)h2p_lw_time_addr = time_digits;
        printf("Time written to FPGA: %02d:%02d\n", hours, minutes); // Печать записанных цифр

        // Задержка между обновлениями (например, 1 секунда)
        sleep(1);
    }

    // Очистка ресурсов
    if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return 1;
    }

    close(fd);
    return 0;
}
