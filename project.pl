:- [houses].
:- [requests].
list([]).
run :-
    write('Μενού:'),nl,
    write('======='),nl,nl,
    write('1 - Προτιμήσεις ενός πελάτη'),nl,
    write('2 - Μαζικές προτιμήσεις πελατών'),nl,
    write('3 - Eπιλογή πελατών μέσω δημοπρασίας'),nl,
    write('0 - Έξοδος'),nl,
    write('Eπιλογη: '),read(Choice),
    run_choice(Choice),repeat.

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
   compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard),
   /*DEBUGGING
   write('HOUSES:'),
   findall(Address,house(Address,_,_,_,_,_,_,_,_),XXx),
   writelist(XXx),
   compatible_houses(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,XXx,ReturnList),
   write('CHEAPER:'),
   find_cheaper(List),
   writelist(List),
   write('Small_garden:'),
   find_biggest_garden(List2),
   writelist(List2),
   write('Biggest_Area:'),
   find_biggest_house(List3),
   writelist(List3),
   write('REQUESTS:'),
   findall(Name,request(Name,_,_,_,_,_,_,_,_,_),YYy),
   writelist(YYy) */.


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

compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard):-
    house_address(Address),
    /* print('for '), print(Address), nl, */ /* only for development */
    compatible_least_area(Address, Area),
    /* print('compatible_least_area'), nl, */ /* only for development */
    compatible_bedrooms(Address,Minimum_bedrooms),
    /* print('compatible_bedrooms'), nl, */ /* only for development */
    compatible_pet(Address,Pets),
    /* print('compatible_pet'), nl, */ /* only for development */
    compatible_lift(Address, Elevator),
    /* print('compatible_lift'), nl, */ /* only for development */
    compatible_money(Address, Price_min_center, Price_min_pros, Area, Money_offers, Price_renting, Money_offers_gard),
    /* print('compatible_money'), nl, */ /* only for development */
    print_house(Address),nl,fail.

compatible_houses(end_of_file) :-!.

compatible_houses(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,XXx,ReturnList):-nl
   /* compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard)*/.

print_house(Address) :-
    house_bedrooms(Address, Bedrooms),
    house_area(Address, Area),
    house_garden_area(Address, Garden_area),
    house_city_center(Address, City_center),
    house_pet(Address, Pet),
    house_floor(Address, Floor),
    house_lift(Address, Lift),
    house_rent(Address, Rent),
    print('Κατάλληλο σπίτι στην διεύθυνση: '), print(Address), nl,
    print('Υπνοδωμάτια: '), print(Bedrooms), nl,
    print('Εμβαδόν: '), print(Area), nl,
    print('Εμβαδόν κήπου: '), print(Garden_area), nl,
    print('Είναι στο κέντρο της πόλης: '), print(City_center), nl,
    print('Επιτρέπονται κατοικίδια: '), print(Pet), nl,
    print('Όροφος: '), print(Floor), nl,
    print('Ανελκυστήρας: '), print(Lift), nl,
    print('Ενοίκιο: '), print(Rent), nl, nl.

/*debbuging*/
writelist([]). /* Base case: An empty list */ writelist([H|T]) :- write(H),nl,writelist(T). /* Recursive case: */


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
    Floor =< Floor_limit.

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

housee_address(Address,ValueA):-
     house(Address, _, _, _, _, _, _, _, _), ValueA = Address.

find_cheaper(List) :-
    findall(Price, house(_,_,_,_,_,_,_,_,Price),PriceList),
    find_smallest(PriceList,MinValue),
    findall(Address,house(Address,_,_,_,_,_,_,_,MinValue),List).

find_biggest_garden(List) :-
    findall(Garden, house(_,_,_,_,_,_,_,Garden,_),GardenList),
    find_largest(GardenList,MaxValue),
    findall(Address,house(Address,_,_,_,_,_,_,MaxValue,_),List).

find_biggest_house(List) :-
    findall(Area, house(_,_,Area,_,_,_,_,_,_),AreaList),
    find_largest(AreaList,MaxValue),
    findall(Address,house(Address,_,MaxValue,_,_,_,_,_,_),List).
find_houses(List,ListHouses) :-
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

listFacts( Names, List) :-
    setof(house(Address,_,_,_,_,_,_,_,_), (member(Address,Names),house(Address,_,_,_,_,_,_,_,_)),List).
/*========These facts help us in order to find the part of the biggest or smallest tasks in our code=======*/
find_smallest([X|List],Maxval):-
find_small(List,Maxval,X).
find_small([],Currentsmallest,Currentsmallest).
find_small([A|L],Maxval,Currentsmallest):-
 A<Currentsmallest,
find_small(L,Maxval,A).
find_small([A|L],Maxval,Currentsmallest):-
 A>=Currentsmallest,
 find_small(L,Maxval,Currentsmallest).

find_largest([X|List],Maxval):-
find_biggest(List,Maxval,X).
find_biggest([],Currentlargest,Currentlargest).
find_biggest([A|L],Maxval,Currentlargest):-
 A>Currentlargest,
 find_biggest(L,Maxval,A).
find_biggest([A|L],Maxval,Currentlargest):-
 A=<Currentlargest,
 find_biggest(L,Maxval,Currentlargest).

