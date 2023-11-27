# certbot DNS challenge hook for managing WHM CDN

## Requirement

```bash
whmapi1 version
```

This script will display your WHMAPI version. Please ensure that it is available.

## Usage

In order to use this script, follow these simple steps:

1. Run the following command in /etc/letsencrypt/scripts

```bash
cd /etc/letsencrypt/scripts
```

2. Clone the project

```bash
git clone https://github.com/javadmsd/certbot-whm-command.git
```

3. Type `cd certbot-whm-command` and press enter. You should now be in the certbot-whm-command directory

4. Type `chmod +x authenticator.sh` and `chmod +x cleanup.sh` in the terminal and press enter. This will make the script executable.

5. Install `certbot` package

```bash
sudo apt update
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot --version
```

6. Run the following command

```bash
certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook ./authenticator.sh --manual-cleanup-hook ./cleanup.sh -d *.example.com
```

If you do not receive the following message at the end, continue with the steps

```
Certbot has set up a scheduled task to automatically renew this certificate in the background.
```

7. If Use the command `crontab -e` to open the cron jobs for renew certificates

```bash
crontab -e
```

8. Press `i` on the keyboard to insert a new line.

9. Type the following line

```bash
certbot renew --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /etc/letsencrypt/scripts/certbot-whm-command/authenticator.sh --manual-cleanup-hook /etc/letsencrypt/scripts/certbot-whm-command/cleanup.sh -d *.example.com >> /etc/letsencrypt/scripts/certbot-whm-command/certbot.renew.log
```

10. Press `Esc`.

11. Type `:wq` and press `Enter` to save the changes.

12. Now the script is ready to be used.
