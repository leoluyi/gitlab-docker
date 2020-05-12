# GitLab with Docker

## Getting Started

```bash
git clone https://github.com/leoluyi/gitlab-docker
cd gitlab-docker

docker-compose up
# or run the service as daemon
docker-compose up -d 
```

Then check your browser http://localhost:9000/

## Backup and Restore Volumes

Edit the backup path in the following files then run:

```bash
./backup.sh
./restore.sh
```

## SMTP Settings

To access GitLab’s configuration file, you can start a shell session in the context of a running container. This will allow you to browse all directories and use your favorite text editor:

```bash
docker exec -it gitlab_web_1 vim /etc/gitlab/gitlab.rb
```

[Example configurations](https://docs.gitlab.com/omnibus/settings/smtp.html)

```
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.server"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "smtp user"
gitlab_rails['smtp_password'] = "smtp password"
gitlab_rails['smtp_domain'] = "example.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'

# If your SMTP server does not like the default 'From: gitlab@localhost' you
# can change the 'From' with this setting.
gitlab_rails['gitlab_email_from'] = 'gitlab@example.com'
gitlab_rails['gitlab_email_reply_to'] = 'noreply@example.com
```

Then run:

```bash
docker-compose restart
```
