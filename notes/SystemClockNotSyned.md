# Time is not synced correctly.
Try if `timedatectl` give you correct output.

It might tell you NTP is inactive.
NTP is a utility to get time from a server through package exchange.

Try edit `/etc/systemd/timesyncd.conf`
Add a new line under `[Time]`
`NTP=time.cloudflare.com`
We will use Cloudflare server to configure the time.

Then restart the NTP service by `systemctl restart systemd-timesyncd.service`

If `timedatectl` still says NTP inactive, try enable NTP manually
`timedatectl set-ntp true`
