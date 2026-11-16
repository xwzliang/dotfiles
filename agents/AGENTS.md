# Agent Guidelines

## Run large pytest suites in parallel

For large pytest suites, prefer `pytest -n auto` with `pytest-xdist` when the
plugin is available and the suite supports parallel execution. Follow any
repository-specific test instructions and run tests that require serial
execution without xdist.

## Automatically commit completed work

Use judgment to commit code changes automatically when a coherent fix or feature
is complete and the relevant validation has passed. Do not wait for a separate
commit request or ask for confirmation for routine local commits, unless the user
has explicitly asked to leave changes uncommitted.

Keep one problem per commit. Include the implementation, related tests, and
necessary documentation for that problem together; separate unrelated fixes or
features into separate commits. Do not split one coherent fix merely by file type.
For a problem spanning repositories, make a focused commit in each affected
repository and explain their relationship.

Review the diff and stage only changes belonging to the problem being committed.
Preserve unrelated user or agent edits.

## Git commit messages

Follow the repository's enforced convention; otherwise use:
`type(scope): imperative summary` — scope is optional.

| Type | Use for |
| --- | --- |
| feat | New functionality |
| fix | Correcting a bug |
| refactor | Restructuring code while preserving intended behavior |
| perf | Improving performance |
| docs | Documentation changes |
| test | Changes primarily to tests |
| build | Build tooling, packaging, or dependency changes |
| ci | CI configuration and automation |
| style | Code formatting that does not change behavior |
| chore | Maintenance that does not fit a more specific category |

- Choose the main purpose: a fix with tests remains `fix`; a CSS behavior
  change is not `style`. Split unrelated changes into separate commits.
- Use lowercase types, meaningful scopes, and specific imperative summaries.
  Omit the final period. Prefer headers within 72 characters; obey configured
  limits when different.
- For nontrivial changes, add a blank line and explain the problem, rationale,
  and important consequences. Omit unnecessary bodies. Wrap prose around
  72 characters without breaking URLs, identifiers, or commands.
- For breaking changes, add `!` before `:` and a `BREAKING CHANGE:` footer
  explaining incompatibility and migration.
- Derive messages from the staged diff. Never invent references, test results,
  performance claims, or rationale. Close issues only when actually resolved.
- Preserve required authorship, attribution, signing, and project conventions
  for merge/revert messages. Run configured message validation and fix
  rejections without bypassing hooks.

## Git synchronization and publishing

- Use the branch explicitly requested by the user; otherwise record the
  checked-out branch at task start and keep working on it. Do not create
  or switch to task branches, including through worktrees, unless requested.
  If HEAD is detached, establish the intended branch before proceeding.

- Pull and push the SAME branch name on the selected remote.
  Work started on `main` must be published to `origin/main`, not `codex/*`,
  `feature/*`, or another substitute branch. Ordinary direct pushes to
  `main` are authorized; do not ask for routine confirmation.

- Use the explicitly assigned remote; otherwise use `origin`, or the sole
  remote. Use explicit branch arguments so stale upstream or push settings
  cannot redirect publication. Report genuinely ambiguous destinations.

- Preserve unrelated edits, staging, and commits. Do not discard, auto-stash,
  or commit unrelated work. Coordinate concurrent agents and serialize Git
  mutations. Do not continue or abort someone else's Git operation.

- Workflow: pull when safe → implement → validate → commit → pull/integrate
  latest changes → rerun affected checks → push. Prefer fast-forward;
  otherwise follow repository policy, rebasing only your own unpublished
  commits or merging to preserve existing history.

- Resolve clear conflicts autonomously, preserving relevant changes from
  both sides. Report unresolved ambiguity rather than guessing.

- Review outgoing commits and push with an explicit matching source and
  destination:
  `git push <remote> refs/heads/<branch>:refs/heads/<branch>`
  Verify success. Never publish to an alternative branch as a workaround.

- If the remote advances, synchronize, revalidate, and retry up to twice.
  Do not force-push, bypass hooks/protections, or alter credentials or
  repository settings merely to succeed.

- If no remote exists, retain local commits and report publication skipped.
  If the matching remote branch is new, create only that same-named branch;
  investigate an unexpectedly missing upstream before recreating it.

- Finish with the branch, final commit IDs, validation results, and exact
  push destination. If publication is blocked, preserve the work and report
  the blocker; do not claim completion by pushing somewhere else.
