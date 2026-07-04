# Version Diff Notes

Static comparison between Microsoft Company Portal `5.0.6991.0` and `5.0.7009.0`.

## APKs Compared

- `5.0.6991.0`
  - SHA-256: `04684de6b9e16d7a4a1962bb492adc9be3a0475c738804f7781625280b0c3077`
- `5.0.7009.0`
  - SHA-256: `ac8aa0e75c099e58017601fb5ee70e3762261a09ecb309eef934a556501a181f`

## Root Detector Constants

The known literal root/hook indicators were unchanged between these two versions.

No new literal strings were found for:

- `lsposed`
- `zygisk`
- `riru`
- `shamiko`
- `kernelsu`
- `apatch`

The existing package, Xposed class, Magisk-name, Frida, and RASP telemetry strings remained present.

## Native RASP Runtime

The obfuscated native RASP library changed:

- `5.0.6991.0`: `lib/arm64-v8a/libb9fc.so`
- `5.0.7009.0`: `lib/arm64-v8a/libe145.so`

The new library imports `dl_iterate_phdr`; the old one does not. This API can enumerate loaded ELF shared objects in the current process, so the newer native runtime appears to have added or enabled in-process module enumeration.

Most other relevant native imports were already present in both versions, including:

- `dladdr`
- `dlopen`
- `dlsym`
- `execv`
- `fork`
- `mprotect`
- `prctl`
- `stat`
- `statfs`
- `__system_property_get`

## RASP Manager Behavior

The Java/Kotlin RASP manager changed shape:

- `5.0.6991.0`: `kotlin.createContentIntent`
- `5.0.7009.0`: `kotlin.AutoProtoEncoderDoNotUseEncoderProtoEncoderDoNotUseEncoder`

In `5.0.7009.0`, the manager constructor schedules an executor task that touches the lazy RASP backend during initialization. The older manager constructor only stores dependencies.

This suggests the newer version may initialize or arm the RASP backend earlier in the app lifecycle.

## RASP Events

The event names did not change:

- `RASP_ROOT_DETECTED`
- `RASP_HOOK_DETECTED`
- `RASP_CERTIFICATE_TAMPER_DETECTED`

The notification/control-flow glue changed, including additional generated call sites around `notifyRASPRootFailed(...)`.

## Summary

The visible version delta is not a new package-name or literal-string detector. The important change is the updated native RASP runtime and earlier RASP backend initialization. The added `dl_iterate_phdr` import is consistent with loaded-library/module enumeration inside the app process.
