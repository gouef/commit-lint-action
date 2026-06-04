#!/usr/bin/env bash
set -e

# Výchozí hodnoty (pokud uživatel nezadá vlastní přes args)
PREFIXES="Add|Fix|Update|Remove|Refactor|Docs|Test|Improve|Merge|Bump"
MIN_LENGTH=8

# Parsování argumentů pomocí getopts
while getopts "prefixes:minLength:" opt; do
  case $opt in
    prefixes) PREFIXES="$OPTARG" ;;
    minLength) MIN_LENGTH="$OPTARG" ;;
    *) echo "Unknown option"; exit 1 ;;
  esac
done

# Pre-commit posílá cestu k souboru s commit zprávou jako POSLEDNÍ argument
shift $((OPTIND -1))
COMMIT_MSG_FILE=$1

if [ -z "$COMMIT_MSG_FILE" ]; then
  echo "ERROR: Missing commit message file argument."
  exit 1
fi

COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")
PREFIXES_LIST=$(echo "$PREFIXES" | tr '|' ', ')

# Váš REGEX
REGEX="^(fixup! )*\[($PREFIXES)\] .{${MIN_LENGTH},}$|^Merge pull request #.*$|^Merge .* into .*$|^Revert \".*\"$|^Initial commit$|^Bump .*$|^Co-authored-by: .*$|^Signed-off-by: .*$"

if [[ ! $COMMIT_MSG =~ $REGEX ]]; then
  echo "ERROR: Invalid commit message: \"$COMMIT_MSG\""
  echo "Commit messages must match: '[TYPE] Description' (e.g., '[Add] New feature')."
  echo "[TYPE] allowed is: $PREFIXES_LIST"
  echo "Minimum description length is $MIN_LENGTH characters."
  exit 1
fi

echo "Commit message is valid!"
exit 0