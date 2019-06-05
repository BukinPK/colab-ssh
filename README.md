# colab-ssh
SSH Connector to connect Google Colab VM instance with Labstack Tunnel

# Usage

1. Go to https://colab.research.google.com/github/BukinPK/colab-ssh/blob/master/Colab_ssh.ipynb

2. In second cell change `password` to password you'd like;

3. Run the cells

4. Wait some time and you'll be able to see the last line like that: `⇨ routing traffic from tcp://zoe.labstack.me:41045`

5. On your local machine - `ssh root@labstack.me -p 41045`, answer `yes`, enter your `[PASSWORD]`
