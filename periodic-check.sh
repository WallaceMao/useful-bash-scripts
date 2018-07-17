#!/bin/sh

# parameter passing template
set -e

PROGNAME=$(basename $0)

die() {
    echo "$PROGNAME: $*" >&2
    exit 1
}

success() {
    echo "$PROGNAME: $*"
    exit 0
}

usage() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi

    cat << EOF
Usage: $PROGNAME [OPTION ...] [command] [expect]
check if the command execution result meet the expected result at interval until check count exceed the limit

Options:
-h, --help                display this usage message and exit
-i, --interval [SECOND]   interval in second to check if meet the condition
-c, --count    [TIMES]    max count to try
EOF

    exit 1
}

command=""
expect=""
interval=5
count=12
while [ $# -gt 0 ] ; do
    case "$1" in
    -h|--help)
        usage
        ;;
    -i|--interval)
        interval="$2"
        shift
        ;;
    -c|--count)
        count="$2"
        shift
        ;;
    -*)
        usage "Unknown option '$1'"
        ;;
    *)
        if [ -z "$command" ] ; then
            command="$1"
        elif [ -z "$expect" ] ; then
            expect="$1"
        else
            usage "Too many arguments"
            die
        fi
        ;;
    esac
    shift
done

if [ -z "$expect" ] ; then
    usage "Not enough arguments"
    die
fi

# script
index=0
while true
do
  result=$(command)
  echo "date: $date: count: $count, index: $index, result: $result, expect: $expect"
  if [ $index -ge $count ]; then
    die "reach max count $count"
  fi
  if [ "$result" = "$expect" ]; then
    success "$command: successfully meet expect result: $expect" 
  fi 
  index=$((index+1))
  sleep ${interval}
done
