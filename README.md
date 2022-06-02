# docker-base-images
Official Bridge multi architecture docker base images


## Plans
Maybe open source this repository for the greater good! Initially we will keep it private to ensure we don't
accidentally leak data or trade secrets ;).

# How to build
- `docker buildx bake -f core/jammy/docker-bake.hcl`
- or if you get an error `PWD=$(pwd) docker buildx bake -f core/jammy/docker-bake.hcl`
