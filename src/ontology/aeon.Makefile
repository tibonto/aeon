## Customize Makefile settings for aeon
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

## Module for ontology: bfo

$(IMPORTDIR)/bfo_import.owl: $(MIRRORDIR)/bfo.owl $(IMPORTDIR)/bfo_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) merge -i $< \
		query --update ../sparql/preprocess-module_provo.ru --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: omo

$(IMPORTDIR)/omo_import.owl: $(MIRRORDIR)/omo.owl $(IMPORTDIR)/omo_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) merge -i $< \
		query --update ../sparql/preprocess-module_provo.ru --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: iao

$(IMPORTDIR)/iao_import.owl: $(MIRRORDIR)/iao.owl $(IMPORTDIR)/iao_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query  -i $< --update ../sparql/preprocess-module_provo.ru \
		extract -T $(IMPORTDIR)/iao_terms_combined.txt --force true --copy-ontology-annotations true --individuals exclude --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: ro

$(IMPORTDIR)/ro_import.owl: $(MIRRORDIR)/ro.owl $(IMPORTDIR)/ro_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module_provo.ru \
		filter -T $(IMPORTDIR)/ro_terms_combined.txt --select "self annotations ontology equivalents domains ranges" --signature true --trim true \
		query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Module for ontology: obi

$(IMPORTDIR)/obi_import.owl: $(MIRRORDIR)/obi.owl $(IMPORTDIR)/obi_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) filter -i $< -T $(IMPORTDIR)/obi_terms.txt --select " self ancestors" --signature false --trim true \
		--output $@.tmp.owl; fi
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module_provo.ru \
		filter -T $(IMPORTDIR)/obi_terms.txt --select "self annotations ontology equivalents" --signature true --trim true \
		query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		merge -i $@.tmp.owl \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: cro

$(IMPORTDIR)/cro_import.owl: $(MIRRORDIR)/cro.owl $(IMPORTDIR)/cro_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) filter -i $< -T $(IMPORTDIR)/cro_terms.txt --select "self ancestors" --signature false --trim true \
		--output $@.tmp.owl; fi
	if [ $(IMP) = true ]; then $(ROBOT) merge -i $< \
		query --update ../sparql/preprocess-module_provo.ru \
		filter -T $(IMPORTDIR)/cro_terms.txt --select "self annotations ontology" --signature false --trim true \
	    query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		merge -i $@.tmp.owl \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: envo

$(IMPORTDIR)/envo_import.owl: $(MIRRORDIR)/envo.owl $(IMPORTDIR)/envo_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) filter -i $< -T $(IMPORTDIR)/envo_terms.txt --select " self ancestors" --signature false --trim true \
		--output $@.tmp.owl; fi
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module_provo.ru \
		filter -T $(IMPORTDIR)/envo_terms.txt --select "self annotations ontology" --signature true --trim true \
		query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		merge -i $@.tmp.owl \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: txpo

$(IMPORTDIR)/txpo_import.owl: $(MIRRORDIR)/txpo.owl $(IMPORTDIR)/txpo_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) filter -i $< -T $(IMPORTDIR)/txpo_terms.txt --select "self ancestors ontology" --signature false --trim true \
		--output $@.tmp.owl; fi
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module_provo_op.ru \
		filter -T $(IMPORTDIR)/txpo_terms.txt --select "self annotations ontology" --signature false --trim true \
		query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		merge -i $@.tmp.owl \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi



## Module for ontology: ico

$(IMPORTDIR)/ico_import.owl: $(MIRRORDIR)/ico.owl $(IMPORTDIR)/ico_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) filter -i $< -T $(IMPORTDIR)/ico_terms.txt --select "self ancestors" --signature false --trim true \
		--output $@.tmp.owl; fi
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module_prov_wo_iri.ru \
		filter -T $(IMPORTDIR)/ico_terms.txt --select "self annotations ontology equivalents" --signature false --trim true \
		query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		merge -i $@.tmp.owl \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi