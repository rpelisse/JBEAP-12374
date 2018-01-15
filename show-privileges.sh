#!/bin/bash

readonly ZIP_FILE=${1}

if [ ! -e "${ZIP_FILE}" ]; then
  echo "${ZIP_FILE} does not exist. Abort."
  exit 1
fi

readonly WORKDIR=${WORKDIR:-$(mktemp -d)}

if [ -e "${ZIP_FILE}" ] ; then
  echo -n "Extracting ${ZIP_FILE} archive into ${WORKDIR}..."
  unzip "${ZIP_FILE}" -d "${WORKDIR}" > /dev/null
  echo 'Done.'
fi

ls -l ${WORKDIR}/*/jboss-modules.jar
ls -l ${WORKDIR}/*/domain/  -d
readonly JARS_FILE_MASK='-rw-rw-r--'
if [ -z "${NO_JAR}" ]; then
  echo -n "Looking for jars with priviliges different from ${JARS_FILE_MASK} ... "
  for jar in $(find ${WORKDIR}/*/modules/ -name *.jar)
  do
    ls -l "${jar}"
  done | sed -e "/${JARS_FILE_MASK}/d"
fi
echo 'Done.'
