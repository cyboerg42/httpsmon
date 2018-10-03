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

#### Install crontab

```
crontab -e
```

```
SA_API_ENDPOINT="https://bhirx7b3p8.execute-api.sa-east-1.amazonaws.com/default/serverless_httpsMON"
SA_API_KEY="2IBJkyxXoG7EUWI6MTZnJhTf33Klr6Tyk9Nchxmg0"

# for batch request
* * * * * /bin/bash /root/scripts/batch_httpsMON.sh /home/root/scripts/sa_monitoring.list $SA_API_ENDPOINT $SA_API_KEY
* * * * * ( sleep 15 ; /bin/bash /root/scripts/batch_httpsMON.sh /root/scripts/sa_monitoring.list $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 30 ; /bin/bash /root/scripts/batch_httpsMON.sh /root/scripts/sa_monitoring.list $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 45 ; /bin/bash /root/scripts/batch_httpsMON.sh /root/scripts/sa_monitoring.list $SA_API_ENDPOINT $SA_API_KEY)

# for normal one-by-one request (low jitter!)
* * * * * /bin/bash /home/root/scripts/httpsMON.sh https://hot_spare.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY

* * * * * /bin/bash /home/root/scripts/httpsMON.sh https://old.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY
* * * * * ( sleep 30 ; /home/root/scripts/httpsMON.sh https://old.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)

* * * * * /bin/bash /home/root/scripts/httpsMON.sh https://demo.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY
* * * * * ( sleep 15 ; /home/root/scripts/httpsMON.sh https://demo.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 30 ; /home/root/scripts/httpsMON.sh https://demo.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 45 ; /home/root/scripts/httpsMON.sh https://demo.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)

* * * * * /bin/bash /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY
* * * * * ( sleep 5 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 10 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 15 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 20 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 25 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 30 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 35 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 40 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 45 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 50 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
* * * * * ( sleep 55 ; /home/root/scripts/httpsMON.sh https://important.example.com/login.php $SA_API_ENDPOINT $SA_API_KEY)
```
