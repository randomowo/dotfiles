Write or refactor Go tests for the target file(s) provided as arguments. Follow these rules exactly:

**Package**
- Use an external test package: `package <pkg>_test` (e.g., `package httpx_test`, `package contextx_test`, `package journal_test`)

**Structure**
- Use table-driven tests with a `tcases` slice of anonymous structs
- Iterate with `for _, tcase := range tcases { t.Run(tcase.Name, func(t *testing.T) { ... }) }`

**Test case names**
- Format: `key=value` (e.g., `"userId=user-123"`, `"name=Assets:Checking"`, `"panic=true"`)
- Use the primary input identifier as the key
- For empty values use just the key with no value: `"userId="`

**Assertions**
- Use `t.Logf` to log relevant values before failing (e.g., `t.Logf("expected=%s, got=%s", expected, actual)`)
- Use `t.Error` (not `t.Errorf`) when the message has no format verbs
- Use `t.Errorf` only when the message itself contains format verbs
- Use `errors.AsType[T](err)` for typed error assertions
- Use `return` after error assertions inside `t.Run` when subsequent checks would be invalid

**Mocking**
- Use GoMock (`go.uber.org/mock/gomock`) for mocking interfaces
- Create controllers with `gomock.NewController(t)` (no manual `ctrl.Finish()` needed with `t`)
- Always use generated GoMock mocks — never implement interfaces manually in tests
- If mocks for a required interface do not exist, create `<pkg>/mocks/<name>.gen.go` following the generated mock pattern (see existing `*.gen.go` files)
- Add `//go:generate go tool mockgen -package mocks -destination mocks/<file>.gen.go -source <source>.go <Interface>` at the top of the test file for each mocked interface
- For `ProviderDependencies`-style interfaces, mock them with `MockProviderDependencies` and use `.EXPECT().MethodName().Return(...)` — do not build concrete helper structs

**Logging**
- Use `slog.New(slog.DiscardHandler)` when a logger is needed in tests

**HTTP handler tests**
- Register routes via the handler's `RegisterPublicRoutes` (or equivalent) on a real `http.NewServeMux()` — do not call handler methods directly
- Always include `WantBody []byte` in the test case struct alongside `WantStatus int`
- Assert both status and body in every test case:
  ```go
  if rw.Code != tcase.WantStatus {
      t.Logf("expected=%d, got=%d", tcase.WantStatus, rw.Code)
      t.Error("unexpected status code")
  }
  if !bytes.Equal(rw.Body.Bytes(), tcase.WantBody) {
      t.Logf("expected=%s, got=%s", tcase.WantBody, rw.Body.Bytes())
      t.Error("unexpected response body")
  }
  ```
- Body values per response type:
  - Success with data → `json.Marshal(result)` (pre-compute above the `tcases` slice)
  - No body (204 No Content, context-canceled early return) → `[]byte{}`
  - Bad request → `httpx.BadRequestBody("...")`
  - Not found → `httpx.NotFoundBody("...")`
  - Conflict → `httpx.ConflictBody("...")`
  - Internal error → `httpx.InternalErrorBody()`

**Arguments:** $ARGUMENTS
