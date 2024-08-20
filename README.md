# Internal Wallet Transactional System API

This is an API designed for managing internal wallets and transactions across multiple entities such as users, teams, and stocks. The system also includes an integration with an external service to fetch the latest stock prices.

## Table of Contents
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
    - [Authentication](#authentication)
    - [Wallet Transactions](#wallet-transactions)
    - [Stock Prices](#stock-prices)
- [Example Usage](#example-usage)

## Getting Started

1. Clone the repository.
2. Run `bundle install` to install dependencies.
3. Set up your database with `rails db:setup`.
4. Set your RapidAPI key in the `.env` file:
   ```bash
   RAPIDAPI_KEY=your_rapidapi_key_here
   ```

## Endpoints
### Authentication
- `POST /sessions`

Log in a user.

Request:

```json
{
    "email": "user@example.com",
    "password": "password123"
}
```
Response:

```json
{
    "message": "Logged in successfully",
    "user": {
        "id": 1,
        "email": "user@example.com"
    },
    "token": "your_jwt_token_here"
}
```

- `DELETE /sessions`

Log out a user.

Request:

```json
{
    "token": "your_jwt_token_here"
}
```

Response:

```json
{
    "message": "Logged out successfully"
}
```

### Wallet Transactions
- `POST /transactions`

Create a transaction (credit or debit).

Request:

```json
{
    "transaction": {
        "amount": 100.00,
        "transaction_type": "credit",
        "target_wallet_id": 1
    }
}
```

Response:

```json
{
    "id": 1,
    "amount": 100.00,
    "transaction_type": "credit",
    "source_wallet_id": null,
    "target_wallet_id": 1,
    "created_at": "2024-08-19T12:00:00Z",
    "updated_at": "2024-08-19T12:00:00Z"
}
```

Validation Errors Example:

```json
{
    "errors": [
        "Source wallet must be nil for credit transactions",
        "Amount must be greater than 0"
    ]
}
```

### Stock Prices
- `GET /stocks/price?symbol=:symbol`

Get the latest price for a specific stock symbol.

Request:

``` bash
GET /stocks/price?symbol=AAPL
```

Response:

```json
{
    "symbol": "AAPL",
    "price": 150.25,
    "timestamp": "2024-08-19T12:00:00Z"
}
```

- `GET /stocks/prices?symbols=:symbols`

Get the latest prices for multiple stock symbols.

Request:

```bash
GET /stocks/prices?symbols=AAPL,GOOGL,MSFT
```

Response:

```json
[
    {
        "symbol": "AAPL",
        "price": 150.25,
        "timestamp": "2024-08-19T12:00:00Z"
    },
    {
        "symbol": "GOOGL",
        "price": 2800.50,
        "timestamp": "2024-08-19T12:00:00Z"
    },
    {
        "symbol": "MSFT",
        "price": 299.75,
        "timestamp": "2024-08-19T12:00:00Z"
    }
]
```

- `GET /stocks/price_all`

Get the latest prices for all available stocks.

Request:

```bash
GET /stocks/price_all
```

Response:

```json
[
    {
        "symbol": "AAPL",
        "price": 150.25,
        "timestamp": "2024-08-19T12:00:00Z"
    },
    {
        "symbol": "GOOGL",
        "price": 2800.50,
        "timestamp": "2024-08-19T12:00:00Z"
    },
    {
        "symbol": "MSFT",
        "price": 299.75,
        "timestamp": "2024-08-19T12:00:00Z"
    },
    {
        "symbol": "TSLA",
        "price": 720.80,
        "timestamp": "2024-08-19T12:00:00Z"
    }
    // More stock data...
]
```

## Example Usage
This section provides examples of how to interact with the API endpoints. You can use tools like curl, Postman, or any HTTP client to make requests to the API.

### Authentication
- Log in a user:

```bash
curl -X POST http://localhost:3000/sessions \
-H "Content-Type: application/json" \
-d '{"email": "user@example.com", "password": "password123"}'
```

- Log out a user:

```bash
curl -X DELETE http://localhost:3000/sessions \
-H "Content-Type: application/json" \
-d '{"token": "your_jwt_token_here"}'
```

### Wallet Transactions
- Create a credit transaction:

```bash
curl -X POST http://localhost:3000/transactions \
-H "Content-Type: application/json" \
-d '{"transaction": {"amount": 100.00, "transaction_type": "credit", "target_wallet_id": 1}}'
```

- Create a debit transaction:

```bash
curl -X POST http://localhost:3000/transactions \
-H "Content-Type: application/json" \
-d '{"transaction": {"amount": 50.00, "transaction_type": "debit", "source_wallet_id": 1}}'
```

### Stock Prices
- Get the price for a single stock:

```bash
curl -X GET "http://localhost:3000/stocks/price?symbol=AAPL"
```

- Get prices for multiple stocks:

```bash
curl -X GET "http://localhost:3000/stocks/prices?symbols=AAPL,GOOGL,MSFT"
```

- Get prices for all stocks:

```bash
curl -X GET "http://localhost:3000/stocks/price_all"
```