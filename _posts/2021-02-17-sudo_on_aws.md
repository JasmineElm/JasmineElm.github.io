---
layout: post
title: sudo on AWS
date: 2021-02-17T12:46:58.000Z
categories: code
synopsis: Getting sudo to work on AWS isn't as obvious as it might be.
last-modified-date: '2021-06-12T16:40:09+01:00'

---

While following the [Linux Upskill challenge](https://github.com/snori74/linuxupskillchallenge/), I came across some unexpected behaviour:  issuing `sudo <command>` didn't prompt me for a password.
No problem I thought; I simply need to set a password for my account.  While I'm thinking of it, let's update the password for root too, after all our ec2 instance [isn't using a firewall](https://github.com/snori74/linuxupskillchallenge/blob/master/00-AWS-Free-Tier.md) yet.

```bash
su - root
passwd root
passwd ubuntu
exit
```

Passwords duly set, the password wasn't prompted:

![huh? Why am I not being asked for a password?]({{site.url}}/images/aws_passwd_01.jpg)

Let's check I'm in the `sudo` group:

![groups looks OK]({{site.url}}/images/aws_passwd_02.jpg)

So there must be some config that means I'm not prompted for a password.  Let's look at the `etc/sudoers` file:

```bash
cat /etc/sudoers
```

There's nothing in there that is obviously preventing the password prompt.  [This](https://askubuntu.com/questions/153933/no-password-prompt-at-sudo-command)
question on Stack Overflow suggests that the problem may be a file in `/etc/sudoers.d`.  Let's look for all instance of `NOPASSWD`

```bash
grep -rl NOPASSWD /etc/sudoers.d
```

_Output_

```bash
/etc/sudoers.d/90-cloud-init-users
```

Let's look at the file (note the lazy history expansion):

```bash
more $(!!)
```

_Output_

```bash
# User rules for ubuntu
ubuntu ALL=(ALL) NOPASSWD:ALL
```

This line means I'll never be prompted for a password.  Let's fix that by commenting it out.

```bash
su - root
vi /etc/sudoers.d/90-cloud-init-users
```

![wait, it's not writeable?]({{site.url}}/images/aws_passwd_03.jpg)

Oh! The file isn't writeable.  I could use `visudo` to edit it, but that is defaulting to use `nano`. Ugh, no thanks.

Instead, let's check, and fix the file permissions

```bash
ls -l /etc/sudoers.d/90-cloud-init-users
```

![what permissions does the file have?]({{site.url}}/images/aws_passwd_04.jpg)

It's owned by root, but root cannot write to it.  Let's temporarily make the file writeable:

```bash
chmod 640 /etc/sudoers.d/90-cloud-init-users
```

Now we can edit it, and return the permissions

![editing once the permissions are changed]({{site.url}}/images/aws_passwd_05.jpg)

```bash
vi /etc/sudoers.d/90-cloud-init-users
chmod 440 /etc/sudoers.d/90-cloud-init-users
exit # exit the root acct, we don't need it any more
```

and test that we are being prompted for the password correctly:

```bash
sudo apt update
```

![hooray! we're asked for a password]({{site.url}}/images/aws_passwd_06.jpg)
