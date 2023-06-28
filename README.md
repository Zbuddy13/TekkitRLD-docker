# TekkitRLD-docker
A Tekkit Reloaded Minecraft Server for Containerized Environments

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
docker run -p <port>:25565 -v '/path/to/files':'/data':'rw' moyito2604/tekkitrld-docker:latest
```

Default Java Arguments are set with minimum memory requirements of ```-Xms1024m -Xmx4096m```

To change these arguments and add more, add the following environment variable to the container before the image name
```
-e JAVA_ARGS="New Java Arguments"
```

Memory arguments can be set to either megabytes or gigabytes with ```-Xms4096m``` as Megabytes and ```-Xms4G``` as Gigabytes
