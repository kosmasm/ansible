#!/bin/bash
ecode=0
for a in $(cat certificate-sites.conf); do
  days=$(./ssl_cert_check.sh expire $a)
  (( $days <= 10 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days.
  ecode=2
  }
done
for a in $(cat certificate-sites.conf); do
  days=$(./ssl_cert_check.sh expire $a)
  (( $days == 15 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days.
  ecode=1
  }
done
exit $ecode
