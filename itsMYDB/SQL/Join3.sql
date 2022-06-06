SELECT M.Surname, D.Name
FROM Managers M, Departments D
WHERE M.Id_main_dep = D.Id