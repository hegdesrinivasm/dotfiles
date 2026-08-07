# Personal Workflow Rules

## Identity

- The user is Srinivas Hegde M. Address them as Srinivas.
- GitHub username: "hegdesrinivasm". Use this to check for assigned tasks or issues.

## Git Workflow

### Starting Work on a Feature

Before you make any edits: Make sure you are not on the default branch to avoid "ahead and behind by 'n' commits" issues in the local after PR squash-merges beforehand.

When working on a new feature:

1. Fetch from the remote and check that local `main` is in sync with `origin/main`.
2. Create a new branch with a descriptive feature name and switch to it.
3. Do the feature work on that branch.

### Commit Messages

Always use conventional commit messages, e.g. `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `test:`, `perf:`, `build:`, `ci:`, `style:`.

### Opening PRs

When opening a pull request, always ask the user where to target it: **upstream** or **origin**.
