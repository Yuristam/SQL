/*
    EXCEPT - возвращает только те данных, которых нет в других таблицах(т.е. уникальные данные)
*/

SELECT *
FROM Comixes

EXCEPT

SELECT *
FROM Mangas