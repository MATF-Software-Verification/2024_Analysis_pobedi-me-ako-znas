## CppCheck (tvoj slučaj)

Alat **Cppcheck** je analizom koda projekta detektovao veći broj nalaza u više kategorija: preporuke vezane za **inicijalizaciju članova u initializer list-i**, neusklađena imena argumenata između deklaracije i definicije funkcija (`funcArgNamesDifferent`), **neiskorišćene promenljive i funkcije** (`unusedFunction`, `unusedVariable`, `unreadVariable`), kao i preporuke tipa `functionConst`/`functionStatic` koje se tiču stila i potencijalne optimizacije.

Ipak, u rezultatima postoje i nalazi koji su **potencijalno relevantni za ispravnost logike**, ne samo za stil:
- `bitwiseOnBoolean` i `clarifyCondition` u `server/session.cpp` ukazuju da se boolean izrazi koriste u **bitovskim operacijama** (npr. `&`, `|`) gde se često očekuje logičko poređenje (`&&`, `||`) ili barem jasnije zagrade, što može promeniti ponašanje uslova.
- `incorrectStringBooleanError` u `application/reckoui.cpp` ukazuje na situaciju gde se string literal koristi kao `bool` i time uvek daje `true`, što može dovesti do pogrešne kontrole toka.
- `uninitMemberVar` ukazuje da pojedine članske promenljive nisu inicijalizovane u konstruktorima, što može dovesti do nedefinisanog ponašanja u zavisnosti od korišćenja.

Zaključno, Cppcheck nije prijavio masovne “fatalne” probleme, ali je otkrio nekoliko nalaza koji zaslužuju pažnju jer mogu biti **logički bugovi** ili izvor nestabilnosti u specifičnim scenarijima, dok se ostatak nalaza uglavnom odnosi na kvalitet koda, održavanje i stil.
