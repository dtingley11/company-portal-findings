# Detector Details

This file lists detector details from decompiled code and native strings/disassembly.

## Package Detection

The APK contains static package-name checks for root apps, root managers, Xposed/root-hiding tools, and suspicious tooling.

Root / superuser packages:

- `eu.chainfire.supersu`
- `com.noshufou.android.su`
- `com.koushikdutta.superuser`
- `com.noshufou.android.su.elite`
- `com.thirdparty.superuser`
- `com.yellowes.su`
- `com.topjohnwu.magisk`
- `com.kingroot.kinguser`
- `com.kingo.root`
- `com.smedialink.oneclickroot`
- `com.zhiqupk.root.global`
- `com.alephzain.framaroot`

Root hiding / hooking packages:

- `com.devadvance.rootcloak`
- `com.devadvance.rootcloakplus`
- `de.robv.android.xposed.installer`
- `com.saurik.substrate`
- `com.zachspong.temprootremovejb`
- `com.amphoras.hidemyroot`
- `com.amphoras.hidemyrootadfree`
- `com.formyhm.hiderootPremium`
- `com.formyhm.hideroot`

Additional suspicious tooling/package indicators:

- `com.koushikdutta.rommanager`
- `com.koushikdutta.rommanager.license`
- `com.dimonvideo.luckypatcher`
- `com.chelpus.lackypatch`
- `com.ramdroid.appquarantine`
- `com.ramdroid.appquarantinepro`
- `com.android.vending.billing.InAppBillingService.COIN`
- `com.android.vending.billing.InAppBillingService.LUCK`
- `com.chelpus.luckypatcher`
- `com.allinone.free`
- `com.repodroid.app`
- `org.creeplays.hack`
- `com.baseappfull.fwd`
- `com.zmapp`
- `com.dv.marketmod.installer`
- `org.mobilism.android`
- `com.android.wp.net.log`
- `com.android.camera.update`
- `cc.madkite.freedom`
- `com.solohsu.android.edxp.manager`
- `org.meowcat.edxposed.manager`
- `com.xmodgame`
- `com.cih.game_cih`
- `com.charles.lpoqasert`
- `catch_.me_.if_.you_.can_`
- `cn.wq.myandroidtools`
- `com.kunkunsoft.rootservicedisabler`

Package-name pattern:

- `ru.(.*).installer`

## Xposed Runtime Detection

The APK checks for these classes:

- `de.robv.android.xposed.XposedBridge`
- `de.robv.android.xposed.XC_MethodReplacement`

These checks are separate from package-name checks.

The class-check path also treats stack traces containing root-cloak indicators as suspicious:

- `devadvance`
- a dynamically built string ending in `cloak`

## Binary / Name Checks

The APK checks for these names:

- `su`
- `magisk`
- `magiskhide`
- `magiskinit`
- `magiskpolicy`

## Filesystem / Path Checks

Static path/name checks include:

- `data`
- `system`
- `system/bin`
- `sbin`
- `system/sbin`
- `system/xbin`
- `system/etc`
- `vendor/bin`

## Build / Device Checks

Static build/device checks include:

- `Build.TAGS` containing `test-keys`
- emulator/model/manufacturer/type strings, including:
  - `android sdk built for x86`
  - `sdk_gphone64_x86_64`
  - `sdk_gphone_x86_arm`

## Native Instrumentation Checks: `liborigin.so`

Native library:

- `assets/mam_libs/arm64-v8a/liborigin.so`

Exported JNI method:

- `Java_com_microsoft_intune_origindetection_InstrumentationCheck_runChecksImpl`

Relevant native strings:

- `/proc/self/maps`
- `/proc/self/mem`
- `FRIDA`
- `FRIDA_AGENT`
- `LIBFRIDA_GADGET`
- `/data/local/tmp/re.frida.server`
- `liborigin.so`
- `init_frida_hook_check_if_necessary`

Relevant native imports/calls:

- `access`
- `socket`
- `inet_aton`
- `getaddrinfo`
- `setsockopt`
- `connect`
- `prctl`
- `__open_2`
- `fopen`
- `sscanf`
- `strcmp`
- `strrchr`
- `memmem`
- `pread64` / `__pread64_chk`
- `dl_iterate_phdr`
- `dlsym`
- `__system_property_get`
- `strncmp`

Inferred native bitmask behavior:

- Checks `/data/local/tmp/re.frida.server`; if accessible, returns a detection bit.
- Attempts local socket/connect behavior consistent with probing for a local instrumentation server.
- Contains `/proc/self/maps` and `/proc/self/mem` scanning code.
- Searches process memory/maps for Frida-related strings.
- Uses `dl_iterate_phdr` and `dlsym`-style checks for loaded symbols/libraries.

Important feature-flag nuance:

- APK default: `INCUBATING_INSTRUMENTATION_CHECKS_MEMORY("mam_incubating_instrumentation_check_mem", true)`
- If enabled, the subclass calls the native checker with the incubating memory flag path and logs `AUDIT_INSTRUMENTATION_CHECK` when native bits `0x4` or `0x8` are set.

## Intune Origin Check Aggregation

Static Java/Kotlin shows multiple origin check groups:

- `inHouseOriginChecks`
- `mamRaspChecks`
- `omadmRaspChecks`

The detailed compliance result logging is gated by:

- `ORIGIN_CHECK_DIAGNOSTICS("mam_origin_check_diagnostic_logs", false)`

## MAM / RASP Events

Static event names:

- `RASP_ROOT_DETECTED`
- `RASP_HOOK_DETECTED`
- `RASP_CERTIFICATE_TAMPER_DETECTED`

Static root-event detail:

- Empty detail string in some paths
- `checkpoint` detail string in another path

## LSPosed-Specific Notes

No literal strings were found for:

- `lsposed`
- `zygisk`
- `riru`
- `shamiko`

However, LSPosed can still be implicated indirectly by:

- Xposed class checks
- package visibility checks for Xposed/EdXposed managers
- native/RASP hook detection
