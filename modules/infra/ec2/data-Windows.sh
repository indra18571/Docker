<powershell>
mkdir c:\temp
echo "script starts" | Out-File c:\temp\ps-logs.txt
cd c:/users/Administrator/downloads
Start-Process msiexec.exe -Wait -ArgumentList ' /I "https://amazoncloudwatch-agent-eu-west-2.s3.eu-west-2.amazonaws.com/windows/amd64/latest/amazon-cloudwatch-agent.msi" /passive /quiet'
echo "Agent installed" | Out-File c:\temp\ps-logs.txt -Append
& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -s -c ssm:AmazonCloudWatch-Windows
echo "Agent config added" | Out-File c:\temp\ps-logs.txt -Append
shutdown /s /t 20
</powershell>