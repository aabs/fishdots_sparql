#!/usr/bin/env fish

# set up env var for SPARQL Endpoint: base case - assume local blazegraph on docker-compose

# this could have been set via the localrc file (as in my work machine)
if not set -q SPARQL_ENDPOINT
    warn "SPARQL_ENDPOINT not set. assuming local Blazegraph on DC"
    set -U SPARQL_ENDPOINT 'http://localhost:8889/blazegraph/namespace/kb/sparql'
end

if not set -q JENA_HOME
    warn "JENA_HOME not set. assuming local Blazegraph on DC"
    set -U JENA_HOME "$FISHDOTS_PLUGINS_HOME/fishdots_sparql/bin/jena"
end

if not set -q SPARQL_DEFAULT_RESULT_FORMAT
    warn "SPARQL_DEFAULT_RESULT_FORMAT not set. assuming CSV format for now."
    set -U SPARQL_DEFAULT_RESULT_FORMAT "CSV"
end
