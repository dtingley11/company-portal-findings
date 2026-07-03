# Static Source References

Static decompiled/native references using class names and APK-internal paths.

## Decompiled Java/Kotlin

Package-list checks:

- `kotlin.r8lambdaE9XW8fIBuBlfy6ibDQdajXfq4Mo`

Xposed class checks:

- `kotlin.toList`

`su` lookup:

- `kotlin.beginTransactionSync`

Magisk-name checks:

- `kotlin.SharedPreferencesQueue`

Filesystem/stat checks:

- `kotlin.createInstance`

`test-keys` check:

- `kotlin.syncState`

Native origin check loader:

- `kotlin.checkAndSyncState`
- `com.microsoft.intune.origindetection.InstrumentationCheck`

Native-memory/instrumentation subclass:

- `kotlin.logIfAbledefault`

Origin check aggregator / diagnostics:

- `kotlin.LoggerAndroidLoggerWhenMappings`

Origin provider:

- `com.microsoft.intune.origindetection.abstraction.DeviceOriginContentProvider`

Root-detection telemetry event:

- `com.microsoft.intune.origindetection.telemetry.domain.RootDetectionRootDetectedEvent`

MAM feature flags:

- `com.microsoft.intune.mam.client.ipcclient.MAMFeatureFlag`

RASP telemetry/logging paths:

- `kotlin.AutoProtoEncoderDoNotUseEncoderProtoEncoderDoNotUseEncoder`
- `kotlin.limit`

Tracked occurrence names:

- `com.microsoft.intune.mam.client.telemetry.events.TrackedOccurrence`

MAM sub-operation names:

- `com.microsoft.intune.mam.log.MAMSubOpTrace`

## Native Library

APK-internal native library:

- `assets/mam_libs/arm64-v8a/liborigin.so`

Exported JNI symbol:

- `Java_com_microsoft_intune_origindetection_InstrumentationCheck_runChecksImpl`

Example commands after extracting the APK:

```sh
readelf -Ws assets/mam_libs/arm64-v8a/liborigin.so
strings -a -tx assets/mam_libs/arm64-v8a/liborigin.so
llvm-objdump -d --no-show-raw-insn --start-address=0x39b44 --stop-address=0x3a5c0 assets/mam_libs/arm64-v8a/liborigin.so
```
