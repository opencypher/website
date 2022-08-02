---
layout: post
categories: articles
title:  "The Summer of Syntax: MANDATORY MATCH"
date:   2017-07-17
author: "Petra Selmer"
excerpt: "In this article, we describe the new MANDATORY MATCH clause."
---

---
__Please note that the grammar and TCK currently do not include `MANDATORY MATCH`. __

_During the course of this summer, we’re holding [regular virtual meetings](http://www.opencypher.org/events) in which language changes proposed via Cypher Improvement Requests ([CIRs](https://github.com/opencypher/openCypher/issues?q=is%3Aopen+is%3Aissue+label%3ACIR)) and Cypher Improvement Proposals ([CIPs](http://www.opencypher.org/cips/)) are going to be discussed, and subsequently agreed or rejected._
_The aim of these is to develop Cypher into a true open standard for declarative querying of property graphs._
_The goal is to have in place for our next face-to-face openCypher Implementers Meeting (co-located with Neo4j’s GraphConnect New York conference in late October this year) an extended feature set in Cypher, including (but not limited to) the ability to process multiple graphs, the provision of complex path matching, a way forward for configurable uniqueness behaviour, subqueries, and clearer semantics for aggregation._

---

As announced in the [First oCIG (openCypher Implementers Group) Meeting](http://www.opencypher.org/event/2017/06/22/ocig1/), the decision was taken to add to the language a new variant of the `MATCH` clause, called `MANDATORY MATCH`.
`MANDATORY MATCH` is, in effect, a sibling of the `OPTIONAL MATCH` clause.

We discuss below a motivating use case for `MANDATORY MATCH`, after which we describe how it works, summarise the benefits and conclude with some related considerations.

---

## Resources

* The [CIP](https://github.com/opencypher/openCypher/blob/master/cip/1.accepted/CIP2016-01-26-mandatory-match.adoc), authored by _Stefan Plantikow_ (Neo4j)
* Supplementary [slides](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim2/slides/10-00+MANDATORY+MATCH+%5BDONE%5D.pdf)

---

## Motivation


A frequent use case in many applications is one in which there is an expectation that a particular node, identified by some unique id, exists in the graph.
This node is usually used as a starting point, from which traversals are undertaken to retrieve related information.

For example, assume we have the following query, called __Query 1__, running as part of a recommendations application:

~~~~
MATCH (u:User {id: $user})
MATCH (old:Product {id: $product})<-[:BOUGHT]-(u)
MATCH (store)-[:IN]->(c:City {name: $city}),
    (store)-[:SELLS]->(new:Product),
    (new)-[:MADE_BY]->(brand)<-[:MADE_BY]-(old)
WHERE new.availability > 0 AND new.category = old.category
RETURN store, count(DISTINCT new) AS offers
ORDER BY offers
~~~~

For the user identified by `$user`, __Query 1__ returns all stores in the city (given by `$city`) offering products that are in stock from the same brand and category as the product (given by `$product`) which was purchased by the user.

__Query 1__ may not return any results for perfectly valid reasons, such as the following:

* all products having the same brand and category as `$product` may be out of stock, and
* there may be no stores in the city given by `$city`.


The expectation is very clear that a node ought to be found for each of the patterns `(u:User {id: $user})`, `(old:Product {id: $product})` and `(c:City {name: $city})`.
At least one node needs to be found and subsequently bound for each of these in order for __Query 1__ to return any results.

So, if it turns out that __Query 1__ returns no results because no nodes were found for one or more of these patterns, this means that __Query 1__ was written incorrectly to begin with, or there is some error in the application itself, which is, for instance, generating or passing invalid parameter values for the user, product or city.
The outcome of all of this with regards to our recommendations application is that because of bad input or erroneous queries -- rather than no matching data in the graph -- no recommendations are ever made to users, potentially leading to lost revenue.

In complex domains, it is all too easy to introduce such 'invisible' errors without being aware of them, and for applications to continue silently to fail to function as expected.

There are workarounds to detect these situations.
For example, the following code could be written to ensure the validity of the value for `$user` in our recommendations application:

~~~~
val user = ...
session.run(
    "MATCH (u:User {id: $user}) RETURN u",
    Map("user" -> user)
).single() // <- This fails if no user is found
~~~~

In practice, however, this is very inefficient for the following reasons:

* extra round trip(s) are made from the application to the database, increasing the amount of traffic,
* there is increased latency of the application owing to the extra validation and checking of data,
* extra validation code needs to be written and executed,
* the complexity of the application is increased,
* more tests are required to be written, and
* the expectation of the query is not immediately obvious; i.e. it is not obvious that contained within the query is the assumption that it must match an _existing_ user.


Thus, for these sorts of common scenarios, it would be very useful (i) to be able to identify which matches fail to return any results, and (ii) in the event of these matches returning no results, having these queries failing as soon as possible.
In other words, having the capability of errors being raised when certain data is not found in the graph (such as `$user`, `$city` and `$product` from __Query 1__) would be of great benefit to a developer.

---

## How MANDATORY MATCH works


`MANDATORY MATCH`, a new variant of the `MATCH` clause, comes to the rescue by allowing the author of a query to force a match in the cases where there is an expectation of matching at least one node complying with a given pattern, enabling implicit query validity checking; i.e `MANDATORY MATCH <pattern>` will cause a query to fail when `pattern` does not produce at least one result.
This means it is now possible to raise appropriate errors when the query itself contains invalid portions, such as non-existent parameter values.
In all other aspects, however, `MANDATORY MATCH` works in the same way as `MATCH`.

Returning to our recommendations example, let's take a look at __Query 2__, which is a rewritten version of __Query 1__ using `MANDATORY MATCH`:

~~~~
MANDATORY MATCH (u:User {id: $user})
MANDATORY MATCH (c:City {name: $city})
MANDATORY MATCH (old:Product {id: $product})<-[:BOUGHT]-(u)
MATCH (store)-[:IN]->(c),
    (store)-[:SELLS]->(new:Product),
    (new)-[:MADE_BY]->(brand)<-[:MADE_BY]-(old)
WHERE new.availability > 0 AND new.category = old.category
RETURN store, count(DISTINCT new) AS offers
ORDER BY offers
~~~~

`MANDATORY MATCH` instead of `MATCH` is used in the first three lines, in which all the data that is supposed to be in the graph is queried with the expectation of finding the particular user, city and product identified by `$user`, `$city` and `$product`, respectively.
This means that any errors with these properties will cause the query to fail immediately.

It is perfectly acceptable to interleave `MANDATORY MATCH` and `MATCH` statements, but the intuition is that it is best practice to put all `MANDATORY MATCH` statements first for easier query readability.

---

## Benefits

`MANDATORY MATCH` confers the following benefits:

* Developers get a powerful new facility for detecting semantic errors in their applications, failing early in the case of an error.
* Unnecessary round-trips to the database in order to check for the presence of mandatory data are avoided, leading to decreased application latency.
* Extra validation code to check for the presence of mandatory data is no longer required, leading to decreased application complexity and verbosity, and increased application maintainability.
* The expectation of a query (insofar as which portions of the data are expected to be present) is made much more obvious from the outset, leading to a better encapsulation of domain knowledge within the query.

---

## Auxiliary considerations

At the [oCIG Meeting](http://www.opencypher.org/event/2017/06/22/ocig1/), _József Marton_ (Budapest University of Technology and Economics), raised the question of what the semantics would be in the following query, given a graph with two `:Person` nodes, only one of which is linked to an `:Address` node:

~~~~
MATCH (p:Person)
MANDATORY MATCH (p)-[:HAS]-(a:Address)
RETURN p, a
~~~~

_Stefan Plantikow_ (Neo4j) responded that the query would in fact succeed, as there is one `:Person` linked to an `:Address`.

This underscores the fact that the primary intention of `MANDATORY MATCH` is not to undertake error-checking of complex patterns, but instead to find individual nodes.
However, this notion may be worth exploring as an extension to `MANDATORY MATCH` at a future date.
Moreover, we anticipate that this scenario would be better dealt with using subqueries, which will be presented and discussed at the [Sixth oCIG Meeting](http://www.opencypher.org/event/2017/10/19/ocig6) in September 2017.


In addition, we note that the CIP does not include a mechanism to identify precisely _which_ `MANDATORY MATCH` clause failed (when there is more than one of these in a query); i.e. the ability to specify different errors for say, when a `user` is not found compared to a `city`, is not defined.
This facet is part of a much larger topic of error management, which will be covered in a future proposal.
