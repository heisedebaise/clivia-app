#!/bin/bash

rm -rf build

flutter build web

#dir=~/tomcat/webapps/ROOT
dir=../clivia/clivia-web/src/main/webapp
rm -rf $dir/*.*
rm -rf $dir/assets
rm -rf $dir/icons
rm -rf $dir/.last_build_id
cp -rf build/web/** $dir/