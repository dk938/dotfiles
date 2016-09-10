#!/bin/bash
CORKSCREW=`which corkscrew`
$CORKSCREW proxy.*.*.jp 8080 $1 $2
