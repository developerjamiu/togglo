# Togglo

A feature toggle management system built with Dart and GlobeKV for high-performance, eventually-consistent storage.

## Features

- Create, read, update, and delete feature toggles
- Support for percentage-based rollouts
- User-specific targeting
- RESTful API
- High-performance storage with GlobeKV
- Eventually-consistent data replication

## Getting Started

### Prerequisites

- Dart SDK ^3.6.0
- Globe app with enabled namespace

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/togglo.git
cd togglo
```

2. Install dependencies:

```bash
dart pub get
```

3. Run the server:

```bash
dart run bin/server.dart
```

The server will start on port 8080 by default. You can change the port by setting the `PORT` environment variable:

```bash
PORT=3000 dart run bin/server.dart
```

## API Documentation

### Feature Toggles

#### Create a Feature Toggle

```http
POST /toggles
Content-Type: application/json

{
  "name": "Dark Mode",
  "description": "Enable dark mode theme",
  "enabled": true,
  "rules": {
    "percentage": 100,
    "users": ["user1", "user2"]
  }
}
```

#### Get All Feature Toggles

```http
GET /toggles
```

#### Get a Specific Feature Toggle

```http
GET /toggles/{id}
```

#### Update a Feature Toggle

```http
PUT /toggles/{id}
Content-Type: application/json

{
  "name": "Dark Mode",
  "description": "Updated description",
  "enabled": false,
  "rules": {
    "percentage": 50,
    "users": ["user1"]
  }
}
```

#### Delete a Feature Toggle

```http
DELETE /toggles/{id}
```

#### Check if a Feature is Enabled

```http
GET /toggles/{id}/enabled
```

## Development

### Project Structure

```
togglo/
├── bin/
│   ├── server.dart        # Server entry point
│   └── test_globe_kv.dart # GlobeKV test script
├── lib/
│   ├── handlers/          # API request handlers
│   ├── models/           # Data models
│   └── services/         # Business logic and storage
└── test/                 # Test files
```

### Running Tests

```bash
dart test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
