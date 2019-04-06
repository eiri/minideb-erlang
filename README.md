# Erlang on Minideb Linix

**DEPRECATED**

This Dockerfile provides an absolute minimal installation of Erlang on [Minideb](https://github.com/bitnami/minideb) with no build tools installed.

## Build

```bash
$ make help
COMMAND: build|test|shell|bash|deploy VERSION=$version
BUILDS IMAGE: eirica/minideb-erlang:20.1
VERSIONS: 17.5 18.3 19.3 20.1(default) latest

$ make build VERSION=19.3
...

$ make test VERSION=19.3
docker run --rm -it eirica/minideb-erlang:19.3 /opt/erlang/19.3/bin/erl -noshell -eval 'erlang:display(erlang:system_info(system_version))' -eval 'init:stop()'
"Erlang/OTP 19 [erts-8.3] [source] [64-bit] [async-threads:10] [kernel-poll:false]\n"

```

## Usage

Image sets up a default user `erlanger` to run not under root.

```bash
$ docker run --rm -it eiri/minideb-erlang /bin/bash
$ erl
Eshell V9.1  (abort with ^G)
1> 
```

## License

[MIT](../master/LICENSE)
