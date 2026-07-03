# Static Source References

Static decompiled/native references from the analysis environment.

## Decompiled Java/Kotlin

Package-list checks:

- `/tmp/companyportal_jadx/sources/kotlin/r8lambdaE9XW8fIBuBlfy6ibDQdajXfq4Mo.java`

Xposed class checks:

- `/tmp/companyportal_jadx/sources/kotlin/toList.java`

`su` lookup:

- `/tmp/companyportal_jadx/sources/kotlin/beginTransactionSync.java`

Magisk-name checks:

- `/tmp/companyportal_jadx/sources/kotlin/SharedPreferencesQueue.java`

Filesystem/stat checks:

- `/tmp/companyportal_jadx/sources/kotlin/createInstance.java`

`test-keys` check:

- `/tmp/companyportal_jadx/sources/kotlin/syncState.java`

Native origin check loader:

- `/tmp/companyportal_jadx/sources/kotlin/checkAndSyncState.java`
- `/tmp/companyportal_jadx/sources/com/microsoft/intune/origindetection/InstrumentationCheck.java`

Native-memory/instrumentation subclass:

- `/tmp/companyportal_jadx/sources/kotlin/logIfAbledefault.java`

Origin check aggregator / diagnostics:

- `/tmp/companyportal_jadx/sources/kotlin/LoggerAndroidLoggerWhenMappings.java`

Origin provider:

- `/tmp/companyportal_jadx/sources/com/microsoft/intune/origindetection/abstraction/DeviceOriginContentProvider.java`

Root-detection telemetry event:

- `/tmp/companyportal_jadx/sources/com/microsoft/intune/origindetection/telemetry/domain/RootDetectionRootDetectedEvent.java`

MAM feature flags:

- `/tmp/companyportal_jadx/sources/com/microsoft/intune/mam/client/ipcclient/MAMFeatureFlag.java`

RASP telemetry/logging paths:

- `/tmp/companyportal_jadx/sources/kotlin/AutoProtoEncoderDoNotUseEncoderProtoEncoderDoNotUseEncoder.java`
- `/tmp/companyportal_jadx/sources/kotlin/limit.java`

Tracked occurrence names:

- `/tmp/companyportal_jadx/sources/com/microsoft/intune/mam/client/telemetry/events/TrackedOccurrence.java`

MAM sub-operation names:

- `/tmp/companyportal_jadx/sources/com/microsoft/intune/mam/log/MAMSubOpTrace.java`

## Native Library

Extracted native library:

- `/tmp/companyportal_apk_analysis/assets/mam_libs/arm64-v8a/liborigin.so`

Exported JNI symbol:

- `Java_com_microsoft_intune_origindetection_InstrumentationCheck_runChecksImpl`

Useful commands:

```sh
readelf -Ws /tmp/companyportal_apk_analysis/assets/mam_libs/arm64-v8a/liborigin.so
strings -a -tx /tmp/companyportal_apk_analysis/assets/mam_libs/arm64-v8a/liborigin.so
llvm-objdump -d --no-show-raw-insn --start-address=0x39b44 --stop-address=0x3a5c0 /tmp/companyportal_apk_analysis/assets/mam_libs/arm64-v8a/liborigin.so
```
