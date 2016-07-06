#Использовать ".."

// Вспомогательные методы
// 
Процедура ОбеспечитьКаталог(Знач Каталог)

	Файл = Новый Файл(Каталог);
	Если Не Файл.Существует() Тогда
		СоздатьКаталог(Каталог);
	ИначеЕсли Не Файл.ЭтоКаталог() Тогда
		ВызватьИсключение "Каталог " + Каталог + " не является каталогом";
	КонецЕсли;

КонецПроцедуры

Процедура Выполнить()

	Данные = Новый Структура();
	Данные.Вставить("Тип","HRM");
	Данные.Вставить("Версия","30");
	Данные.Вставить("ПолнаяВерсия","30");
	Данные.Вставить("ВерсияПлатформы","83");
	Данные.Вставить("Логин","");
	Данные.Вставить("Пароль","");
	Данные.Вставить("КаталогСохранения","tests/arh");

	МенеджерРелизов = Новый ПоследнийРелизКонфигурации;
	Обновление = Новый ОбновлениеКонфигурации;
	Информация = МенеджерРелизов.ПолучитьИнформацию(Данные);

	Если НЕ Информация = Неопределено Тогда
		Данные.ПолнаяВерсия = Информация.Версия;
		//Результат = МенеджерРелизов.Скачать(Данные);

		Результат = Новый Файл("c:\work\GitHub\autoupdatecfg\tests\arh\1cv8.zip");

		ПутьРаспаковки = Данные.КаталогСохранения + "/" + Данные.Тип + "/"+ СтрЗаменить(Данные.ПолнаяВерсия, ".", "_");
		Сообщить(ПутьРаспаковки);

		КаталогОбъект = Новый Файл(ПутьРаспаковки);

		ОбеспечитьКаталог(ПутьРаспаковки);

		ФайлАрхива = Результат.ПолноеИмя;

		Результат = "";

		Архив = Новый ЧтениеZipФайла(ФайлАрхива); 
		Архив.ИзвлечьВсе(КаталогОбъект.ПолноеИмя);
		Архив.Закрыть();

		ПараметрыСоединения = Новый Структура;
		ПараметрыСоединения.Вставить("ПутьКБазе",     "/FC:\Users\usergey\Documents\1C\DemoHRM\");
		ПараметрыСоединения.Вставить("Логин",         "Савинская З.Ю. (Системный программист)");
		ПараметрыСоединения.Вставить("Пароль",        "");
		ПараметрыСоединения.Вставить("КаталогВерсии", КаталогОбъект.ПолноеИмя);

		Обновление.УстановитьОбновление(ПараметрыСоединения);

	Иначе
		ВызватьИсключение "Получены ошибочные данные по последнему релизу";
	КонецЕсли;

	
КонецПроцедуры

Выполнить();

//Параметры = новый Массив;
////Параметры.Добавить("all");
//Параметры.Добавить("db");
//Параметры.Добавить("c:\work\db\v8_tasks");
//Выполнить(Параметры);