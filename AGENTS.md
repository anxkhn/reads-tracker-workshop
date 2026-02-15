# AGENTS.md

This file contains instructions for AI tools and automated systems working with this repository.

## Project Overview

Reads Tracker Workshop is a Goodreads Lite application built with Ruby on Rails. This is an educational repository with intentionally seeded bugs for practicing open source contributions.

## Technology Stack

- Ruby 3.4
- Rails 8.1
- SQLite3 (development)
- Solid Queue (background jobs)
- RuboCop (linting)

## Commands

### Running Tests

```bash
# Run all tests
bin/rails test

# Run specific test file
bin/rails test test/models/book_test.rb

# Run specific test method
bin/rails test test/models/book_test.rb -n test_should_be_valid

# Run tests with verbose output
bin/rails test TESTOPTS="-v"
```

### Code Quality

```bash
# Run RuboCop linter
bundle exec rubocop

# Run RuboCop with auto-fix
bundle exec rubocop -a

# Run RuboCop on specific file
bundle exec rubocop app/models/book.rb
```

### Starting the Server

```bash
# Start development server
bin/rails server

# Start server on specific port
bin/rails server -p 3001

# Start server with binding
bin/rails server -b 0.0.0.0
```

### Background Jobs

```bash
# Start Solid Queue worker
bin/jobs
```

### Database Operations

```bash
# Setup database (create, migrate, seed)
bin/rails db:setup

# Create database
bin/rails db:create

# Run migrations
bin/rails db:migrate

# Reset database (drop, create, migrate, seed)
bin/rails db:reset

# Seed database with sample data
bin/rails db:seed

# View database console
bin/rails dbconsole
```

### Console

```bash
# Start Rails console
bin/rails console

# Start console in sandbox mode (rollback on exit)
bin/rails console --sandbox
```

### Generate

```bash
# Generate a model
bin/rails generate model ModelName field:type

# Generate a controller
bin/rails generate controller ControllerName action1 action2

# Generate a migration
bin/rails generate migration AddFieldToTableName field:type
```

## Code Style Rules

- Follow RuboCop configuration
- Maximum line length: 100 characters
- Use 2 spaces for indentation
- Use single quotes for strings unless interpolation needed
- Use meaningful variable and method names
- Keep methods under 15 lines
- Keep classes under 100 lines

## Commit Message Format

Use conventional commits:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `test:` for test changes
- `refactor:` for code refactoring
- `style:` for formatting changes
- `chore:` for maintenance tasks

## Testing Requirements

- All new code must have tests
- Bug fixes must include regression tests
- Tests must pass before any commit
- RuboCop must pass before any commit

## Seeded Bugs

This repository contains intentionally seeded bugs for educational purposes:

### Easy Bugs
1. Missing presence validation on Book#title
2. Hardcoded pagination limit (10) instead of constant
3. Missing alt text on book cover images in _book.html.erb partial
4. Typo in README ("Liscense" instead of "License")
5. Incorrect comment on BooksHelper#format_book_title method

### Medium Bugs
6. N+1 query in books#index - missing .includes(:author)
7. Missing strong parameters in ReviewsController#update
8. Incorrect HTTP status code (200 instead of 422) on review validation failure
9. Missing error handling in ShelvesController#add_book when shelf not found

### Hard Bugs
10. Transaction isolation issue in book borrowing logic
11. Race condition in Solid Queue job for email notifications
12. SQL injection vulnerability in advanced search

## Important Notes

- Never commit sensitive data (API keys, credentials, secrets)
- Always create a branch for changes
- Keep pull requests focused on a single issue
- Reference issues in commit messages and pull requests