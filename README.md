# Электронно-механические часы на ПЛИС

## Описание проекта

Данный проект представляет собой курсовую работу, посвящённую разработке электронно-механических часов на базе программируемой логической интегральной схемы (ПЛИС) с использованием встроенного процессора (HPS). В рамках проекта реализована система, получающая текущее время из операционной системы Linux, работающей на HPS, и передающая его в ПЛИС для аппаратного отображения. Также предусмотрено управление подсветкой часов с помощью Python-программы.

Проект объединяет аппаратную и программную части, а также 3D-моделирование.

## Состав репозитория

Репозиторий содержит следующие основные компоненты:

### 1. **Проект Quartus**
Каталог `quartus_project/` содержит файлы проекта Quartus Prime, включая:

- HDL-файлы, реализующие логику отображения времени;
- Проект Qsys с настройкой взаимодействия между HPS и FPGA;
- Конфигурационные файлы (`.qsf`, `.qpf`, `.sdc`) проекта Quartus.

### 2. **Программа для HPS**
Каталог `hps_program/` содержит C-программу, выполняемую на процессоре HPS:

- Получение текущего времени из Linux и передача его в FPGA посредством C-программы;
- Makefile для сборки программы под ARM-платформу.
- Скомпилированная C-программа.

### 3. **3D-модель часов**
Каталог `models/` включает файлы для реализации 3D-модели часов:

- 3D-модели каждого элемента часов.
- Сборка модели.
- STL файлы для печати на 3D-принтере.

### 4. **Скрипт управления подсветкой**
Каталог `python_tools/` содержит Python-скрипт, управляющий подсветкой устройства:

- `backlight_control.py` — позволяет переключать режимы подсветки;

### 5. **Документация**
Каталог `doc/` содержит материалы курсовой работы:

- Отчет;
- Руководство разработчика;
- Руководство пользователя.

### 6. **Образ Linux**
Каталог `linux_image/` содержит необходимые файлы для запуска Linux на HPS:

- Предсобранный образ Linux (`Image`);
- Инструкции по прошивке на SD-карту;

## Назначение проекта

Проект направлен на интеграцию программируемой логики с системой на базе Linux, развитие навыков работы с ПЛИС и системным программированием, а также демонстрацию взаимодействия аппаратных и программных средств в рамках одной функциональной системы.

---

**Авторы:** *Батаев Максим, Леснов Илья*  
**Проект выполнен в рамках курсовой работы по дисциплине "Алгоритмизация и программирование"*


