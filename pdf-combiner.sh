#/bin/bash

function help {
    echo "Usage: 
  $(basename $0) [options] <file>...
    
Combines multiple pdf files into a single output pdf.

Options:
  -h, --help            display this help
  -o, --output <file>   set the output file to <file>
"
    exit 0
}

function error {
    echo "error: $@"
    echo "try '$(basename $0) -h' for help"
    exit 1
}


# Now lets parse the arguments

POSITIONAL_ARGS=()

OUTPUT_FILE="out.pdf"

while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            OUTPUT_FILE="$2"
            shift # shift past the -o|--output 
            shift # shift past the value
            ;;
        -h|--help)
            help
            exit 0
            ;;
        -*|--*)
            error "unknown option $1"
            ;;
        *)
            POSITIONAL_ARGS+=("$1")
            shift
            ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters


[[ $# -lt 1 ]] && error "no input files provided"

# call pdfunite
pdfunite "$@" "$OUTPUT_FILE"

