---
layout: post
categories: articles
title:  "Research references and presentations on graph querying"
date:   2017-10-20
author: "Petra Selmer"
excerpt: "We provide an overview of our new <a href='http://www.opencypher.org/references'>References</a> page: a collection of research papers and presentations on the concepts underpinning the current and future versions of Cypher."
---

Most of the core elements we envisage underpinning Cypher in the very near future have their origins in academic research spanning the last few decades.


The new [References](/references) page comprises a list of publications, grouped by topic and listed in ascending date order, so that the lineage of the topic is clearly visible.
The list of publications is by no means exhaustive, as our intention is to show the paper which pioneered the area, and any influential papers that followed.


Underneath the publications is a list of slides and recordings of talks presented at openCypher Implementers Meetings, detailing how these ideas may be brought forward into Cypher.


I will describe each topic briefly to give you an idea of the very broad, challenging and complex -- but highly fascinating -- graph querying landscape, which will inform the evolution of Cypher for a long time to come.

---

Cypher is a _property_ graph query language, and, to this end, we begin with [publications](/references#pgm) describing the property graph model.
Included in this list is novel research undertaken on extensions to the property graph model, such as temporal constructs.


The next topic is [graph querying](/references#rpq), with a focus on aspects that differentiate and elevate graph querying above other forms of querying, namely _regular path queries_ and _graph pattern matching_.
Regular path queries were first proposed by _Cruz, Mendelzon_ and _Wood_  in 1987, and now, thirty years later, we have turned our attention to this topic and how it may be included in Cypher, in the form of _Path Pattern Queries_, or _PPQs_.
PPQs, inspired by recent seminal work by _Libkin, Martens_ and _Vrgoč_, extend RPQs with notions of node and relationship property tests, and are an extremely powerful and expressive mechanism for graph querying.
We see this as an integral part of Cypher, particularly as the need for users to express ever more complex patterns becomes more pressing in the near future.


Cypher itself has been the subject of [recent research](/references/#cypher) in areas such as algebra formalisation, execution strategies and triggers, as well as how to use schema information to optimise the execution of Cypher queries over a relational database.
Innovative research on the implementation of Cypher over a distributed graph processing system -- entitled GRADOOP -- is described by _Junghanns, Kiessling, Averbuch, Petermann_ and _Rahm_.


As Cypher matures, it is natural to consider how to integrate it with the colossus that is SQL.
We introduce some [preliminary thoughts](/references#cypher-sql) on possible directions forward; in particular, a mechanism for SQL to invoke Cypher through the use of a graph query procedure.


Supporting [multiple graphs and graph composition](/references#graph-composition) will form the substrate of graph querying going into the future, with a paper from 2008 by _He_ and _Singh_ introducing the topic.
The GRADOOP system is also the first implementation of multiple graphs.
This year, much work has been carried out on defining how Cypher could support multiple graphs and compositional querying, and underneath the publications is a list of talks on this topic.


Lastly, we end with a section containing [papers](/references#position-papers) covering surveys in the area of graph data management as a whole.
_Angles_ and _Gutierrez_ provide a comprehensive survey of graph database models, dating back over thirty years, and providing a glimpse into the very intriguing early work undertaken on graph-structured data, showing its long and distinguished presence in academic research, and underscoring the fact that the graph data model has been acknowledged as a useful data modelling and querying paradigm for a very long time.
A very recent survey on how graph processing is undertaken in practice -- covering the types of graph data, computations and visualisations, data volumes and scales, software used, and challenges faced - makes for very interesting reading.

---

I hope this quick peek into this fascinating world has whetted your appetite to read about these topics in more detail!


We’d like to continue to provide this as a community service.
Therefore, if you think anything is missing from this page, please raise an issue [here](https://github.com/opencypher/openCypher/issues) and add the label "add link to references".
