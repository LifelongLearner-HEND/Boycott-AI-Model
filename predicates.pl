:- consult('data.pl').
% 1- List all orders of a specific customer (as a list).

% Find the ID corresponding to the given customer and assign the first order ID to 1
list_orders(CustomerName, Orders) :- customer(CustomerID, CustomerName), get_orders(CustomerID, 1 ,Orders).

% Base Case is: until no more orders to process increase the orderID by one and match
get_orders(CustomerID, OrderID, [Order|T]) :- 
order(CustomerID, OrderID , Items), Order = order(CustomerID, OrderID, Items), 
NextOrderID is OrderID + 1, get_orders(CustomerID, NextOrderID, T).
get_orders(_, _ , []).

% -----------------------------------------------------
% 2- Get the number of orders of a specific customer given customer id.