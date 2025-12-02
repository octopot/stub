---
id: 10
database_id: 2000766232
node_id: I_kwDOKDhGtc53QUUY
status: open
title: "ci/cd: add integration tests"
labels: ["type: improvement","scope: test","scope: inventory","impact: high","effort: easy"]
url: https://github.com/octopot/stub/issues/10
created_at: 2023-11-19T09:14:41Z
updated_at: 2023-11-19T09:14:41Z
---

# ci/cd: add integration tests

**Motivation:** healthcheck.

**PoC**

```bash
#!/bin/bash

# URL to check
url="http://example.com"

# Expected redirect location
expected_redirect="http://example.com/new-location"

# Send a request and extract the actual redirect location
actual_redirect=$(curl -Ls -o /dev/null -w %{url_effective} "$url")

# Compare the actual redirect location with the expected one
if [ "$actual_redirect" = "$expected_redirect" ]; then
    echo "Redirect is correct: $actual_redirect"
else
    echo "Redirect is incorrect: Expected $expected_redirect, but got $actual_redirect"
fi
```
