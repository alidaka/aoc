#!/bin/bash -e
script=""
set_script() {
  script=$1
}

# $1 is expected, $2 is input
verify_equal() {
  if [ "$script" == "" ];
  then
    echo "Call set_script!"
    exit 1
  fi

  actual=$(runhaskell $script "$2")

  if [ "$1" != "$actual" ];
  then
    echo "Failed!"
    echo "Expected: $1"
    echo "Actual: $actual"
    exit 1
  fi
}
