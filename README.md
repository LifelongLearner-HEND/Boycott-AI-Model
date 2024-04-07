# Boycott Item Replacement System

The Boycott Item Replacement System is an AI-powered solution designed to handle orders containing boycotted items. It identifies and replaces these items with suitable alternatives, ensuring a seamless shopping experience for users.

## Features

1. **Item Replacement**: Given a user's order, the system replaces boycotted items with alternatives (if available).

2. **Price Calculation**: Calculates the total price of an order after replacing boycotted items.

3. **Price Difference**: Determines the price difference between a boycotted item and its alternative.

4. **Knowledge Base Management**: Allows insertion and removal of items, alternatives, and new boycott companies.

## Usage

### 1. Replace Boycotted Items in an Order

```prolog
?- replaceBoycottItemsFromAnOrder(UserName, OrderID, NewList).
```
