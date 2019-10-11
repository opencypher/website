---
layout: post
categories: articles
title:  "Critical milestone for ISO graph query standard GQL"
date:   2019-06-19
author: "Alastair Green (Lead, Query Languages Standards and Research Group at Neo4j)"
excerpt: "The GQL standard project is up for the final vote in the ISO/IEC ballot: plans to create a standard property graph query language GQL took a critical step forward, this past Friday June 14th."
---

#### This is a reproduction of the article originally posted [here](https://www.linkedin.com/pulse/critical-milestone-iso-graph-query-standard-gql-alastair-green/).


<img src="{{ site.baseurl }}/public/images/JTC1-SC32Plenary-&-WGs-Meeting.jpeg" width="840" height="530" />

*Group photo of the participants at the JTC 1/SC 32 Plenary & WGs meeting in Korea.*

## GQL standard project up for final vote in ISO/IEC ballot

Plans to create a standard property graph query language **GQL** took a critical step forward, this past Friday June 14th. 

A year ago over 3,000 people took the opportunity to say “Yes to GQL” by voting in an open web poll for [The GQL Manifesto](http://gql.today/), launched in mid-May 2018. 
Now the industry has responded.

The ISO international standards group responsible for data management **SC 32**, meeting in Jeju-si in Korea, agreed to launch a ballot of all the national standards institutes that belong to SC 32's parent body, ISO/IEC Joint Technical Committee 1 or **JTC 1**, which governs standards for IT as a whole.

JTC 1 members are now being asked to vote on the proposal that a **new GQL project** be started. 
This will be the first time in 35 years that ISO has considered creating a new database language standard, to parallel the vastly successful SQL project.

## Building on the success of SQL ...

GQL will build on the **foundational aspects of SQL** (data types, expressions etc). 
Discussion this past week in Korea, and at prior U.S. standards meetings, emphasized the importance of making it easy for users and implementers of SQL to move into the fast-growing world of graph data by avoiding maybe elegant, but practically pointless, variation from SQL. 
The negative example of the difference in type system between SQL and XQuery was cited. 
An important example that came up last week was a proposal to make SQL’s bottom-up `SELECT` expression available alongside Cypher’s top-down `RETURN`, allowing users to choose between nested query composition and “and then” linear composition for tabular-output queries.

## ... and of openCypher and other existing languages

However, as that example also shows, GQL will draw heavily on **existing declarative graph query languages** like openCypher (which originated in Neo4j’s database product), PGQL (implemented by Oracle) and GSQL (designed and implemented by Tigergraph). 
Between them these industrial languages are implemented by around a dozen products and open source projects. 
These languages are not only graph-oriented, but also incorporate features and approaches that have become commonplace in programming languages since SQL was first conceived by IBM over forty years ago.

## Increasing complexity, extent and criticality

In addition, GQL will build on the academic **research language G-CORE**, and will incorporate read-only property graph query extensions to SQL, which have been in development within WG3 for the last two years under the title SQL/PGQ.

All of these overlapping projects over the past couple of years have brought vendors, academics, users and consultants together in repeated collaborations, building mutual respect and trust.

The emerging consensus of these intersecting efforts is a core set of features. 
Taken together they set the bar for the **next generation of property graph data management**.

* Create a full **CRUD** query language that is **natively oriented to property graph** query data management and which allows for implementations that are graph-native as well as relational-viewed-as-graph implementations. 
Cypher and GSQL are existing languages in this category.

* Codify the **pattern-centric approach to querying graph data**, as pioneered by Cypher and extended conceptually in interesting ways by all three of PGQL, GSQL and SQL/PGQ.

* Make the graph query language support **multiple named graphs**, and be **fully composable** over graphs (as well as tables and values). 
This allows for persistent storage of libraries of graphs, and for **graph transformations**. 
It also allows a transactional database to offer queries which ouput graphs to be used as **temporary or permanent views**. 
Prefigured by G-CORE, the OSS openCypher Morpheus (Cypher for Apache Spark) project shows many of these features in executable software. 
Some are also present in Tigergraph’s database product.

* Introduce comprehensive support for **property graph schema**, including flexible or partial schema. 
The openCypher Morpheus project incorporates an interesting first pass at schema, which forms the target for mappings or graph views over relational data.

## The ISO GQL project ballot

<img src="{{ site.baseurl }}/public/images/ISO-GQL-project-ballot.png" width="840"  />


The proposal before JTC 1 states that the ISO technical working group that runs the SQL standard, **SC 32/WG3**, will also be the home for work on GQL. 
Stefan Plantikow of Neo4j and Stephen Cannan, the SQL Technical Corrigenda editor, are proposed as the editors of the new standard. 
If you'd like to know more about WG3’s work please contact the Convenor, [Keith Hare](jcc.com).

The formal “letter ballot” is already open, and will finish in twelve weeks, in September.

All of the countries represented at the closing session of the SC 32 meeting gave their backing: Korea, China, Japan, the Netherlands, Canada, Germany, Sweden, and the United States (whose national body INCITS originally recommended to WG3 and SC 32 that this project should be started).

Given this unanimous support from countries active in the data management standards arena, it seems very likely indeed that the ballot will succeed.

There has been substantial discussion and preparatory drafting work on GQL since SC32’s last meeting in Toronto in May 2018. 
Much work has taken place in official national and international standards groups. 
There is already a very early editors’ draft of GQL running to about three hundred pages, which is a great starting point. 
But there is also lots of work being carried on in a looser, wider GQL community.

## The GQL community

One example of GQL community activity is the informal **“Existing Languages” working group** (convened by [Petra Selmer](neo4j.com) of Neo4j).

This group gathers together about fifteen implementers and consultants. 
They have been working on a systematic analysis of the semantics and syntax of existing languages that are relevant to the emerging GQL standard (including languages like SPARQL and Gremlin that are not directly in the field of declarative property graph querying). 
This analysis will help us avoid “holes” and also shows where there is a high degree of convergence or divergence, helping to shape priorities for the process of language evolution.

From the beginning of the GQL initiative in May 2018, we in Neo4j have advocated that GQL learn from the successful experience of the [openCypher Implementers Group](https://www.opencypher.org/events) (which has met face-to-face five times in the last two years).

Formal standards participation requires significant resources available only to a limited number of vendors. We’d like to see a core of formal work surrounded by an active periphery of more informal meetings and forums, in line with the kind of working practices that have become familiar in the Apache Software Foundation’s projects and processes (to take one successful example).

## Open-source software tools for implementers

Informal consensus-based working groups are one part of the community picture. 
A second big part of the success of the [openCypher project](https://www.opencypher.org/) has been that it provides **[open-source software tools](https://github.com/opencypher)**. 
These can be used by query engines and equally by tools such as the Neueda Intellij IDEA plug-in or ETL and data modelling products and projects.

**Grammar artefacts** make it easier for implementers to create their own products (to date in C++ and in Javascript, as well as JVM languages like Scala and Java). 
The openCypher **Technology Compatibility Kit (TCK)** has made it much easier to test for conformance. 
The **Query Processor Front-End** has provided a query parsing and semantic analysis pipeline for JVM implementations, that is shared by Cypher for Gremlin, Cypher for Apache Spark (Morpheus) and by the Neo4j database.

Other Cypher implementers have contributed to these tools: the intention is that these resources, and the use of Apache-licensed Github projects, will be replicated and extended in GQL community software projects, reusing some core aspects of Cypher that will also be part of GQL.

## Combining two ways of working

Combining the two historical styles of open-source (de facto) and international (de jure) standards is going to be an interesting test for GQL. 
Formal standards have very great weight in many contexts, and impose a high bar of completeness and accuracy. 
At the same time open-source projects can be very influential, inclusive and fast-moving.

Many people prefer to contribute their ideas in the form of running code; others find the formalization of conventional standards specifications to be weak, and would prefer to extend formal semantics or executable formal semantics to describe the emerging GQL standard, and to make it easier to produce reference implementations.

These different ways of expressing the GQL standard should be welcomed with open arms. 
The more artefacts and tools surround the official specification, the easier it is to get multiple successful implementations that express well-understood common semantics. 
All interested parties should be able to contribute to developing GQL as a live and relevant tool for the database industry and its users. 
We cannot deny the weight of database vendors, but we are not living in 1975 or 1985, when they formed a “closed shop”.

Modern internet tools like Github, Google docs and forum cloud services make a big difference to accessibility and velocity. 
A modern culture of collaborative, international and open development should allow individuals, educational bodies and startups to support and challenge the vendors who’ve decided to invest in the official process.

We need to get early incubatory GQL implementations “on the ground”. 
Can we also get researchers to adopt GQL as a focus? 
Can we bring together GQL and the informal API standard GraphQL, or the incubating Tinkerpop 4.0 virtual data machine project? 

The good news is that there are many companies and research groups already orienting to GQL. 
The advocates of GQL in companies like Neo4j, Redis Labs, SAP, IBM and Tigergraph, as well as the officers, staff and leading bodies of formal standards organizations, all seem very supportive of bridging the historical divide between the open-source world of loose consensus and running-code and the formal standards world.

## W3C graph data workshop

The over-subscribed [2019 W3C Graph Data Management Standards workshop](https://www.w3.org/Data/events/data-ws-2019/report.html) was attended by 100 specialists in the field. 
Held in Berlin in March, the theme was building bridges between RDF, property graphs and SQL. 
Participants demonstrated a strong desire to avoid “needle fights,” in favour of careful consideration of technical interoperation standards when one data management model rubs up against another. 
Big thanks are due to W3C staff members Dave Raggett, Ivan Herman and Alan Bird for being so welcoming to the property graph community and ISO. 
This extended from planning to scheduling, and to the conduct of the workshop, which I had the privilege of co-chairing with Dave.

It became clear that GQL was a vital pillar for interoperation standards of the future: without a defined standard for the property graph data model, schema, query language and data interchange, it will not be possible to relate property graphs systematically to the RDF standards family, or to SQL.

By plan, the informal GQL community **“Property Graph Schema” working group** (convened by [Juan Sequeda](capsenta.com/) of Capsenta Inc.) also met face-to-face in the same week in Berlin. 
Since then its fifty members have interacted on Basecamp to discuss slides and documents; met in a recent conference call, and are planning to meet again, face-to-face, at the tail-end of SIGMOD in Amsterdam early next month.

Jan Hidders from Belgium, Juan and Renzo Angles from Chile have played a leading role in orchestrating the group’s technical discussions. 
The felt need for “stronger graph schema” is demonstrated by the wide participation in this group, which also involves Tinkerpop project members, including people working for Uber and Datastax Inc.

## Potential role for Linked Database Benchmark Council

At the Berlin workshop Juan Sequeda proposed that the GQL community efforts be folded into LDBC. 
The [Linked Database Benchmark Council](http://ldbcouncil.org/) is chaired by Peter Boncz from CWI in Amsterdam, and I am the vice-chair. 
LDBC is a multi-vendor body that also has very strong representation from senior academics and multiple talented younger researchers and practitioners.

LDBC was established as an outgrowth of an EU project on graph database benchmarking. 
The need to describe benchmarks in a standard way brought LDBC to look at graph query languages.

From 2015 to 2017 the LDBC’s Graph Query Language Task Force worked to produce a suitable prototype language called G-CORE (which started from Cypher/PGQL syntax and some core semantics, but went much further, particularly in the area of composable graph querying and path handling). 
The G-CORE paper, including denotational semantics, was published at SIGMOD 2018.

The social and technical success of LDBC’s G-CORE project, which anticipates desirable features of the GQL community process, led Juan Sequeda to suggest that LDBC would be the best venue for organizing the GQL community’s efforts. 
LDBC is vendor-neutral; it has members from the native property graph, RDF and SQL worlds, and has successfully established three performance benchmark specs.

LDBC is a not-for-profit company, which makes it easier to set up intellectual property rules that will enable collective work to be submitted into the formal ISO process, and it already has a “Category C Liaison” with SC 32/WG3, which enables the exchange of documents. 
Individual membership of LDBC is free.

LDBC’s board meets in early July. 
It will be able to consider the idea that community working groups are reconstituted as one or more LDBC task forces. 
The [12th LDBC Technical User Committee](http://ldbcouncil.org/12th-tuc-meeting-sigmod-2019-amsterdam-july-5-2019) meeting will follow the directors’ meeting and will also be an opportunity to bring the progress on GQL to a wider audience including SIGMOD attendees.

## Growing participation in the ISO GQL project

For the new GQL project to go ahead the ballot must pass, and five or more countries will also have to put forward national experts to work on the project. 
Before the decision in Korea it seemed likely that the U.S., Britain, Sweden, Germany and the Netherlands would be able to put forward experts.

For me it was a great moment last week when Korean delegates (who it turns out are already working in the area of property graphs), came forward to volunteer their willingness to work as experts on behalf of the Korean Agency for Technology and Standards.

This growth of interest is mirrored in increased activity inside national bodies. 
Three new members have this year joined the U.S. INCITS database committee, **DM32**, as a result of the GQL project activity: ArangoDB, Redis Labs and Optum.

The United Kingdom delegates had to leave the SC 32 meeting before the resolution was considered on Friday but there is active support by BSI members for this work, including from researchers at the University of Edinburgh who have already worked on formal semantics for SQL and Cypher.

## The year ahead

The first WG3 meeting to start work on the official GQL project will take place in September in Arusha, Tanzania. 
The project has an overall term of 48 months, but it’s expected that a credible working draft of a GQL spec, that could be used for preliminary experimental implementations, is likely to emerge before the end of 2020, and that a Committee Draft could be achieved in the following year.

It’s taken a lot of joint work and a lot of complex technical thinking to figure out how the industry can make this project work. 
It feels like there is now a solid framework, on top of a willingness to collaborate and strong momentum.

So, I think we just might have seen an important bit of computing history made last week.

The wins here include an easier life for users (who will benefit from a single skillset and easy interoperation with SQL), and a bigger market for all vendors who have a stake in the property graph data management category. 
Above all, users will be able to write more powerful graph applications and analyses, as GQL’s newer features begin to appear in products and projects.

## Get in touch, and get involved!

Please feel free to [mail me](neo4j.com/) or contact me through [LinkedIn](https://www.linkedin.com/in/alastair-green-65a861a7/) if you’d like further information, introductions or want to get involved in any way.

If you know any of the companies, people or groups mentioned in this post, I’m sure that all of them would also be happy to help you take part.
