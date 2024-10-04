#/bin/bash

function help {
    echo "Usage: 
  $(basename $0) [options] <file>
    
Compresses the input pdf by converting it into jpgs and back into a pdf.

Options:
  -h, --help                display this help
  -o, --output     <file>   set the output file to <file>
  -r, --resolution <res>    set the resolution used during conversion
"
    exit 0
}

function error {
    echo "error: $@"
    echo "try '$(basename $0) -h' for help"
    exit 1
}

function cleanup {
    [[ -d "$TEMP_DIR" ]] && rm -r "$TEMP_DIR"
}

trap cleanup EXIT


# Now lets parse the arguments

POSITIONAL_ARGS=()

OUTPUT_FILE="out.pdf"
RESOLUTION="300"

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
        -r|--resolution)
            RESOLUTION="$2"
            shift
            shift
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

# do various checks on input files
[[ $# -lt 1 ]] && error "no input files provided"
[[ $# -gt 1 ]] && error "only one input file allowed"

INPUT_FILE="$1"

[[ -f "$INPUT_FILE" ]] || error "$INPUT_FILE: file not found"

# create a temp directory
TEMP_DIR=$(mktemp -d)
[[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]] && error "failed to create temp directory"

# call pdftoppm
pdftoppm -jpeg -r "$RESOLUTION" "$INPUT_FILE"  "$TEMP_DIR/img" || exit

# call img2pdf
img2pdf "$TEMP_DIR"/*.jpg --output "$OUTPUT_FILE" || exit

