﻿&НаСервере
Функция УстановитьДоступность_влн_РеализацияПрочих()
	флагЕсть9101 = Ложь;
	счет9101 = ПланыСчетов.Хозрасчетный.НайтиПоКоду("91.01");
	Для Каждого стр из Объект.Услуги Цикл
		Если стр.СчетДоходов = счет9101 Тогда
			флагЕсть9101 = истина;
		Конецесли;
	КонецЦикла;
	
	Если флагЕсть9101 = ложь Тогда
		Объект.влн_РеализацияПрочих = Ложь;
	КонецЕсли;
	
	Элементы.влн_РеализацияПрочих.Доступность = флагЕсть9101;
	
КонецФУнкции


&НаКлиенте
Процедура влн_УслугиАналитикаУчетаПриИзмененииПосле(Элемент)
	// Вставить содержимое обработчика.
	УстановитьДоступность_влн_РеализацияПрочих();
КонецПроцедуры

&НаКлиенте
Процедура влн_УслугиПриИзмененииПосле(Элемент)
	УстановитьДоступность_влн_РеализацияПрочих();
КонецПроцедуры

&НаСервере
Процедура влн_ПриЧтенииНаСервереПосле(ТекущийОбъект)
	УстановитьДоступность_влн_РеализацияПрочих();
КонецПроцедуры

&НаКлиенте
Процедура влн_ОбработкаВыбораПосле(ВыбранноеЗначение, ИсточникВыбора)
	//Вставить содержимое обработчика
	УстановитьДоступность_влн_РеализацияПрочих();
КонецПроцедуры
