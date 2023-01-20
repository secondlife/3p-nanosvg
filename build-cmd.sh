#!/usr/bin/env bash

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x
# make errors fatal
set -e
# complain about unset env variables
set -u

# check autobuild is around or fail
if [ -z "$AUTOBUILD" ] ; then
    exit 1
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    autobuild="$(cygpath -u $AUTOBUILD)"
else
    autobuild="$AUTOBUILD"
fi

STAGING_DIR="$(pwd)"
TOP_DIR="$(dirname "$0")"
SRC_DIR="${TOP_DIR}/nanosvg"

# load autobuild provided shell functions and variables
source_environment_tempfile="$STAGING_DIR/source_environment.sh"
"$autobuild" source_environment > "$source_environment_tempfile"
set +x
. "$source_environment_tempfile"
set -x

mkdir -p "$STAGING_DIR"/LICENSES
cp "$SRC_DIR"/LICENSE.txt "$STAGING_DIR"/LICENSES/nanosvg.txt

mkdir -p "$STAGING_DIR"/include/nanosvg
cp "$SRC_DIR"/src/*.h "$STAGING_DIR"/include/nanosvg
