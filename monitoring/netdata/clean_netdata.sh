#!/bin/bash
# completely uninstall / purge and remove all configs for netdata

# Netdata installed through Kickstarter.sh has a different directory structure from apt-get install netdata.
# this file gets them both gone, as well as any cloud affililations

sudo killall netdata

sudo wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --uninstall --non-interactive

sudo systemctl stop netdata
sudo systemctl disable netdata
sudo systemctl unmask netdata
sudo rm -rf /lib/systemd/system/netdata.service
sudo rm -rf /lib/systemd/system/netdata-updater.service
sudo rm -rf /lib/systemd/system/netdata-updater.timer
sudo rm -rf /etc/logrotate.d/netdata
sudo /usr/libexec/netdata/netdata-uninstaller.sh --yes --env /etc/netdata/.environment

sudo apt-get --purge remove netdata -y

sudo rm /usr/lib/netdata* -R
sudo rm /var/lib/apt/lists/packagecloud.io_netdata_* -R
sudo rm /etc/init.d/netdata
sudo rm /etc/rc0.d/K01netdata
sudo rm /etc/rc1.d/K01netdata
sudo rm /etc/rc2.d/K01netdata
sudo rm /etc/rc3.d/K01netdata
sudo rm /etc/rc4.d/K01netdata
sudo rm /etc/rc5.d/K01netdata
sudo rm /etc/rc6.d/K01netdata
sudo rm /etc/rc0.d/S01netdata
sudo rm /etc/rc1.d/S01netdata
sudo rm /etc/rc2.d/S01netdata
sudo rm /etc/rc3.d/S01netdata
sudo rm /etc/rc4.d/S01netdata
sudo rm /etc/rc5.d/S01netdata
sudo rm /etc/rc6.d/S01netdata
sudo rm /usr/sbin/netdata
sudo rm -rf /var/lib/dpkg/info/netdata* -R
sudo rm -rf /var/lib/apt/lists/packagecloud.io_netdata* -R
sudo rm -rf /usr/share/netdata -R
sudo rm -rf /usr/share/doc/netdata* -R
sudo rm /usr/share/lintian/overrides/netdata*
sudo rm /usr/share/man/man1/netdata.1.gz
sudo rm /var/lib/systemd/deb-systemd-helper-enabled/netdata.service.dsh-also
sudo rm /var/lib/systemd/deb-systemd-helper-enabled/multi-user.target.wants/netdata.service
sudo rm /var/lib/systemd/deb-systemd-helper-masked/netdata.service

sudo rm -rf /usr/lib/netdata -R
sudo rm -rf /etc/rc2.d/S01netdata -R
sudo rm -rf /etc/rc3.d/S01netdata -R
sudo rm -rf /etc/rc4.d/S01netdata -R
sudo rm -rf /etc/rc5.d/S01netdata -R
sudo rm -rf /etc/default/netdata -R
sudo rm -rf /etc/apt/sources.list.d/netdata.list
sudo rm -rf /etc/apt/sources.list.d/netdata-edge.list
sudo rm -rf /etc/apt/trusted.gpg.d/netdata-archive-keyring.gpg
sudo rm -rf /etc/apt/trusted.gpg.d/netdata-edge-archive-keyring.gpg
sudo rm -rf /etc/apt/trusted.gpg.d/netdata-repoconfig-archive-keyring.gpg
sudo rm -rf /SM_DATA/sm_virt_machines/media/netdata-uninstaller.sh
sudo rm -rf /SM_DATA/sm_virt_machines/media/netdata*
sudo rm -rf /SM_DATA/working/netdata-kickstart*
sudo rm -rf /usr/share/lintian/overrides/netdata
sudo rm -rf /var/cache/apt/archives/netdata*
sudo rm -rf /opt/netdata*
sudo rm -rf /etc/cron.daily/netdata-updater

sudo rm -rf /usr/libexec/netdata -R
sudo rm -rf /var/log/netdata -R
sudo rm -rf /var/cache/netdata -R
sudo rm -rf /var/lib/netdata -R
sudo rm -rf /etc/netdata -R
sudo rm -rf /opt/netdata -R

systemctl daemon-reload