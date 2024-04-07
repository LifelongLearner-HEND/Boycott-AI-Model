# Boycott Item Replacement System

The Boycott Item Replacement System is an AI-powered solution designed to handle orders containing boycotted items. It identifies and replaces these items with suitable alternatives, ensuring a seamless shopping experience for users.

## Features

1. **Item Replacement**: Given a user's order, the system replaces boycotted items with alternatives (if available).

2. **Price Calculation**: Calculates the total price of an order after replacing boycotted items.

3. **Price Difference**: Determines the price difference between a boycotted item and its alternative.

4. **Knowledge Base Management**: Allows insertion and removal of items, alternatives, and new boycott companies.

5. **Retrieve Information**: Get information about customer's order and what companies and items to boycott.
   
## Usage
Given data file that includes facts about cutomers, orders, items and boycott companies:

### 1. List all orders of a specific customer (as a list).

```prolog
?- list_orders(customer name, RetunedList).
```

### 2. Get the number of orders of a specific customer given customer id.

```prolog
?- countOrdersOfCustomer(customer name,Count).
```

### 3. List all items in a specific customer order given customer id and order id.

```prolog
?- getItemsInOrderById(customer name,order id,Items).
```

### 4. Get the num of items in a specific customer order given customer Name and order id.

```prolog
?- getNumOfItems(customer name,order id,Count).
```

### 5. Calculate the price of a given order given Customer Name and order id.
```prolog
?- calcPriceOfOrder(customer name,order id,TotalPrice).
```

### 6. Given the item name or company name, determine whether we need to boycott or not.
```prolog
?- isBoycott(comapny name).
```

### 7. Given the company name or an item name, find the justification why you need to boycott this company/item.
```prolog
?- whyToBoycott(company name, Justification).
```

### 8. Given a username and order ID, remove all the boycott items from this order.
```prolog
?- removeBoycottItemsFromAnOrder(customer name, order id, NewList).
```

### 9. Given a username and order ID, update the order such that all boycott items are replaced by an alternative (if exists).
```prolog
?- replaceBoycottItemsFromAnOrder(customer name, prder id, NewList).
```

### 10. Given a username and order ID, calculate the price of the order after replacing all boycott items by its alternative (if it exists).
```prolog
?- calcPriceAfterReplacingBoycottItemsFromAnOrder(customer name, prder id, TotalPrice).
```

### 11. Calculate the difference in price between the boycott item and its alternative.
```prolog
?- getTheDifferenceInPriceBetweenItemAndAlternative(item name, Alternative, DiffPrice).
```

### 12. Insert/Remove item, alternative and new boycott company to/from the knowledge base
```prolog
?- add_item(item name, Alternative, quantity).
```
