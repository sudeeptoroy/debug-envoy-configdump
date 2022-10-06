#!/bin/bash

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -al|--all-listerners)
            cat $filename | jq '.configs[]|select(."@type"=="type.googleapis.com/envoy.admin.v3.ListenersConfigDump")'.dynamic_listeners[].name
            shift # past arg
            shift # past value
            ;;
        -l|--one-listener)
            query=".dynamic_listeners[]|select(.name==\"$2\")"
            cat $filename | jq '.configs[]|select(."@type"=="type.googleapis.com/envoy.admin.v3.ListenersConfigDump")' | jq $query
            shift # past arg
            shift # past value
            ;;
        -ar|--all-routes)
            cat $filename | jq '.configs[]|select(."@type"=="type.googleapis.com/envoy.admin.v3.RoutesConfigDump")'.dynamic_route_configs[].route_config.name
            shift # past arg
            shift # past value
            ;;
        -r|--one-route)
            query=".dynamic_route_configs[].route_config|select(.name==\"$2\")"
            cat $filename | jq '.configs[]|select(."@type"=="type.googleapis.com/envoy.admin.v3.RoutesConfigDump")' | jq $query
            shift # past arg
            shift # past value
            ;;
        -ac|--all-clusters)
            cat $filename | jq '.configs[]|select(."@type"=="type.googleapis.com/envoy.admin.v3.ClustersConfigDump")'.dynamic_active_clusters[].cluster.name
            shift # past arg
            shift # past value
            ;;
        -c|--one-cluster)
            query=".dynamic_active_clusters[].cluster|select(.name==\"$2\")"
            cat $filename | jq '.configs[]|select(."@type"=="type.googleapis.com/envoy.admin.v3.ClustersConfigDump")' | jq $query
            shift # past arg
            shift # past value
            ;;
        -f|--filename)
            filename=$2
            shift # past arg
            shift # past value
            ;;
        -h|--help)
            echo "options: -f filename, -al( print all listeners), -l ( print one listener) , -r, -c"
            exit
            ;;
        *)
            echo "invalid arg"
            exit
            ;;
    esac
done


