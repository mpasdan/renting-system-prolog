/*:- [houses].*/
/*:- [requests].*/

run :-
    write('Μενού:'),nl,
    write('======='),nl,nl,
    write('1 - Προτιμήσεις ενός πελάτη'),nl,
    write('2 - Μαζικές προτιμήσεις πελατών'),nl,
    write('3 - Eπιλογή πελατών μέσω δημοπρασίας'),nl,
    write('0 - Έξοδος'),nl,
    write('Eπιλογη: '),read(Choice),
    run_choice(Choice).

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
run_choice(2):-
   findall(Name,request(Name,_,_,_,_,_,_,_,_,_),List),
   writelist(List),
   second_query(List),
   run.
run_choice(2):-
    write('Δεν υπάρχει κατάλληλο σπίτι!'), nl, nl, run.

run_choice(3):-
    findall(Houses,house_address(Houses),List),
    third_query(List),
    run.

run_choice(0):- !,
    true.
run_choice(_):-
    nl,write('Επίλεξε έναν αριθμό μεταξύ 0 εώς 3!'),nl,nl,
    run.


third_query([]):-nl.
third_query([House|Rest]):-
    setof(Name, third_query_aux(House, Name), Compatible_requests),
    findall(MoneyOffer, take_request_offer(Compatible_requests, House, MoneyOffer), ListOfPrices),
    find_largest(ListOfPrices, MaxPrice),
    setof(Name, third_query_aux(House, Name), MostCompatibleName),
    /*setof(House,take_request_offer(Compatible_requests, House, MaxPrice), ListOfCompatibleAddress),*/
    write('Για το σπίτι :'), write(House), nl,
    writelist(ListOfCompatibleAddress),
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
                                MArea,Garden,Address),
    Name2 = Name.

take_request_offer(Compatible_requests, House, MoneyOffer):-
    request_name(Name),
    member(Name, Compatible_requests),
    request_area(Name,Area),
    request_bedrooms(Name,Minimumbedrooms),
    request_rent(Name,Rent),
    request_elevator(Name,Elevator),
    request_rent_center(Name,Center),
    request_rent_pros(Name,Pros),
    request_more_area(Name,MArea),
    request_more_gard(Name,Garden),
    request_money_for_house(House, Center, Pros, Area, MArea, Rent, Garden, MoneyOffer2),
    MoneyOffer = MoneyOffer2.



second_query([]):-nl.
second_query([Name|Rest]):-
    /*write('Name: '),write(Name),nl,*/
    request_area(Name,Area),
   /* write('Area: '),write(Area),nl,*/
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

    write('Προτείνεται η ενοικίαση του διαμερίσματος στην διεύθυνση: '), writelist(Max_garden_address),
    nl.


find_best_houses(ListOfAddresses,AddressOf):-
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
                                  Price_min_pros,Money_offers,Money_offers_gard,Max,Address),AddressOf).


compatible_house(Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,Address2):-
    house_address(Address),
    compatible_least_area(Address, Area),
    compatible_bedrooms(Address,Minimum_bedrooms),
    compatible_pet(Address,Pets),
    compatible_lift(Address, Elevator),
    compatible_money(Address, Price_min_center, Price_min_pros, Area, Money_offers, Price_renting, Money_offers_gard),
    house_rent(Address,Rent),
    Address2 = Address.

take_houses_rents(ListOfAddresses,Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,Price,Add):-
    house_address(Address),
    member(Address, ListOfAddresses),
    house_rent(Address, Rent),
    Add = Address,
    Price = Rent.

take_houses_gardens(ListOfAddresses,Area,Minimum_bedrooms,Pets,Elevator,Price_renting,Price_min_center,Price_min_pros,Money_offers,Money_offers_gard,Garden,Add):-
    house_address(Address),
    member(Address, ListOfAddresses),
    house_garden_area(Address,Garde),
    Garden = Garde,
    Add = Address.

list_length([]     , 0 ).
list_length([_|Xs] , L ) :- list_length(Xs,N) , L is N+1 .

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
    print('Κατάλληλο σπίτι στην διεύθυνση: '), print(Address), nl,
    print('Υπνοδωμάτια: '), print(Bedrooms), nl,
    print('Εμβαδόν: '), print(Area), nl,
    print('Εμβαδόν κήπου: '), print(Garden_area), nl,
    print('Είναι στο κέντρο της πόλης: '), print(City_center), nl,
    print('Επιτρέπονται κατοικίδια: '), print(Pet), nl,
    print('Όροφος: '), print(Floor), nl,
    print('Ανελκυστήρας: '), print(Lift), nl,
    print('Ενοίκιο: '), print(Rent), nl, nl,
    print_house(Rest).

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

list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

list_append(A,T,T) :- list_member(A,T),!.
list_append(A,T,[A|T]).

list_delete(X, [X], []).
list_delete(X,[X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X,L2,L1).
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


housee_address(Address,ValueA):-
     house(Address, _, _, _, _, _, _, _, _), ValueA = Address.

find_cheaper(ListOfAddresses) :-
    find_smallest(ListOfPrices,MinValue),
    findall(Address,house(Address,_,_,_,_,_,_,_,MinValue),List),
    intersection(List,ListOfPrices,FinalList).

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


/*========These facts help us in order to find the part of the biggest or smallest tasks in our code=======*/
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
