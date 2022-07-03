#!/bin/bash
HELLO=hello
function hello {
  local HELLO=word
  echo $HELLO
}
echo $HELLO
hello
echo $HELLO
