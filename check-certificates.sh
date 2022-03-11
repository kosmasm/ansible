#!/bin/bash
exitcode=0

for a in $(cat ansible/certificate-sites.conf); do
  days=$(ansible/ssl_cert_check.sh expire $a)
  (( $days <= 10 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days. | mailx -s "WARINING!!! Site $a certificate expires in $days days" -S smtp-auth=login -S smtp-use-starttls -S smtp=10.72.3.128 -S from="webmail@kotsovolos.gr" -S smtp-auth-user=webmail@kotsovolos.gr -S smtp-auth-password="555W3bm@il" -S ssl-verify=ignore kosmas@kosmas.gr
  echo WARNING\!\!\! Site $a certificate expiring in $days days.
  exitcode=2
  }
  (( $days == 15 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days. | mailx -s "WARINING!!! Site $a certificate expires in $days days" -S smtp-auth=login -S smtp-use-starttls -S smtp=10.72.3.128 -S from="webmail@kotsovolos.gr" -S smtp-auth-user=webmail@kotsovolos.gr -S smtp-auth-password="555W3bm@il" -S ssl-verify=ignore kosmas@kosmas.gr
  echo WARNING\!\!\! Site $a certificate expiring in $days days.
  exitcode=1
  }
  echo Site $a certificate expiring in $days days.
done
exit $exitcode
