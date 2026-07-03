# Runtime Evidence

This file summarizes local runtime evidence without storing raw logs.

## Exported Intune / OMADM Logs

Observed high-level markers:

- `tracked occurrence RASP_ROOT_DETECTED`
- `DeviceHealth=1`
- `internalUnenrollPackageForMAM ... WipeReason DEVICE_NON_COMPLIANT`
- service request with `WipeReason=adminPolicyJB`

Observed ECS/config values:

- `mam_app_rasp_root_check=true`
- `mam_32bit_app_rasp_root_check=true`
- `mam_rasp_root_check=true`
- `mam_rasp_filetamper_check=true`
- `mam_rasp_certificate_check=true`
- `mam_rasp_hook_check=true`
- `MdmGuardsquareRASPOriginDetection_Enabled=true`
- `mam_incubating_instrumentation_check_mem=false`

## LSPosed / HMA Logs

Observed package visibility query:

- `PmsHookTarget34 @shouldFilterApplication: query from com.microsoft.windowsintune.companyportal`

Implication:

- Company Portal performed package visibility queries during the flow.
- This supports package-list detection as active runtime behavior.

## Live `logcat`

Observed MAM scenario traces:

- `ORIGIN_CHECKS`
- `inHouseOriginChecks`
- `mamRaspChecks`
- `omadmRaspChecks`

Observed managed app library loading:

- `libmsmam-pre.so`
- `libwolfssl.so`
- `libmsmdmarp.so`
- `liborigin.so`

## Live `dmesg`

Observed Company Portal probes:

- `/sys/fs/selinux/policy`
- `/sys/kernel/tracing/trace_marker`
- `anon_inode:[userfaultfd]`

Observed managed app probes:

- Managed Best Buy process loaded Intune MAM libraries.
- Managed Best Buy process also triggered tracing/SELinux-style probes.

## Origin State Provider

Provider queried:

- `content://com.microsoft.omadm.originstate`

Observed result:

- `Row: 0 value=0`

Interpretation:

- This provider did not expose the current root failure in the observed run.
- It should not be treated as authoritative for the visible device-health failure.

## App Data Inspection

Observed relevant files:

- Company Portal logs:
  - `OMADMLog_0.log`
  - `CompanyPortal_0.log`
  - `AuditEvents_0.log`
  - `broker.0.txt`
- Company Portal databases:
  - `omadm.db`
  - `mam.db`
  - `portal.db`
  - `AriaStorage.db`
- Managed app logs:
  - `cache/com.microsoft.intune.mam.log/native-hooking.log`
  - `cache/com.microsoft.intune.mam.log/MAM_0.0.log`
- Managed app libraries:
  - `mam_libs/arm64-v8a/liborigin.so`
  - `mam_libs/arm64-v8a/libmsmdmarp.so`
  - `mam_libs/arm64-v8a/libmsmam-pre.so`
  - `mam_libs/arm64-v8a/aes/libwolfssl.so`

Managed app MAM logs were nonempty but did not directly expose the exact root detector.

