From: Magnus Hoff <maghoff@gmail.com>
Subject: Broadcom BCM57765/57785 SDXC/MMC Card Reader doesn't work for Ultra
 High Speed SD cards
Date: Wed, 28 May 2014 14:35:59 +0200
Message-ID: <CAJb5=h9djzoyBVqsd6h0hKy2ut8eLk0asVbEEGdyM_mZAgMwww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:54013 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaE1MgA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 08:36:00 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so12463400vcb.28
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 05:35:59 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Bug report as per https://wiki.ubuntu.com/Bugs/Upstream/kernel, using
the upstream kernel found here:
http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.15-rc6-utopic/


[1.] One line summary of the problem:

Broadcom BCM57765/57785 SDXC/MMC Card Reader doesn't work for Ultra
High Speed SD cards

[2.] Full description of the problem/report:

As I attach my Ultra High Speed SD card (SDHC I, U1, C10, rated at
30MB/s), Linux is unable to read from it at all.

I get the following output in dmesg:

[  101.498565] sdhci: Timeout waiting for Buffer Read Ready interrupt
during tuning procedure, falling back to fixed sampling clock
[  101.498580] mmc0: new ultra high speed SDR104 SDHC card at address 59b4
[  101.502161] mmcblk0: mmc0:59b4 SD32G 29.5 GiB
[  101.512251] mmc0: Controller never released inhibit bit(s).
[  111.525954] mmc0: Timeout waiting for hardware interrupt.
[  111.526076] mmcblk0: error -110 sending status command, retrying
[  111.658196] mmcblk0: unknown error -5 sending read/write command,
card status 0x900
[  111.658205] end_request: I/O error, dev mmcblk0, sector 0
[  111.658209] quiet_error: 57 callbacks suppressed
[  111.658211] Buffer I/O error on device mmcblk0, logical block 0
[  111.758391] ldm_validate_partition_table(): Disk read failed.
[  111.758406] Dev mmcblk0: unable to read RDB block 0
[  111.858502]  mmcblk0: unable to read partition table
[  112.611269] sdhci: Timeout waiting for Buffer Read Ready interrupt
during tuning procedure, falling back to fixed sampling clock
[  112.621251] mmc0: Controller never released inhibit bit(s).
[  115.162263] mmc0: Card removed during transfer!
[  115.162269] mmc0: Resetting controller.
[  115.162396] mmcblk0: error -123 sending status command, retrying
[  115.162469] mmcblk0: error -123 sending status command, retrying
[  115.162547] mmcblk0: error -123 sending status command, aborting
[  115.362489] mmc0: card 59b4 removed


I don't have a High Speed SD card to test with, but when I use the
kernel module parameter "debug_quirks2=4" for the sdhci module, it
seems to attempt to treat my UHS card as merely HS. I get the
following output in dmesg when attaching the SD card while using this
module parameter:

[  180.617180] mmc0: new high speed SDHC card at address 59b4
[  180.617366] mmcblk0: mmc0:59b4 SD32G 29.5 GiB
[  180.717318]  mmcblk0: p1
[  200.640119] FAT-fs (mmcblk0p1): Volume was not properly unmounted.
Some data may be corrupt. Please run fsck.
[  314.370496] mmc0: card 59b4 removed


The card is recognized and shows up in my KDE interface automatically
and works like it should, although the transfer rate maxes out at an
abysmal 1.25 MB/s. (NOTE: When using the downstream Ubuntu kernel I
get a much more palatable 20MB/s in this situation)

For reference, the hardware is capable of supplying a steady 50 MB/s,
which is what I see in OS X on the same machine.


[3.] Keywords (i.e., modules, networking, kernel):

(Ubuntu tells me to "Please do not put anything here")

[4.] Kernel version (from /proc/version):

Linux version 3.15.0-031500rc6-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201405211835 SMP Wed May 21
22:35:54 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Not applicable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Sorry, I don't think this would be possible.

[7.] Environment

Output from `lsb_release -rd`:
Description: Ubuntu 14.04 LTS
Release: 14.04

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux retinald-linux 3.15.0-031500rc6-generic #201405211835 SMP Wed
May 21 22:35:54 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         hidp snd_hrtimer pci_stub vboxpci vboxnetadp
vboxnetflt vboxdrv rfcomm bnep binfmt_misc nfsd auth_rpcgss nfs_acl
nfs lockd sunrpc fscache joydev bcm5974 btusb bluetooth 6lowpan_iphc
snd_hda_codec_hdmi snd_hda_codec_cirrus snd_hda_codec_generic uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_core videodev
snd_hda_intel snd_hda_controller snd_hda_codec applesmc snd_hwdep
intel_rapl input_polldev x86_pkg_temp_thermal intel_powerclamp
kvm_intel snd_pcm kvm crct10dif_pclmul crc32_pclmul snd_seq_midi
ghash_clmulni_intel snd_seq_midi_event aesni_intel aes_x86_64 lrw
gf128mul glue_helper ablk_helper cryptd snd_rawmidi microcode snd_seq
snd_seq_device snd_timer lpc_ich snd mei_me soundcore mei sbs sbshc
apple_gmux apple_bl parport_pc mac_hid ppdev coretemp lp parport
hid_generic hid_apple usbhid hid i915 i2c_algo_bit ahci drm_kms_helper
libahci drm sdhci_pci sdhci video

[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
stepping : 9
microcode : 0x15
cpu MHz : 2798.437
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep
erms
bogomips : 4988.72
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
stepping : 9
microcode : 0x15
cpu MHz : 2446.875
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep
erms
bogomips : 4988.72
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
stepping : 9
microcode : 0x15
cpu MHz : 2485.937
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep
erms
bogomips : 4988.72
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
stepping : 9
microcode : 0x15
cpu MHz : 1665.625
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep
erms
bogomips : 4988.72
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

nls_iso8859_1 12713 0 - Live 0x0000000000000000
sdhci_pci 23347 0 - Live 0x0000000000000000
sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
mmc_block 36596 0 - Live 0x0000000000000000
hidp 24317 0 - Live 0x0000000000000000
snd_hrtimer 12744 1 - Live 0x0000000000000000
bcm5974 17688 0 - Live 0x0000000000000000
btusb 32555 0 - Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
uvcvideo 82299 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 45435 1 uvcvideo, Live 0x0000000000000000
videodev 149504 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
snd_hda_codec_hdmi 48229 1 - Live 0x0000000000000000
intel_rapl 19238 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
snd_hda_codec_cirrus 18855 1 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_cirrus, Live 0x0000000000000000
kvm_intel 148919 0 - Live 0x0000000000000000
kvm 463808 1 kvm_intel, Live 0x0000000000000000
applesmc 19564 0 - Live 0x0000000000000000
snd_hda_intel 30608 6 - Live 0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
input_polldev 13896 1 applesmc, Live 0x0000000000000000
snd_hda_codec 144671 5
snd_hda_codec_hdmi,snd_hda_codec_cirrus,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
rfcomm 75078 12 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
snd_pcm 113863 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
bluetooth 461775 23 hidp,btusb,rfcomm,bnep, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
aesni_intel 152648 1 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
snd_seq 67636 3 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30118 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
snd 74195 24 snd_hda_codec_hdmi,snd_hda_codec_cirrus,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
mei_me 18562 0 - Live 0x0000000000000000
soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000
mei 87522 1 mei_me, Live 0x0000000000000000
sbs 13682 0 - Live 0x0000000000000000
sbshc 13847 1 sbs, Live 0x0000000000000000
apple_gmux 13707 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
apple_bl 14007 1 apple_gmux, Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
nfsd 291772 13 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
auth_rpcgss 60032 1 nfsd, Live 0x0000000000000000
nfs_acl 12883 1 nfsd, Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
nfs 248168 0 - Live 0x0000000000000000
lockd 95174 2 nfsd,nfs, Live 0x0000000000000000
sunrpc 301108 23 nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live 0x0000000000000000
fscache 64282 1 nfs, Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
hid_apple 13546 0 - Live 0x0000000000000000
usbhid 53121 0 - Live 0x0000000000000000
hid 106436 4 hidp,hid_generic,hid_apple,usbhid, Live 0x0000000000000000
i915 873516 2 - Live 0x0000000000000000
ahci 30167 1 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 59729 1 i915, Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
drm 310655 4 i915,drm_kms_helper, Live 0x0000000000000000
video 19932 2 apple_gmux,i915, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports:

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0300-031f : applesmc
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-057f : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:04
  2000-203f : 0000:00:02.0
  2060-207f : 0000:00:1f.2
    2060-207f : ahci
  2090-2097 : 0000:00:1f.2
    2090-2097 : ahci
  2098-209f : 0000:00:1f.2
    2098-209f : ahci
  20b8-20bb : 0000:00:1f.2
    20b8-20bb : ahci
  20bc-20bf : 0000:00:1f.2
    20bc-20bf : ahci
  3000-5fff : PCI Bus 0000:04
  efa0-efbf : 0000:00:1f.3


/proc/iomem:

00000000-00000fff : reserved
00001000-0008dfff : System RAM
0008e000-0008ffff : reserved
00090000-0009ffff : System RAM
000a0000-000bffff : PCI Bus 0000:00
  000a0000-000bffff : reserved
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-0177c658 : Kernel code
  0177c659-01d1efbf : Kernel data
  01e7b000-01fe0fff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:09
20200000-40003fff : System RAM
40004000-40004fff : reserved
40005000-84f4d18f : System RAM
84f4d190-84f5d1cf : System RAM
84f5d1d0-88d11fff : System RAM
88d12000-88d52fff : ACPI Non-volatile Storage
88d53000-88d66fff : System RAM
88d67000-88d8efff : ACPI Tables
88d8f000-88e3bfff : System RAM
88e3c000-88e8efff : reserved
88e8f000-88ed6fff : System RAM
88ed7000-88efefff : reserved
88eff000-88f91fff : System RAM
88f92000-88ffefff : reserved
88fff000-88ffffff : System RAM
89000000-8f9fffff : reserved
  89a00000-8f9fffff : Graphics Stolen Memory
8fa00000-feafffff : PCI Bus 0000:00
  8fa00000-8fafffff : PCI Bus 0000:02
  90000000-9fffffff : 0000:00:02.0
  a0000000-a03fffff : 0000:00:02.0
  a0400000-a04fffff : PCI Bus 0000:02
    a0400000-a040ffff : 0000:02:00.0
    a0410000-a041ffff : 0000:02:00.0
    a0420000-a042ffff : 0000:02:00.1
      a0420000-a042ffff : mmc0
    a0430000-a04307ff : 0000:02:00.0
  a0500000-a05fffff : PCI Bus 0000:03
    a0500000-a0503fff : 0000:03:00.0
  a0600000-a060ffff : 0000:00:14.0
    a0600000-a060ffff : xhci_hcd
  a0610000-a0613fff : 0000:00:1b.0
    a0610000-a0613fff : ICH HD audio
  a0616000-a06167ff : 0000:00:1f.2
    a0616000-a06167ff : ahci
  a0616800-a0616bff : 0000:00:1d.0
    a0616800-a0616bff : ehci_hcd
  a0616c00-a0616fff : 0000:00:1a.0
    a0616c00-a0616fff : ehci_hcd
  a0617000-a06170ff : 0000:00:1f.3
  a0617100-a061710f : 0000:00:16.0
    a0617100-a061710f : mei_me
  a0700000-ac7fffff : PCI Bus 0000:04
  ac800000-b87fffff : PCI Bus 0000:04
  e0000000-e9afffff : PCI MMCONFIG 0000 [bus 00-9a]
    e00f8000-e00f8fff : reserved
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:02
fed10000-fed17fff : pnp 00:08
fed18000-fed18fff : pnp 00:08
fed19000-fed19fff : pnp 00:08
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:08
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:08
fed40000-fed44fff : PCI Bus 0000:00
fed45000-fed8ffff : pnp 00:08
fee00000-feefffff : pnp 00:08
  fee00000-fee00fff : Local APIC
ffe70000-ffe9ffff : reserved
100000000-26f5fffff : System RAM
26f600000-26fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)
Subsystem: Apple Inc. Device 0102
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: ivb_uncore

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core
processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 256 bytes
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [88] Subsystem: Apple Inc. Device 0102
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4171
Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 256 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #2, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency
L0s <1us, L1 <8us
ClockPM- Surprise- LLActRep- BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled+ CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending+ InProgress-
Capabilities: [140 v1] Root Complex Link
Desc: PortNumber=02 ComponentID=01 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed19000
Capabilities: [d94 v1] #19
Kernel driver in use: pcieport

00:01.1 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core
processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 256 bytes
Bus: primary=00, secondary=04, subordinate=9a, sec-latency=0
I/O behind bridge: 00003000-00005fff
Memory behind bridge: a0700000-ac7fffff
Prefetchable memory behind bridge: 00000000ac800000-00000000b87fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [88] Subsystem: Apple Inc. Device 0102
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4181
Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #3, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s
<256ns, L1 <8us
ClockPM- Surprise- LLActRep- BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled+ CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending+ InProgress-
Capabilities: [140 v1] Root Complex Link
Desc: PortNumber=03 ComponentID=01 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed19000
Capabilities: [d94 v1] #19
Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
Subsystem: Apple Inc. Device 0102
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 46
Region 0: Memory at a0000000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at 90000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at 2000 [size=64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4122
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
Subsystem: Intel Corporation Device 7270
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 44
Region 0: Memory at a0600000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41c1
Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210
Series Chipset Family MEI Controller #1 (rev 04)
Subsystem: Intel Corporation Device 7270
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 47
Region 0: Memory at a0617100 (64-bit, non-prefetchable) [size=16]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 4142
Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
Subsystem: Intel Corporation Device 7270
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at a0616c00 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)
Subsystem: Intel Corporation Device 7270
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 256 bytes
Interrupt: pin A routed to IRQ 48
Region 0: Memory at a0610000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 4152
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
VC1: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=22
Status: NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc: PortNumber=0f ComponentID=00 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed1c000
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 256 bytes
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: 8fa00000-8fafffff
Prefetchable memory behind bridge: 00000000a0400000-00000000a04fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4191
Capabilities: [90] Subsystem: Intel Corporation Device 7270
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 256 bytes
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: a0500000-a05fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 41b1
Capabilities: [90] Subsystem: Intel Corporation Device 7270
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
Subsystem: Intel Corporation Device 7270
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 22
Region 0: Memory at a0616800 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QS77 Express Chipset LPC
Controller (rev 04)
Subsystem: Intel Corporation Device 7270
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: Intel Corporation Device 7270
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 45
Region 0: I/O ports at 2098 [size=8]
Region 1: I/O ports at 20bc [size=4]
Region 2: I/O ports at 2090 [size=8]
Region 3: I/O ports at 20b8 [size=4]
Region 4: I/O ports at 2060 [size=32]
Region 5: Memory at a0616000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0a00c  Data: 41e1
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
SMBus Controller (rev 04)
Subsystem: Intel Corporation Device 7270
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 0
Region 0: Memory at a0617000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at efa0 [size=32]

02:00.0 Ethernet controller: Broadcom Corporation Device 16a3 (rev 21)
Subsystem: Broadcom Corporation Device 16a3
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 0
Region 0: Memory at a0400000 (64-bit, prefetchable) [disabled] [size=64K]
Region 2: Memory at a0410000 (64-bit, prefetchable) [disabled] [size=64K]
Expansion ROM at a0430000 [disabled] [size=2K]
Capabilities: [48] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [50] Vital Product Data
Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
Read-only fields:
[PN] Part number: BCM957766
[EC] Engineering changes: 106679-15
[SN] Serial number: 0123456789
[MN] Manufacture ID: 31 34 65 34
[RV] Reserved: checksum good, 27 byte(s) reserved
End
Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [a0] MSI-X: Enable- Count=5 Masked-
Vector table: BAR=2 offset=00000000
PBA: BAR=2 offset=00000120
Capabilities: [ac] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [13c v1] Device Serial Number 00-00-00-10-18-00-00-00
Capabilities: [150 v1] Power Budgeting <?>
Capabilities: [160 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [1b0 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns

02:00.1 SD Host controller: Broadcom Corporation BCM57765/57785
SDXC/MMC Card Reader (rev 21) (prog-if 01)
Subsystem: Broadcom Corporation Device 96bc
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 256 bytes
Interrupt: pin B routed to IRQ 17
Region 0: Memory at a0420000 (64-bit, prefetchable) [size=64K]
Capabilities: [48] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [ac] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [150 v1] Power Budgeting <?>
Capabilities: [160 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Kernel driver in use: sdhci-pci

03:00.0 Network controller: Broadcom Corporation BCM4331 802.11a/b/g/n (rev 02)
Subsystem: Broadcom Corporation BCM4331 802.11a/b/g/n
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
Latency: 0, Cache Line Size: 256 bytes
Interrupt: pin A routed to IRQ 0
Region 0: Memory at a0500000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
Capabilities: [58] Vendor Specific Information: Len=78 <?>
Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [d0] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <32us
ClockPM+ Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [13c v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 00-00-00-ff-ff-00-00-00
Capabilities: [16c v1] Power Budgeting <?>


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: APPLE SSD SM256E Rev: CXM0
  Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Excerpts from dmesg after boot:

[    4.153430] sdhci: Secure Digital Host Controller Interface driver
[    4.153433] sdhci: Copyright(c) Pierre Ossman
[    4.154578] sdhci-pci 0000:02:00.1: SDHCI controller found
[14e4:16bc] (rev 21)
[    4.154769] mmc0: no vqmmc regulator found
[    4.154770] mmc0: no vmmc regulator found
[    4.154846] mmc0: SDHCI controller on PCI [0000:02:00.1] using ADMA

...

[    8.741243] irq 17: nobody cared (try booting with the "irqpoll" option)
[    8.741247] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
3.15.0-031500rc6-generic #201405211835
[    8.741249] Hardware name: Apple Inc.
MacBookPro10,2/Mac-AFD8A9D944EA4843, BIOS
MBP102.88Z.0106.B03.1211161133 11/16/2012
[    8.741250]  ffff88025f91529c ffff88026f283e28 ffffffff81761a51
0000000000003946
[    8.741254]  ffff88025f915200 ffff88026f283e58 ffffffff810ca97d
ffff88026f283e88
[    8.741256]  ffff88025f915200 0000000000000011 0000000000000000
ffff88026f283e88
[    8.741259] Call Trace:
[    8.741261]  <IRQ>  [<ffffffff81761a51>] dump_stack+0x46/0x58
[    8.741271]  [<ffffffff810ca97d>] __report_bad_irq+0x3d/0xe0
[    8.741274]  [<ffffffff810cadab>] note_interrupt+0x14b/0x1a0
[    8.741277]  [<ffffffff810c8411>] handle_irq_event_percpu+0xb1/0x1e0
[    8.741282]  [<ffffffff8101c735>] ? native_sched_clock+0x35/0x90
[    8.741284]  [<ffffffff810c8588>] handle_irq_event+0x48/0x70
[    8.741287]  [<ffffffff810cbae4>] handle_fasteoi_irq+0x84/0x110
[    8.741291]  [<ffffffff81016182>] handle_irq+0x22/0x40
[    8.741295]  [<ffffffff8177a19e>] do_IRQ+0x5e/0x110
[    8.741299]  [<ffffffff8176ec6d>] common_interrupt+0x6d/0x6d
[    8.741300]  <EOI>  [<ffffffff815fe641>] ? cpuidle_enter_state+0x61/0xe0
[    8.741306]  [<ffffffff815fe637>] ? cpuidle_enter_state+0x57/0xe0
[    8.741309]  [<ffffffff815fe6f7>] cpuidle_enter+0x17/0x20
[    8.741312]  [<ffffffff810b344d>] cpuidle_idle_call+0x10d/0x260
[    8.741315]  [<ffffffff810b3765>] cpu_idle_loop+0x1c5/0x1e0
[    8.741320]  [<ffffffff810dcdb2>] ? clockevents_register_device+0xe2/0x140
[    8.741322]  [<ffffffff810b37eb>] cpu_startup_entry+0x6b/0x70
[    8.741326]  [<ffffffff810448f8>] start_secondary+0xc8/0xd0
[    8.741327] handlers:
[    8.741333] [<ffffffffa0011290>] sdhci_irq [sdhci]
[    8.741334] Disabling IRQ #17

I did try rebooting with "irqpoll", but it did not seem to effect any change.


[8.] Other notes, patches, fixes, workarounds:

[8.1] Workaround

Use module parameter debug_quirks2=4 for the sdhci module.

With this (the "upstream") kernel, I get 1.25 MB/s transfer rate and
high CPU use.

With the downstream Ubuntu kernel, I get 20 MB/s transfer rate and a
little CPU use.

With OS X, I get 50 MB/s.

[8.2] Note: Ethernet controller in the same chipset

Apparently, the SDHC controller comes on the same chip as an Ethernet
controller. I have read some reports that people need to engage the
Ethernet port in order to make the SD-reader work. However, on this
hardware, the Ethernet controller is not attached to an Ethernet port.
There is no Ethernet port on this machine, even though there is an
Ethernet controller, as you can see in the lspci output.

[8.3] Note: Excessive heat

When attaching the UHS-SD card without enabling the workaround
(debug_quirks2=4), the following side effects happen:

 a. One CPU core ends up spinning at 100%
 b. The machine gets really, uncomfortably, hot really quickly near
the SD card slot. The SD card gets unexpectedly hot as well.


Best regards,
Magnus Hoff
