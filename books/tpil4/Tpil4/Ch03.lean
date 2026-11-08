/-!
# 3. Propositions and Proofs

<https://lean-lang.org/theorem_proving_in_lean4/Propositions-and-Proofs/>

Chapter 3 of *Theorem Proving in Lean 4*.
-/

/-! ## 3.1. Propositions as Types -/
namespace «3.1. Propositions as Types»

end «3.1. Propositions as Types»

/-! ## 3.2. Working with Propositions as Types -/
namespace «3.2. Working with Propositions as Types»

end «3.2. Working with Propositions as Types»

/-!
## 3.3. Propositional Logic

- 3.3.1. Conjunction
- 3.3.2. Disjunction
- 3.3.3. Negation and Falsity
- 3.3.4. Logical Equivalence
-/
namespace «3.3. Propositional Logic»

end «3.3. Propositional Logic»

/-! ## 3.4. Introducing Auxiliary Subgoals -/
namespace «3.4. Introducing Auxiliary Subgoals»

end «3.4. Introducing Auxiliary Subgoals»

/-! ## 3.5. Classical Logic -/
namespace «3.5. Classical Logic»

end «3.5. Classical Logic»

/-! ## 3.6. Examples of Propositional Validities -/
namespace «3.6. Examples of Propositional Validities»

end «3.6. Examples of Propositional Validities»

/-!
## 3.7. Exercises

Prove the following identities, replacing the `sorry` placeholders with actual
proofs.
-/
namespace «3.7. Exercises».Constructive

variable (p q r : Prop)

-- commutativity of ∧ and ∨
example : p ∧ q ↔ q ∧ p := sorry
example : p ∨ q ↔ q ∨ p := sorry

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) := sorry
example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := sorry

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) := sorry
example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) := sorry

-- other properties
example : (p → (q → r)) ↔ (p ∧ q → r) := sorry
example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := sorry
example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := sorry
example : ¬p ∨ ¬q → ¬(p ∧ q) := sorry
example : ¬(p ∧ ¬p) := sorry
example : p ∧ ¬q → ¬(p → q) := sorry
example : ¬p → (p → q) := sorry
example : (¬p ∨ q) → (p → q) := sorry
example : p ∨ False ↔ p := sorry
example : p ∧ False ↔ False :=
  Iff.intro
    (fun h : p ∧ False => h.right.elim)
    (fun h : False => h.elim)
example : (p → q) → (¬q → ¬p) := sorry

end «3.7. Exercises».Constructive

/-!
These require classical reasoning.
-/
namespace «3.7. Exercises».ClassicalReasoning

open Classical

variable (p q r : Prop)

/-- info: Or.elim {a b c : Prop} (h : a ∨ b) (left : a → c) (right : b → c) : c -/
#guard_msgs in
#check Or.elim

/-- info: Classical.em (p : Prop) : p ∨ ¬p -/
#guard_msgs in
#check em

example : (p → q ∨ r) → ((p → q) ∨ (p → r)) :=
  fun h : p → q ∨ r =>
  Or.elim (em p)
  (fun hp : p => (h hp : q ∨ r).elim
    (fun hq : q =>
      Or.inl (fun _ => hq))
    (fun hr : r =>
      Or.inr (fun _ => hr)))
  (fun hnp : ¬p =>
    Or.inl fun hp : p => absurd hp hnp)

example : ¬(p ∧ q) → ¬p ∨ ¬q :=
  Or.elim (em p)
  (fun hp => fun hnpq =>
    Or.elim (em q)
    (fun hq => absurd
      (And.intro hp hq)
      (hnpq))
    (fun hnq => Or.inr hnq)
    )
  (fun hnp => (fun _ => Or.inl hnp))

example : ¬(p → q) → p ∧ ¬q :=
  fun h : ¬(p → q) =>
  Or.elim (em p)
  (fun hp =>
    suffices hnq : ¬q from And.intro hp hnq
    show ¬q from
      fun hq => absurd
        (fun _ : p => hq)
        h)
  (fun hnp =>
    have hpq : (p → q) := (fun hp => absurd hp hnp)
    absurd hpq h)

example : (p → q) → (¬p ∨ q) :=
  fun hpq : p → q =>
    Or.elim (em p)
    (fun hp => Or.inr (hpq hp))
    (fun hnp => Or.inl hnp)

example : (¬q → ¬p) → (p → q) :=
  fun h : ¬q → ¬p =>
    Or.elim (em p)
    (fun hp =>
      Or.elim (em q)
      (fun hq => fun _ => hq)
      (fun hnq => absurd hp (h hnq)))
    (fun hnp => fun hp => absurd hp hnp)

example : p ∨ ¬p := em p

example : (((p → q) → p) → p) :=
  Or.elim (em p)
  (fun hp => fun _ => hp)
  (fun hnp =>
    fun h : (p → q) → p =>
      absurd (h fun hp => absurd hp hnp) hnp)

end «3.7. Exercises».ClassicalReasoning

/-!
Prove `¬(p ↔ ¬p)` without using classical logic.
-/
namespace «3.7. Exercises».NotIffNot

variable (p : Prop)

example : ¬(p ↔ ¬p) :=
  fun h =>
    have hr : ¬p → p := h.mpr
    have hnp : ¬p := fun hp => h.mp hp hp
    hnp (hr hnp)

end «3.7. Exercises».NotIffNot
