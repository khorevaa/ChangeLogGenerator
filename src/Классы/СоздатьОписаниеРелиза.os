///////////////////////////////////////////////////////////////////////////////
//
// Служебный модуль с реализацией работы команды
//
///////////////////////////////////////////////////////////////////////////////
#Использовать "./"

Перем Лог;

Процедура НастроитьКоманду(Знач Команда, Знач Парсер) Экспорт

	Парсер.ДобавитьПараметрФлагКоманды(Команда, "addauthors", "Добавить в описание релиза автора коммита");
	
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "--from",	"SHA или TAG откуда начинать парсить логи");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "--to", 		"SHA или TAG до куда парсить логи");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "--release", "Номер релиза");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "--break", 	"После какой надписи выводить новые записи");

КонецПроцедуры // НастроитьКоманду

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие - Соответствие ключей командной строки и их значений
//   Приложение - Модуль - Модуль менеджера приложения
//
Функция ВыполнитьКоманду(Знач ПараметрыКоманды, Знач Приложение) Экспорт

	Лог = Приложение.ПолучитьЛог();
	Если Не ВалидироватьПараметрыКоманды(ПараметрыКоманды) Тогда
		Возврат Приложение.РезультатыКоманд().НеверныеПараметры;
	КонецЕсли;


	ЛогИзменений = ПолучитьЛогИзмененийИзGIT(ПараметрыКоманды["--from"], ПараметрыКоманды["--to"]);
	// При успешном выполнении возвращает код успеха
	Возврат Приложение.РезультатыКоманд().Успех;
	
КонецФункции // ВыполнитьКоманду


Функция ВалидироватьПараметрыКоманды(ПараметрыКоманды)
	Результат = Истина;
	Если ПараметрыКоманды["--from"] = Неопределено Тогда
		Лог.Ошибка("Отсутствует обязательный параметр --from");
		Результат = Ложь;
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция ПолучитьЛогИзмененийИзGIT(От, До)

	Возврат ПарсерГит.ПолучитьМассивКоммитов(От, До);

КонецФункции
