zimbra-munin
============

Munin plugins to monitor Zimbra metrics reported by zmprov.

* zimbraAggrQuota - monitor Aggregate Quota
* zimbraCount - monitor various object counts e.g. account, alias, dl, etc

Because zmprov takes a few seconds to return answers, we use a cronjob
to write values to a file, and plugins read values for the file instantly.

Installation
============

Execute install.sh as root.
Then restart munin-node service and wait ~10 minutes for graphs to appear.

Notes
=====

Tested with Zimbra 8.0.x and Munin 2.0.x.

