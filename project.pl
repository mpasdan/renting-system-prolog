run :-
    write('Μενού:'),nl,
    write('======='),nl,nl,
    write('1 - Προτιμήσεις ενός πελάτη'),nl,
    write('2 - Μαζικές προτιμήσεις πελατών'),nl,
    write('3 - Eπιλογή πελατών μέσω δημοπρασίας'),nl,
    write('0 - Έξοδος'),nl,
    write('Eπιλογη: '),read(Choice),
    run_menu(Choice).

run_menu(Choice):-
         Choice == 1, customer_preferences,
         Choice == 2, all_customer_preferences,
         Choice == 3, vendue,
         Choice == 0, break,
         Choice > 3,write('Dwse mia epilogi'),nl,nl,run.

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
    write('Κατάλληλο').


all_customer_preferences :-
    write('todo2').

vendue :-
    write('todo3').



