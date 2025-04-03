SSH Server access
-

Granting access to servers during the hackathon is realised through SSH public key authentication.
Insert your key into the `hackathon-2025.txt` file and you will be automatically granted access to the servers.


User perspective:
--
Create a pull request where you add your SSH key in the correct openssh format to the file `hackathon-2025.txt`, containing a username field.
Wait until the pull request is accepted. One minute after you can log in into the connected server.


Admininstrator perspective:
--

Make sure to install the following software: `git ssh-keygen mail useradd cut id`

As root, clone this repository to `/root` directory
`$ git clone https://github.com/ossbase-org/hackathon-local-ssh-public-keys.git`

Add to `/etc/ssh/sshd_config`:
```
AuthorizedKeysCommand /bin/bash /root/hackathon-local-ssh-public-keys/fetch_keys.sh
AuthorizedKeysCommandUser root
```
Now restart sshd:`systemctl restart ssh`

Edit your crontab: `crontab -e`
`* * * * * /bin/bash /root/hackathon-local-ssh-public-keys/fetch_keys.sh insert`
