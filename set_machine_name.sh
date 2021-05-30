echo "# Static table lookup for hostnames.
# See hosts(5) for details.

127.0.0.1	localhost
::1		localhost
127.0.1.1	$1.localdomain $1" >> /etc/hosts
echo "$1" >> /etc/hostname

