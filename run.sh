#!/bin/bash
now=`date +%Y-%m-%d-%H-%M-%S`

az deployment group create --name main-deployment-bicep-lab-$now --resource-group pergus-bicep --template-file ./main.bicep