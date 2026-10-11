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

inductive HttpMethod where
  | get
  | post
  | delete

inductive HttpVersion where
  | «HTTP/1.0»
  | «HTTP/1.1»
  | «HTTP/2»
  | «HTTP/3»

inductive HttpRespStatus where
  | «200»
  | «201»
  | «204»

structure HttpResponse where
  version : HttpVersion
  status : HttpRespStatus

class Request (m : HttpMethod) where
  send : String → HttpVersion → IO HttpResponse

def HttpVersion.toString : HttpVersion → String
  | «HTTP/1.0» => "HTTP/1.0"
  | «HTTP/1.1» => "HTTP/1.1"
  | «HTTP/2» => "HTTP/2"
  | «HTTP/3» => "HTTP/3"


def HttpRespStatus.toString : HttpRespStatus → String
  | «200» => "200 OK"
  | «201» => "201 Created"
  | «204» => "204 No Content"

instance : ToString HttpVersion where
  toString := HttpVersion.toString

instance : ToString HttpRespStatus where
  toString := HttpRespStatus.toString

instance : ToString HttpResponse where
  toString resp := toString resp.version ++ " " ++ toString resp.status

instance : Request .get where
  send uri v := do
    IO.println s!"GET {uri} {v}"
    return ⟨v, .«200»⟩

instance : Request .post where
  send uri v := do
    IO.println s!"POST {uri} {v}"
    return ⟨v, .«201»⟩

instance : Request .delete where
  send uri v := do
    IO.println s!"DELETE {uri} {v}"
    return ⟨v, .«204»⟩

def testHarness : IO Unit := do
  IO.println (← Request.send (m := .get) "/index.html" .«HTTP/1.1»)
  IO.println (← Request.send (m := .post) "/posts" .«HTTP/1.1»)
  IO.println (← Request.send (m := .delete) "/posts/1" .«HTTP/1.1»)

/--
info: GET /index.html HTTP/1.1
HTTP/1.1 200 OK
POST /posts HTTP/1.1
HTTP/1.1 201 Created
DELETE /posts/1 HTTP/1.1
HTTP/1.1 204 No Content
-/
#guard_msgs in
#eval testHarness

end «3.1. Positive Numbers».Exercises.HttpRequests
