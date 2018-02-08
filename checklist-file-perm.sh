#!/bin/bash

readonly ZIP_FILE=${1}

listPrivilegesIfFileExist() {
  local file=${1}

  if [ -e "${file}" ]; then
    ls -ld "${file}"
  else
    echo "No such file in the archive:${file}"
  fi
}

if [ ! -e "${ZIP_FILE}" ]; then
  echo "No such file: ${ZIP_FILE}."
  exit 1
fi

readonly TARGET_DIR=$(mktemp -d)

unzip "${ZIP_FILE}" -d "${TARGET_DIR}" 2>&1 > /dev/null
echo "Check that all *.sh are associated to 755 (-rwxr-xr-x):"
ls -ld $(find "${TARGET_DIR}" -name '*.sh')

echo "Check that all */tmp/auth folders are associated to 700 (drwx-------):"
ls -ld $(find "${TARGET_DIR}" -name 'auth' -type d )

echo "Check that all *-users.properties folders  are associated to 600 (-rw--------):"
ls -ld $(find "${TARGET_DIR}" -name '*-users.properties' )

echo "Check that all .installation folder are associated to 600 (drw-------):"
ls -ld $(find "${TARGET_DIR}" -name ".installation" -type d)

echo "===== CHANGES ===== "
echo "Check that domain/tmp and standalone/tmp are associated to 771 (drwxrwx--x):"
listPrivilegesIfFileExist ${TARGET_DIR}/*/domain/tmp
listPrivilegesIfFileExist ${TARGET_DIR}/*/standalone/tmp

echo "Check that the following folders are associated to 751 (drwxr-x--x):"
listPrivilegesIfFileExist ${TARGET_DIR}/*/bin
listPrivilegesIfFileExist ${TARGET_DIR}/*/domain
listPrivilegesIfFileExist ${TARGET_DIR}/*/migration
listPrivilegesIfFileExist ${TARGET_DIR}/*/standalone
listPrivilegesIfFileExist ${TARGET_DIR}/*/bin/client
listPrivilegesIfFileExist ${TARGET_DIR}/*/docs/examples
listPrivilegesIfFileExist ${TARGET_DIR}/*/docs/schema
listPrivilegesIfFileExist ${TARGET_DIR}/*/docs/licenses

rm -rf "${TARGET_DIR}"
