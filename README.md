# Microsoft Company Portal / Intune Root Detection Notes

Minimal writeup of local static and runtime findings from Microsoft Company Portal / Intune MAM root and instrumentation checks.

## Scope

- APK analyzed: `com.microsoft.windowsintune.companyportal (1).apk`
- Decompiled Java/Kotlin output: JADX
- Native library reviewed: `assets/mam_libs/arm64-v8a/liborigin.so`
- Runtime sources: Company Portal logs, OMADM logs, LSPosed/HMA logs, `logcat`, and `dmesg`

Raw APKs, databases, and full logs are intentionally not included because they can contain account, device, tenant, token, or other private data.

## Conclusion

Company Portal / Intune uses more than one root/integrity signal.

Confirmed categories:

- Installed package/app-list detection
- Xposed class/runtime detection
- `su`/Magisk binary-name checks
- Filesystem/path checks
- Build/emulator/test-key checks
- Native Frida/instrumentation checks in `liborigin.so`
- MAM/RASP root and hook checks
- Device-health reporting through OMADM/MAM service check-in

The UI message showing an X next to "device is healthy" maps to Intune marking the device unhealthy/non-compliant. It does not reveal the exact detector that fired.

## Key Runtime Evidence

- OMADM logs showed `RASP_ROOT_DETECTED`.
- OMADM/MAM service requests sent `DeviceHealth=1`.
- Unenrollment/wipe reason included `DEVICE_NON_COMPLIANT`.
- MAM service delete URL included `WipeReason=adminPolicyJB`.
- LSPosed/HMA logs showed package visibility queries from `com.microsoft.windowsintune.companyportal`.
- `dmesg` showed Company Portal and managed app processes probing SELinux/tracing/userfaultfd surfaces.
- Managed app data contained copied Intune MAM native libraries, including `liborigin.so`.

See:

- [Detector Details](docs/detectors.md)
- [Runtime Evidence](evidence/runtime-evidence.md)
- [Source References](docs/source-references.md)

## Important Unknown

The exported local logs did not expose the final internal `failedChecks` bitmask. The APK contains a diagnostic feature flag, `mam_origin_check_diagnostic_logs`, that would log per-check compliance names, but it was not enabled in the observed run.

