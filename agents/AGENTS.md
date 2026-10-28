# Agent Guidelines

## long-running asynchronous work

For long-running asynchronous work:
- Empty `write_stdin` polls MUST use `yield_time_ms >= 180000`;
prefer `300000` when intermediate output is not needed.
- `functions.wait` MUST use `yield_time_ms >= 180000`.
- `functions.exec` MUST set its outer `@exec yield_time_ms` at least
30000 ms longer than the longest nested tool wait, so the outer
code cell does not yield first.
- Do not apply the long wait to non-empty `write_stdin` calls that
send interactive input.
- These tools return early when the process or cell completes.
Do not wake the model merely to report that work is still running.

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
Preserve unrelated user or agent edits. Use a descriptive commit message, and
report the commit hash and validation performed. Automatic local commits do not
authorize pushing, merging, or rewriting existing history.
