#!/bin/bash

DEST="/opt/zimbra/data/munin"
TF=$(mktemp)

echo "Installing munin plugins in /etc/munin/plugins."
install -m 755 zimbraAggrQuota /etc/munin/plugins/
install -m 755 zimbraCount /etc/munin/plugins/

echo "Configuring munin-node to run plugins as zimbra."
cat << EOF > /etc/munin/plugin-conf.d/zimbra
[zimbra*]
  user zimbra
  group zimbra
EOF

echo "Installing config files in ${DEST}."
install -o zimbra -g zimbra -m 755 -d ${DEST}
install -o zimbra -g zimbra -m 644 zimbra.commands ${DEST}
install -o zimbra -g zimbra -m 755 zimbra.cronjob ${DEST}

echo "Activating cronjob every 5 minutes."
crontab -l -u zimbra > ${TF}
echo "*/5 * * * * ${DEST}/zimbra.cronjob" >> ${TF}
crontab -u zimbra ${TF}
rm -f ${TF}

echo "Now restart munin-node and wait for graphs to appear."
