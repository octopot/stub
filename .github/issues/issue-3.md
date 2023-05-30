---
code: null
id: I_kwDOKDhGtc5uLlw1
databaseId: 1848532021
number: 3
url: https://github.com/octopot/stub/issues/3
title: "feat: use dynamic config instead of static"
issueType: null
labels:
  - "type: feature"
  - "scope: code"
  - "scope: deps"
  - "scope: inventory"
  - "impact: high"
  - "effort: medium"
assignees:
  - kamilsk
milestone: null
parent: null
issueFields: {}
state: CLOSED
stateReason: NOT_PLANNED
duplicateOf: null
createdAt: 2023-08-13T10:38:51Z
updatedAt: 2023-10-10T18:47:45Z
lastEditedAt: 2023-08-13T10:40:20Z
closedAt: 2023-10-10T18:47:45Z
---

# feat: use dynamic config instead of static

**Motivation:** it allows to avoid redeploying process and improves service maintenance.

**Candidates**

- https://doc.traefik.io/traefik/providers/consul/
- https://doc.traefik.io/traefik/providers/etcd/
- https://doc.traefik.io/traefik/providers/http/
- https://doc.traefik.io/traefik/providers/consul-catalog/

<!-- 2023-10-10T18:47Z https://github.com/octopot/stub/issues/3#issuecomment-1756038401
won't do because I split dynamic config https://github.com/octomation/stub/tree/main/traefik/dynamic
-->
