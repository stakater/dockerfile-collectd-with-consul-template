#!/bin/bash

# We just start the collectd service and then leave consul-template running on the foreground.
# Here we use the CONSUL_URL environment variable that we defined before. Consul template
# expects to find a collectd.ctmpl file in /templates. This is the template that we would
# mount as a volume from our host. The result is then placed in /etc/collectd/conf.d/collectd.conf
# where collectd will be able to read from.
# collectd will run in a separate process and consul-template runs in this process
kill -9 `collectd.pid`
consul-template -consul=$CONSUL_URL -template="/templates/collectd.ctmpl:/etc/collectd/conf.d/collectd.conf:collectd -C /etc/collectd/conf.d/collectd.conf -P collectd.pid"
