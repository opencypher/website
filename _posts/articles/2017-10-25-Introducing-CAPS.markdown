---
layout: post
categories: articles
title:  "Cypher(TM) for Apache Spark(TM) with support for multiple graph processing"
date:   2017-10-25
author: "Stefan Plantikow"
excerpt: "The first public alpha release of the source code for Cypher(TM) for Apache Spark(TM) (CAPS) is now available. We discuss key features, such as support for working with multiple graphs and data source integration."
---

We'd like to announce the first public alpha release of the source code for Cypher(TM) for Apache Spark(TM) (CAPS).
We've been building CAPS at Neo4j for over a year now and have released it under the Apache 2.0 license as an official openCypher contribution at [https://github.com/opencypher/cypher-for-apache-spark](https://github.com/opencypher/cypher-for-apache-spark).


<p style="text-align:center">
<img src="https://raw.githubusercontent.com/opencypher/cypher-for-apache-spark/master/doc/images/zeppelin_screenshot.png" style="width:60%;height:60%" align="center" />
</p>

CAPS enables the execution of Cypher queries on property graphs stored in the Apache Spark cluster in the same way that SparkSQL allows for the querying of tabular data.
The system provides both the ability to run Cypher queries as well as a more programmatic API for working with graphs inspired by the API of Apache Spark.

CAPS is the first implementation of Cypher with support for working with multiple graphs and query composition.
Cypher queries in CAPS can access multiple graphs, dynamically construct new graphs, and return such graphs as part of the query result.
Furthermore, both the tabular and graph results of a Cypher query may be passed on as input to a follow-up query.
This enables complex data processing pipelines across multiple heterogeneous data sources to be constructed incrementally.


CAPS provides an extensible API for integrating additional data sources for loading and storing graphs.
Initially, CAPS will support loading graphs from HDFS (CVS, Parquet), the file system, session local storage, and via the Bolt protocol (Neo4j).
We plan to integrate further technologies at both the data source level as well as the API level in the future.


CAPS also is the first open source implementation of Cypher on a relational big data processing system.
Property graphs are represented as a set of scan tables that each correspond to all nodes with a certain label or all relationships with a certain type.
To achieve this efficiently, we developed a new schema model for describing the labels, relationship types, and property keys that occur in a graph.
This schema plays a crucial role in bringing Cypher's capabilities for also working with heterogeneous data to the Apache Spark ecosystem.


Most importantly, CAPS is the first release of a full Cypher system in the context of openCypher for re-use, modification, and extension by the wider community.
To get started, please follow the instructions in the [README](https://github.com/opencypher/cypher-for-apache-spark/blob/master/README.md) and have a look at the included demo applications.
This an early alpha release and we will further develop and refine CAPS until the first public release of 1.0 next year.
If you're interested in contributing, please let us know.
We hope you're as excited about this as we are:
It's a great moment in time to be working on and with Cypher as the data industry is increasingly realizing the true power of graphs.

Stay tuned for further articles about Cypher for Apache Spark and multiple graph processing.
