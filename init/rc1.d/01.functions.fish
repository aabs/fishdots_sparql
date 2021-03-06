#!/usr/bin/env fish

define_command rdf "fishdots plugin for SPARQL Queries on CLI"

define_subcommand_nonevented rdf home rdf_home "select and archive an active instance"
define_subcommand_nonevented rdf endpoint rdf_set_ep "<endpoint> set the endpoint to present queries to"
define_subcommand_nonevented rdf data rdf_add_df "<file> add a file to the list of data files to apply local operations to"
define_subcommand_nonevented rdf clear rdf_clear_df "reset the list of data files to apply local operations to"
define_subcommand_nonevented rdf query rdf_query "<sparql_query> send a sparql query to the registered server"
define_subcommand_nonevented rdf update rdf_update "<sparql_update> send a sparql update to the registered server"
define_subcommand_nonevented rdf lquery rdf_lquery "<query> run a sparql query using local files"
define_subcommand_nonevented rdf lupdate rdf_lupdate "<update> run a sparql update using local files"
define_subcommand_nonevented rdf fmt rdf_set_format "<fmt> change the default results format"
define_subcommand_nonevented rdf show rdf_show "display configuration information"

function rdf_show
    echo "RDF plugin configuration info:"
    echo -e "\tPWD \t $PWD"
    echo -e "\tEndpoint \t $SPARQL_ENDPOINT"
    echo -e "\tData Files \t $RDF_DATA_FILE"
end

function rdf_set_ep -a endpoint -d 'set the endpoint to present queries to'
    set -U SPARQL_ENDPOINT "$endpoint"
end

function rdf_add_df -a datafile -d '<file> add a file to the list of data files to apply local operations to'
  set -l p (realpath $datafile)
    set -U RDF_DATA_FILE "$RDF_DATA_FILE --data='$p'"
end

function rdf_clear_df -d 'reset the list of data files to apply local operations to'
    set -U RDF_DATA_FILE ''
end

function rdf_query -a qf -d 'send a sparql query to the registered server'
  set q $argv
  if not test -e $qf
    echo "$argv" > /tmp/blah.rq
    set q /tmp/blah.rq
  end
  set -l cmd "$JENA_HOME/bin/rsparql --results=$SPARQL_DEFAULT_RESULT_FORMAT --service=$SPARQL_ENDPOINT --query='$q'"
  eval $cmd
end

function rdf_update -a qf -d 'send a sparql update to the registered server'
  set q $argv
  if not test -e $qf
    echo "$argv" > /tmp/blah.rq
    set q /tmp/blah.rq
  end
  set -l cmd "$JENA_HOME/bin/rupdate --service=$SPARQL_ENDPOINT --update='$q'"
  eval $cmd

end

function rdf_lquery -a qf -d '<query file> send a sparql query to the registered server'
  set q $argv
  if not test -e $qf
    echo "$argv" > /tmp/blah.rq
    set q /tmp/blah.rq
  end
  set -l cmd "$JENA_HOME/bin/sparql --results=$SPARQL_DEFAULT_RESULT_FORMAT $RDF_DATA_FILE --query='$q'"
  eval $cmd
end

function rdf_lupdate -d 'send a sparql update to the registered server'
  set q $argv
  if not test -e $qf
    echo "$argv" > /tmp/blah.rq
    set q /tmp/blah.rq
  end
  set -l cmd "$JENA_HOME/bin/update --results=$SPARQL_DEFAULT_RESULT_FORMAT $RDF_DATA_FILE --update='$q'"
  eval $cmd
end

function rdf_set_format -a fmt -d "change the default result format"
  set -U SPARQL_DEFAULT_RESULT_FORMAT $fmt
end
