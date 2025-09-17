# DeepSeek-Test-API

ИИ-чат приложение для общения с моделью DeepSeek AI.

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## Описание

DeepSeek-Test-API - это интерактивное приложение для iOS, которое позволяет пользователям общаться с ИИ-ассистентом DeepSeek. Приложение демонстрирует возможности интеграции с API DeepSeek и предоставляет удобный интерфейс для взаимодействия с искусственным интеллектом.

## Возможности

- 💬 Чат с ИИ-ассистентом DeepSeek
- 🌐 Интеграция с DeepSeek API
- 🎨 Современный интерфейс iOS
- 💾 Сохранение истории разговоров
- ⚡ Быстрые ответы от ИИ
- 🔄 Поддержка продолжения диалогов

## Требования

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Установка

1. Клонируйте репозиторий:
```bash
git clone https://github.com/your-username/DeepSeek-Test-API.git
```

2. Откройте проект в Xcode:
```bash
cd DeepSeek-Test-API
open DeepSeek-Test-API.xcodeproj
```

3. Установите зависимости (если используются):
```bash
# Если используете CocoaPods
pod install

# Если используете Swift Package Manager
# Дependencies автоматически resolved в Xcode
```

4. Настройте API ключ:
   - Создайте файл `Config.plist` в папке проекта
   - Добавьте ключ `API_KEY` со значением вашего DeepSeek API ключа

5. Соберите и запустите проект в Xcode (⌘ + R)

## Настройка API

Для работы приложения необходим API ключ от DeepSeek:

1. Зарегистрируйтесь на [DeepSeek API](https://platform.deepseek.com/)
2. Получите API ключ в личном кабинете
3. Добавьте ключ в конфигурацию приложения

## Структура проекта

```
DeepSeek-Test-API/
├── Sources/
│   ├── Models/
│   │   ├── Message.swift
│   │   └── ChatSession.swift
│   ├── Views/
│   │   ├── ChatView.swift
│   │   └── MessageCell.swift
│   ├── ViewModels/
│   │   └── ChatViewModel.swift
│   ├── Services/
│   │   └── APIService.swift
│   └── Utilities/
│       ├── Constants.swift
│       └── Extensions.swift
├── Resources/
│   ├── Assets.xcassets
│   └── Config.plist
└── Supporting Files/
    └── Info.plist
```

## Использование

1. Запустите приложение
2. Начните вводить сообщение в текстовое поле
3. Нажмите кнопку отправки или Enter
4. Дождитесь ответа от ИИ DeepSeek
5. Продолжайте беседу, задавая новые вопросы

## Разработка

### Сборка и запуск

1. Откройте проект в Xcode
2. Выберите целевое устройство или симулятор
3. Нажмите ⌘ + R для сборки и запуска

### Тестирование

Запустите тесты с помощью ⌘ + U или через меню Product → Test

### Архитектура

Приложение использует архитектуру MVVM (Model-View-ViewModel) для разделения ответственности и обеспечения тестируемости кода.

## Лицензия

Этот проект распространяется под лицензией MIT. Подробнее см. в файле [LICENSE](LICENSE).

## Вклад в проект

1. Форкните репозиторий
2. Создайте ветку для вашей функции (`git checkout -b feature/amazing-feature`)
3. Закоммитьте изменения (`git commit -m 'Add some amazing feature'`)
4. Запушьте в ветку (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

## Обратная связь

Если у вас есть вопросы или предложения по улучшению приложения, создайте issue в репозитории проекта или свяжитесь с нами по email: your-email@example.com

## Благодарности

- Команде DeepSeek за предоставление API
- Сообществу Swift и iOS разработчиков
