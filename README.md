# docker-base-images
Official Bridge multi architecture docker base images

Available images:
- [Core - Ubuntu Bionic and Jammy](core/)
- [Ruby](ruby/)
- [Node](node/)
- [Java](java/)
- [Clojure](clojure/)

# How to build
- `docker buildx bake -f core/jammy/docker-bake.hcl`
- or if you get an error `PWD=$(pwd) docker buildx bake -f core/jammy/docker-bake.hcl`

## Development
We use `ruby` , and `erb` templates to generate our Dockerfile's
- Install `ruby`, ([chruby](https://github.com/postmodern/chruby), or [asdf](https://github.com/asdf-vm/asdf))
- `bundle install`
- `bundle exec rake -T` to see rake tasks

You can install some useful git-hooks by install [overcommit](https://github.com/sds/overcommit#installation)
- `gem install overcommit`
- `cp .overcommit.sample.yml .overcommit.yml`
- `overcommit --install`
