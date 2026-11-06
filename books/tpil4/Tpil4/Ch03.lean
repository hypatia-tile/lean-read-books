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
example : p ∧ False ↔ False := sorry
example : (p → q) → (¬q → ¬p) := sorry

end «3.7. Exercises».Constructive

/-!
These require classical reasoning.
-/
namespace «3.7. Exercises».Classical

open Classical

variable (p q r : Prop)

example : (p → q ∨ r) → ((p → q) ∨ (p → r)) := sorry
example : ¬(p ∧ q) → ¬p ∨ ¬q := sorry
example : ¬(p → q) → p ∧ ¬q := sorry
example : (p → q) → (¬p ∨ q) := sorry
example : (¬q → ¬p) → (p → q) := sorry
example : p ∨ ¬p := sorry
example : (((p → q) → p) → p) := sorry

end «3.7. Exercises».Classical

/-!
Prove `¬(p ↔ ¬p)` without using classical logic.
-/
namespace «3.7. Exercises».NotIffNot

variable (p : Prop)

example : ¬(p ↔ ¬p) := sorry

end «3.7. Exercises».NotIffNot
