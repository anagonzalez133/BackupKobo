# BackupKobo
Transformaciones de para actualizar la base de datos de los lectores electrónicos Kobo. Estos lectores utilizan una base de datos sqllite para guardar la información de los libros, he creado este proyecto para pasar información de un backup de esa base de datos (copia) a la base de datos del lector (original), para las ocasiones en que compro un lector nuevo y quiero pasar el estado de lectura y las colecciones desde el lector anterior, o se corrompe la base de datos del lector y tengo que reiniciarlo borrando esa información.

## Pentaho
Actualmente el proyecto sólo contiene el código generado en Pentaho 8.2, en un futuro posiblemente lo migre a Apache-Hop, ya que parece que Pentaho ha sido abandonado por Hitachi Vantara.

Para poder ser utilizado, es necesario ajustar en las tres transformaciones los datos de la conexión a las bases de datos. Al crear la conexión a la base de datos no he podido utilizar parámetros que me impidan usar rutas absolutas, por lo que no puedo referenciar la carpeta donde está la transformación para hacer el código más transportable.

El proyecto contiene actualmente tres transformaciones independientes:
- TR_KOBO_REVISA_LIBRO: Esta transformación no actualiza nada, la he utilizado simplemente para explorar el contenido de la tabla CONTENT con la información básica de la biblioteca existente en el Kobo, he estado revisando campos de la tabla content para explorar su contenido y hacerme una idea de las diferencias que hay entre la copia y el original. Lo utilizo antes de lanzarme a actualizar la base de datos, especialmente en los casos en que el lector es nuevo y lo quiero actualizar con los datos de un lector antiguo, o cuando llevo mucho tiempo sin mirar el contenido de la tabla CONTENT, por si acaso hay un campo nuevo que pueda resultar interesante.
- TR_KOBO_INSERTA_COLECCIONES: Esta transformación lee la asociación libro-colecciones de la base de datos original y de la copia de seguridad, e inserta en la original las asociaciones que falten que existan en la copia original.
- TR_KOBO_ACTUALIZA_LIBROS: Esta transformación actualiza la información de título, autor, serie, estado de lectura, fecha de lectura y porcentaje de lectura de la tabla CONTENT original con los datos de la copia (cuando el ContentId coincide en ambas bases de datos).

## Consultas
En esta carpeta hay un script sql con consultas sueltas utilizadas para explorar la base de datos y actualizarla en algunos casos, sirven como plantilla para adaptar a nuestro caso de uso real. La última que revisé estas consultas fue en el 2017, por lo que los campos nuevos para guardar la serie no están.

Además de las consultas se incluyen algunas fórmulas (de Calc de LibreOffice, habrá que adaptarlas si se utiliza Excel) para lanzar INSERTS y UPDATES masivos con el resultado de esas consultas.
