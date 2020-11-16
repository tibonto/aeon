import json
import pytest
import rdflib

@pytest.mark.dumb
def test_test():
    assert 1 == 1

@pytest.mark.ontology
def test_maps_to_property():
    # open a graph
    graph = rdflib.Graph()
    # load some data
    graph.parse('aeon.ttl', format="ttl")
    assert graph, 'Error: aeon.ttl graph failed to parse'

    qres = graph.query("""
        PREFIX aeon: <https://github.com/tibonto/aeon#>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX owl: <http://www.w3.org/2002/07/owl#>
    
        SELECT DISTINCT ?aeon_property ?maps_to ?aeon_property_domain 
        ?rdfs_label 
    
        WHERE {
                ?aeon_property aeon:AEON_0000026 ?maps_to.
                {?aeon_property rdf:type owl:ObjectProperty.} UNION             
                {?aeon_property rdf:type owl:DatatypeProperty.}
                OPTIONAL {?aeon_property rdfs:domain ?aeon_property_domain.}
                OPTIONAL {?aeon_property rdfs:label ?rdfs_label.}
               }
        """)
    assert len(qres) > 0  , 'Error: No triples returned.'

    for printout in qres:
        printout_dict = printout.asdict()
        print(printout_dict["aeon_property"])  # only prints in error
        assert printout_dict.get('maps_to'), 'Error: maps_to key not found. '

        maps_to = json.loads(str(printout_dict.get('maps_to')))
        # print mapping dictionary
        assert isinstance(maps_to, dict), 'Error: maps_to value did not ' \
                                          'convert correctly to Dict.'
