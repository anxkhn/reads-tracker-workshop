# Contributing to Reads Tracker Workshop

Thank you for your interest in contributing! This guide will walk you through the process step by step.

## Table of Contents

- [Contribution Workflow](#contribution-workflow)
- [Conventional Commits](#conventional-commits)
- [Code Style](#code-style)
- [Testing Requirements](#testing-requirements)
- [Common Mistakes to Avoid](#common-mistakes-to-avoid)
- [Getting Help](#getting-help)

## Contribution Workflow

### Step 1: Fork the Repository

1. Navigate to the main repository on GitHub
2. Click the "Fork" button in the top-right corner
3. Select your account as the destination

### Step 2: Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/reads-tracker-workshop.git
cd reads-tracker-workshop
```

### Step 3: Create a Branch

Create a descriptive branch name based on what you are working on:

```bash
# For bug fixes
git checkout -b fix/issue-number-short-description

# For features
git checkout -b feat/short-description

# For documentation
git checkout -b docs/short-description
```

### Step 4: Make Your Changes

- Write clean, readable code
- Follow the existing code style
- Add tests for new functionality
- Update documentation if needed

### Step 5: Commit Your Changes

Write clear, conventional commit messages (see below).

```bash
git add .
git commit -m "feat: add book export to CSV format"
```

### Step 6: Push to Your Fork

```bash
git push origin your-branch-name
```

### Step 7: Open a Pull Request

1. Go to your fork on GitHub
2. Click "Compare & pull request"
3. Fill out the pull request template
4. Submit the pull request

### Step 8: Respond to Feedback

Maintainers may request changes. Address any feedback promptly and push new commits to the same branch.

## Conventional Commits

All commit messages must follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>: <description>

[optional body]
[optional footer]
```

### Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | `feat: add user registration form` |
| `fix` | Bug fix | `fix: correct pagination offset` |
| `docs` | Documentation only | `docs: update installation steps` |
| `test` | Adding or fixing tests | `test: add tests for book model` |
| `refactor` | Code refactoring | `refactor: extract book validation logic` |
| `style` | Code style (formatting) | `style: fix indentation in book.rb` |
| `perf` | Performance improvement | `perf: optimize database query` |
| `chore` | Maintenance tasks | `chore: update dependencies` |
| `ci` | CI/CD changes | `ci: add Ruby 3.4 to test matrix` |

### Guidelines

- Use lowercase for the type
- Keep the description under 72 characters
- Use imperative mood ("add" not "added")
- No period at the end of the description
- Reference issues in the footer: `Closes #123`

### Examples

```
feat: add ability to filter books by reading status

Users can now filter their book list by:
- Want to Read
- Currently Reading
- Completed

Closes #42
```

```
fix: prevent duplicate books from being added

The uniqueness validation was not being triggered correctly.
Added a database-level unique index as a safeguard.

Fixes #87
```

## Code Style

This project uses [RuboCop](https://github.com/rubocop/rubocop) for Ruby code style enforcement.

### Running RuboCop

```bash
# Check all files
bundle exec rubocop

# Check specific file
bundle exec rubocop app/models/book.rb

# Auto-fix issues
bundle exec rubocop -a
```

### Style Guidelines

- Follow the [Ruby Style Guide](https://rubystyle.guide/)
- Maximum line length: 100 characters
- Use 2 spaces for indentation (no tabs)
- Use single quotes for strings unless interpolation is needed
- Use meaningful variable and method names
- Keep methods small and focused

## Testing Requirements

### Run Tests

```bash
# Run all tests
bin/rails test

# Run with verbose output
bin/rails test TESTOPTS="-v"

# Run specific file
bin/rails test test/models/book_test.rb

# Run specific test method
bin/rails test test/models/book_test.rb -n test_should_be_valid
```

### Testing Requirements

- All new code must have corresponding tests
- Bug fixes must include a test that would have failed before the fix
- Tests must pass before submitting a pull request
- Maintain or improve test coverage

### Writing Tests

Follow the Arrange-Act-Assert pattern:

```ruby
test "should calculate average rating" do
  # Arrange
  book = books(:one)
  book.reviews.create!(rating: 4, content: "Good")
  book.reviews.create!(rating: 5, content: "Great")

  # Act
  average = book.average_rating

  # Assert
  assert_equal 4.5, average
end
```

## Common Mistakes to Avoid

1. **Committing to main/master**: Always create a feature branch
2. **Large pull requests**: Keep PRs focused on a single issue
3. **Missing tests**: Add tests for all new functionality
4. **Ignoring RuboCop**: Run linter before committing
5. **Unclear commit messages**: Use conventional commits
6. **Outdated branch**: Keep your branch updated with upstream
7. **Committing sensitive data**: Never commit credentials or secrets
8. **Not reading the issue**: Understand the problem before coding

### Keeping Your Branch Updated

```bash
# Add upstream remote (once)
git remote add upstream https://github.com/ORIGINAL_OWNER/reads-tracker-workshop.git

# Fetch and merge upstream changes
git fetch upstream
git checkout main
git merge upstream/main

# Update your feature branch
git checkout your-branch-name
git merge main
```

## Getting Help

- Check existing issues for similar problems
- Review closed pull requests for examples
- Ask questions in the issue comments
- Tag maintainers if you need guidance

We are here to help you learn. No question is too basic.

---

Thank you for contributing to open source!