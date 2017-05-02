---
layout: post
title:  "Reflecting on oCIM 1"
date:   2017-03-23
author: "Mats Rydberg & Petra Selmer"
excerpt: "The First openCypher Implementers Meeting was a great success, with over 30(?) participants from many interested database or database-affiliated companies, all with a common ground of graphs."
---
# Introduction

The conference was held in Walldorf, Germany, in SAP's quarters.
Blah blah the weather was nice.

<img src="{{ site.baseurl }}/public/images/ocim1_meeting_room.jpg" width="400" height="268" />

# What happened

The conference was opened by Alastair Green, product manager at Neo Technology with responsibility for development of Cypher, and the openCypher project.
The message that was given was that the goal of the whole openCypher initiative is to craft the standard graph query language, taking base in Cypher as it stands today, and evolving it via an open process, where many vendors or implementers are invited to be active participants.

Immediately turning concrete, Neo's Mats Rydberg gave an overview of the library of shared artifacts that had already been put under the openCypher umbrella, specifically the ideas around a shared grammar and verifiable test kit.
Next Marcus Paradies from SAP presented how they've injected Cypher into their HANA Graph stack, detailing how SAP has modelled graphs onto their relational system and mentioning some of the shortcomings that were encountered.
Specifically, Marcus highlighted the importance of compositionality within the language, and brought up two of the conference's larger topics: pattern matching semantics, and multiple graphs.

Later during the day, Neo's Stefan Plantikow and Oracle's Oskar van Rest both presented problem descriptions relating to Cypher's pattern matching semantics, and what other options exist.
Stefan also presented solution ideas for future evolution, in which the language would expose several options for semantics to users, effectively enabling all advantages to users at their choosing.

After Marcus' presentation, Dmitry Vrublevsky from Irish(?) Neueda presented and demonstrated the Cypher developer tool that they have been building as a plugin for the popular JetBrains family of IDEs.
So far, the plugin had over 11,000 downloads, and Dmitry showcased its syntax highlighting, refactoring and error reporting features.

Just before the first coffee break, Gábor Szárnyas and József Marton from Budapest University of Technology and Economics took the audience through their research project of incremental query execution on graphs.
The example model of a railroad network seemed to resonate well, and the extensive work on mapping Cypher onto relational algebra (with special extensions) impressed.
The session ended with a list of challenging parts of the language, which included list handling, aggregations and the default bag semantics that are in effect when not using `DISTINCT`.

Both Gábor and József as well as Dmitry had already been directly involved in the openCypher project, raising issues, providing pull requests and discussing various topics, mostly related to the grammar specification.

---

Andres Taylor from Neo started the next session by describing how Cypher has been (and is) implemented in Neo4j, for and from which the language has been grown.
After a brief look on Cypher's history, Andres gave in-depth description of the cost-based query planner, the algorithm it is based on, and peeked at Neo4j's new Cypher runtime, which runs on generated code.

Next up was Roi Lipman from Redis Labs, who explained how he had developed the Redis graph module based on a hexastore model, where node-relationship-node triplets were stored in six permutations to enable fast prefix-based searches.

One idea that had come up during prior meetings with several interested parties was that of a shared standard of internal graph query representation, possibly compiled from several distinct source languages.
Stefan Plantikow gave an insight to how Neo and the Cypher Language Group had been thinking about such a model, called QUIL (Query Intermediary Language).

Tomasz Zdybał from Czech Dgraph Labs presented Dgraph, an in-memory native graph database, and their implementation of a graph query language based on Facebook's GraphQL in their product.
Tomasz highlighted Dgraph's intentions of adding support for Cypher, and how schema validation was an important topic.

Just before lunch, Alastair Green took the floor again, standing in for BitNine, the Korean company behind Agens Graph, discussing how Cypher, SQL, and other query languages may be integrated with one another.
BitNine were originally scheduled for attendance at the oCIM, but had to decline, as the Central European location was unfit given time their time constraints.
Alastair went through slides by Kisung Kim from BitNine, detailing the hybrid relational/graph architecture of Agens Graph, which is based on PostgreSQL.
The most highlighted contribution was the way in which BitNine had introduced integration points between SQL and Cypher, allowing each as a subquery construct to the other, and how functions may be shared as expressions between the languages.

---

The lunch break paved way for the big topic previously brought up by Marcus Paradies of SAP in the morning: multiple graphs.
Cypher has always been a language that operates on a single implicitly understood graph, and producing a stream or records as output (the collection of which effectively form a table).
Alastair Green discussed motivations for changing this model to make Cypher a language _closed over graphs_, sketching out a future where Cypher would come to operate on a multitude of graphs, and also producing a multitude of graphs as output.
Alastair touched on important subtopics such as identity, addressing, and how compositions of graphs from distinct sources may be defined.

Stefan Plantikow led a longer session on the very topic, presenting his latest thinking on how Cypher can be remodeled towards a graph-in-graph-out paradigm.
Stefan deep-dove into the motivations, but the focus was put on how the concept of multiple graphs could be made logically consistent, and how the execution model could be extended, while still paying respects to Cypher's sizable user base and imposing breaking change in semantics.
One of Stefan's main ideas was the re-interpretation of Cypher's result records as graph-records, or 'g-records' (should we retro-actively amend this to mention our new term graphlets?), meaning each binding of a matched subgraph would itself be interpreted as a (typically very small) graph, and the extended ability to collapse/union all such g-records into one large result graph.
Both the g-record model and it's larger sibling would enact Cypher as being _closed over graphs_, as it would be possible to upon retrieval of the result graph(s) immediately issue a new Cypher query, now pattern matching on the newly computed results.
Stefan also gave detailed syntax proposals for how to define and use graphs as values in the context of a query, including a take on the addressing topic raised by Alastair.
It was made clear that this topic is at the top of the minds of several key Cypher innovators.

Before Stefan's dive into multi-graph land, Martin Junghanns from the University of Leipzig presented his research project on implementing Cypher on Gradoop, a graph platform based on Apache Hadoop.
Martin gave us an overview on how their system handled query planning, and the model used to represent (intermediate) query results in the distributed framework, Flink, that queries are executed in.
The project had also featured some interesting extensions to the Property Graph Model, over which Cypher is defined, including a concept of logical subgraphs and a set of graph operations.

Following Martin's talk, Hannes Voigt from the Technical University of Dresden walked us through his research project, in which also Michael Hunger from Neo had participated.
The topic was virtual graphs and views, and featured several intriguing extensions to Cypher, which were expressed as able to cross the concept chasm, which Hannes explained as the different levels of abstraction that users view their data in.
At the lowest level is the pure data, big and raw.
At higher levels, larger patterns start to appear, which are made up of groups of nodes and relationships from the lower levels.
These larger patterns are in the model constructed using virtual nodes and relationships, with the additional ability to define views which provide several interesting qualities, such as performance optimizations and query modularization.

---

The afternoon session was featured two larger sections in which the members of the Cypher Language Group, Neo's internal team responsible for developing Cypher, presented views and ideas on how to address the most prominently mentioned shortcomings of the language in its current form.
Mats Rydberg presented a proposal for a new schema/constraint syntax, and also talked more in-depth on the Technology Compatibility Kit, highlighting its usefulness to verify that a multitude of language implementations are semantically consistent.
Petra Selmer went through the latest thinking on several classes of subqueries, including syntax proposals.
Petra also detailed the revised Cypher improvement process, which has been designed to fit the open, collaborative format intended for the openCypher project.
As mentioned above, Stefan and Oskar discussed semantics of pattern matching, in terms of isomorphism/homomorphism of subgraphs and entities.
Tobias Lindaaker provided insights in how Cypher could complete its support for Conjunctive Regular Path Queries (CRPQs), going through historical thinking as well as recent syntax and semantics proposals.
The topic of vendor-specific extensions, including some of the pitfalls that should be looked out for from experiences with the SQL standard was also presented by Tobias.

The last session also featured Paolo Guagliardo from the University of Edinburgh, who gave us a look into a recent research project on formalising semantics of SQL, and what advantages that a language may be given throug a formal specification.
Paolo also announced the newly started project of producing a formal semantics specification of Cypher, which is to be carried out by his research team, including Nadime Francis and prof. Leonid Libkin.
This project will be carried out during the spring of 2017, and reports of progress will be given at upcoming oCIMs.

## Some reflections

Overall, the meeting was received in a very positive light.

Maybe some code examples or pictures here?

    CREATE VIRTUAL NODE

    CREATE CONSTRAINT <name>
    FOR (n:Label)
    REQUIRE NODE KEY n.p1, n.p2

#### Presentation materials


The programme, complete with all slide material presented during the conference may be found at the [event page for the 1st oCIM](http://localhost:4000/event/2017/02/08/event-ocim1/#program).
