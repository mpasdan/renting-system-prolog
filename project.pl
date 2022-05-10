:- [houses].
:- [requests].


run :-
    write('Μενού:'),nl,
    write('======='),nl,nl,
    write('1 - Προτιμήσεις ενός πελάτη'),nl,
    write('2 - Μαζικές προτιμήσεις πελατών'),nl,
    write('3 - Eπιλογή πελατών μέσω δημοπρασίας'),nl,
    write('0 - Έξοδος'),nl,
    write('Eπιλογη: '),read(Choice),
    run_choice(Choice).

run_choice(1):- !,
   write('Δώσε τις παρακάτω πληροφορίες:'),nl,nl,
   write('==============================='),nl,
   write('Ελάχιστο Εμβαδόν: '), read(Area),nl,
   write('Eλάχιστος αριθμός υπνοδωματίων: '),read(Minimum_bedrooms),nl,
   write('Να επιτρέπονται κατοικίδια; (ναι/οχι) '),read(Pets),nl,
   write('Από ποιον όροφο και πάνω υπάρχει ανελκυστήρας;'),read(Elevator),nl,
   write('Ποιο είναι το μέγιστο ενοίκιο που μπορείς να πληρώσεις;'),read(Price_renting),nl,
   write('Πόσα θα έδινες για ένα διαμέρισμα στο κέντρο της πόλης (στα ελάχιστα τετραγωνικά);'),read(Price_min_center),nl,
   write('Πόσα θα έδινες για ένα διαμέρισμα στα προάστια της πόλης (στα ελάχιστα τετραγωνικά)'),read(Price_min_pros),nl,
   write('Πόσα θα έδινες για κάθε τετραγωνικό διαμερίσματος πάνω από το ελάχιστο;'),read(Money_offers),nl,
   write('Πόσα θα έδινες για κάθε τετραγωνικό κήπου;'),read(Money_offers_gard),nl,
   compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard).

run_choice(2):- !,
    write('adsf'),
    run.
run_choice(3):- !,
    write('fdf'),
    run.
run_choice(0):- !,
    true.
run_choice(_):-
    nl,write('Επίλεξε έναν αριθμό μεταξύ 0 εώς 3!'),nl,nl,
    run.

customer_preferences :-
   write('Δώσε τις παρακάτω πληροφορίες:'),nl,nl,
   write('==============================='),nl,
   write('Ελάχιστο Εμβαδόν: '), read(Area),nl,
   write('Eλάχιστος αριθμός υπνοδωματίων: '),read(Minimum_bedrooms),nl,
   write('Να επιτρέπονται κατοικίδια; (ναι/οχι) '),read(Pets),nl,
   write('Από ποιον όροφο και πάνω υπάρχει ανελκυστήρας;'),read(Elevator),nl,
   write('Ποιο είναι το μέγιστο ενοίκιο που μπορείς να πληρώσεις;'),read(Price_renting),nl,
   write('Πόσα θα έδινες για ένα διαμέρισμα στο κέντρο της πόλης (στα ελάχιστα τετραγωνικά);'),read(Price_min_center),nl,
   write('Πόσα θα έδινες για ένα διαμέρισμα στα προάστια της πόλης (στα ελάχιστα τετραγωνικά)'),read(Price_min_pros),nl,
   write('Πόσα θα έδινες για κάθε τετραγωνικό διαμερίσματος πάνω από το ελάχιστο;'),read(Money_offers),nl,
   write('Πόσα θα έδινες για κάθε τετραγωνικό κήπου;'),read(Money_offers_gard),nl,
   compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard).

compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard):-
    house(Address, Minimum_bedrooms, Area, yes, Elevator, no, yes, 0, 350),
    print(Address), nl.



house_bedrooms(Address,Bedrooms) :-
    house(Address, Bedrooms, _, _, _, _, _, _, _).

house_area(Address,Area) :-
    house(Address, _, Area, _, _, _, _, _, _).

house_city_center(Address,City_center) :-
    house(Address, _, _, City_center, _, _, _, _, _).

house_floor(Address,Floor) :-
    house(Address, _, _, _, Floor, _, _, _, _).

house_lift(Address,Lift) :-
    house(Address, _, _, _, _, Lift, _, _, _).

house_pet(Address,Pet) :-
    house(Address, _, _, _, _, _, Pet, _, _).

house_garden_area(Address, Garden_area) :-
    house(Address, _, _, _, _, _, _, Garden_area, _).

house_rent(Address, Rent) :-
    house(Address, _, _, _, _, _, _, _, Rent).


/*
house_bedrooms('Βασιλέως Γεωργίου 35',Bedrooms).
house_area('Βασιλέως Γεωργίου 35',Area).
house_city_center('Βασιλέως Γεωργίου 35',City_center).
house_floor('Βασιλέως Γεωργίου 35',Floor).
house_lift('Βασιλέως Γεωργίου 35',Lift).
house_pet('Βασιλέως Γεωργίου 35',Pet).
house_garden_area('Βασιλέως Γεωργίου 35', Garden_area).
house_rent('Βασιλέως Γεωργίου 35', Rent).
*/


compatible_houses :-
    write(compatible_houses_test), nl.
find_best_house :-
    write(find_best_house_test), nl.
find_cheaper :-
    write(find_cheaper_test), nl.
find_biggest_garden :-
    write(find_biggest_garden_test), nl.
find_biggest_house :-
    write(find_biggest_house_test), nl.
find_houses :-
    write(find_houses_test), nl.
find_bidders :-
    write(find_bidders_test), nl.
find_best_bidders :-
    write(find_best_bidders_test), nl.
remove_houses :-
    write(remove_houses_test), nl.
refine_houses :-
    write(refine_houses_test), nl.
offer :-
    write(offer_test), nl.

