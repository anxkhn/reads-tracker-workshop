# Reads Tracker Workshop

A Goodreads Lite application for tracking books and reviews. This is an educational repository with intentionally seeded bugs for practicing open source contributions.

## Features

- User authentication (registration, login, logout)
- Books management (CRUD operations)
- Authors management
- Reviews with ratings (1-5 stars)
- Custom shelves for organizing books
- Reading session tracking
- Statistics dashboard
- Advanced search functionality

## Technology Stack

- Ruby 3.4
- Rails 8.1
- SQLite3 (development)
- Solid Queue (background jobs)
- RuboCop (code linting)

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup database:
   ```bash
   bin/rails db:setup
   ```

3. Start the server:
   ```bash
   bin/rails server
   ```

4. Visit `http://localhost:3000` in your browser.

## Default User

After running the seeds, you can log in with:
- Email: `demo@example.com`
- Password: `password`

## Running Tests

```bash
bin/rails test
```

## Code Quality

Run RuboCop linter:
```bash
bundle exec rubocop
```

## Background Jobs

Start Solid Queue for background job processing:
```bash
bin/jobs
```

## Known Issues

This repository contains intentionally seeded bugs for educational purposes. See the issues section for bug reports to fix.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linter
5. Submit a pull request

## License

MIT License