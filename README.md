# freebsd-ports-electron

This repository contains the FreeBSD build scripts, patches and checksum for [Electron](https://electronjs.org/) ([GitHub](https://github.com/electron/electron)).

This port is still in an early stage, so more eyes and hands are always welcome! Please don't hesitate to submit new [Issues](https://github.com/yzgyyang/freebsd-ports-electron/issues) or [Pull Requests](https://github.com/yzgyyang/freebsd-ports-electron/pulls).

## Supported Platforms

The port has been developed on FreeBSD 11.1 x64. We are looking into adding support for FreeBSD 12-CURRENT.

## CI/CD

For the development purpose of this port, I set up a [build plan](http://ci.charlieyang.me:8180/jenkins/job/electron-freebsd-x64) for this port on my personal Jenkins server. Each push to the `master` branch of this repo will be built and tested here.

If a build was successful, the `dist` folder will be published to [yzgyyang/freebsd-ports-electron](https://github.com/yzgyyang/freebsd-ports-electron) for further testing.

## `libcc` Releases for Electron

[libchromiumcontent](https://github.com/electron/libchromiumcontent), the shared library build of Chromium’s content module, is a direct dependency of Electron. Since FreeBSD is currently not officially supported by libcc, we manually build libcc as a prerequisite for the Electron port.

For build scripts, patches and releases used by Electron, please refer to [yzgyyang/freebsd-libcc-release](https://github.com/yzgyyang/freebsd-libcc-release).

## Credits

Heavily based on @prash-wghats work at [prash-wghats/Electron-VSCode-Atom-For-FreeBSD](https://github.com/prash-wghats/Electron-VSCode-Atom-For-FreeBSD).
