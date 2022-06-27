![Build Status](https://github.com/StroemPhi/aeon/workflows/CI/badge.svg)
# Academic Event Ontology (AEON)

Description: _WIP - NOT READY FOR PRODUCTION_ The Academic Event Ontology (AEON) is used to represent information regarding academic events. The ontology supports the identification, development, management, evaluation, and impact assessment of events, components of events and event series, as well as identification and reuse of works presented or developed at events. The ontology is independent of knowledge, creative domain, or topics related to events. AEON is focused on events and assumes the representation of many entities associated with events such as attendees, locations, academic works, datetimes, and processes are defined in compatible ontologies.

A first draft of AEON was discussed at the [VIVO Ontology Workshop in February 2020](https://docs.google.com/document/d/1C9vs3_pCqhS_ujcqmUeu9TSXtgxFIvsBv-fW3sXl7yk) with regard to the process of renewing the VIVO ontology to make it [BFO](https://basic-formal-ontology.org/) conform.

The application ontology of the TIB project [ConfIDent](https://projects.tib.eu/en/confident/), will hopefully serve as meaningful input for AEON, due to its data driven development. This entails importing academic event metadata from donators and existing datasets, such as [OpenResearch](https://www.openresearch.org), [EventKG](https://github.com/saidfathalla/EVENTSKG-Dataset), [DBLP](http://dblp2.uni-trier.de/) and [NASA/ADS](https://ui.adsabs.harvard.edu/), in order to identify the needed classes, object and data properties by analysing their relevance in these datasets.

Additional analysis is needed regarding the reuse of external terms from related ontologies and schemas, such as:

- [SEO - The Scientific Event Ontology](https://saidfathalla.github.io/SEOontology)

    - reuses:
    
        - [Semantic Web for Research Communities Ontology](https://lov.linkeddata.es/dataset/lov/vocabs/swrc)

        - the [conference-ontology](http://www.scholarlydata.org/ontology/conference-ontology.owl) from scholarlydata.org

-   [schema.org/event](http://www.schema.org/event) & [schema.org/eventseries](http://www.schema.org/eventseries)

-   [GND Ontology](https://d-nb.info/standards/elementset/gnd) (not very elaborate for events)

-   [BIBO]([http://bibliontology.com/](https://service.tib.eu/webvowl/#iri=https://raw.githubusercontent.com/structureddynamics/Bibliographic-Ontology-BIBO/master/bibo.owl)) imports Event class and sub-event object property from Event Ontology and adds the relevant classes: [Conference](http://purl.org/ontology/bibo/Conference) and [Workshop](http://purl.org/ontology/bibo/Workshop)

-   [FRAPO](https://sparontologies.github.io/frapo/current/frapo.html#d4e2645) - has classes like conference fee etc.

-   [FaBiO](https://sparontologies.github.io/fabio/current/fabio.html) - has classes for publications as conference output

## [Domain Definition](https://docs.google.com/document/d/1e7MWIO7IZHtj1Ww-pXswcQVDO7rIs8aQwwgnKk2KQ-o)

An academic event is a gathering of scholars and researchers to present their work, hear others present, and discuss the latest developments within their field. Some examples of academic events include conferences, symposia, workshops, colloquia, talks, hackathons, meet-ups, seminars, and forums.

The Academic Event Ontology (AEON) is used to represent information regarding academic events. The ontology supports the identification, development, management, evaluation, and impact assessment of events, components of events and event series, as well as identification and reuse of works presented or developed at events. The ontology is independent of knowledge, creative domain, or topics related to events. AEON is focused on events and assumes the representation of many entities associated with events such as attendees, locations, academic works, datetimes, and processes are defined in compatible ontologies.

## Ontology Competency Questions

AEON seeks to represent information about events to answer the questions below as examples. Many additional questions regarding events should be answerable.

1.  Basic information about the event: its date, type (conference, workshop, symposium, etc.) location (including multiple and virtual), topics, name, program/agenda

2.  Who attended the event? Who presented? Who served on panels?

3.  What deadlines are associated with the event such as registration, submission

4.  Who was on the organizing committee? Who were the local organizers? The reviewers?

5.  Was the event part of a series? Who is responsible for the series?

6.  Who won awards presented at the event?

7.  What material was presented at the event? (e.g. papers, posters, presentations, demonstrations)

8.  Were there panel sessions, workshops? Who attended them?

## Consequences and observations

-   AEON represents information useful in assessing the research impact of an event.

-   Awards are outside the domain of AEON. AEON will represent awards using ontology developed for that purpose.

-   AEON is a BFO-based ontology that recognizes roles, processes, and process outputs. So, for example, a person might have the role attendee in an event. A person might have a chair role in an organizing committee associated with the event.

-   An event defined by this ontology produces outputs that are information artifacts ([http://www.obofoundry.org/ontology/iao.html](http://www.obofoundry.org/ontology/iao.html)). These outputs can be referenced, but they are not in the scope of this ontology.

-   An academic event has one or more topics. Defining topics is outside the scope of this ontology. Existing topic vocabularies can be used with AEON.

-   Events are defined in a general manner with sub-events (occurrent parts) that are themselves events. This allows for the representation of conferences that have workshops with their own organizing committees, for example.

-   Events without much structure are often called "meetings."


## Visualization
You can see a visualization of the master branch aeon.ttl using [WebVOWL](http://www.visualdataweb.de/webvowl/#iri=https://raw.githubusercontent.com/tibonto/aeon/master/aeon.ttl)

### TBox
This is a reduced general overview of the classes and relation AEON uses.
![](docs/AEON_overwiew.PNG)

#### What makes up an academic event or event series?
TODO

#### Where and when did it take place?
CAVE/TODO: I've wrongly labeled the edges for the subclasses in this version, as it must be rdfs:subclassOf not rdf:type! 
    see also [issue#105](https://github.com/tibonto/aeon/issues/105)
![](docs/AEON_where_and_when.PNG)

We've added subproperties to 'ro:occurs in' in order to be able to map the data from external databases such as Wikidata more precisely. 


#### Who is involved?
CAVE/TODO: I've wrongly labeled the edges for the subclasses in this version, as it must be rdfs:subclassOf not rdf:type! 
    see also [issue#105](https://github.com/tibonto/aeon/issues/105)
![](docs/AEON_who.PNG)

The contributors are defined classes, that are equivalent to ('NCBITaxon:'Homo sapiens' or obi:organization) and ('ro:has role' some ('aeon:contributor role' and ('bfo:realized in' some 'obi:planned process'))). For the sake of reducing the information overload the discrete roles for each type of contributor (e.g. 'aeon:organizer role', 'aeon:presenter role', ...) are thus left out here. What is also not shown in this figure are additional subproperties of 'ro:has participant' (e.g. 'aeon:has contributor', 'aeon:has organizer', ...) with which we can specify the type of participation more concretely, by adhering to the pattern that a contributor role is equivalent to 'ro:role of' some ('aeon:contributes to' some 'obi:planned process'). At the moment these axioms have been asserted manually, but it is intended to do this automatically via macro expansion or some similar automatic implementation of this pattern. 

Similarly to AEONs subproperties of 'ro:occurs in', having additional subproperties of 'ro:has participant' is needed for the mapping to external databases and in general for those applications that do not define the participation in an academic event or event series via a destinct role.

It is intended to reuse the contibutor role ontology, once it will include this use case of research contribution.
    see also [issue#97](https://github.com/tibonto/aeon/issues/97)

#### How is the event or series organized?
CAVE/TODO: I've wrongly labeled the edges for the subclasses in this version, as it must be rdfs:subclassOf not rdf:type! 
    see also [issue#105](https://github.com/tibonto/aeon/issues/105
![](docs/AEON_how.PNG)
This is still a very early draft and it needs to be discussed if and how the various metrics and deadlines can be modeled better using classes and object properties instead of just data properties.

## Versions

### Stable release versions

The latest version of the ontology can always be found at:

http://purl.obolibrary.org/obo/aeon.owl

(note this will not show up until the request has been approved by obofoundry.org)

### Editors' version

Editors of this ontology should use the edit version, [src/ontology/aeon-edit.owl](src/ontology/aeon-edit.owl)


## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/tibonto/aeon/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit).