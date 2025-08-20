#!/bin/bash
 
echo "THIS WILL DELETE THE ENTIRE ASM TOPOLOGY"
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Nn]$ ]]
then
    exit
fi

echo "You must be in the correct project; use this command: oc project <name of project>"
read -p "Are you in the right project? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Nn]$ ]]
then
    exit
fi

echo "proceeding...."
#ASMINDEX=$(oc exec `oc get pod -l app=search -o jsonpath={.items[0].metadata.name}` -- bash -c 'grep indexName /opt/ibm/search-service/search-service.yml' |grep indexName |awk '{print $2}')
#echo $ASMINDEX
ASMINDEX=searchservice
echo "will run command 'curl -X DELETE http://localhost:9200/$ASMINDEX*'"
echo "scaling down topology deployments...ignore 'NotFound' messages"
oc scale deployment evtmanager-topology-appdynamics-observer --replicas=0
oc scale deployment evtmanager-topology-bigfixinventory-observer --replicas=0
oc scale deployment evtmanager-topology-docker-observer --replicas=0
oc scale deployment evtmanager-topology-file-observer --replicas=0
oc scale deployment evtmanager-topology-itnm-observer --replicas=0
oc scale deployment evtmanager-topology-noi-gateway --replicas=0
oc scale deployment evtmanager-topology-noi-probe --replicas=0
oc scale deployment evtmanager-topology-observer-service --replicas=0
oc scale deployment evtmanager-topology-openstack-observer --replicas=0
oc scale deployment evtmanager-topology-rest-observer --replicas=0
oc scale deployment evtmanager-topology-search --replicas=0
oc scale deployment evtmanager-topology-servicenow-observer --replicas=0
oc scale deployment evtmanager-topology-status --replicas=0
oc scale deployment evtmanager-topology-topology --replicas=0
oc scale deployment evtmanager-topology-ui-api --replicas=0
oc scale deployment evtmanager-topology-vmvcenter-observer --replicas=0
oc scale deployment evtmanager-topology-layout --replicas=0
oc scale deployment evtmanager-topology-merge --replicas=0
oc scale deployment evtmanager-topology-search --replicas=0
oc scale deployment evtmanager-topology-status --replicas=0
oc scale deployment evtmanager-topology-topology --replicas=0
oc scale deployment evtmanager-topology-kubernetes-observer --replicas=0
oc scale deployment evtmanager-topology-aws-observer --replicas=0
echo "sleeping for 60 seconds"
sleep 10
echo "sleeping 50 seconds"
sleep 10
echo "sleeping 40 seconds"
sleep 10
echo "sleeping 30 seconds"
sleep 10
echo "sleeping 20 seconds"
sleep 10
echo "sleeping 10 seconds"
sleep 10
echo "deleting entries"
oc exec evtmanager-topology-elasticsearch-0 -- bash -c 'curl -X DELETE http://localhost:9200/searchservice*'
oc exec evtmanager-cassandra-0 -- bash -c 'cqlsh -u $CASSANDRA_USER -p $CASSANDRA_PASS -e "DROP KEYSPACE janusgraph" --request-timeout=3600'
echo ""
echo "scaling up topology deployments"
oc scale deployment evtmanager-topology-appdynamics-observer --replicas=1
oc scale deployment evtmanager-topology-bigfixinventory-observer --replicas=1
oc scale deployment evtmanager-topology-docker-observer --replicas=1
oc scale deployment evtmanager-topology-file-observer --replicas=1
oc scale deployment evtmanager-topology-itnm-observer --replicas=1
oc scale deployment evtmanager-topology-noi-gateway --replicas=1
oc scale deployment evtmanager-topology-noi-probe --replicas=1
oc scale deployment evtmanager-topology-observer-service --replicas=1
oc scale deployment evtmanager-topology-openstack-observer --replicas=1
oc scale deployment evtmanager-topology-rest-observer --replicas=1
oc scale deployment evtmanager-topology-search --replicas=1
oc scale deployment evtmanager-topology-servicenow-observer --replicas=1
oc scale deployment evtmanager-topology-status --replicas=1
oc scale deployment evtmanager-topology-topology --replicas=1
oc scale deployment evtmanager-topology-ui-api --replicas=1
oc scale deployment evtmanager-topology-vmvcenter-observer --replicas=1
oc scale deployment evtmanager-topology-layout --replicas=1
oc scale deployment evtmanager-topology-merge --replicas=1
oc scale deployment evtmanager-topology-search --replicas=1
oc scale deployment evtmanager-topology-status --replicas=1
oc scale deployment evtmanager-topology-topology --replicas=1
oc scale deployment evtmanager-topology-kubernetes-observer --replicas=1
oc scale deployment evtmanager-topology-aws-observer --replicas=1