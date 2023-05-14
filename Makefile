MAKEFLAGS = -j6

dev: server ngrok

server:
	python3 -m http.server 7000

ngrok:
	ngrok http --domain turtleforge.ngrok.dev 7000

build:
	lua5.4 build.lua

provision:
	sudo apt install lua5.4
	luarocks config lua_version 5.4
	sudo luarocks install dkjson --lua-version=5.4
