rc-status
/etc/init.d/sshd restart
echo "root:root" | chpasswd
nginx
while pgrep nginx > /dev/null && pgrep sshd > /dev/null; do
	sleep 1;
done