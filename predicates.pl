:- consult('data.pl').
% 1- List all orders of a specific customer (as a list).

% Find the ID corresponding to the given customer and assign the first order ID to 1
list_orders(CustomerName, Orders) :- customer(CustomerID, CustomerName), get_orders(CustomerID, 1 ,Orders).

% Base Case is: until no more orders to process increase the orderID by one and match
get_orders(CustomerID, OrderID, [Order|T]) :- 
    order(CustomerID, OrderID , Items), Order = order(CustomerID, OrderID, Items), 
    NextOrderID is OrderID + 1, get_orders(CustomerID, NextOrderID, T).
get_orders(_, _ , []):- !.

%----------------------------------------------------------------------
% 2- Get the number of orders of a specific customer given customer id.

% Using the predicate 1 to get the orders list of the given customer name
countOrdersOfCustomer(CustomerName, Count):- list_orders(CustomerName, Orders), count_Orders_helper(Orders, Count).
% Get the length of the returned list of orders
count_Orders_helper([], 0):- !.
count_Orders_helper([_|T], Count):- 
    count_Orders_helper(T, Temp), 
    Count is Temp + 1.
    
%----------------------------------------------------------------------

% NOUR ----------------------------------------------------------------

% 6. Given the item name or company name, determine whether we need to boycott or not.
isBoycott(X) :-
    boycott_company(X, _);
    item(X, Y, _),
    boycott_company(Y, _).


% 7. Given the company name or an item name, find the justification why you need to boycott this company/item.
whyToBoycott(X, Y) :-
    boycott_company(X, Y);
    item(X, Z, _),
    boycott_company(Z, Y).

    
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
