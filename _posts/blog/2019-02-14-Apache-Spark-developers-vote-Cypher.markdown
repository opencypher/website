---
layout: post
categories: blog
title:  "Apache Spark developers vote for Cypher in Spark 3.0"
date:   2019-02-14
author: "Alastair Green (Lead, Query Languages Standards and Research Group at Neo4j)"
excerpt: "As part of the preparations for a forthcoming Spark 3.0 release, the Apache Spark development community has just completed a positive vote for a Spark Project Improvement Proposal to add Property Graphs based on DataFrames to Spark. Based on the achievements of the ongoing Cypher for Apache Spark project, Spark 3.0 users will be able to use the well-established Cypher language for graph query processing, as well as having access to graph algorithms stemming from the GraphFrames project."
---

## Community vote by Spark contributors just closed

As part of the preparations for a forthcoming Spark 3.0 release, the Apache Spark development community has just [completed a positive vote](https://community.neo4j.com/t/feedback-requested-on-proposal-for-spark-cypher-in-spark-3-0/4431/4?u=alastair.green) for a [Spark Project Improvement Proposal](https://issues.apache.org/jira/browse/SPARK-25994) to add Property Graphs based on DataFrames to Spark. 
Based on the achievements of the ongoing [Cypher for Apache Spark project](https://github.com/opencypher/cypher-for-apache-spark), Spark 3.0 users will be able to use the well-established Cypher language for graph query processing, as well as having access to graph algorithms stemming from the [GraphFrames project](https://github.com/graphframes).

This is a great step forward for a standardized approach to graph analytics, including querying and algorithms, in an extremely widely-used data science and data integration platform. 
The vote reflects much patient and detailed work from many groups, and it's great to see collaboration by many contributors to bring additional graph capability to such a large open-source project.

## Cypher and the plans for [GQL](https://www.gqlstandards.org/)

Cypher continues to gain new implementations in research and industry. 
Besides its ease of use and strong graph-specific feature set, Cypher is attractive to vendors and users because the openCypher community and implementing vendors are strongly supportive of the plan to create a single standard declarative query language called GQL, which will draw heavily on the ASCII-Art pattern-based representation of sub-graphs pioneered by Cypher and extended in Oracle's PGQL. 
The goal is that [GQL will be a formal international standard](https://s3.amazonaws.com/artifacts.opencypher.org/website/materials/DM32.2/DM32.2-2018-00128r1.Working+towards+a+GQL+NWIP.pdf), specified and maintained by the ISO working group that manages the SQL standard (WG3).

The WG3 committee met last month in Brisbane, and discussed and encouraged further work on shaping a proposal to initiate the GQL project. 
The new project should start formally in the second half of this year. 
Proposals from [Neo4j](https://s3.amazonaws.com/artifacts.opencypher.org/website/materials/GQL/bne041-GQL-Scope-and-Features-Digest.pdf), Oracle and Tigergraph on the [content and scope of GQL](https://s3.amazonaws.com/artifacts.opencypher.org/website/materials/sql-pg-2018-0046r3-GQL-Scope-and-Features.pdf) were discussed at the meeting.

## Property Graph and RDF standards specialists to meet at W3C workshop

Supporters of GQL, including implementers of Cypher, PGQL and GSQL, are joining experts from the RDF world at a forthcoming [W3C workshop on graph data management standards in Berlin](https://www.w3.org/Data/events/data-ws-2019/) early next month. 
The over-subscribed W3C workshop will bring together one hundred RDF, labelled property graph and SQL standards specialists to figure out the best ways of creating bridges between these disparate but related data models and languages. 
The goal is to benefit users who increasingly want to create effective graph-aware applications which fit well with existing data technologies.

## openCypher Implementers Meeting follows

The [Fifth openCypher Implementers Meeting (oCIM)](https://www.opencypher.org/event/2019/03/06/ocim5/) will also be taking place, at the same venue in Berlin, immediately after the W3C workshop.

oCIM participants will be discussing language improvement requests and proposals. 
These include the ability to carry out queries that project new graphs, and to incorporate those queries in parameterized views, as well as designs for domain-specific property graph types and relational-to-graph mappings. 
Both these key features were first implemented in Cypher for Apache Spark, and have been discussed in previous implementers' meetings. 
(The graph types and SQL source mappings are also reflected in [Neo4j proposals for the forthcoming Property Graph Querying extension to SQL](https://s3.amazonaws.com/artifacts.opencypher.org/website/materials/sql-pg-2018-0056r1-Property-Graph-Schema.pdf), which is seen as a read-only subset of the planned GQL language.)

The theme of creating a managed and orderly transition from Cypher to GQL is an overarching concern and opportunity for the openCypher community. 
With my Neo4j hat on, I can say that our company takes the need to avoid disruption to existing customers and their applications extremely seriously. 
So, while we are big backers of GQL, we are strong advocates of carefully preserving working and familiar features from the "input" languages that are contributing to the future GQL specification. 
From a product perspective we see Cypher as having a long future life while the industry defines, and then standardizes on, the GQL language over the coming years.

## GQL Community: [Property Graph Schema Working Group](https://3.basecamp.com/4100172/projects/10013370) also meet face to face

openCypher advocates, designers and implementers from several companies are very active in a broader, emerging GQL community that has already spawned informal working groups to analyze existing graph query languages and to discuss scope and designs for stronger property graph schema.

There is a strong felt need for property graph schema/typing, and high interest in how to apply flexible or partial schema. 
The schema working group is also meeting face-to-face after the W3C workshop in Berlin, where there will have been an opportunity to correlate the property graph view against WC3 recommendations like OWL and SHACL, which overlap in their concerns.

It's great to see this level of activity with so many contributors on so many fronts: the push for standardization reflects continuing growth in all aspects of the graph data software and services market.
