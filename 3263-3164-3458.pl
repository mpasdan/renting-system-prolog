/* Εργασία Prolog 2021-2022
 *   ΣΥΜΜΕΤΕΧΟΝΤΕΣ:
 * Νικόλαος Μπουντικίδης : 3263
 * Γεώργιος Δαγκαλής : 3164
 * Νικόλαος Μπασδάνης : 3458
*/

/* Τα κατηγορήματα των σπιτιών */
house("Βασιλέως Γεωργίου 35",1,50,yes,1,no,yes,0,300).
house("Αγγελάκη 7",2,45,yes,0,no,yes,0,335).
house("Κηφισίας 10",2,65,no,2,no,yes,0,350).
house("Πλαστήρα 72",2,55,no,1,yes,no,15,330).
house("Τσιμισκή 97",3,55,yes,0,no,yes,15,350).
house("Πολυτεχνείου 19",2,60,yes,3,no,no,0,370).
house("Ερμού 22",3,65,yes,1,no,yes,12,375).
house("Τσικλητήρα 13",3,65,no,2,yes,no,0,320).

/* Τα κατηγορήματα των απαιτήσεων των ενοικιαστών */
request("John Smith",45,2,yes,3,400,300,250,5,2).
request("Nick Cave",55,2,yes,3,450,350,300,7,3).
request("George Harris",50,3,yes,1,500,350,300,7,5).
request("Harrison Ford",50,2,no,0,370,300,350,5,0).
request("Will Smith",100,5,yes,0,100,50,25,2,1).

:- dynamic already_chosen/1.

/* Το βασικό μας μενόυ με τις επιλογές {0,1,2,3}
 * 0 : Έξοδος από το πρόγραμμα μας
 * 1 : Προτιμήσεις ενός πελάτη (διαδραστική λειτουργία)
 * 2 : Μαζικές Προτιμήσεις πελατών (μαζική λειτουργία)
 * 3 : Επιλογή πελατών μέσω δημοπρασίας
 */
run :-
    write('Μενού:'),nl,
    write('======='),nl,nl,
    write('1 - Προτιμήσεις ενός πελάτη'),nl,
    write('2 - Μαζικές προτιμήσεις πελατών'),nl,
    write('3 - Eπιλογή πελατών μέσω δημοπρασίας'),nl,
    write('0 - Έξοδος'),nl,
    write('Eπιλογη: '),read(Choice),
    run_choice(Choice).

/* Υλοποίηση της πρώτης λειτουργίας.
 * Ο χρήστης δίνει όλες τις προδιαγραφές που θέλει
 * να πληρεί το σπίτι που θέλει να νοικιάσει.
 * Έπειτα χρησιμοποιούμε την εντολή setof με την βοήθεια του
 * κατηγορήματος compatible_house έτσι ώστε να επιστραφεί
 * μια λίστα των σπιτιών που πληρούν τις παραπάνω προδιαγραφές.
 * Στην συνέχεια τυπώνεται αυτή η λίστα με την βοήθεια του κατηγορήματος
 * print_house και στην συνέχεια καλώντας το κατηγόρημα
 * most_suitable_house βρίσκεται και τυπώνεται το προτεινόμενο σπίτι
 * για τον χρήστη.
 */
run_choice(1):-
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
 setof(Address,compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,
                                Money_offers,Money_offers_gard,Address), ListOfAddress),
    !,
    print_house(ListOfAddress),
    most_suitable_house(ListOfAddress),
    run.
run_choice(1):-
    write('Δεν υπάρχει κατάλληλο σπίτι!'), nl, nl, run.

/* Υλοποίηση της δεύτερης λειτουργίας
 * Βρίσκοντας ολά τα ονόματα των ενοικιαστών με την βοήθεια της εντολής
 * findall καλώντας έπειτα το κατηγόρημα second_query με είσοδο την
 * λίστα με τα ονόματα των ενοικιαστών.
 */
run_choice(2):-
   findall(Name,request(Name,_,_,_,_,_,_,_,_,_),List),
   second_query(List),
   run.

run_choice(2):-
    write('Δεν υπάρχει κατάλληλο σπίτι!'), nl, nl, run.

/* Υλοποίηση της τρίτης λειτουργείας */
run_choice(3):-
    findall(Houses,house_address(Houses),List),
    third_query(List),
    run.

run_choice(0):- !,
    true.
/* Σε περίπτωση που ο χρήστης δεν επιλέξει αριθμό απο το 0 εώς το 3
 * ξανα τρέχει το μενού πετώντας το παρακάτω μήνυμα.
 */
run_choice(_):-
    nl,write('Επίλεξε έναν αριθμό μεταξύ 0 εώς 3!'),nl,nl,
    run.

/*Το third_query παιρνει μια λιστα με ολα τα σπιτια
 * και ψαχνει μετα για το καθε request ξεχωριστα,ποια
 * σπιτια ταιριαζουν στις απαιτησεις του μεσω της
 * third_query_aux. Στη συνεχεια βρίσκει ποιες ειναι
 * οι μεγαλυτερες προσφορες και τις ταιριαζει με το καταλληλο
 * σπιτι. Στο third_query με την κενη λιστα, βρισκει ποιο request
 * δεν ταιριαζει με κανενα σπιτι. Το κατηγορημα already_chosen,
 * ειναι δυναμικο και αποθηκεύει τα request τα οποια εχουν ήδη
 * πάρει σπιτι.
    */
third_query([]):-
    request_name(Name),
    not(already_chosen(Name)),
    write('O πελάτης '),write(Name),write(' δεν θα νοικιάσει κάποιο διαμέρισμα! '),
    (retract(already_chosen(X)), fail); true,
    nl.

third_query([House|Rest]):-
    setof(Name, third_query_aux(House, Name), Compatible_requests),
    findall(MoneyOffer, take_request_offer(Compatible_requests, House, MoneyOffer, Name), ListOfPrices),
    find_largest(ListOfPrices, MaxPrice),
    findall(Name, take_request_offer(Compatible_requests, House, MaxPrice, Name), MostCompatibleRequest),
    nth0(0, MostCompatibleRequest, Already_chosen_name),
    assert(already_chosen(Already_chosen_name)),
    write('O πελάτης '),writelist(MostCompatibleRequest),write(' θα νοικιάσει το διαμέρισμα στην διεύθυνση: '),write(House),nl,
    third_query(Rest).

third_query([House|Rest]):-
    third_query(Rest).


third_query_aux(HouseAddress, Name2):-
    request_name(Name),
    request_area(Name,Area),
    request_bedrooms(Name,Minimumbedrooms),
    request_pets(Name,Pets),
    request_rent(Name,Rent),
    request_elevator(Name,Elevator),
    request_rent_center(Name,Center),
    request_rent_pros(Name,Pros),
    request_more_area(Name,MArea),
    request_more_gard(Name,Garden),
    compatible_house(Area,Minimumbedrooms,Pets,Elevator,Rent,Center,Pros,
    MArea,Garden,HouseAddress),
    Name2 = Name.

/*Το κατηγόρημα take_request_offer επιστρέφει το ποσο
 * που διαθετει για καθε σπιτι, το καθε request.
    */
take_request_offer(Compatible_requests, House, MoneyOffer, Name):-
    request_name(Name),
    not(already_chosen(Name)),
    member(Name, Compatible_requests),
    request_area(Name,Area),
    request_rent(Name,Rent),
    request_rent_center(Name,Center),
    request_rent_pros(Name,Pros),
    request_more_area(Name,MArea),
    request_more_gard(Name,Garden),
    request_money_for_house(House, Center, Pros, Area, MArea, Rent, Garden, MoneyOffer2),
    MoneyOffer = MoneyOffer2.


/* Αναδρομική περίπτωση */
second_query([]):-nl.
/* Αυτό το κατηγόρημα παίρνει ως είσοδο την λίστα με όλα τα ονόματα
 * των ενοικιαστών  και για κάθε ενοικιαστή βρίσκει τις απαιτήσεις του
 * καλώντας τα βοηθητικά κατηγορήματα. Έπειτα χρησιμοποιώντας την εντολή
 * setof και με την βοήθεια του κατηγορήματος compatible_house βρίσκουμε
 * μια λίστα με σπίτια που ικανοποιούν τις απαιτήσεις του ενοικιαστή.
 * Στην συνέχεια εκτυπώνουμε αύτα τα σπίτια και έπειτα καλώντας το
 * κατηγόρημα most_suitable_house βρίσκουμε το πιο συμβατό σπίτι σύμφωνα
 * με τις απαιτήσεις του ενοικιαστή.
 * Είναι περίπου ίδιας φιλοσοφίας με το πρώτο ερώτημα, με την διαφορά
 * ότι τα δεδομένα δεν τα παίρνει απο τον χρήστη του προγράμματος.
 */

second_query([Name|Rest]):-
    request_area(Name,Area),
    request_bedrooms(Name,Minimumbedrooms),
    request_pets(Name,Pets),
    request_rent(Name,Rent),
    request_elevator(Name,Elevator),
    request_rent_center(Name,Center),
    request_rent_pros(Name,Pros),
    request_more_area(Name,MArea),
    request_more_gard(Name,Garden),
    setof(Address,compatible_house(Area,Minimumbedrooms,Pets,Elevator,Rent,Center,Pros,
    MArea,Garden,Address), ListOfAddress),
    write('Κατάλληλα διαμερίσματα για τον πελάτη: '),write(Name),write(':'),nl,
    write('==================================='),nl,
    print_house(ListOfAddress),
    most_suitable_house(ListOfAddress),!,
    second_query(Rest).



/* η λογική του most_suitable_house είναι ως εξής,
    Παίρνει μια λίστα με όλα τα πιθανά σπίτια,
    Φτιάχνει με αυτά μια λίστα με όλες τις τιμές αυτών των σπιτιών (ListOfPrices) χρησιμοποιόντας την take_houses_rents,
    Βρίσκει την min των παραπάνω τιμών,
    Βρίσκει τα σπίτια που έχουν αυτή την min τιμή,
    Από τα σπίτια που έχουν την min τιμή βρίσκει το μέγεθος των gardens (ListOfGardens) χρησιμοποιόντας την take_houses_gardens,
    Από την λίστα των gardens βρίσκει την max τιμή,
    Βρίσκει τα σπίτια που έχουν αυτή την max τιμή που έχουν και την min τιμή αγοράς χρησιμοποιόντας την take_houses_rents,
    Εκτυπώνει την τελευταία λίστα που εκπληρεί όλες τις προυποθέσεις που πρέπει
    */

most_suitable_house(ListOfAddresses) :-
    /*write(ListOfAddresses), nl,*/
    findall(Price,take_houses_rents(ListOfAddresses, Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,
                                 Money_offers,Money_offers_gard,Price,Add),ListOfPrices),
    /*write(here), nl,*/
    /*write(ListOfPrices), nl,*/
    find_smallest(ListOfPrices,Min),
    /*write(Min), nl,*/
    setof(Address,take_houses_rents(ListOfAddresses, Area,Minimum_bedrooms,Pets,Elevator,Min,Price_min_center,Price_min_pros,
                                 Money_offers,Money_offers_gard,Price,Address),Min_price_address), /* todo check Price or Min */
    /*write(Min_price_address), nl,*/
    findall(Garden,take_houses_gardens(Min_price_address,Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,
                                  Price_min_pros,Money_offers,Money_offers_gard,Garden,Add),ListOfGardens),
    /*write(ListOfGardens), nl,*/
    find_largest(ListOfGardens,Max),
    /*write(Max), nl,*/
    setof(Address,take_houses_gardens(Min_price_address,Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,
                                  Price_min_pros,Money_offers,Money_offers_gard,Max,Address),Max_garden_address),
    /*write(Max_garden_address), nl,*/

    write('Προτείνεται η ενοικίαση του διαμερίσματος στην διεύθυνση: '), writelist(Max_garden_address),nl,
    nl.


/* H λογική του compatible_house είναι ως εξής,
 * Παίρνει ώς είσοδο τα στοιχεία ενός σπιτιού
 * και επιστρέφει την διεύθυνση ενός σπιτιού
 * που τα χαρακτηριστικά του είναι συμβατά με
 * τα στοιχεία της εισόδου. Το συγκεκριμένο
 * κατηγόρημα είναι απο τα πιο βασικά του project αυτού
 * καθώς χρησιμοποιήθηκε στην υλοποίηση και των τριών λειτουργειών του
 * προγράμματος.
 */

compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,Address2):-
    house_address(Address),
    compatible_least_area(Address, Area),
    compatible_bedrooms(Address,Minimum_bedrooms),
    compatible_pet(Address,Pets),
    compatible_lift(Address, Elevator),
    compatible_money(Address, Price_min_center, Price_min_pros, Area, Money_offers, Price_renting, Money_offers_gard),
    house_rent(Address,Rent),
    Address2 = Address.

/* Aυτό το κατηγόρημα μας βοηθάει στην υλοποιήση του κατηγορήματος most_suitable_house
 * επιστρέφωντας την τιμή των σπιτιών απο μια λίστα σπιτιών.
 */
take_houses_rents(ListOfAddresses,Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,Price,Add):-
    house_address(Address),
    member(Address, ListOfAddresses),
    house_rent(Address, Rent),
    Add = Address,
    Price = Rent.

/* Aυτό το κατηγόρημα μας βοηθάει στην υλοποιήση του κατηγορήματος most_suitable_house
 * επιστρέφωντας την τιμή των κήπων των σπιτιών απο μια λίστα σπιτιών.
 */
take_houses_gardens(ListOfAddresses,Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,Garden,Add):-
    house_address(Address),
    member(Address, ListOfAddresses),
    house_garden_area(Address,Garde),
    Garden = Garde,
    Add = Address.

/* το κατηγόρημα print_house μας βοήθησε στην υλοποίηση της διαδραστικής
 * λειτουργίας του προγράμματος το οποίο δέχεται μία λίστα από τα σπίτια
 * και εκτυπώνει ένα ένα τα σπίτια μαζί με τα χαρακτηριστικά του εώς
 * ότου τελείωσει η λίστα.
 */

print_house([]):- nl.
print_house([Address|Rest]) :-
    house_bedrooms(Address, Bedrooms),
    house_area(Address, Area),
    house_garden_area(Address, Garden_area),
    house_city_center(Address, City_center),
    house_pet(Address, Pet),
    house_floor(Address, Floor),
    house_lift(Address, Lift),
    house_rent(Address, Rent),
    write('Κατάλληλο σπίτι στην διεύθυνση: '), print(Address), nl,
    write('Υπνοδωμάτια: '), print(Bedrooms), nl,
    write('Εμβαδόν: '), print(Area), nl,
    write('Εμβαδόν κήπου: '), print(Garden_area), nl,
    write('Είναι στο κέντρο της πόλης: '), print(City_center), nl,
    write('Επιτρέπονται κατοικίδια: '), print(Pet), nl,
    write('Όροφος: '), print(Floor), nl,
    write('Ανελκυστήρας: '), print(Lift), nl,
    write('Ενοίκιο: '), print(Rent), nl, nl,
    print_house(Rest).

/* Bασική περίπτωση όπου η λίστα είναι κενή */
writelist([]).
/* Αναδρομική περίπτωση */
writelist([H|T]) :- write(H),writelist(T).

/* Τα παρακάτω βοηθητικά κατηγορήματα μας βοήθησαν να υλοποιήσουμε
 * το compatible_house.
 */
compatible_least_area(AddressToCheck, Least_area) :-
    house_area(AddressToCheck, Area),
    Area >=  Least_area.

compatible_bedrooms(AddressToCheck,Least_bedrooms) :-
    house_bedrooms(AddressToCheck, Bedrooms),
    Bedrooms >= Least_bedrooms.

compatible_lift(AddressToCheck, Floor_limit) :-
    house_lift(AddressToCheck, yes);
    !,
    house_floor(AddressToCheck, Floor),
    Floor < Floor_limit.

compatible_pet(AddressToCheck,Pet) :-
    Pet = no;
    house_pet(AddressToCheck, yes).

amount_based_on_address_location(AddressToCheck, CenterAmount, OutCenterAmount, ReturnedAmount) :-
    house_city_center(AddressToCheck, yes),
    ReturnedAmount = CenterAmount;
    ReturnedAmount = OutCenterAmount.

compatible_money_upper_limit(AddressToCheck, Amount) :-
    house_rent(AddressToCheck, HouseAmount),
    HouseAmount =< Amount.

compatible_money(AddressToCheck, CenterAmount, OutCenterAmount, Least_area, Extra_amount_per_area, Upper_limit_amount, Extra_amount_per_garden_area) :-
    compatible_money_upper_limit(AddressToCheck, Upper_limit_amount),
    amount_based_on_address_location(AddressToCheck, CenterAmount, OutCenterAmount, BasicAmount),
    house_area(AddressToCheck, HouseArea),
    house_rent(AddressToCheck, HouseRent),
    house_garden_area(AddressToCheck, HouseGarden),
    BasicAmount + ((HouseArea - Least_area) * Extra_amount_per_area) + (HouseGarden * Extra_amount_per_garden_area) >= HouseRent.

request_money_for_house(AddressToCheck, CenterAmount, OutCenterAmount, Least_area, Extra_amount_per_area, Upper_limit_amount, Extra_amount_per_garden_area, MoneyOffer) :-
    compatible_money_upper_limit(AddressToCheck, Upper_limit_amount),
    amount_based_on_address_location(AddressToCheck, CenterAmount, OutCenterAmount, BasicAmount),
    house_area(AddressToCheck, HouseArea),
    house_rent(AddressToCheck, HouseRent),
    house_garden_area(AddressToCheck, HouseGarden),
    MoneyOffer is (BasicAmount + ((HouseArea - Least_area) * Extra_amount_per_area) + (HouseGarden * Extra_amount_per_garden_area)).


/* κατηγόρημα το οποίο ελέγχει αν κάποιο στοιχείο είναι μέλος κάποιας λίστας */
list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

/* Βοηθητικά κατηγορήματα τα οποία παίρνουν ως είσοδο
 * την διεύθυνση ενός σπιτιού και γυρίζουν το χαρακτηριστικό τους.
 * Για παράδειγμα το house_bedrooms παιρνει ως είσοδο την διεύθυνση
 * του σπιτιού και επιστρέφει στην μεταβλητή Bedrooms το συνολικό
 * πλήθος δωματίων αυτού του σπιτιού.
 */
house_address(Address) :-
    house(Address, _, _, _, _, _, _, _, _).

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

/* Ίδιας φιλοσοφίας βοηθητικά κατηγορήματα που παίρνουν
 * ως είσοδο το όνομα κάποιου ενοικιαστή και επιστρέφουν
 * το ανάλογο χαρακτηριστικό τους.
 */
request_name(Name):-
    request(Name,_,_,_,_,_,_,_,_,_).

request_area(Name,Area):-
    request(Name,Area,_,_,_,_,_,_,_,_).

request_bedrooms(Name,Bedrooms):-
    request(Name,_,Bedrooms,_,_,_,_,_,_,_).

request_pets(Name,Pets):-
    request(Name,_,_,Pets,_,_,_,_,_,_).

request_elevator(Name,Elevator):-
    request(Name,_,_,_,Elevator,_,_,_,_,_).

request_rent(Name,Rent):-
    request(Name,_,_,_,_,Rent,_,_,_,_).

request_rent_center(Name,Center):-
    request(Name,_,_,_,_,_,Center,_,_,_).

request_rent_pros(Name,Pros):-
    request(Name,_,_,_,_,_,_,Pros,_,_).

request_more_area(Name,Area):-
    request(Name,_,_,_,_,_,_,_,Area,_).

request_more_gard(Name,Garden):-
    request(Name,_,_,_,_,_,_,_,_,Garden).


/* Βοηθητικά κατηγορήματα τα οποία εν τέλει δεν χρησιμοποιήθηκαν
 * στην υλοποίηση του προγραμματός μας.
 */
find_cheaper(ListOfAddresses) :-
    find_smallest(ListOfPrices,MinValue),
    findall(Address,house(Address,_,_,_,_,_,_,_,MinValue),List),
    intersection(List,ListOfPrices,ListOfAddresses).

find_biggest_offer_money(List):-
    findall(Money,request(_,_,_,_,_,Money,_,_,_,_),ListOfMoney),
    find_largest(ListOfMoney,Max),
    findall(Name,request(Name,_,_,_,_,Max,_,_,_,_),List).

find_biggest_garden(List) :-
    findall(Garden, house(_,_,_,_,_,_,_,Garden,_),GardenList),
    find_largest(GardenList,MaxValue),
    findall(Address,house(Address,_,_,_,_,_,_,MaxValue,_),List).

find_biggest_house(List) :-
    findall(Area, house(_,_,Area,_,_,_,_,_,_),AreaList),
    find_largest(AreaList,MaxValue),
    findall(Address,house(Address,_,MaxValue,_,_,_,_,_,_),List).


/* Αυτά τα βοηθητικά κατηγορήματα δημιουργήθηκαν προκειμένου να μας βοηθήσουν να βρίσκουμε τα μεγαλύτερα η τα μικρότερα στοιχεία στο πρόγραμμα μας.
 * Κυρίως στοιχεία των λιστών.
 */
find_smallest([X|List],Minval):-
    find_small(List,Minval,X).

find_small([],Currentsmallest,Currentsmallest).
find_small([A|L],Minval,Currentsmallest):-
    A<Currentsmallest,
    find_small(L,Minval,A).
find_small([A|L],Minval,Currentsmallest):-
    A>=Currentsmallest,
    find_small(L,Minval,Currentsmallest).

find_largest([X|List],Maxval):-
    find_biggest(List,Maxval,X).

find_biggest([],Currentlargest,Currentlargest).
find_biggest([A|L],Maxval,Currentlargest):-
    A>Currentlargest,
    find_biggest(L,Maxval,A).
find_biggest([A|L],Maxval,Currentlargest):-
    A=<Currentlargest,
    find_biggest(L,Maxval,Currentlargest).

