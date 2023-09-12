CREATE DATABASE HomeTask5;

USE HomeTask5;

-- Создание таблиц для работы
CREATE TABLE Cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT Cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM Cars;

# Задание 1: Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE VIEW CheapCars AS 
SELECT *
FROM Cars 
WHERE cost < 25000;

SELECT *
FROM CheapCars;

# Задание 2: Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW CheapCars AS
SELECT *
FROM Cars
WHERE cost < 30000;

SELECT *
FROM CheapCars;

# Задание 3: Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE VIEW CarsSkodaAudi AS
SELECT *
FROM Cars
WHERE name = 'Skoda' or name = 'Audi';

SELECT *
FROM CarsSkodaAudi;

# Задание 4: Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
CREATE TABLE TrainTime
(
	train_id_integer INT NOT NULL,
	station_character_varying_20 VARCHAR(30) NOT NULL,
	station_time_time_without_time_zone TIME NOT NULL
);

INSERT TrainTime
VALUES
(110, 'San Francisco', 100000),
(110, 'Redwood City', 105400),
(110, 'Palo Alto', 110200),
(110, 'San Jose', 123500),
(120, 'San Francisco', 110000),
(120, 'Palo Alto', 124900),
(120, 'San Jose', 133000);

SELECT *
FROM TrainTime;

SELECT 
	train_id_integer AS ID_train,
	station_character_varying_20 AS City,
	station_time_time_without_time_zone AS FirstTime,
	SUBTIME(LEAD(station_time_time_without_time_zone) OVER(PARTITION BY train_id_integer), station_time_time_without_time_zone) AS SecondTime
FROM TrainTime;
-- В сети нашел функцию, которая вычисляет разницу времени: https://oracleplsql.ru/mysql-function-subtime.html 