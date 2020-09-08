#!/bin/bash

####
#
# Script to dynamically build a instackenv.json
# file for importing OpenStack nodes from IBM CLoud Baremetal
#
# Written By: Thomas Crowe
# Date: Sept. 2020
#
####

IC=/usr/local/bin/ibmcloud

NODES=($(${IC} sl hardware list --tag $1 --output json | jq '.[].id'))
len=${#NODES[@]}
let stop="${len} - 1" 
count=0

# Print instackenv.json preamble

echo "{"
echo "  nodes:["


for i in ${NODES[@]}
do
  JSON=$(${IC} sl hardware detail ${i} --output json)
  HOSTNAME=$(echo ${JSON} | jq -r '.hostname')
  PM_ADDR=$(echo ${JSON} | jq -r '.networkComponents[0].ipmiIpAddress')
  MAC=$(echo ${JSON} | jq -r '.networkComponents[1].macAddress')
  PM_PASSWORD=$(echo ${JSON} | jq -r '.remoteManagementAccounts[0].password')
  PM_USER=$(echo ${JSON} | jq -r '.remoteManagementAccounts[0].username')
  echo "    {"
  echo "      name: $HOSTNAME,"
  echo "      mac: ["
  echo "        $MAC"
  echo "      ],"
  echo "      pm_user: $PM_USER,"
  echo "      pm_password: $PM_PASSWORD,"
  echo "      pm_addr: $PM_ADDR,"
  echo "      pm_type: ipmi,"
  echo "      arch: x86_64,"
  if [ $count = $stop ]
    then
      echo "    }"
    else
      echo "    },"
  fi
  count=$(( $count + 1 ))
done

# Print postamble

echo "  ]"
echo "}"
