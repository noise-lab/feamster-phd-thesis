#!/bin/sh

latex thesis | grep -i "warning: citation" | sort | cut -f 4 -d ' ' | uniq -c
