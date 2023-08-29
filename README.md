# avitoSwiftTrainee
Тестовое задание для стажёра iOS 2023

### Общее описание задания:
Написать приложение для iOS, которое будет состоять из двух экранов: 
- Список товаров, данный экран будет стартовым.
- Детальная карточка товара, будет открываться по нажатию на элемент в списке товаров.

### Реализовала 2 экрана:
1) Экран - список товаров на продажу:
<img width="30%" alt="Снимок экрана 2023-08-29 в 09 03 18" src="https://github.com/RSusanna/avitoSwiftTrainee/assets/123595600/a19d3bf1-6fc7-4354-adfa-cfcb8fae4b11">

2) карточка товара:
<img width="30%" alt="Снимок экрана 2023-08-29 в 09 03 28" src="https://github.com/RSusanna/avitoSwiftTrainee/assets/123595600/70694b94-4688-4d3a-b089-147bea4c5118">

### У каждого экрана должно  три состояния: 

- Отображение ошибки
<img width="30%" alt="Снимок экрана 2023-08-29 в 09 10 22" src="https://github.com/RSusanna/avitoSwiftTrainee/assets/123595600/02184442-1dfb-485e-8391-1f93d24bd2e1">


- Состояние загрузки
 <img width="30%" alt="Снимок экрана 2023-08-29 в 08 51 45" src="https://github.com/RSusanna/avitoSwiftTrainee/assets/123595600/5a77f69f-e8cd-4874-8827-ef6295f83c5f">

- Отображение контента из JSON файла
 <img width="30%" alt="Снимок экрана 2023-08-29 в 09 03 18" src="https://github.com/RSusanna/avitoSwiftTrainee/assets/123595600/d57d6cbc-8d4f-42bc-ac31-a9e44372eebc">

Референс для внешнего вида - приложение Авито.
Для каждого экрана данные загружаются в формате JSON из интернета: 
- https://www.avito.st/s/interns-ios/main-page.json - URL для запроса на главном экране.
- https://www.avito.st/s/interns-ios/details/{itemId}.json - URL для запроса на детальной странице. ID берется из данных для главного экрана. 
##  Для реализации данного приложения использовались следующие технологии:
1. Архитектура: MVP
2. Интерфейс: Создание пользовательского интерфейса осуществлен через код без использования SwiftUI.
3. Использовала сторонние библиотеки: SnapKit и Kingfisher
4. Список товаров: Для отображения списка товаров используется UICollectionView с отображением в два столбца.
5. Карточка товара: Для его отображения использовала UISCrollView
6. Загрузка данных: Данные загружаются с использованием URLSession.
7. Адаптировала для светлой и темной темы
8. Обработка состояний: Для управления состояниями экранов (загрузка, ошибка, контент) применяется подход с использованием различных view и состояний в зависимости от процесса загрузки данных.