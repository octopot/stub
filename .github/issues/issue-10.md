---
code: null
id: I_kwDOKDhGtc53QUUY
databaseId: 2000766232
number: 10
url: https://github.com/octopot/stub/issues/10
title: "ci/cd: add integration tests"
issueType: null
labels:
  - "type: improvement"
  - "scope: test"
  - "scope: inventory"
  - "impact: high"
  - "effort: easy"
assignees:
  - kamilsk
milestone: null
parent: null
issueFields: {}
state: OPEN
stateReason: null
duplicateOf: null
createdAt: 2023-11-19T09:14:41Z
updatedAt: 2023-11-19T09:14:41Z
lastEditedAt: null
closedAt: null
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
