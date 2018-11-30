library(shiny)
library(leaflet)
library(magrittr)
library(rdflib)
library(tibble)
turtleFile = rdf_parse("WithLatAndLong.ttl", fomat="turtle") 
query = "PREFIX ent:<http://www.BiSafe.com/entity/>
          PREFIX ont:<http://www.BiSafe.com/ontology#> 
          PREFIX lode:<http://linkedevents.org/ontology/>
          PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>
          PREFIX foaf: <http://xmlns.com/foaf/0.1/> 
          SELECT  ?accident1 ?date ?place ?latitude ?longitude ?age ?gender ?victims
          WHERE {
              ?accident1 lode:atTime ?date .
              ?accident1 lode:atPlace ?place .
              ?place ont:hasLatitude ?latitude .
              ?place ont:hasLongitude ?longitude .
              ?accident1 lode:involvedAgent ?person .
              ?person foaf:Age ?age .
              ?person foaf:gender ?gender .
              ?accident1 ont:hasVictimeNumber ?victims}"

accidentsTibble = rdf_query(turtleFile, query)