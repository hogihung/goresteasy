# README


This docker image contains the following development tools:

  - Vim             [8.1.1512]
  - Go              [1.12.4]
  - Git             [2.19.1]
  - Ubuntu (for OS) [18.10]



## CLONE THE REPO

```
cd /path/to/your/docker/projects
git clone https://github.com/hogihung/goresteasy.git
cd goresteasy
```



## BUILD THE DOCKER IMAGE

```
docker build -t goresteasy:1.0.0
```



## RUN THE IMAGE (in a container)

```
# User the command 'docker images' to get a listing of images, including the new one created
docker run -it --name=godev --hostname=devbox --rm [image-id]

*Note: the --rm flag is optional and it will remove the container on exit.


# Running the image and mounting your local file system into the container:
docker run -it --name=godev --hostname=devbox --rm \
-v /path/to/local/dir:/usr/local/development/go/  [image-id]

*Note: Windows uses need to replace the \ character with the ^ character when
       spanning multiple lines.
```



## SAVE UPDATED CONTAINER AS NEW IMAGE

```
docker commit --message "some message here" [running-container-id] hub-repo-name/image-name:x.y.z

# Example:
docker commit --message "Fix elixir_go and reset_path scripts" resteasy-dev hogihung/goresteasy:1.0.1
```

