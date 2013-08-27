Тестовое задание Clickavia
==========================
## Что проверяем?
Задание состоит из ряда разноплановых действий, для проверки общего спектра навыков. Вам понадобятся знания:

- Серверной части rails приложений (backend)
- backbone.js + jquery + datatables (frontend)
- Unit тестирования (RSpec)
- Рефакторинга и оптимизации существующего кода

## Времязатраты
Во время выполнения задания обязательно фиксируйте времязатраты по каждому отдельному пункту и выписывайте их в отдельном файле ([TIMETRACKING.md](TIMETRACKING.md) в корне проекта). Фиксировать нужно время затраченное и на изучение проекта, и на изучение сути задания, и на итоговую реализацию.

## Порядок работы
1. Данный github проект необходимо форкнуть и все последующие действия выполнять только в своем форке
2. По окончании работы отправить ссылку на свой форк с созданным и заполненным файлом [TIMETRACKING.md](TIMETRACKING.md) на адрес `bazzy.bazzy@gmail.com`
3. Старайтесь коммитить часто, сохраняйте историю коммитов в том порядке, в каком вы их и создавали.


## Задания
В приложении уже присутствуют основные необходимые сущности: модели, котроллеры. Есть все необходимые миграции и данные в seeds. В процессе работы любые улучшения визуальной и UX части только приветствуются (по-умолчанию приложение имеет почти спартанский внешний вид)

### Datatables + Рефакторинг ([http://datatables.net](http://datatables.net))
1. По адресу `/flights` выводится таблица всех существующих в БД рейсов, с использованием плагина `datatables`. Данные загружаются с использованием ajax. Необходимо сделать сортировку и фильтрацию в данной таблице. И сортировка, и филтрация должны происходить на стороне сервера. Сортировка по полям: `дата вылета`, `время вылета`, `время прилета`, `наличие мест`.
2. Фильтр по коду рейса уже реализован, в качестве вспомогательного примера. Нужно сделать фильтрацию рейсов по `дате вылета` внутри указанного диапазона дат (например в ячейке сделать два инпута для ввода даты начала и даты конца диапазона, либо другим удобным способом, на ваше усмотрение).
3. Поля `дата вылета`, `время вылета`, `время прилета` выводятся не в человекопонятном виде. Изменить вывод даты и времени в понятном для русского пользователя формате.
4. Провести рефакторинг `FlightsController#index`.

### Backbone.js + Backend ([http://backbonejs.org/](http://backbonejs.org/))
1. В неймспейсе `Parsers` присутствует второй контроллер(`Parsers::FlightsController`) для отображения рейсов(`/parsers/flights`). По этому пути используется отдельный layout и это уже отдельное backbone приложение. Основа приложения уже существует и расположена в `assets/javascripts/backbone`. Необходимо доработать приложение для отображения таблицы рейсов: реализовать пагинацию для таблицы и динамическое изменение количества элементов на одной странице таблицы (10, 50, 100).
2. Написать парсер рейсов с сайта `NecTravel`. Описание и подробности смотрите в тестовом задании на реализацию парсера ([PARSER_TEST_JOB.md](PARSER_TEST_JOB.md) в корне проекта). Примечание: покрывать тестами данный парсер **не нужно**. При обдумывании архитектуры парсера учитывайте, что парсеров и операторов может быть много. Продумывайте архитектуру при которой добавление и реализация новых парсеров максимально упростит жизнь.
3. Для интерфейса из п.2 используйте `FilterView` (`/app/assets/javasripts/backbone/views/flights/filter_view.js.coffee`). При сабмите данных формы, должен отсылаться запрос на сервер, например на `/parsers/flights/parse`, где должен запускаться парсер из п.2. По окончании работы парсера, все рейсы должны быть сохранены в БД. При каждом запуске парсера, можно очищать таблицу с рейсами для упрощения работы.

### Немного тестирования
1. Написать тесты для расчета времени рейса в пути `Flight#travel_time`. Пункты вылета и назначения рейса могут (и чаще всего будут) находиться в разных часовых поясах. Доработайте логику расчета этого времени и протестируйте правильность расчетов. Используйте `RSpec` и `FactoryGirl`.
