DECLARE @TenantID INT;
DECLARE @j INT;
DECLARE @k INT;
DECLARE @CreatedUserID INT;
DECLARE @TenantCursor CURSOR;
DECLARE @TenantName VARCHAR(50);

BEGIN TRY
    BEGIN TRANSACTION;

----------- tworze 10 podmiotów
    DECLARE @i INT = 1;
    WHILE @i <= 10 
    BEGIN
        INSERT INTO Tenants (Name) VALUES('Podmiot' + CAST(@i AS VARCHAR(10)));
        SET @i = @i + 1;
    END;

---- utworzony kursor inaczej nie wstawi danych 
    SET @TenantCursor = CURSOR FOR
    SELECT TenantID, Name FROM Tenants;

    OPEN @TenantCursor;
    FETCH NEXT FROM @TenantCursor INTO @TenantID, @TenantName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Aktualny TenantID: ' + CAST(@TenantID AS VARCHAR(10)) + ', Nazwa: ' + @TenantName;

        SET @j = 1;
        WHILE @j <= 100
        BEGIN
---- dodanie u¿ytkownika do danych 
            INSERT INTO Users (TenantID, Username, Manager)
            VALUES (@TenantID, 'Uzytkownik_' + CAST(@TenantID AS VARCHAR(10)) + '_' + CAST(@j AS VARCHAR(10)), 
                    CASE WHEN @j % 10 = 0 THEN 2 ELSE 1 END);

            SET @CreatedUserID = SCOPE_IDENTITY();
--- sprawdzenie czy dodany poprawnie, je¿eli nie to wywali ca³¹ procedrue 
            IF @CreatedUserID > 0
            BEGIN
                SET @k = 1;
                WHILE @k <= 1000
                BEGIN
---- dodanie zadañ do u¿ytkownika 
                    INSERT INTO Tasks (TenantID, CreatedByUserID, Title, Priority, Descriptions, Status)
                    VALUES (@TenantID, @CreatedUserID, 'Zadanie ' + CAST(@k AS VARCHAR(10)),
                        CASE WHEN @k % 3 = 0 THEN 'Wysoki' WHEN @k % 3 = 1 THEN 'Sredni' ELSE 'Niski' END,
                        'Opis zadania ' + CAST(@k AS VARCHAR(255)),
                        CASE WHEN @k % 4 = 0 THEN 'Nowe' WHEN @k % 4 = 1 THEN 'W toku' ELSE 'Zakoñczone' END);

                    SET @k = @k + 1;
                END;
            END
            ELSE
            BEGIN
                THROW 50000, 'Wyst¹pi³ problem z dodaniem u¿ytkownika.', 1; ---- informacja jak wyst¹pi problem 
            END
            
            SET @j = @j + 1;
        END;

        FETCH NEXT FROM @TenantCursor INTO @TenantID, @TenantName;
    END;

    CLOSE @TenantCursor;
    DEALLOCATE @TenantCursor;

    COMMIT TRANSACTION; -- zatwierdzenie transakcji jak nie ma b³êdu 
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION; -- wycofanie jak jest b³¹d
    THROW; -- Rzuca wyj¹tek ponownie, aby przekazaæ b³¹d do wy¿szego poziomu
END CATCH;


UPDATE USERS 
SET Role = 'Manager'
WHERE Manager = 2;
