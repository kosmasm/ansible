#!/bin/bash
exitcode=0

for a in $(cat certificate-sites.conf); do
  days=$(./ssl_cert_check.sh expire $a)
  (( $days <= 10 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days. | mailx -s "WARINING!!! Site $a certificate expires in $days days" -S smtp-auth=login -S smtp-use-starttls -S smtp=smtp.ip.address -S from="user@domain.com" -S smtp-auth-user=user@domain.com -S smtp-auth-password="somepassword" -S ssl-verify=ignore kosmas@kosmas.gr
  echo WARNING\!\!\! Site $a certificate expiring in $days days.
  exitcode=2
  }
  (( $days == 15 )) && {
  echo WARNING\!\!\! Site $a certificate expiring in $days days. | mailx -s "WARINING!!! Site $a certificate expires in $days days" -S smtp-auth=login -S smtp-use-starttls -S smtp=10.72.3.128 -S from="user@domain.com" -S smtp-auth-user=user@domain.com -S smtp-auth-password="somepassword" -S ssl-verify=ignore kosmas@kosmas.gr
  echo WARNING\!\!\! Site $a certificate expiring in $days days.
  exitcode=1
  }
  echo Site $a certificate expiring in $days days.
done
exit $exitcode
