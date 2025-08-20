#!/bin/bash
 
echo "THIS WILL DELETE THE ALL METRICS FROM EVENT MANAGER"
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
echo "scaling down metrics deployments"
oc scale deployment evtmanager-metric-action-service-metricactionservice --replicas=0
oc scale deployment evtmanager-metric-api-service-metricapiservice --replicas=0
oc scale deployment evtmanager-metric-spark-service-metricsparkservice --replicas=0
oc scale deployment evtmanager-metric-trigger-service-metrictriggerservice --replicas=0
echo "sleeping for 60 seconds"
sleep 10
echo "sleeping for 50 seconds"
sleep 10
echo "sleeping for 40 seconds"
sleep 10
echo "sleeping for 30 seconds"
sleep 10
echo "sleeping for 20 seconds"
sleep 10
echo "sleeping for 10 seconds"
sleep 10
echo "deleting entries"
oc exec evtmanager-cassandra-0 -- bash -c 'cqlsh -u $CASSANDRA_USER -p $CASSANDRA_PASS -e "truncate tararam.dt_metric_value; truncate tararam.md_metric_resource;" --request-timeout=3600'
echo ""
echo "scaling up metric deployments"
oc scale deployment evtmanager-metric-action-service-metricactionservice --replicas=1
oc scale deployment evtmanager-metric-api-service-metricapiservice --replicas=1
oc scale deployment evtmanager-metric-spark-service-metricsparkservice --replicas=1
oc scale deployment evtmanager-metric-trigger-service-metrictriggerservice --replicas=1
echo "you may need to wait a little for the pods to be fully initialized"
