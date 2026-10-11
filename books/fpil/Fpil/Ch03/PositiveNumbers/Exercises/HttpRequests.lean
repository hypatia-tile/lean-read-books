/-!
# 3.1. Positive Numbers — Exercise: HTTP Requests

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Positive-Numbers/>

An HTTP request begins with an identification of an HTTP method, such as
`GET` or `POST`, along with a URI and an HTTP version.

- Define an inductive type that represents an interesting subset of the HTTP
  methods.
- Define a structure that represents HTTP responses, with a `ToString`
  instance that makes it possible to debug it.
- Use a type class to associate different `IO` actions with each HTTP method.
- Write a test harness as an `IO` action that calls each method and prints
  the result.
-/
namespace «3.1. Positive Numbers».Exercises.HttpRequests

end «3.1. Positive Numbers».Exercises.HttpRequests
