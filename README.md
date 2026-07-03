# Microsoft Company Portal / Intune Root Detection Reference

Static-code writeup of Microsoft Company Portal / Intune MAM root, origin, and instrumentation checks.

## Scope

- Decompiled Java/Kotlin definitions
- Native `liborigin.so` strings/imports/disassembly
- Detector names, return bits, and check behavior

Raw artifacts are not included.

## Summary

Company Portal / Intune uses more than one root/integrity signal.

Static detector categories:

- Installed package/app-list detection
- Xposed class/runtime detection
- `su`/Magisk binary-name checks
- Filesystem/path checks
- Build/emulator/test-key checks
- Native Frida/instrumentation checks in `liborigin.so`
- MAM/RASP root and hook checks

The in-house origin checks implement a shared checker interface and return integer bit values. `ServiceStarter` combines checker results into a single bitmask.

## Files

- [Detector Details](docs/detectors.md)
- [Function Map](docs/function-map.md)
- [Source References](docs/source-references.md)
