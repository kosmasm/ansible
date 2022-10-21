#!/bin/bash
for a in $(cat certificate-sites.conf); do
  days=$(ssl_cert_check.sh expire $a)
  (( $days <= 10 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days. | mailx -s "WARINING!!! Site $a certificate expires in $days days" -r support@kosmas.gr -S smtp=127
  }
done
for a in $(cat certificate-sites.conf); do
  days=$(ssl_cert_check.sh expire $a)
  (( $days == 15 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days. | mailx -s "WARINING!!! Site $a certificate expires in $days days" -r support@kosmas.gr -S smtp=127
  }
done
exit 0
