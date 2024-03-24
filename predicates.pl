:- consult('data.pl').

% 1. List all orders of a specific customer (as a list).
% Find the ID corresponding to the given customer and assign the first order ID to 1
list_orders(CustomerName, Orders) :-
    customer(CustomerID, CustomerName),
    get_orders(CustomerID, 1 ,Orders).

% Base Case is: until no more orders to process increase the orderID by one and match
get_orders(CustomerID, OrderID, [Order|T]) :-
    order(CustomerID, OrderID , Items),
    Order = order(CustomerID, OrderID, Items),
    NextOrderID is OrderID + 1, get_orders(CustomerID, NextOrderID, T).
get_orders(_, _ , []):- !.

%----------------------------------------------------------------------
% 2. Get the number of orders of a specific customer given customer id.
% Using the predicate 1 to get the orders list of the given customer name
countOrdersOfCustomer(CustomerName, Count):-
    list_orders(CustomerName, Orders),
    count_Orders_helper(Orders, Count), !.
% Get the length of the returned list of orders
count_Orders_helper([], 0):- !.
count_Orders_helper([_|T], Count):-
    count_Orders_helper(T, Temp),
    Count is Temp + 1.

%----------------------------------------------------------------------
% 3-List all items in a specific customer order given customer id and order id.

%customer name as example
getItemsInOrderById(CustUserName, OrderID, Items) :-
    customer(CustID, CustUserName),
    order(CustID, OrderID, Items).
%customer id as asked
getItemsInOrderById(CustID, OrderID, Items) :-
    order(CustID, OrderID, Items).

%----------------------------------------------------------------------
% 4-Get the num of items in a specific customer order given
% customer Name and order id.

% counter predicate replacing legnth predicate
count_items([], 0).
count_items([_|Rest], Count) :-
    count_items(Rest, RestCount),
    Count is RestCount + 1.

% The question Predicate
getNumOfItems(CustName, OrderID, Count) :-
    customer(Custid, CustName),
    order(Custid, OrderID, Items),
    count_items(Items, Count).

%----------------------------------------------------------------------
% 5- Calculate the price of a given order given Customer Name and order id
calcPriceOfOrder(CustName, OrderID, TotalPrice) :-
    customer(CustID,CustName),
    order(CustID, OrderID, Items),
    calcPriceOfItems(Items, TotalPrice).

% حسابه السعر
calcPriceOfItems([], 0).  % Base case
calcPriceOfItems([Item|Rest], TotalPrice) :-
    item(Item, _, Price),
    calcPriceOfItems(Rest, RestPrice),
    TotalPrice is Price + RestPrice.

%----------------------------------------------------------------------
% 6. Given the item name or company name, determine whether we need to boycott or not.
isBoycott(X) :-
    boycott_company(X, _);
    item(X, Y, _),
    boycott_company(Y, _).

%----------------------------------------------------------------------
% 7. Given the company name or an item name, find the justification why you need to boycott this company/item.
whyToBoycott(X, Y) :-
    boycott_company(X, Y);
    item(X, Z, _),
    boycott_company(Z, Y).

%----------------------------------------------------------------------
% 8. Given an username and order ID, remove all the boycott items from this order.
removeBoycottItems([], []).

removeBoycottItems([X|Y], NewList) :-
    isBoycott(X),
    removeBoycottItems(Y, NewList).

removeBoycottItems([X|Y], [X|NewList]) :-
    removeBoycottItems(Y, NewList).

removeBoycottItemsFromAnOrder(X, Y, NewList) :-
    customer(Z, X),
    order(Z, Y, List),
    removeBoycottItems(List, NewList).

%----------------------------------------------------------------------
% 9. Given an username and order ID, update the order such that all boycott items are replaced by an alternative i/f e/xists.
replaceBoycottItems([], []).

replaceBoycottItems([X|Y], [Z|NewList]) :-
    isBoycott(X),
    alternative(X, Z),
    replaceBoycottItems(Y, NewList).

replaceBoycottItems([X|Y], [X|NewList]) :-
    replaceBoycottItems(Y, NewList).

replaceBoycottItemsFromAnOrder(X, Y, NewList) :-
    customer(Z, X),
    order(Z, Y, List),
    replaceBoycottItems(List, NewList).

%----------------------------------------------------------------------
% 10. Given an username and order ID, calculate the price of the order after replacing all boycott items by its alternative (if it exists).
calcPriceAfterReplacingBoycottItemsFromAnOrder(CustomerName, OrderID, NewList, TotalPrice):-
    replaceBoycottItemsFromAnOrder(CustomerName, OrderID, NewList),
    price_helper(NewList, TotalPrice).

price_helper([], 0).
price_helper([H|T], TotalPrice):-
    item(H, _, Price),
    price_helper(T, Temp),
    TotalPrice is Temp + Price.

%----------------------------------------------------------------------
% 11. calculate the difference in price between the boycott item and its alternative.
getTheDifferenceInPriceBetweenItemAndAlternative(Item, Alternative, DiffPrice) :-
    item(Item, _, PriceItem),
    alternative(Item, Alternative),
    item(Alternative, _, PriceAlternative),
    DiffPrice is PriceItem - PriceAlternative.

%----------------------------------------------------------------------
% 12. Bonus

:- dynamic item/3.
% Add Item
add_item(Name, Manufacturer, Price):-
    assert(item(Name, Manufacturer, Price)).

% Remove Item
remove_item(Name, Manufacturer, Price):-
    retract(item(Name, Manufacturer, Price)).

:- dynamic boycott_company/2.
% Add Company
add_company(CompanyName, Justification):-
    assert(boycott_company(CompanyName, Justification)).

% Remove Company
remove_company(CompanyName, Justification):-
    retract(boycott_company(CompanyName, Justification)).

% Add alternative
:- dynamic(alternative/2).
add_alternative(ItemName, AlternativeItem):-
    item(ItemName,_,_),
    item(AlternativeItem,_,_),
    assert(alternative(ItemName, AlternativeItem)).

% Remove alternative
remove_alternative(ItemName, AlternativeItem):-
    item(ItemName,_,_),
    item(AlternativeItem,_,_),
    retract(alternative(ItemName, AlternativeItem)).
