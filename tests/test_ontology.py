import json
import pytest
import rdflib
from urllib.parse import urlsplit


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

'''
the following block was used, before switching back to the OBO namespace/prefix standard to test the availability 
of the obo ontologies


@pytest.mark.ontology
def test_obo_ontos_resolution():
    # open a graph
    graph = rdflib.Graph()
    # load some data
    graph.parse('aeon.ttl', format="ttl")
    assert graph, 'Error: aeon.ttl graph failed to parse'
    qres = graph.query("""
    PREFIX bfo: <https://standards.iso.org/iso-iec/21838/-2/ed-1/en/owl/bfo-2020.owl#>
    PREFIX iao: <http://purl.obolibrary.org/obo/iao/2020-06-10/iao.owl#>
    PREFIX ro: <http://purl.obolibrary.org/obo/ro.owl#>
    PREFIX ico: <http://purl.obolibrary.org/obo/ico.owl#>
    PREFIX obi: <http://purl.obolibrary.org/obo/obi.owl#>
    PREFIX ncbitaxon: <http://purl.obolibrary.org/obo/ncbitaxon.owl#>
    PREFIX gaz: <http://purl.obolibrary.org/obo/gaz.owl#>
    PREFIX cro: <http://purl.obolibrary.org/obo/cro.owl#>
    SELECT DISTINCT ?term
    WHERE{ 
        ?term ?p ?v .
        FILTER (STRSTARTS(str(?term), "http://purl.obolibrary.org/obo/"))
    }
    ORDER BY ?term
    """)
    assert len(qres) > 0, 'Error: No triples returned.'
    uris_cache = []
    too_large_ontos = ['gaz.owl', 'ncbitaxon.owl']
    for printout in qres:
        uri = str(printout.get('term'))
        split_uri = urlsplit(uri)
        uri_base = uri.replace(f'#{split_uri.fragment}', '')  # before hash

        in_too_large_ontos = any(onto in uri for onto in too_large_ontos)
        if uri_base not in uris_cache and in_too_large_ontos is False:
            print(uri_base)
            uris_cache.append(uri_base)
            graph_external_onto = rdflib.Graph()
            graph_external_onto.parse(uri_base, format="application/rdf+xml")
            external_onto_query = graph_external_onto.query("""
            SELECT DISTINCT ?term
            WHERE{ ?term ?p ?v .}
            """)
            print(f'{len(external_onto_query)} triples found in {uri_base}')
            assert len(external_onto_query) > 10,  'Error: less than 10 ' \
                                                   'triples returned...Fishy!'
'''