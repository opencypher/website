---
layout: post
categories: blog
title:  "The Summer of Syntax: Executive Summary of the First openCypher Implementers Group Meeting"
date:   2017-07-14
author: "Petra Selmer"
excerpt: "In the first of a series of virtual meetings being held during the summer of 2017, we agreed upon the introduction into Cypher of a new clause called MANDATORY MATCH, and discussed approaches to improve the aggregation and grouping semantics."
---

---

_During the course of this summer, we’re holding [regular virtual meetings](http://www.opencypher.org/ocig) in which language changes proposed via Cypher Improvement Requests ([CIRs](https://github.com/opencypher/openCypher/issues?q=is%3Aopen+is%3Aissue+label%3ACIR)) and Cypher Improvement Proposals ([CIPs](http://www.opencypher.org/cips/)) are going to be discussed, and subsequently agreed or rejected._
_The aim of these is to develop Cypher into a true open standard for declarative querying of property graphs._
_The goal is to have in place for our next face-to-face openCypher Implementers Meeting (co-located with Neo4j’s GraphConnect New York conference in late October) an extended feature set in Cypher, including (but not limited to) the ability to process multiple graphs, the provision of complex path matching, a way forward for configurable uniqueness behaviour, subqueries, and clearer semantics for aggregation._

---

The [First oCIG (openCypher Implementers Group) Meeting](http://www.opencypher.org/ocig1) was held on Thursday 22 June 2017, and we were delighted to welcome a wide range of attendees.

The major outcome was the acceptance by the oCIG of a new clause into Cypher, called [`MANDATORY MATCH`](https://github.com/opencypher/openCypher/pull/212).
This is a new variant of the `MATCH` clause, which will cause a query to fail if no matching data is found in the underlying graph, and the purpose is to allow for easier query validation.

`MANDATORY MATCH <pattern>` allows the author of a query to force a match in the cases where there is an expectation of matching at least one node complying with `<pattern>`, enabling implicit query validity checking.
Errors in the writing of the query itself -- such as invalid/non-existent parameter values -- will raise an appropriate exception.

`MANDATORY MATCH` confers the following benefits:

* Developers get a powerful new facility for detecting semantic errors in their applications, failing early in the case of an error.
* Unnecessary round-trips to the database in order to check for the presence of mandatory data are avoided, leading to decreased application latency.
* Extra validation code to check for the presence of mandatory data is no longer required, leading to decreased application complexity and verbosity, and increased application maintainability.
* The expectation of a query (insofar as which portions of the data are expected to be present) is made much more obvious from the outset, leading to a better encapsulation of domain knowledge within the query.

---

Aggregation and grouping was also discussed at the meeting. Currently, the semantics are confusing and ill-defined, leading to unexpected behaviour under some circumstances.
A number of approaches to address this issue were discussed.
Under consideration was a proposed syntactical change allowing for far easier differentiation between aggregating functions (such as `count()`), and standard functions (such as `length()`) to improve query readability.

---

The `MANDATORY MATCH` clause, as well as the issues and proposed solutions regarding aggregation and grouping, will be discussed in detail in forthcoming blog posts.
