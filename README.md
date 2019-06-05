# colab-ssh
SSH Connector to connect Google Colab VM instance with Labstack Tunnel

# Usage

1. Go to https://colab.research.google.com and create new Colab Notebook

2. Create the cell with the following: `!git clone https://github.com/BukinPK/colab-ssh` Run the cell and wait for clonning of repository

3. Create the cell with the following: `!bash colab-ssh/colab-ssh.sh [PASSWORD]` Choose the password you'd like instead of `[PASSWORD]` Run the cell.

4. Wait some time and you'll be able to see the last line like that: `⇨ routing traffic from tcp://zoe.labstack.me:41045`

5. On your local machine - `ssh root@labstack.me -p 41045`, answer `yes`, enter your `[PASSWORD]`
