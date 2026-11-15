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

- Standing authorization: automatically commit validated task changes,
  pull/integrate remote updates, and push when a remote exists. No routine
  confirmation is needed. Explicit task restrictions override this rule.

- Inspect branch, tracking/push configuration, staged/unstaged changes, and
  ongoing Git operations. Preserve unrelated work and staging; never discard,
  auto-stash, or commit it. Use an isolated worktree when needed, accounting
  for uncommitted dependencies. Do not continue or abort others' operations.

- Honor explicit targets and repository configuration. Otherwise select
  `origin`, or the sole remote; pull the configured upstream or same-named
  remote branch, and publish the task branch under its own name. Tracking
  `origin/main` does not authorize pushing a feature branch over `main`.
  Report unresolved destination ambiguity rather than guessing.

- Workflow: pull before editing when safe → implement → validate → commit →
  pull/integrate again → rerun affected checks → push. If pull and push
  destinations differ, also integrate updates from the publishing branch.

- Prefer fast-forward integration. On divergence, follow repository policy;
  otherwise rebase only your own unpublished commits while preserving intended
  history, or merge when existing history must remain intact. Resolve clear
  conflicts autonomously, review both sides, and fix task-related failures.

- Review outgoing commits to avoid publishing unrelated work. Push one explicit
  remote/branch and verify success. For a new remote branch, fetch, verify the
  base, then push and establish tracking if missing. Preserve existing tracking;
  investigate vanished upstreams instead of silently recreating them.

- If the remote advances and rejects the push, synchronize, revalidate, and
  retry up to two additional times. Never substitute force-pushing, bypass
  hooks/protections, or alter signing, global configuration, credentials, or
  remote URLs merely to succeed.

- With no remote, retain local commits and report publication skipped; do not
  invent a remote or pull an arbitrary branch. Access failures do not mean
  a remote is absent. Preserve work and report genuine access, protection,
  validation, or unresolved conflict blockers precisely.

- Finish with branch, final commit IDs, validation results, and push destination
  or exact blocker. Do not stop at suggesting Git commands or claim publication
  succeeded without verification. Preserve unrelated remaining changes.
