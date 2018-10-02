# httpsmon
monitor HTTPs servers via AWS Lambda
#### Setup AWS Lambda Project

```
git clone https://github.com/cyborg00222/httpsmon
cd httpsmon
npm install
zip -r * ../httpsmon.zip
```

now upload the zip to AWS and deploy a new lambda project. - don't forget to create and deploy a API endpoint.

#### Install curl.

**Ubuntu/Debian:**

```
apt-get update
apt-get install curl
```

```
git clone https://github.com/cyborg00222/httpsmon
cd httpsmon
mkdir /root/scripts/
cp *.sh /root/scripts
```

now add your API keys&endpoints.

```
nano /root/scripts/httpmon.sh
```

#### Install crontab
```
crontab -e
* * * * * /bin/bash /home/root/scripts/httpsMON.sh https://demo.example.com/login.php
* * * * * ( sleep 15 ; /home/root/scripts/httpsMON.sh https://demo.example.com/login.php)
* * * * * ( sleep 30 ; /home/root/scripts/httpsMON.sh https://demo.example.com/login.php)
* * * * * ( sleep 45 ; /home/root/scripts/httpsMON.sh https://demo.example.com/login.php)
```
