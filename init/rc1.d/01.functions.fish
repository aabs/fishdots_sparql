#!/usr/bin/env fish



function rdf
  if test 0 -eq (count $argv)
    rdf_help
    return
  end
  switch $argv[1]
    case help
        rdf_help
    case home
        rdf_home
    case query
        rdf_query $argv[2]
    case '*'
      rdf_help
  end
end

function rdf_help -d "display usage info"
  
  echo "SPARQL:"
  colour_print normal "  Current store: "
  colour_print green $SPARQL_ENDPOINT
  echo ""
  colour_print normal "  Result Format: "
  colour_print green $SPARQL_DEFAULT_RESULT_FORMAT
  echo ""
  echo ""

  echo "USAGE:"
  echo ""
  echo "rdf <command> [options] [args] <query>"
  echo ""
  _fd_display_option 'rdf' "help" "display usage info"
  _fd_display_option 'rdf' "home" "go to the root directory of the current rdf"
  _fd_display_option 'rdf' "query" "list all available rdfs"
end

function rdf_query -a sparql_query -d 'send a sparql query to the registered server'
    pushd .
    cd $JENA_HOME
    echo query: $sparql_query
    echo to: $SPARQL_ENDPOINT
    echo "$sparql_query" | ./bin/rsparql --results=$SPARQL_DEFAULT_RESULT_FORMAT --service=$SPARQL_ENDPOINT --query=-
    popd
end

function rdf_update -a sparql_update -d 'send a sparql update to the registered server'
    pushd .
    cd $JENA_HOME
    echo update: $sparql_update
    echo to: $SPARQL_ENDPOINT
    echo "$sparql_update" | ./bin/rupdate --results=$SPARQL_DEFAULT_RESULT_FORMAT --service=$SPARQL_ENDPOINT --update=-
    popd
end