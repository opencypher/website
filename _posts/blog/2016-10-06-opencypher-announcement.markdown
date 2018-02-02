---
layout: post
categories: blog
title:  "openCypher — Grammar and TCK"
date:   2016-10-06
author: "Cypher Language Group"
---
The openCypher project has produced two significant new features in 2016: an Extended BNF
grammar which formally defines the permitted syntax of Cypher, and a TCK (Technology Compatibility Kit).

An XML grammar definition is used to generate an EBNF and an Antlr4 grammar for use by projects who wish
to parse Cypher, and "Railroad Diagrams" which document the syntax.

Cypher is a declarative query language which is not tied to any general-purpose programming language or
domain-specific language. In line with this approach, the TCK is a Cucumber-based set of tests that can
be used for any Cypher implementation in any of the many languages supported by
[Cucumber](https://cucumber.io/).

The grammar specification and the TCK may be downloaded from the [Resources](http://www.opencypher.org/resources) page.

Several organizations are already involved in openCypher; read more about them in [Current projects](http://www.opencypher.org/#projects).

Furthermore, we have been approaching the growing number of product and service vendors who are
offering property graph databases or data storage services, to explore the best way to come together
around an open standards process for a declarative property graph query language that occupies the same
ecological niche as SQL does for relational query processors.
