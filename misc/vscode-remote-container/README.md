# Setup Goal

Use VS Code on Mac to develop in a container that is hosted on our Linux Box (Redhat 7.3 at the time of this writing, `hachen-ld1.linkedin.biz` is the hostname for mine)



# Prerequisites

1 Install Docker Desktop on Mac (19.03.4 at the time of this writing)
2 Install VS Code (Remote Development extension, Docker extension and others you may need) on Mac
3 Install Docker-ce (19.03,4) on your Linux box





# Instructions

1 Configure the docker daemon on your Linux box so that it listens to `localhost:23750` besides `/var/run/docker.sock`

    sudo vim /lib/systemd/system/docker.service:  ExecStart=/usr/bin/dockerd -H fd:// -H tcp://localhost:23750 --containerd=/run/containerd/containerd.sock
    sudo systemctl daemon-reload
    sudo systemctl restart docker
2 Set up a SSH local port forwarding:  `ssh -vvvv -NL localhost:23750:localhost:23750 hachen@hachen-ld1.linkedin.biz`  This sets up a ssh tunnel between `localhost:23750` on your Mac and `hachen-ld1.linkedin.biz:23750`, which is being listened to by the remote docker daemon running on your Linux box

3 Create an empty folder on your Mac:  `mkdir -p demo/.devcontainer/ && touch devcontainer.json`, and then add to `devcontainer.json` 

    {
        "image": "node",
        "workspaceFolder": "/workspace",
        "workspaceMount": "src=/home/hachen/Documents/git/tensorflow,dst=/workspace,type=bind"
    }

Note: **node is the docker image name that you'd like to run on your Linux box (hence must be available on your Linux box), and src specifies the absolute path to the code repository on your Linux box and it is mounted into the container under /workspace**

After that, open VS Code when you're in that directory (demo): `cd demo && code .`, configure DOCKER_HOST in workspace settings to  `tcp://localhost:23750` and Reopen folder in container using Remote Containers extension. It takes a while for VS Code to start the container and set things up in your Linux box.



# TODO

try to reference a Dockerfile under .devcontainer in Mac to see if it works with remote containers.
