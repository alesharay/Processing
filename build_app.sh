#!/bin/bash

usage () {
  echo ; echo "usage: $0 OR $0 [sketch name]"; echo ;

  echo "NOTE: If run without a sketch name, the user will be prompted for one"

  exit 0
}


SKETCH=$1

if [ -z "$SKETCH" ]; then
  read -p "Please enter the name of the sketch you would like to run (q to quit): " SKETCH
  if [ $SKETCH == q ]; then
    echo "quitting..."
    exit 0
  fi
fi

if [[ ! -e $SKETCH ]]; then 
  usage
fi

processing-java --sketch=$PWD/$SKETCH --export