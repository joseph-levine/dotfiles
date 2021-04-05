function dns
 sudo dscacheutil -flushcache
 sudo killall -HUP mDNSResponder;
 if type dnsmasq >/dev/null 2>&1
	 sudo brew services restart dnsmasq >/dev/null 2>&1
 end
 printf '\033[32mflushed, killed\033[0m\n'
end
