---
layout: post
title:  "Reflections on the First openCypher Implementers Meeting"
date:   2017-03-31
author: "Mats Rydberg & Petra Selmer"
excerpt: "The First openCypher Implementers Meeting on 8 February 2017 was a great success, with over 30 delegates from many database and database-affiliated companies and institutions, all with a common interest in graph data and graph querying."
---
# Introduction

The conference was held in Walldorf, Germany, at SAP's headquarters.

<img src="{{ site.baseurl }}/public/images/ocim1_meeting_room.jpg" width="400" height="268" />

_The conference room, featuring Alastair Green making the case for multiple graph querying._

# What happened

The [opening presentation](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/09-30+-+Introduction.pdf) was given by _Alastair Green_, the Product Manager at Neo Technology responsible for the development of Cypher and the openCypher project.
In his talk, Alastair explained that the goal of the openCypher initiative is to craft a standard language for querying graphs, using as a basis Cypher in its current form, and seeking to evolve it via an open process, with the active participation of all interested vendors and implementers.

_Mats Rydberg_, an engineer at Neo Technology, [presented an overview](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/09-45+-+openCypher+artefacts.pdf) of the library of shared artifacts that have been produced and made publicly available under the auspices of openCypher.
He then proceeded to a discussion of ideas around a shared grammar and a verifiable test kit.

<div class="abstract-anchor" id="above"></div>

Next, _Marcus Paradies_, developer at SAP, discussed how they've [injected Cypher](https://blogs.sap.com/2016/12/01/graph-processing-with-sap-hana-2/) into their HANA Graph stack, [detailing how SAP has modelled graphs in their relational system](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/Graph+Pattern+Matching+in+SAP+HANA.pdf), and mentioning some of the shortcomings that were encountered.
In particular, Marcus highlighted the importance of compositionality within the language, and brought up two of the conference's larger topics: pattern matching semantics, and multiple graphs.
[Later in the day](#below), Neo Technology's CLG (Cypher Language Group, the internal Neo Technology team responsible for language development of Cypher) team lead _Stefan Plantikow_ and _Oskar van Rest_, Principal Member of Technical Staff at Oracle, both described problems relating to Cypher's pattern matching semantics, and explored alternatives.

Following on from Marcus' presentation, _Dmitry Vrublevsky_, software engineer at [Neueda](http://www.neueda.com/), [presented and demonstrated](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/Jetbrains_Plugin_-_Graph_Database_support.pdf) the Cypher developer tool that they have been building as a plugin for the popular JetBrains family of IDEs.
As of 8 February 2017, the plugin had over 11,000 downloads, and Dmitry showcased its syntax highlighting, refactoring and error reporting features.

Just before the first coffee break of the day, [_Gábor Szárnyas_](https://inf.mit.bme.hu/en/members/szarnyasg) and [_József Marton_](https://www.tmit.bme.hu/marton.jozsef?language=en), researchers at Budapest University of Technology and Economics, took the audience through [their research project of incremental query execution](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/ocim2017-incremental-opencypher.pdf) on graphs.
The example model of a railroad network resonated well with the audience, as did the extensive work on mapping Cypher onto relational algebra (with special extensions).
The session concluded with a list of challenging components of the language, which include the handling of lists, aggregations and the default bag semantics that are in effect when not using `DISTINCT`.

Both Gábor and József, as well as Dmitry, had already been directly involved in the openCypher project, raising issues, providing pull requests and discussing various topics, mostly related to the grammar specification.

---

_Andrés Taylor_, engineer at Neo Technology, father of Cypher, and former team lead of the CLG, started the next session by [describing how Cypher has been (and is) implemented in Neo4j](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/11-20+-+Neo4j+Cypher+implementation.pdf), for and from which the language has been grown.
After a brief overview of Cypher's history, Andrés described in detail the cost-based query planner, the algorithm it is based on, and ended with a quick look at Neo4j's new Cypher runtime, which runs on generated code.

_Roi Lipman_, software engineer at [Redis Labs](https://redislabs.com/), then gave a [presentation](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/Redis+Graph.pdf) on how he had developed the Redis graph module based on a hexastore model, where node-relationship-node triplets are stored in six permutations to enable fast prefix-based searches.

A concept that has arisen in prior meetings with several interested parties is that of a shared standard of internal graph query representation, possibly compiled from several distinct source languages.
_Stefan Plantikow_ [gave an insight](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/12-00+-+QUIL.pdf) as to how Neo Technology and the CLG had been thinking about such a model, called QUIL (Query Intermediary Language).

_Tomasz Zdybał_, software engineer at [Dgraph Labs](https://dgraph.io/), [presented Dgraph](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/dgraph.pdf), an in-memory native graph database, and the implementation in their product of a graph query language based on Facebook's GraphQL.
Tomasz highlighted Dgraph's intentions of adding support for Cypher, and how schema validation was an important topic.

Just before lunch, _Alastair Green_ took the floor again, standing in for [Bitnine](http://Bitnine.net/) (the Korean company behind Agens Graph, who were unable to attend in person) discussing how Cypher, SQL, and other query languages could be integrated with one another.
Alastair [presented slides authored by Kisung Kim from Bitnine](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/AgensGraph-+SQL+%2B+Cypher+Integration.pdf), detailing the hybrid relational/graph architecture of Agens Graph, which is based on PostgreSQL.
The most significant contribution was the way in which Bitnine had introduced integration points between SQL and Cypher, allowing for each to be passed in as a subquery construct to the other, and how functions may be shared as expressions between the languages.

---

The lunch break paved the way for the big topic previously brought up by _Marcus Paradies_ of SAP in the morning: multiple graphs.
Cypher has always been a language that operates on a single implicit graph, producing a stream of records as output (the collection of which effectively form a table).
_Alastair Green_ [discussed the motivations for changing this model](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/14-00+-+The+Case+for+Multiple+Graph+Querying.pdf) to make Cypher a language _closed over graphs_, envisioning a future where Cypher would be capable of processing multiple graphs provided as input, and producing as output one or more graphs.
Alastair explored salient subtopics such as identity, addressing, and ways of defining compositions of graphs from distinct sources.

Following on from Alastair's talk on the vision of multiple graphs in Cypher, _Stefan Plantikow_ [led a longer session on the topic](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/14-30+Multiple+Graphs-+Evolving+Cypher.pdf), presenting his latest thinking on how Cypher can be remodeled towards a graph-in-graph-out paradigm.
Stefan discussed the motivations from a different angle to those covered by Alastair, focusing on how to make the concept of multiple graphs logically consistent and how to extend the execution model, whilst still keeping in mind Cypher's considerable user base and the cost of imposing breaking change in semantics.
One of the major concepts in Stefan's discussion was the re-interpretation of Cypher's result records as 'g-records' (graph-records, or graphlets), meaning each binding of a matched subgraph would itself be interpreted as a (typically very small) graph, and the extended ability to collapse/union all such g-records into one large result graph.
Both the g-record model and the companion model of the unionised graph would enact Cypher as being _closed over graphs_, as it would be possible to upon retrieval of the result graph(s) immediately issue a new Cypher query, now pattern matching on the newly computed results.
Stefan also gave detailed syntax proposals for how to define and use graphs as values in the context of a query, including a take on the addressing topic raised by Alastair.
It was made clear that this topic is foremost in the minds of several key Cypher innovators.

Before Stefan's dive into the world of multiple graphs, _Martin Junghanns_, researcher at the University of Leipzig, [presented his research project](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/20170208-oCIM-Gradoop.pdf) on implementing Cypher on [Gradoop](http://dbs.uni-leipzig.de/en/research/projects/gradoop), a graph platform based on [Apache Hadoop](http://hadoop.apache.org/).
Martin gave us an overview on how their system handled query planning, and the model used to represent (intermediate) query results in the distributed framework, Flink, in which the queries are executed.
The project also featured interesting extensions to the [Property Graph Model](https://github.com/opencypher/openCypher/blob/master/docs/property-graph-model.adoc), upon which Cypher is based, including the concept of logical subgraphs and a set of graph operations.

Following on from Martin's talk, _Hannes Voigt_, researcher at the Technical University of Dresden, [walked us through his research project](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/openCypher-GraphViews.pdf), in which _Michael Hunger_, community caretaker at Neo Technology, had participated.
The topic comprised virtual graphs and views, and featured several intriguing extensions to Cypher. These were expressed in terms of 'crossing the concept chasm', which Hannes explained as the different levels of abstraction that users view their data in.
At the lowest level of abstraction is the actual raw unprocessed data, which is usually very high in volume.
At higher levels, larger patterns start to appear, composed of groups of nodes and relationships from the lower levels.
These larger patterns are in the model constructed using virtual nodes and relationships, with the additional ability to define views which provide several interesting qualities, such as performance optimizations and query modularization.

---

<div class="abstract-anchor" id="below"></div>

The afternoon session featured two larger sections ([#1](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/15-30+-+Language+Evolution-+Future+Features.pdf) and [#2](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/16-20+-+Language+Evolution-+Conformance+and+Extension.pdf)) in which four of the members of the CLG presented views and ideas on how to address the most prominently mentioned shortcomings of the language in its current form.
_Mats Rydberg_ presented a proposal for a new schema/constraint syntax, and also talked more in-depth on the Technology Compatibility Kit, highlighting its usefulness to verify that a multitude of language implementations are semantically consistent.
_Petra Selmer_ went through the latest thinking on several classes of subqueries, including syntax proposals.
Petra also detailed the revised Cypher improvement process, which has been designed to chime in with the open, collaborative format intended for the openCypher project.
[As mentioned above](#above), _Stefan Plantikow_ and _Oskar van Rest_ discussed ([Oskar's slides](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/cypher_implementers_day_2017_pattern_matching_semantics.pdf)) semantics of pattern matching in terms of isomorphism/homomorphism of subgraphs and entities.
_Tobias Lindaaker_ provided insights as to how Cypher could complete its support for Conjunctive Regular Path Queries (CRPQs), going through historical thinking as well as recent syntax and semantics proposals.
The topic of vendor-specific extensions, including some of the pitfalls that should be looked out for from experiences with the SQL standard, was also presented by Tobias.

The last session also featured [_Paolo Guagliardo_](http://www.research.ed.ac.uk/portal/en/persons/paolo-guagliardo(653c9723-b374-4ad3-9cef-0f7e7f45d812).html), researcher at the University of Edinburgh, who [presented a recent research project on formalising semantics of SQL](https://s3.amazonaws.com/artifacts.opencypher.org/website/ocim1/slides/sql-sem.pdf), and the advantages conferred on a language through the provision of a formal specification.
Paolo also announced the recently begun project of producing a formal semantics specification of Cypher, which is to be carried out by his research team, including [_Nadime Francis_](https://www.inf.ed.ac.uk/people/staff/Nadime_Francis.html) and Professor [_Leonid Libkin_](http://homepages.inf.ed.ac.uk/libkin/).
This project will be undertaken during the spring of 2017, and reports of progress will be given at upcoming oCIMs.

---

All in all, the meeting was a resounding success, and we look forward to many more in the future, starting with the 2nd oCIM already on May 10th, this time in London.
Please do reach out to us at <openCypher@neotechnology.com> if you are interested, and be sure to check out the [event page for the 2nd oCIM](/event/2017/05/10/event-ocim2/) for further details.

### Presentation materials

The programme, complete with all slide material presented during the conference may be found at the [event page for the 1st oCIM](/event/2017/02/08/event-ocim1/#program).
