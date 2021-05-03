#!/bin/sh
# *** Removes terms from input ontology ***
# run from parent dir:
# ./scripts/robot_remove_terms.sh 

robot remove --add-prefixes prefixes.json \
--input aeon.ttl \
--term aeon:SMW_datatype \
--term aeon:SMW_import_info \
--term aeon:WikidataLabel \
--term aeon:WikidataURI  \
--output aeon_no_SMW_datatype.ttl