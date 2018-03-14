#!/bin/bash

displayFolderPermissionsIfExist() {
  local folder=${1}

  if [ -e "${folder}" ]; then
    ls -dl "${folder}"
  else
    echo "No such folder: ${folder}"
  fi
}

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

echo "jar should be rw-r--r--:"
ls -l ${WORKDIR}/*/jboss-modules.jar
echo '===================================================='

echo "following folders should be drwxr-x--x:"
displayFolderPermissionsIfExist ${WORKDIR}/*/domain/
displayFolderPermissionsIfExist ${WORKDIR}/*/migration
displayFolderPermissionsIfExist ${WORKDIR}/*/bin
displayFolderPermissionsIfExist ${WORKDIR}/*/docs/examples
displayFolderPermissionsIfExist ${WORKDIR}/*/bin/client
echo '===================================================='

echo "following folders should be drwxrwx--x:"
displayFolderPermissionsIfExist ${WORKDIR}/*/domain/tmp
displayFolderPermissionsIfExist ${WORKDIR}/*/standalone/tmp
echo '===================================================='
readonly JARS_FILE_MASK='-rw-r--r--'
if [ -z "${NO_JAR}" ]; then
  echo -n "Looking for jars with priviliges different from ${JARS_FILE_MASK} ... "
  for jar in $(find ${WORKDIR}/*/modules/ -name *.jar)
  do
    ls -l "${jar}"
  done | sed -e "/${JARS_FILE_MASK}/d"
fi
rm -rf "${WORKDIR}"
echo 'Done.'
