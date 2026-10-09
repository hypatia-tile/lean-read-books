# lean-read-books

One repository for reading any number of Lean books, sharing a single Nix +
[elan](https://github.com/leanprover/elan) environment so that starting a new
book costs no environment setup.

## Environment

The devShell provides only `elan`; `lean` and `lake` are elan proxies that pick
the toolchain from the nearest `lean-toolchain` file, downloading it into
`~/.elan` on first use. Each book pins its own toolchain, so books on different
Lean versions coexist.

Enter it either way:

- `direnv allow` once — the shell (and any editor started inside the
  repository) then has `elan`, `lean` and `lake` on `PATH`.
- `nix develop` — for a one-off shell, or prefix a command with
  `nix develop -c`.

Build every book:

```sh
nix develop -c sh -c 'for d in books/*/; do (cd "$d" && lake build) || exit 1; done'
```

## Layout

```
books/<slug>/          one Lake project per book
  lean-toolchain       the book's pinned toolchain
  <Module>.lean        library root; imports each chapter
  <Module>/ChNN.lean   code written while reading chapter NN
  notes/chNN.md        notes for chapter NN
  README.md            title, source URL, why this toolchain
notes/<topic>.md       notes that span books
```

Learning notes may be written in any language.

## Books

| Slug | Book | Toolchain |
|---|---|---|
| [`tpil4`](books/tpil4) | Theorem Proving in Lean 4 | `v4.33.0` |
| [`mpil4`](books/mpil4) | Metaprogramming in Lean 4 | `v4.34.1` |
| [`fpil`](books/fpil) | Functional Programming in Lean | `v4.33.0` |

## Adding a book

No change to the Nix environment is needed.

1. Pick a short kebab-case slug (e.g. `tpil4`) and a toolchain — usually the
   one the book's upstream examples are pinned to, or the latest stable
   release.
2. Scaffold it from inside the devShell:
   ```sh
   cd books && lake +leanprover/lean4:<version> new <slug> lib.toml
   ```
   This writes `lean-toolchain` for you. Delete the generated `.github/`
   (CI is not used here) and `.gitignore` (the root one covers `.lake/`).
3. Replace `<Module>/Basic.lean` with `<Module>/Ch01.lean` and update the
   import in `<Module>.lean`.
4. Write `books/<slug>/README.md` (title, source URL, why this toolchain) and
   create `books/<slug>/notes/`.
5. Run `lake build` in the book, commit `lake-manifest.json` with the rest,
   and add a row to the table above.

Keep only your own code in a book directory and link to the source. If a book
genuinely needs its upstream vendored (e.g. as a git submodule), say so in that
book's README.
