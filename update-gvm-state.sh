feedstate_scap=$(/opt/gvm/sbin/greenbone-feed-sync --type SCAP --feedversion | grep -E -o '^........')
feedstate_gvmd=$(/opt/gvm/sbin/greenbone-feed-sync --type GVMD_DATA --feedversion | grep -E -o '^........')
feedstate_cert=$(/opt/gvm/sbin/greenbone-feed-sync --type CERT --feedversion | grep -E -o '^........')
feedstate_nvt=$(/opt/gvm/bin/greenbone-nvt-sync --feedversion | grep -E -o '^........')
 
#mydate=$(date +%Y%m%d)
mydate=$((`date +%s`/86400)) 

overallstate=0
 
##checking SCAP age
scap_feed_date=$((`date -d "$feedstate_scap" +%s`/86400))
scap_age=$(echo $((mydate-scap_feed_date)))
 
if (( $scap_age > 7 ));
        then
                scap_return="SCAP outated by $scap_age days!";
                echo $scap_return;
                overallstate=1;
        else
		scap_return="SCAP OK ($scap_age)";
                echo $scap_return;
fi
 
##checking GVMD age
gvmd_feed_date=$((`date -d "$feedstate_gvmd" +%s`/86400))
gvmd_age=$(echo $((mydate-gvmd_feed_date)))
 
if (( $gvmd_age > 45 ));
        then
                gvmd_return="GVMD might be outated by $gvmd_age days";
                echo $gvmd_return;
                overallstate=1;
        else
		gvmd_return="GVMD OK ($gvmd_age)";
                echo $gvmd_return;
fi
 
##checking CERT age
cert_feed_date=$((`date -d "$feedstate_cert" +%s`/86400))
cert_age=$(echo $((mydate-cert_feed_date)))
 
if (( $cert_age > 7 ));
        then
                cert_return="CERT outated by $cert_age days!";
                echo $cert_return;
                overallstate=1;
        else
		cert_return="CERT OK ($cert_age)";
                echo $cert_return;
fi
 
##checking NVT age
nvt_feed_date=$((`date -d "$feedstate_nvt" +%s`/86400))
nvt_age=$(echo $((mydate-nvt_feed_date)))
 
if (( $nvt_age > 7 ));
        then
                nvt_return="NVT outated by $nvt_age days!";
                echo $nvt_return;
                overallstate=1;
        else
		nvt_return="NVT OK ($nvt_age)";
                echo $nvt_return;
fi
 
#if [ "$overallstate" == "1" ];
#then printf "Subject: Check GVM Feedstate\n\nMaster,\n\nThe peasants disobey!\nSomething is wrong with the feeds!\nPlease check feedstates immediately!\n\n$scap_return\n$gvmd_return\n$cert_return\n$nvt_return\n\nYours sincerely,\nyour most humble servant \nGVM" | /usr/sbin/sendmail recipient@example.invalid

if [ "$overallstate" == "1" ];
then printf "Subject: Check GVM Feedstate\n\nMaster,\n\nThe peasants disobey!\nSomething is wrong with the feeds!\nPlease check feedstates immediately!\n\n$scap_return\n$gvmd_return\n$cert_return\n$nvt_return\n\nYours sincerely,\nyour most humble servant \nGVM" 
fi
