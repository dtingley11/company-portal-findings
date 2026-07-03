# Function Map

Static map of relevant decompiled classes/functions and what each contributes.

## Checker Interface

All in-house origin checks implement:

- `RequestDeduplicatorExternalSyntheticLambda0`
- method: `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl(): int`

Each checker returns `0` when its condition is not detected, or a nonzero bit value when detected.

## Aggregator

Class:

- `kotlin.ServiceStarter`

Function:

- `ResetPasswordSubmitNewPasswordCommandParametersResetPasswordSubmitNewPasswordCommandParametersBuilderImpl()`

Behavior:

- Iterates a `Set<RequestDeduplicatorExternalSyntheticLambda0>`.
- Calls each checker's `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`.
- Combines each returned integer into a cumulative bitmask.
- Logs warning text if a checker throws.

## Bit Map

Known static bit meanings:

| Bit | Decimal | Class | Meaning |
| --- | ---: | --- | --- |
| `0x1` | `1` | `beginTransactionSync` | `su` binary/name check |
| `0x8` | `8` | `syncState` | `Build.TAGS` contains `test-keys` |
| `0x10` | `16` | `createInstance` | suspicious filesystem/path permission state |
| `0x20` | `32` | `toList` | Xposed class lookup failed with root-cloak-like stack trace |
| `0x40` | `64` | `toList` | Xposed class found |
| `0x80` | `128` | `checkAndSyncState` | native `liborigin.so` instrumentation check detected |
| `0x100` | `256` | `SharedPreferencesQueue` | Magisk-related name detected |

Package-list checks also return a nonzero value from `r8lambdaE9XW8fIBuBlfy6ibDQdajXfq4Mo`, but the exact return bit was not cleanly decompiled by JADX in the available output.

## Package List Checker

Class:

- `kotlin.r8lambdaE9XW8fIBuBlfy6ibDQdajXfq4Mo`

Key functions:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`
- `IMediaSession(List<PackageInfo>)`
- `FitWindowsLinearLayout(String)`
- `getBaselineAlignedChildIndex(String)`

Behavior:

- Calls `PackageManager.getInstalledPackages(...)`.
- Uses `PackageInfo` entries to compare installed package names against static root/tooling sets.
- Uses regex `ru.(.*).installer`.
- Has a helper that checks whether a supplied filesystem path exists.

Static package sets:

- root/superuser apps
- root hiding apps
- Xposed/Substrate apps
- suspicious/modding/tooling apps

## `su` Checker

Class:

- `kotlin.beginTransactionSync`

Function:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`

Behavior:

- Calls the shared `Store` lookup helper with string `su`.
- Returns `1` if detected.
- Returns `0` otherwise.

## Magisk Name Checker

Class:

- `kotlin.SharedPreferencesQueue`

Function:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`

Checked names:

- `magisk`
- `magiskhide`
- `magiskinit`
- `magiskpolicy`

Behavior:

- Iterates the name list.
- Calls the shared `Store` lookup helper for each name.
- Returns `256` on detection.
- Returns `0` otherwise.

## Xposed Class Checker

Class:

- `kotlin.toList`

Functions:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`
- `LinearLayoutCompat(String)`

Checked classes:

- `de.robv.android.xposed.XposedBridge`
- `de.robv.android.xposed.XC_MethodReplacement`

Behavior:

- Calls an injected class-finder abstraction, defaulting to `hasWakeLockPermission`.
- If the class is found, returns `64`.
- If `ClassNotFoundException` stack trace contains configured root-cloak indicators, returns `32`.
- Otherwise returns `0`.

## Filesystem Permission Checker

Class:

- `kotlin.createInstance`

Functions:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`
- `isEmpty(String, String)`

Checked path strings:

- `data`
- `system`
- `system/bin`
- `sbin`
- `system/sbin`
- `system/xbin`
- `system/etc`
- `vendor/bin`

Behavior:

- Calls `Os.stat(path)`.
- Converts `st_mode` to a binary string.
- Checks permission-related character positions in that binary string.
- Returns `16` if a suspicious permission condition is detected.
- Returns `0` otherwise.

## Build Tag Checker

Class:

- `kotlin.syncState`

Functions:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`
- `getDividerDrawable(String)`

Behavior:

- Reads `Build.TAGS`.
- Checks whether it contains `test-keys`.
- Returns `8` when present.
- Returns `0` otherwise.

## Native Origin Loader

Class:

- `kotlin.checkAndSyncState`

Function:

- `SignInResendCodeCommandParametersSignInResendCodeCommandParametersBuilderImpl()`

Behavior:

- Calls `System.loadLibrary("origin")`.
- Instantiates `InstrumentationCheck`.
- Calls `InstrumentationCheck.SignInResendCodeCommandParameters()`.
- Returns `128` if native instrumentation detection is positive.
- Returns `0` otherwise.

## Native Instrumentation Wrapper

Class:

- `com.microsoft.intune.origindetection.InstrumentationCheck`

Functions:

- `SignInResendCodeCommandParameters(): boolean`
- `clientExceptionFromException(): int`
- `runChecksImpl(int incubatingChecksToRun): int`

Behavior:

- `runChecksImpl` is native.
- Base `clientExceptionFromException()` calls `runChecksImpl(0)`.
- `SignInResendCodeCommandParameters()` treats selected native result bits as a boolean detection state.
- Caches positive detection in a static boolean.

## Incubating Native Memory Check Wrapper

Class:

- `kotlin.logIfAbledefault`

Function:

- `clientExceptionFromException(): int`

Feature flag:

- `MAMFeatureFlag.INCUBATING_INSTRUMENTATION_CHECKS_MEMORY`
- backing string: `mam_incubating_instrumentation_check_mem`
- default: `true`

Behavior:

- If the feature flag is enabled, passes the incubating native memory-check flag path into `runChecksImpl`.
- If native result bits `0x4` or `0x8` are set, logs `AUDIT_INSTRUMENTATION_CHECK` with the result as hex.

## Origin Diagnostics

Class:

- `kotlin.LoggerAndroidLoggerWhenMappings`

Feature flag:

- `MAMFeatureFlag.ORIGIN_CHECK_DIAGNOSTICS`
- backing string: `mam_origin_check_diagnostic_logs`
- default: `false`

Behavior:

- When enabled, logs per-check compliance names for origin checks.
- Static sub-operation names include:
  - `inHouseOriginChecks`
  - `mamRaspChecks`
  - `omadmRaspChecks`

## RASP Telemetry Paths

Classes:

- `kotlin.AutoProtoEncoderDoNotUseEncoderProtoEncoderDoNotUseEncoder`
- `kotlin.limit`

Static tracked occurrences:

- `RASP_ROOT_DETECTED`
- `RASP_HOOK_DETECTED`
- `RASP_CERTIFICATE_TAMPER_DETECTED`

Behavior:

- Logs root/hook/certificate-tamper RASP events through `TelemetryLogger`.
- One root path logs detail string `checkpoint`.

