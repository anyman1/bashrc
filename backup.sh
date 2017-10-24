Backstuffup.sh

#!/bin/bash

PP1='172.16.43.11'
SERVERUP=$(fping $SATURN | grep alive)

function noconnection {

if [ "$SERVERUP" != $PP1" is alive" ]; then 
    /usr/bin/posttoslack.sh -t "PP1 backup" -b "@anthony.nyman the PP1 backup server is unreachable" -c "#it" -u "https://hooks.slack.com/services/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"
   #echo "Saturn is unrechable" | /usr/sbin/ssmtp sysadm@digecor.com
   exit 0
fi
}

function syncthis {

echo "running rsync" 
/usr/bin/rsync -av /content-xfer/ -e ssh root@$PP1:/content-xfer/

}

function syncsvn {

echo "running rsync" 
/usr/bin/rsync -av /srv/svn/ -e ssh root@$PP1:/srv/svn/

}

function syncopenvpn {

echo "running rsync" 
/usr/bin/rsync -av /etc/openvpn/ -e ssh root@$PP1:/etc/openvpn/

}

function completecheck {
if [ $? == 0 ]; then
     /usr/bin/posttoslack.sh -t "PP1 backup" -b "@anthony.nyman the PP1 backup to saturn has completed succesfully" -c "#it" -u "https://hooks.slack.com/services/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"
    #echo "Kronos rsync backup completed succesfully" | /usr/sbin/ssmtp sysadm@digecor.com  
else
    /usr/bin/posttoslack.sh -t "PP1 backup" -b "@anthony.nyman the PP1 backup has failed due to adam" -c "#it" -u "https://hooks.slack.com/services/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"
    #echo "Kronos rsync backup failed" | /usr/sbin/ssmtp sysadm@digecor.com 
fi
}

noconnection
syncsvn
completecheck
syncopenvpn
completecheck
syncthis
complete check

check disk space script below. 

#!/bin/bash

#you can set up the threshold to anything you need and it will post to slack. 

CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=95

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
       posttoslack.sh -t "Disktest pp1" -b "@anthony.nyman PP1 is at 95% diskspace check on that." -c "#it" -u "https://hooks.slack.com/services/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"
fi

Command for posting to Slack IT 

posttoslack.sh -t "this" -b "@jeff.anderson I am Kronos Fear Me!" -c "#it" -u "https://hooks.slack.com/services/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"

The post to slack script is below. 

#!/bin/bash
function usage {
    programName=$0
    echo "description: use this program to post messages to Slack channel"
    echo "usage: $programName [-t \"sample title\"] [-b \"message body\"] [-c \"mychannel\"] [-u \"slack url\"]"
    echo "    -t    the title of the message you are posting"
    echo "    -b    The message body"
    echo "    -c    The channel you are posting to"
    echo "    -u    The slack hook url to post to"
    exit 1
}
while getopts ":t:b:c:u:h" opt; do
  case ${opt} in
    t) msgTitle="$OPTARG"
    ;;
    u) slackUrl="$OPTARG"
    ;;
    b) msgBody="$OPTARG"
    ;;
    c) channelName="$OPTARG"
    ;;
    h) usage
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
if [[ ! "${msgTitle}" ||  ! "${slackUrl}" || ! "${msgBody}" || ! "${channelName}" ]]; then
    echo "all arguments are required"
    usage
fi
read -d '' payLoad << EOF
{
        "channel": "#${channelName}",
        "username": "$(hostname)",
        "icon_emoji": ":sunglasses:",
        "attachments": [
            {
                "fallback": "${msgTitle}",
                "color": "good",
                "title": "${msgTitle}",
                "fields": [{
                    "title": "message",
                    "value": "${msgBody}",
                    "short": false
                }]
            }
        ]
    }
EOF
statusCode=$(curl \
        --write-out %{http_code} \
        --silent \
        --output /dev/null \
        -X POST \
        -H 'Content-type: application/json' \
        --data "${payLoad}" ${slackUrl})
echo ${statusCode}
#example
#./posttoslack.sh -t "this" -b "@jeff.anderson I am Kronos Fear Me!" -c "#it" -u "https://hooks.slack.com/services/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"

Setting up madam

mdadm --create --verbose /dev/md3 --level=5 --raid-devices=  18  /dev/sdf  /dev/sdi  /dev/sdl  /dev/sdo  /dev/sdr  /dev/sdu /dev/sdg  /dev/sdj  /dev/sdm  /dev/sdp  /dev/sds  /dev/sdv  /dev/sde /dev/sdh  /dev/sdk  /dev/sdn  /dev/sdq  /dev/sdt   --spare-devices=1 /dev/sdw

 /dev/sdf  /dev/sdi  /dev/sdl  /dev/sdo  /dev/sdr  /dev/sdu /dev/sdg  /dev/sdj  /dev/sdm  /dev/sdp  /dev/sds  /dev/sdv  /dev/sde /dev/sdh  /dev/sdk  /dev/sdn  /dev/sdq  /dev/sdt  /dev/sdw

Cron Jobs 

crontab -e

If you want a cron to run once a day 17 15 * * * root newmail.sh
