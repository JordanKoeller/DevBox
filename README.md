# DevBox
 Docker image of all my dev tools.

Note: This docker image is mostly just a launching-point for other more use-specific images.
      This serves two roles:
        1. Orchestrating other images. Giving me the tools to do that nicely.
        2. A terminal that I can attach to my vscode or other terminals all over the place

docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" devbox

# Notes/Todos
Note: I will mount my "home" directory from host system C:\Users\jkoeller\CLI
Environment Variables:

I'll use environment variables for setting secrets.
The simplest way to do this is have a .secretsrc that gets mounted inside the container and ran when the user starts up.


I will probably need to spend some time to figure out how to expose important ports like for npm and stuff?
Or maybe I can do that by making another npm image 


## Tools to add:

 + Add some type of global-node environment file with some common tools (create-react-app, ts-node, tsc)
 + aws-cli / sam cli
 + google storages (ma-dev tools requirement)
 + Other languages: C/C++, Rust, Java, Scala
