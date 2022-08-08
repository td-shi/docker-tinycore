# Tiny Core Linux Docker Image

[![docker-tinycore](https://github.com/td-shi/docker-tinycore/actions/workflows/main.yml/badge.svg)](https://github.com/td-shi/docker-tinycore/actions/workflows/main.yml)

![Docker Pulls](https://img.shields.io/docker/pulls/tdshi/tinycore) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tdshi/tinycore/latest)

This provides a very small CLI system image based on Tiny Core Linux developed
at [The Core Project](http://tinycorelinux.net). It contains following Core
x86/x86\_64 packages

- rootfs.gz (or rootfs64.gz): contains base system binaries and a file system
  layout.
- squashfs-tools.tcz: contains a squashfs builder and expander.

These original packages are found under

- http://tinycorelinux.net/13.x/
 
and Dockerfile of these images are found at

- [`13.1-x86`, `latest` (13.1/x86/Dockerfile)](https://github.com/td-shi/docker-tinycore/blob/master/x86/Dockerfile)
- [`13.1-x86_64` (13.1/x86\_64/Dockerfile)](https://github.com/td-shi/docker-tinycore/blob/master/x86_64/Dockerfile)

## Installation

The easiest way to install the image is pulling it from
[Docker Hub repositories](https://registry.hub.docker.com/) like following:

```bash
docker pull tdshi/tinycore:latest
```

The latest is "13.1-x86_64". The other tag is "13.1-x86".

## Usage

Just run:

```bash
docker run -it tdshi/tinycore:latest
```

The latest is "13.1-x86_64". The other tag is "13.1-x86".

To install tcz packages into the container and use them, please run `tce-load`
command in it like following:

```bash
tce-load -wic bash.tcz
```

Or run the container with privilege mode like following:

```bash
docker run -it --privileged tdshi/tinycore:latest
```

And, once it starts with privilege mode, you can run the package manager like

```bash
tce-ab
```

## Building an image based on this image

Now Docker doesn't support privilege mode at image building but this image
includes patched `tce-load` which works without privilege mode by using
`unsquashfs` internally instead of mounting squashfs on a loop back device so
to install packages, please use `tce-load` with `-c` option

If you need an example, please see :
- [tinycore-ruby](https://github.com/tatsushid/docker-tinycore-ruby) or
- [tinycore-python](https://github.com/tatsushid/docker-tinycore-python)
- Dockerfile

## Tiny Core Linux x86 and x86\_64 Docker Image Builder

Dockerfile and helper scripts for building a very small CLI system image based
on Tiny Core Linux developed at [The Core Project](http://tinycorelinux.net).
It builds Core 13.1 x86 and x86\_64 image by using following packages which were
converted those archive type from The Core Project packages.

- rootfs.tar.gz: contains base system binaries and a file system layout
- rootfs64.tar.gz: contains base system binaries and a file system layout
- squashfs-tools.tar.gz: contains a squashfs builder and expander

Those original packages are found under http://tinycorelinux.net/13.x/x86 and
http://tinycorelinux.net/13.x/x86_64

### How to build the image

Just run

```bash
make all
```

To clean up the directory, run

```bash
make clean
```

There is something you should be aware of. The `xarg` used in this Makefile
(clean up) uses the `-r` option, which is a GNU extension. 

### License

rootfs.tar.gz,rootfs64.tar.gz, squashfs-tools.tar.gz and tce-load.patch are under
[GPLv2](http://www.gnu.org/licenses/gpl-2.0.html). The other build scripts are
under [MIT](LICENSE).

## Original author
- tatsushid :: origin
- bensuperpc :: fork
