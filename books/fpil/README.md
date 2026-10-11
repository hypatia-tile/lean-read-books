# Functional Programming in Lean

- Source: <https://lean-lang.org/functional_programming_in_lean/>
- Toolchain: `leanprover/lean4:v4.33.0` — the version upstream's `examples/` was pinned to when this book was added.

Code goes in `Fpil/ChNN.lean` (imported from `Fpil.lean`); notes go in `notes/chNN.md`.
A chapter split by section keeps its files in `Fpil/ChNN/<SectionTitle>/` and imports them from `Fpil/ChNN.lean`.
Within a section's directory:

- `Basic.lean` — the main definitions of the section.
- a file for examples and experiments (`Examples.lean`, or a name that fits the topic).
- `DecidableEq.lean` — `#guard` checks that need derived `DecidableEq` instances.
- `Exercises/` — one file per exercise.
