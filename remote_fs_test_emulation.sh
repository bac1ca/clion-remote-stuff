#!/bin/bash

# Emulation of CLion remote FS check (based on jsch-nio output)
# Find Action -> Show Remore Hosts Info

TMP_DIR="/tmp/host_info6265592826834716346"
TMP_FILE="/tmp/host_info6265592826834716346/file.txt"

mkdir $TMP_DIR
if test -e $TMP_FILE; then
  echo "[FAILED] $TMP_FILE exists"
  exit -1
fi

touch $TMP_FILE
stat --printf "%W%i%F%F%F%F%X%Y%s%A%U%G" $TMP_FILE

# write
cat > $TMP_FILE <<EOF
Hello, CLion!
EOF

# read
RESULT=$(dd bs=1 skip=0 if=$TMP_FILE 2> /dev/null)
echo $RESULT

# compare
if [ "$RESULT" = "Hello, CLion!" ]; then
    echo "[PASSED]"
else
    echo "[FAILED]"
fi

stat --printf "%W%i%F%F%F%F%X%Y%s%A%U%G" $TMP_DIR
ls -A -1 $TMP_DIR

unlink $TMP_FILE
rmdir $TMP_DIR
