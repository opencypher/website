---
layout: post
categories: blog
title:  "The Summer of Syntax: Aggregation and grouping"
date:   2017-07-27
author: "Petra Selmer"
excerpt: "We describe issues with the current aggregation and grouping semantics in Cypher, and discuss approaches to address these."
---

---

_During the course of this summer, we’re holding [regular virtual meetings](http://www.opencypher.org/ocig) in which language changes proposed via Cypher Improvement Requests ([CIRs](https://github.com/opencypher/openCypher/issues?q=is%3Aopen+is%3Aissue+label%3ACIR)) and Cypher Improvement Proposals ([CIPs](http://www.opencypher.org/cips/)) are going to be discussed, and subsequently agreed or rejected._
_The aim of these is to develop Cypher into a true open standard for declarative querying of property graphs._
_The goal is to have in place for our next face-to-face openCypher Implementers Meeting (co-located with Neo4j’s GraphConnect New York conference in late October) an extended feature set in Cypher, including (but not limited to) the ability to process multiple graphs, the provision of complex path matching, a way forward for configurable uniqueness behaviour, subqueries, and clearer semantics for aggregation._

---

As mentioned in the [Executive Summary](http://www.opencypher.org/blog/2017/07/14/ocig1-exec-summary-blog/) for the [First oCIG (openCypher Implementers Group) Meeting](http://www.opencypher.org/ocig1), there was a discussion on the potentially confusing behaviour of aggregation and grouping in Cypher today, along with strategies for improvement.

We provide below a description of the problems in the existing aggregation and grouping semantics, and then [present various approaches](#unambiguous-semantics) to address these.
As an ancillary consideration, a proposal to [distinguish between standard and aggregating functions](#distinguish-functions) is also discussed, and we conclude by considering the steps necessary to include this in a clear aggregation story for Cypher.

---

## Unclear aggregation semantics in Cypher today

The potentially confusing semantics of aggregation and grouping which currently exists in the Neo4j implementation of Cypher was initially raised at the [First oCIM in February 2017](http://www.opencypher.org/event/2017/02/08/event-ocim1/) by _Jan Posiadała_ (Scott Tiger), and is exemplified by the following simple scenario (example courtesy of Jan):

Assume we have the graph given by:

~~~~
CREATE (:L {a: 1, b: 2, c: 3})
CREATE (:L {a: 2, b: 3, c: 1})
CREATE (:L {a: 3, b: 1, c: 2})
~~~~

The following two queries look equivalent, but actually return very different results:

**Query 1**:

~~~~
MATCH (x:L)
RETURN x.a + count(*) + x.b + count(*) + x.c
~~~~

~~~~
+---------------------------------------+
| x.a + count(*) + x.b + count(*) + x.c |
+---------------------------------------+
| 8                                     |
| 8                                     |
| 8                                     |
+---------------------------------------+
3 rows
~~~~

In this query, non-aggregated values such as `x.a` are interspersed with `count(*)`, an aggregating function.
This results in `x.a` being designated as the _grouping key_, which means that we get an aggregation on `x.a` and a value of `1` for the `count(*)` expression.
As there are three nodes in the graph, three rows are returned.

**Query 2**:

~~~~
MATCH (x:L)
RETURN x.a + x.b + x.c + count(*) + count(*)
~~~~

~~~~
+---------------------------------------+
| x.a + x.b + x.c + count(*) + count(*) |
+---------------------------------------+
| 12                                    |
+---------------------------------------+
1 row
~~~~

In this query, _all_ the non-aggregated values occur before the aggregating function.
This means that the non-aggregated values are grouped together as a single unit: the sum `x.a + x.b + x.c`, which evaluates to the same value `6` across all rows.
This results in `count(*)` evaluating to `3`, and grouping all results into the same group in a single row (with total sum `6 + 3 + 3`).

### Synopsis

The differing results are due to the way Cypher manages grouping using an _implicit_ key.
Consequently, there may be some ambiguity in determining the grouping key for queries having aggregation as part of a more complex expression.
This ambiguity is obviously undesirable: the fact that **Query 1** and **Query 2** behave so differently even though they both return the result of a seemingly simple addition operation (which, mathematically, is commutative) speaks volumes in this regard.

----

<div class="abstract-anchor" id="unambiguous-semantics"></div>

## Proposals for unambiguous aggregation semantics

_Tobias Lindaaker_ (Neo4j) began by giving a [presentation](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocig1/Improving+Aggregations+in+Cypher.pdf) on his ideas about how to resolve the ambiguous semantics.

Tobias proposed that aggregation should always be forced to be a top-level expression, which will make it much easier to see what the grouping key is, and as a result, to understand the intention of such a query.
Queries can be rewritten to this form using `WITH`.

Let's see how **Query 1** and **Query 2**, introduced earlier, can be rewritten with Tobias' approach in mind:

**Query 1A**: (the rewritten form of **Query 1**)

~~~~
MATCH (x:L)
WITH x, count(x) AS c
RETURN x.a + x.b + x.c + c
~~~~

~~~~
+---------------------+
| x.a + x.b + x.c + c |
+---------------------+
| 8                   |
| 8                   |
| 8                   |
+---------------------+
3 rows
~~~~

**Query 2A**: (the rewritten form of **Query 2**)

~~~~
MATCH (x:L)
WITH x.a + x.b + x.c AS v, count(x) AS c
RETURN v + c + c
~~~~

~~~~
+-----------+
| v + c + c |
+-----------+
| 12        |
+-----------+
1 row
~~~~

_Stefan Plantikow_ (Neo4j) asked whether any considerations were given to making the rule more flexible; for instance, allowing the aggregating functions to be interspersed with constant expressions provided that there were no data flow dependencies.
Tobias stated that it was better to have a clear simple rule that is always applied, as this will be easier for query writers.

The next part of Tobias' presentation concerned syntax differentiation between aggregating functions and standard functions, which we'll discuss in the [next section](#distinguish-functions).

----

_József Marton_ (Budapest University of Technology and Economics) was up next, giving a [presentation](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim2/slides/oCIM2_aggregation_JozsefMarton.pdf) on the [CIR](https://github.com/opencypher/openCypher/issues/219) detailing the semantics for the selection of a grouping key for aggregations.

József's ideas are two-fold:

_Option 1_:

The grouping key is essentially a tuple composed of all the variables appearing outside the aggregate function in a `RETURN` or `WITH` clause, where the variables could be nodes, relationships, properties on either of these, previously-bound variables, or, indeed, any kind of expression (such as list subscripts, boolean conjunctions, `IS NOT NULL` and so on).
For example, in `RETURN n.weight * sum(n.value)`, `n.weight` would be the grouping key.
This is clear in all situations and guarantees consistent behaviour, but would obviously change the current behaviour.

_Option 2_:

The idea here is to make a clear distinction between items returned by aggregations, and ones which are not.
Each item in `RETURN` or `WITH` would be forced to either contain no aggregating functions, or only a single aggregating function at the top level.
If this approach is taken, the grouping key is a tuple built from the items with no aggregates, which is consistent with the standard notion of grouping semantics and with the approach proposed above by Tobias, which József stated was his favoured way forward, especially within the context of the [syntax differentiation proposal](#easy-differentiation-proposal).

----

Jan [presented](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim2/slides/GrupingSemantics_SP_1645_SoCIM_JP_MR.pdf) next, also focusing on the [CIR](https://github.com/opencypher/openCypher/issues/219) detailing the semantics for the selection of a grouping key for aggregations.
He stated that _Option 1_ has strong disadvantages in that by not knowing what the grouping key is from the outset, it would not be straightforward or even possible to determine what the leaf in the expression tree would be.
On the other hand, _Option 2_ is essentially a step back from an implicit group by, a feature in Cypher today which he considers very useful.

Jan's approach -- _Option 3_ -- is to 'rescue' the implicit group by through the mechanism of replacing grouping functions with neutral values being occurrences of aggregations; for example, replacing the expression `a + count(*) + b * count(*) + c ` with `a + 0 + b * 1 + c`.
These then become the grouping key.

----

Stefan ended this part of the session with a talk on the [CIR](https://github.com/opencypher/openCypher/issues/183) regarding supporting the calling of aggregating functions on lists in expressions.
He emphasized that the CIR is not intended to address directly the issue of the confusion around aggregation semantics, but ought rather to be considered as an adjunct to aggregation in general, owing to the extensive usage of lists in Cypher.
The upshot is that the ability to invoke aggregating functions within the context of a list seems like a useful feature, and he would very much welcome feedback and further ideas in this area.

On the back of this, _Hannes Voigt_ (the Technical University of Dresden) asked to what extent will functional programming concepts be incorporated into Cypher's expression sublanguage.
Stefan responded by stating that if enough users wanted to see a particular feature in the language, then that was a reasonably strong incentive for its inclusion, especially given that the expression sublanguage is not a huge concern when it comes to query planning.
Moreover, if a user were to use a powerful expression, it would be taken as a given that this could exhibit non-terminating properties.
By not making any provision for such features in the language, users will in all likelihood attempt to replicate it in their own user-defined procedures and user-defined functions.
A good strategy is to ensure that much careful thought and consideration is given when adding these features in the future.
Stefan concluded by saying that although there is definitely a hint of functional programming woven into the fabric of Cypher, there are no immediate plans to strengthen or align this further.

----

<div class="abstract-anchor" id="distinguish-functions"></div>

## Distinguishing between standard functions and aggregating functions

Another issue arises when combining so-called 'standard' functions (such as `length()`) and aggregating functions in an expression, in that it may not be obvious to the reader of a query as to which is the aggregating function amd which is the standard function.

Let's look at two example queries:

**Query 3**:

~~~~
MATCH (n:Device)-->()
RETURN n.status, min(n.cost)
~~~~

As **Query 3** uses the `min()` function. which is aggregating, it will return one row per value of the `n.status` expression.

**Query 4**:

~~~~
MATCH (n:Device)-->()
RETURN n.status, sin(n.cost)
~~~~

As `sin()` is a standard function, no aggregations will occur, resulting in **Query 4** returning one row per match of the pattern `(n:Device)-->()`.

### Synopsis

It's easy to see that the readability and comprehension are compromised for queries in which both these types of functions are used within the same expression.
The CIR outlining this problem can found [here](https://github.com/opencypher/openCypher/issues/188).

---

<div class="abstract-anchor" id="easy-differentiation-proposal"></div>

## A proposal for easier differentiation between standard and aggregating functions

Tobias [presented](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocig1/Improving+Aggregations+in+Cypher.pdf) his proposal, in which he suggests [new syntax](https://github.com/opencypher/openCypher/pull/218) making it very easy for readers (and writers) of queries to differentiate between aggregating functions and standard functions.

Let's see how these syntactic changes alter **Query 3** (we reproduce it here so it's easier to compare the versions):

**Query 3**: (original syntax)

~~~~
MATCH (n:Device)-->()
RETURN n.status, min(n.cost)
~~~~

**Query 3A**: (the rewritten form of **Query 3**)

~~~~
MATCH (n:Device)-->()
RETURN n.status, min OF n.cost
~~~~

There are some aggregating functions that take multiple arguments.
The proposed syntax elegantly handles these cases too, as we can see in the following examples.

Here is a query using the original syntax:

~~~~
MATCH (n:Person)
RETURN percentileCont(n.age, 0.4)
~~~~

Here is the same query using the proposed syntax:

~~~~
MATCH (n:Person)
RETURN percentileCont(0.4) OF n.age
~~~~

Tobias concluded this segment of his presentation with the following thoughts:

* Even though his syntax proposal deviates from the existing syntax which resembles that used in SQL, it is a good deviation as it improves query readability.
* His syntax proposal is only one idea, and other suggestions are very welcome.

Hannes asked whether any thought had been given as to how to transition a product using the current syntax to the proposed syntax, given that it was undesirable to break existing queries.
Tobias responded by saying that existing transition processes ought to be used; i.e. if one doesn't wish to migrate the query immediately, one could specify a previous Cypher version to be used when executing the query up to the point when the query can be migrated.

Assuming the syntax proposal is accepted, rendering the current syntax 'old', _Alastair Green_ (Neo4j) wondered whether there were any circumstances where a query could be converted automatically from the old syntax to the new syntax.
Tobias reckoned that this would definitely be possible.

To conclude, a number of points were raised regarding the acceptability and/or desirability of Cypher deviating from SQL as it evolves.
Would this hinder the adoption of Cypher, or make it harder to learn or use Cypher?
It turns out there is no definitive 'right' answer to this.
The prevailing attitude is to be very conservative with departures from SQL, and only deviate if there are very compelling reasons to do so -- as exemplified by the case of syntax differentiation between aggregating functions and standard functions.
One way of not being forced to make a trade-off is to allow both variants in the language, even though this is a situation we usually try to avoid in Cypher.

---

## Next steps

It was agreed that more work needed to be done in this area before we could consider making changes to the aggregation semantics.
There was unanimous agreement for the approach concerning the adoption of only allowing aggregating functions as a top-level construct.
Hannes stated that _all_ aspects of aggregation need to considered -- semantics, syntax, aggregations in lists -- in a unified manner, in order to ensure a strong foundation.

The next action to take will be for a single CIP to be produced, specifying very clearly and in detail the complete and consistent semantics and syntax of aggregations and grouping as a whole, with the aim of being able to be discussed and potentially accepted at a forthcoming meeting.
The CIP will be worked on by Jan, József, Mats Rydberg (Neo4j), Tobias and Stefan.
