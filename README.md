Схема базы данных Кардинал Кипера
===================================

Использование скрипта
---------------------

Инсталяция базы данных.

```
index.js install 
```

Обновление базы данных до последней миграции.

```
index.js update
```

Получить версию последней миграции.

```
index.js version
```


Какие есть варианты разработки базы данных?
--------------------------------------------
https://toster.ru/q/372695?e=4598130  
http://www.apgdiff.com/  
https://github.com/fordfrog/apgdiff

##### Автоматизация миграций при помощи утилиты Pyrseas 

https://pyrseas.readthedocs.io/en/latest/  
https://toster.ru/q/372695  
Я рекомендую использовать pyrseas. В нем dbtoyaml парсит схему базы с поддержкой 
всех самобытных фишек PostgreSQL в yaml файл, который вы помещаете в систему контроля 
версий. В отличие от SQL дампа с yaml схемой легко работать и осуществлять слияния в 
ветках. Я использую PyCharm с подсветкой yaml синтаксиса для этого. Так же yamltodb может 
сравнить yaml файл с базой и сформировать SQL миграцию. Я этой штукой уже год пользуюсь 
на работе, все остальные решения рядом не стояли.


Ссылки
-------

Старая версия базы:  
https://ide.c9.io/khusamov/alternativa_online_server  
http://alternativa-online-server-khusamov.c9.io/public/

Репозиторий:  
https://github.com/cardinalkeeper/database

Руководство PostgreSQL:  
https://postgrespro.ru/docs/postgresql/9.6/index.html

Инструкции:  
https://github.com/khusamov/leading

Библиотека клиента к базе:  
https://www.npmjs.com/package/pg-promise  
http://vitaly-t.github.io/pg-promise/  
https://github.com/vitaly-t/pg-promise/wiki/Learn-by-Example

Руководство Ноды:  
https://nodejs.org/dist/latest-v6.x/docs/api/

Утилиты:  
https://lodash.com/  
http://docs.sencha.com/extjs/6.0.1/modern/Ext.html  
https://www.npmjs.com/package/commander  
https://github.com/tj/commander.js/tree/master/examples



