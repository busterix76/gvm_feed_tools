#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}######UPDATING NVT######${NC}"
/opt/gvm/bin/greenbone-nvt-sync
	if [ "$?" == "0" ]; then
		nvt_state="OK"
	else
		nvt_state="Not OK"
	fi
echo " "
echo -e "${GREEN}######UPDATING NVT FINISHED######${NC}"




echo -e "${RED}######UPDATING OPENVAS DB######${NC}"
sudo /opt/gvm/sbin/openvas -u
        if [ "$?" == "0" ]; then
                update_state="OK"
        else
                update_state="Not OK"
        fi
echo " "
echo -e "${GREEN}######UPDATING OPENVAS DB FINISHED######${NC}"




echo -e "${RED}######UPDATING GVMD_DATA######${NC}"
/opt/gvm/sbin/greenbone-feed-sync --type GVMD_DATA
        if [ "$?" == "0" ]; then
                gvmd_state="OK"
        else
                gvmd_state="Not OK"
        fi
echo " "
echo -e "${GREEN}######UPDATING GVMD_DATA FINISHED######${NC}"




echo -e "${RED}######UPDATING SCAP DATA######${NC}"
/opt/gvm/sbin/greenbone-feed-sync --type SCAP
        if [ "$?" == "0" ]; then
                scap_state="OK"
        else
                scap_state="Not OK"
        fi
echo " "
echo -e "${GREEN}######UPDATING SCAP DATA FINISHED######${NC}"




echo -e "${RED}######UPDATING CERT DATA######${NC}"
/opt/gvm/sbin/greenbone-feed-sync --type CERT
        if [ "$?" == "0" ]; then
                cert_state="OK"
        else
                cert_state="Not OK"
        fi
echo " "
echo -e "${GREEN}######UPDATING CERT DATA FINISHED######${NC}"



echo NVT STATUS:     $nvt_state
echo UPDATE STATUS:  $update_state
echo GVMD STATUS:    $gvmd_state
echo SCAP STATUS:    $scap_state
echo CERT STATUS:    $cert_state
