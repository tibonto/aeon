PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>

INSERT { 
    ?ontology prov:wasDerivedFrom ?version_iri .
    ?class dc:source ?version_iri .
    ?object_property dc:source ?version_iri .
    ?data_property dc:source ?version_iri .
}

WHERE {
  ?ontology rdf:type owl:Ontology ;
        owl:versionIRI ?version_iri .
        ?class rdf:type owl:Class .
  OPTIONAL { ?object_property rdf:type owl:ObjectProperty .
              ?data_property rdf:type owl:DatatypeProperty .
              }
}
