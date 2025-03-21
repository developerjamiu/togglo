# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-03-21

### Added

- Initial release of Togglo feature toggle management system
- RESTful API for managing feature toggles
- GlobeKV integration for high-performance storage
- Support for percentage-based rollouts
- User-specific targeting capabilities
- CRUD operations for feature toggles
- Environment variable support for server configuration

### Features

- Create new feature toggles with name, description, and rules
- List all feature toggles
- Get specific toggle details
- Update existing toggles
- Delete toggles
- Check toggle enabled status
- Eventually-consistent data replication with GlobeKV

### Technical Details

- Built with Dart SDK ^3.6.0
- Uses Shelf for HTTP server
- JSON serialization for data handling
- Comprehensive error handling
- Production-ready server configuration

### Dependencies

- shelf: ^1.4.1
- shelf_router: ^1.1.4
- json_annotation: ^4.8.1
- globe_kv: ^1.0.0+1

### Development Dependencies

- lints: ^5.0.0
- test: ^1.24.0
- build_runner: ^2.4.8
- json_serializable: ^6.7.1
