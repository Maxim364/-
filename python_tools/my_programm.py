import requests
from requests.auth import HTTPBasicAuth
import re
import time

while True:
    # Функция для удаления HTML-тегов
    def remove_html_tags(text):
        clean_text = re.sub(r'<.*?>', '', text)  # Убираем все теги
        return clean_text.strip()  # Убираем лишние пробелы по краям

    # Данные для доступа
    api_url = "https://chat.miem.hse.ru/api/v1/messages?anchor=newest&num_before=1&num_after=0&narrow=[{\"operator\":\"stream\",\"operand\":\"test11\"}]"
    api_key = "fxUu9xKeXhfkJaeTbuEidNnoasFaF5q5"
    email = "mabataev@edu.hse.ru"

    # Отправка GET-запроса с авторизацией
    response = requests.get(api_url, auth=HTTPBasicAuth(email, api_key))

    # Проверка успешности запроса
    if response.status_code == 200:
        data = response.json()
        # Извлечение текста последнего сообщения
        if "messages" in data:
            messages = data["messages"]
            if messages:
                last_message = messages[0]["content"]
                # Убираем HTML-теги
                last_message_clean = remove_html_tags(last_message)

                print("Last message:",  last_message_clean)

                # Передаем соответствующее значение в файл
                if last_message_clean.lower() == "green":
                    value = 3
                elif last_message_clean.lower() == "red":
                    value = 2
                elif last_message_clean.lower() == "blue":
                    value = 1
                else:
                    value = 0

                # Записываем значение в файл
                with open("message_value.txt", "w") as file:
                    file.write(str(value))
    else:
        print("Error:", response.status_code)
    time.sleep(5)
