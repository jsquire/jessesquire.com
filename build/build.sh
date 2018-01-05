#!/bin/bash

if [[ "$PWD" == *\/build ]]
then
  cd ..
fi

cd src

TARGETENV="$1"

if [ ${#TARGETENV} -gt 0 ];
then
  export JEKYLL_ENV=$TARGETENV
fi

bundle install
bundle exec jekyll build
