# TailCallOptimized

http://blog.mikaellundin.name

## Prerequisites

* Git
* Docker

## Setup

Clone the project from https://github.com/miklund/tailcalloptimized.git

```
git clone https://github.com/miklund/tailcalloptimized.git
```

Build the Docker container

```
cd tailcalloptimized
docker build -t miklund/tailcalloptimized:1.0 .
```

Run the container with the following command

 ```
 docker run -it -p 4000:4000/tcp --name tailcalloptimized miklund/tailcalloptimized:1.0 /bin/bash
 ```

This will open up a command line in the container. First thing you want to do is to make a complete build.

 ```
 /bin/bash -l -c "jekyll build"
 ```

 To start the server, run the following command

 ```
 /bin/bash -l -c "./server.sh"
 ```

 Now you should be able to browse the site on your host machine.
 http://localhost:4000

 ## Writing a Post

 ## Deployment
