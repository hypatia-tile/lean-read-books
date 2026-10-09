# Agent guide

This repository holds several Lean books side by side, each read by the owner
by hand. See `README.md` for the full layout and the steps for adding a book.

## Environment

- Run every `lean`/`lake` command inside the devShell: either the shell is
  already loaded by direnv, or prefix the command with `nix develop -c`.
- The devShell only provides `elan`. Toolchains come from each book's
  `lean-toolchain` and are downloaded by elan on demand.
- Do not add Lean toolchains or other packages to `flake.nix` to make a book
  work; a book's toolchain belongs in its own `lean-toolchain`.

## Layout

- `books/<slug>/` — one independent Lake project per book. Run `lake` from
  inside the book's directory, never from the repository root (there is no
  root Lake project).
- `books/<slug>/<Module>/ChNN.lean` — the owner's code for chapter NN.
- `books/<slug>/notes/chNN.md` — the owner's notes for chapter NN.
- `notes/<topic>.md` — notes that span books.

## Building

One book: `cd books/<slug> && lake build`.

Every book:

```sh
nix develop -c sh -c 'for d in books/*/; do (cd "$d" && lake build) || exit 1; done'
```

## Conventions

- Do not change a book's `lean-toolchain` unless asked; bumping it can break
  the owner's existing code.
- Learning notes may be in any language; everything else (READMEs, this file,
  commits, PRs) is in English.
