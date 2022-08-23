#!/bin/sh

export MANAGE_LOCAL_HBASE=true
export MANAGE_LOCAL_SOLR=true
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

/opt/plugin/ranger-2.1.0-atlas-plugin/enable-atlas-plugin.sh

/opt/atlas/bin/atlas_start.py
sh /tmp/atlas-setup.sh

tail -f /dev/null
