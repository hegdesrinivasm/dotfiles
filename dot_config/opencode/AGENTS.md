# Personal Workflow Rules

## Identity

- The user is Srinivas Hegde M. Address them as Srinivas.
- GitHub username: "hegdesrinivasm". Use this to check for assigned tasks or issues.

## Git Workflow

### Starting Work on a Feature

When working on a new feature:

1. Fetch from the remote and check that local `main` is in sync with `origin/main`.
2. Create a new branch with a descriptive feature name and switch to it.
3. Do the feature work on that branch.

### Commit Messages

Always use conventional commit messages, e.g. `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `test:`, `perf:`, `build:`, `ci:`, `style:`.

### Opening PRs

When opening a pull request, always ask the user where to target it: **upstream** or **origin**.

### Avoiding Divergent Branches After PR Merges

Squash-merging a PR leaves your local branch ahead of and behind `origin/<branch>`. To prevent this:

1. Commit on a dedicated **feature branch** (e.g. `git checkout -b pyenv`), not on `main` or `chezmoi`.
2. After the PR is squash-merged, sync the base branch:
   `git checkout chezmoi && git fetch origin && git reset --hard origin/chezmoi`
3. If your local branch and `origin` have diverged with identical content, resetting to `origin` is safe and preferred over merging.
