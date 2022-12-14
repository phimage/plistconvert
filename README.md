# plistconvert

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-macOS_Linux-lightgrey.svg?style=flat)](https://developer.apple.com/resources/)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)
[![build](https://github.com/phimage/plistconvert/actions/workflows/build.yml/badge.svg)](https://github.com/phimage/plistconvert/actions/workflows/build.yml)
[![Sponsor](https://img.shields.io/badge/Sponsor-%F0%9F%A7%A1-white.svg?style=flat)](https://github.com/sponsors/phimage)

Convert `plist` or Xcode project (`xxx.xcodeproj/project.pbxproj`) from and to `json`, `xml`, `binary` or `openStep` formats

## Usage

### Convert in place

```bash
plistconvert --convert json /path/to/my.plist
```

```bash
plistconvert --convert json /path/to/xcode.xcodeproj
```

### Convert to a new file

```bash
plistconvert --convert json --output /path/to/my.json /path/to/my.plist
```

you could ouput result to standards output using same option

```bash
plistconvert --convert json --output /dev/stdout # or --output -
```

## Install

Just download from release if any, or build it (and move it to `PATH`)

or alternatively execute install script

```bash
sudo curl -sL https://phimage.github.io/plistconvert/install.sh | bash
```

### On linux for dynamic binary

Some dependencies lib must be installed if you install the dynamic binary

so if you have not already added the swiftlang repo:

```bash
curl -s https://archive.swiftlang.xyz/install.sh | sudo bash
```

then you can install just the minimum package `slim` (or the full one see build chapter)

```bash
sudo apt install swiftlang-slim
```

#### current dependencies info for dynamic executable 

linked to swift lib and os lib

```bash
$ ldd plistconvert 
	linux-vdso.so.1 (0x00007ffe977fb000)
	libswiftGlibc.so => /usr/lib/swift/linux/libswiftGlibc.so (0x00007fe95fcb7000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fe95fb61000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fe95fb3e000)
	libutil.so.1 => /lib/x86_64-linux-gnu/libutil.so.1 (0x00007fe95fb39000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fe95fb33000)
	libFoundation.so => /usr/lib/swift/linux/libFoundation.so (0x00007fe95f28b000)
	libswiftDispatch.so => /usr/lib/swift/linux/libswiftDispatch.so (0x00007fe95f259000)
	libdispatch.so => /usr/lib/swift/linux/libdispatch.so (0x00007fe95f1f8000)
	libBlocksRuntime.so => /usr/lib/swift/linux/libBlocksRuntime.so (0x00007fe95f1f3000)
	libswift_Concurrency.so => /usr/lib/swift/linux/libswift_Concurrency.so (0x00007fe95f191000)
	libswiftCore.so => /usr/lib/swift/linux/libswiftCore.so (0x00007fe95eb34000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fe95e942000)
	libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fe95e75e000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fe95e743000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fe95fded000)
	libicuucswift.so.65 => /usr/lib/swift/linux/libicuucswift.so.65 (0x00007fe95e540000)
	libicui18nswift.so.65 => /usr/lib/swift/linux/libicui18nswift.so.65 (0x00007fe95e226000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fe95e21c000)
	libicudataswift.so.65 => /usr/lib/swift/linux/libicudataswift.so.65 (0x00007fe95c769000)

$ du -sh /usr/lib/swift/
124M	/usr/lib/swift/
```

## Build yourself

```bash
swift build -c release
```

or if we want without swift runtime dependencies (ie static executable)

```bash
swift build -c release -Xswiftc -static-executable
```

### Install swift on linux (needed to build)

#### Download from 

[Swift official website](https://www.swift.org/download/)

#### Download with apt on swiftlang.xyz

```bash
curl -s https://archive.swiftlang.xyz/install.sh | sudo bash
```

Then install the full swiftlang package to install `swift` command

```bash
sudo apt install swiftlang
```

#### or use swiftenv
