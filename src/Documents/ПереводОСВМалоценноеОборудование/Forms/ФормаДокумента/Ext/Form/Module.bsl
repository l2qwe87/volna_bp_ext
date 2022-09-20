﻿
&НаКлиенте
Процедура влн_ЗаполнитьПо01После(Команда)
	влн_ЗаполнитьПо01ПослеНаСервере();
КонецПроцедуры

&НаСервере
Процедура влн_ЗаполнитьПо01ПослеНаСервере()
	
	Если НЕ ЗначениеЗаполнено(Объект.Дата) Тогда
		Сообщить("Дата не заполнена");
		возврат;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(Объект.ПодразделениеОрганизации) Тогда
		Сообщить("Местонахождение не заполнена");
		возврат;
	КонецЕсли;
	// Вставить содержимое обработчика.
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ХозрасчтеныйОС.Субконто1 КАК ОС,
	               |	тМОЛ.МОЛ КАК МОЛ,
	               |	тМОЛ.Местонахождение КАК Местонахождение,
	               |	инв.ИнвентарныйНомер КАК ИнвНомер,
	               |	ХозрасчтеныйОС.СуммаОстаток КАК СуммаОстаток
	               |ИЗ
	               |	РегистрБухгалтерии.Хозрасчетный.Остатки(&КонецПериода, Счет.Код ПОДОБНО ""01%"", , ) КАК ХозрасчтеныйОС
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МестонахождениеОСБухгалтерскийУчет.СрезПоследних(&КонецПериода, ) КАК тМОЛ
	               |		ПО (тМОЛ.ОсновноеСредство = ХозрасчтеныйОС.Субконто1)
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПервоначальныеСведенияОСБухгалтерскийУчет.СрезПоследних(&КонецПериода, ) КАК инв
	               |		ПО ХозрасчтеныйОС.Субконто1 = инв.ОсновноеСредство
	               |ГДЕ
	               |	ХозрасчтеныйОС.СуммаОстаток < 100000
	               |	И тМОЛ.Местонахождение = &Местонахождение";
	
	ЗАпрос.УстановитьПараметр("КонецПериода", КонецДня(Объект.Дата)+1);
	ЗАпрос.УстановитьПараметр("Местонахождение", Объект.ПодразделениеОрганизации);
	
	рез = ЗАпрос.Выполнить().Выбрать();
	
	Пока рез.Следующий() Цикл
		нСтр = Объект.ОС.Добавить();
		нСтр.ОсновноеСредство = рез.ОС;
		нСтр.Сотрудник = рез.МОЛ;
	КонецЦИкла;
КонецПроцедуры
