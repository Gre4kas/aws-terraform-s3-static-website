#!/bin/bash

apply () {
    cd terraform || exit
    terraform init
    terraform apply --auto-approve
}

destroy () {
    cd terraform || exit
    terraform destroy --auto-approve
}

case "$1" in
    "apply") apply 
    ;;
    "destroy") destroy
    ;;
esac
