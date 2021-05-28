-- Actualizar la fecha de lectura:
UPDATE content SET DateLastRead = '2013-07-12T01:00:43Z'
WHERE ContentID= ''
AND ContentType = 6
and ReadStatus = 2;

-- Actualizar el estado de lectura de un libro
UPDATE content
SET DateLastRead = '2013-07-12T01:00:43Z',
    ReadStatus = 2,
    ___PercentRead = 100
WHERE ContentID= '';

UPDATE content
SET DateLastRead = '2013-07-12T01:00:43Z',
ReadStatus = 2
where Title like 'OD%'
AND ___PercentRead = 0


-- Recuperar datos de un libro:
select * from content where DateLastRead is not null and ReadStatus = 2 order by ContentID

select ContentID, Title, Attribution, DateLastRead from content
where DateLastRead is not null and ReadStatus = 2 order by ContentID


-- Recuperar para insertar las colecciones a las que pertenece un libro:
SELECT "INSERT INTO ShelfContent (ShelfName, ContentId, DateModified, _IsDeleted, _IsSynced) VALUES ('" || ShelfName || "', '" || ContentId || "', '" || DateModified || "', '" || _IsDeleted || "', '" || _IsSynced ||"');" as orden FROM ShelfContent
WHERE ContentId like 'file%'
ORDER BY ContentId, ShelfName

SELECT "INSERT INTO Shelf (CreationDate, Id, InternalName, LastModified, Name, Type, _IsDeleted, _IsVisible, _IsSynced) VALUES ('" || CreationDate || "', '" || Id || "', '" || InternalName || "', '" || LastModified || "', '" || Name || "', '" || Type || "', '" || _IsDeleted || "', '" || _IsVisible || "', '" || _IsSynced || "');" AS MyInsOrder FROM Shelf ORDER BY Name


-- Para sacar todos los libros sin colecciones ejecutar esta consulta:
select DISTINCT a.BookId, b.ShelfName
FROM content AS a LEFT OUTER JOIN ShelfContent AS b ON a.BookId = b.ContentId
ORDER BY BookId;

-- Seleccionar todas las filas con el resultado y copiarlas a CSV con formato Excel, a continuación, pegarlo en LibreOfficeCalc y filtrar las filas con el estante vacío.

-- Atención, los BookID con el formato estrictamente numérico no corresponden con libros, se pueden quitar también

-- Escribir esta fórmula en los libros que tengan estanterías vacías:
-- Esta fórmula es para LibreOffice, con Excel habrá que modificarla
=CONCATENAR("SELECT ""INSERT INTO ShelfContent (ShelfName, ContentId, DateModified, _IsDeleted, _IsSynced) VALUES ('"" || ShelfName || ""', '"" || ContentId || ""', '"" || DateModified || ""', '"" || _IsDeleted || ""', '"" || _IsSynced ||""');"" as orden FROM ShelfContent WHERE ContentId = '";A1;"' ORDER BY ContentId, ShelfName;")

-- Si son muchos libros, se pueden ir sacando los estantes de 15 en 15
-- Pasando todos los libros sin estantes a una hoja vacía y rellenando cada 15 filas esta fórmula:
=CONCATENAR("SELECT ""INSERT INTO ShelfContent (ShelfName, ContentId, DateModified, _IsDeleted, _IsSynced) VALUES ('"" || ShelfName || ""', '"" || ContentId || ""', '"" || DateModified || ""', '"" || _IsDeleted || ""', '"" || _IsSynced ||""');"" as orden FROM ShelfContent WHERE ContentId IN ('";A1;"', '";A2;"', '";A3;"', '";A4;"', '";A5;"', '";A6;"', '";A7;"', '";A8;"', '";A9;"', '";A10;"', '";A11;"', '";A12;"', '";A13;"', '";A14;"', '";A15;"') ORDER BY ContentId, ShelfName;")

-- Para evitar andar quitando las comillas de los resultados,
-- Copiar como CSV y pegarlos en LibreOffice, dar a aceptar con las opciones por defecto del pegado,
-- y a continuación volver a copiar los resultados para lanzarlos en la otra base de datos.




SELECT * FROM content
WHERE ContentId IN ('file:///mnt/sd/Autor1/Serie1/XX - libro1.kepub.epub','file:///mnt/sd/Serie2/XX - Libro2.kepub.epub')

-- En content, la columna ContentId suele hacer referencia al archivo del libro, pero la columna
-- que tiene el campo BookID vacío y ContentID es el libro, es la que tiene el estado de lectura:
SELECT ContentID, Title, FirstTimeReading, ChapterIDBookmarked, ParagraphBookmarked, ReadStatus, DateLastRead, ___PercentRead, IsDownloaded FROM content
WHERE ContentType = 6
ORDER BY ContentID

-- Si el resultado se exporta a LibreOfficeCalc, se limpian los ContentID que no se hayan descargado (IsDownloaded false)
-- y los artículos de Pocket (ContentID numérico) podemos actualizar el estado de lectura:
UPDATE content
SET ReadStatus = 2,
    ___PercentRead = 100
WHERE ContentID= '00e895c2-62e5-460a-b6e1-979dc3cf7260';

=CONCATENAR("UPDATE content SET DateLastRead = '";G6;"', ReadStatus = 2, ___PercentRead = 100 WHERE ContentId = '";A6;"';")








-- Libros en la colección Leido con ReadStatus <> 2
SELECT lib.ContentID, lib.Title, lib.FirstTimeReading, lib.ChapterIDBookmarked,
       lib.ParagraphBookmarked, lib.ReadStatus, lib.DateLastRead, lib.___PercentRead,
       lib.IsDownloaded, lei.ShelfName
FROM ShelfContent lei LEFT JOIN content lib
ON lei.ContentID = lib.ContentID
WHERE lib.IsDownloaded = "true"
AND lib.ContentType = 6
AND lei.ShelfName = "AA Leído"
AND lib.ReadStatus <> 2
ORDER BY lib.ContentID

-- Si se saca el resultado a un excel y se copia lo siguiente:
=CONCATENAR("UPDATE content SET DateLastRead = '2013-07-12T01:00:43Z', ReadStatus = 2, ___PercentRead = 100 WHERE ContentId = '";A1;"';")


