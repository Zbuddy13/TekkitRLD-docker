# TekkitRLD-docker
A Tekkit Reloaded Minecraft Server for Containerized Environments

With some minor changes like adding scripts for auto package building

To build the container and run it, use the following commands

To Build:
```
docker build -t imagename .
```
To Run:
```
docker run -p <port>:25565 -v '/path/to/files':'/data':'rw' imagename
```

A prebuilt container can be made and run using the following command
```
docker run -p <port>:25565 -v '/path/to/files':'/data':'rw' zbuddy19/tekkitrld:latest
```

Default Java Arguments are set with minimum memory requirements of ```-Xms1024m -Xmx4096m```

To change these arguments and add more, add the following environment variable to the container before the image name
```
-e JAVA_ARGS="New Java Arguments"
```
Memory arguments can be set to either megabytes or gigabytes with ```-Xms4096m``` as Megabytes and ```-Xms4G``` as Gigabytes

RCON can be enabled as well by setting the following two arguments
```
-p <port>:25575 -e RCON_PASS="password"
```

The default password is ```changeme``` if it isn't changed in the argument

An example compose is ->
```
services:
    tekkitrdl:
        ports:
            - 25565:25565
            - 25575:25575
        environment:
            - JAVA_ARGS=-Xmx4096m
            - RCON_PASS=defaultpass
        volumes:
            - /mnt/appdata/tekkitrdl:/data:rw
        image: zbuddy19/tekkitrdl:1.0
```
