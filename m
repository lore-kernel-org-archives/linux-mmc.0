From: Detlef <racinggoat@gmx.de>
Subject: Sandisk ExtremePro 32GB not readable in Acer Aspire V3-571G
Date: Mon, 30 Sep 2013 09:35:12 +0200
Message-ID: <524929B0.9050902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab3I3HfP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Sep 2013 03:35:15 -0400
Received: from [10.144.16.28] ([77.179.75.108]) by mail.gmx.com (mrgmx003)
 with ESMTPA (Nemesis) id 0Mg42v-1VEGLk015R-00NVbQ for
 <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2013 09:35:13 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

Hallo!

First sorry for my bad English. I do this first, please don't be angry. 
Thanks!

[1]
Sandisk ExtremePro 32GB not readable in Acer Aspire V3-571G

[2]
I bought a new Notebook Acer Aspire V3-571G with Windows 8 , I installed 
ubuntu 12.04. and updated to 12.04.3. And I bought a new SD-card for my 
camera (Sandisk ExtremePro 32GB). It doesn't work with ubuntu. With 
Windows 8 it works fine. My old card ADATA 16 GB class 10 works fine 
with ubuntu too.

[3]
Sandisk, ExtremPro, 32GB, Acer Aspire V3-571G, cardreader, ubuntu 12.04

[4]
Linux version 3.5.0-41-generic (buildd@akateko) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #64~precise1-Ubuntu SMP Thu Sep 12 
16:50:04 UTC 2013

[5]
-------

[6]
-------

[7]
Description:    Ubuntu 12.04.3 LTS
Release:    12.04

[7.1]
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux muede-nb 3.5.0-41-generic #64~precise1-Ubuntu SMP Thu Sep 12 
16:50:04 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.6
Gnu make               3.81
binutils               2.22
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.13
wireless-tools         30
Modules Loaded         pci_stub vboxpci vboxnetadp vboxnetflt vboxdrv 
btrfs zlib_deflate libcrc32c ufs qnx4 hfsplus hfs minix ntfs msdos jfs 
xfs reiserfs ext2 parport_pc ppdev rfcomm bnep binfmt_misc 
snd_hda_codec_hdmi snd_hda_codec_realtek ath3k btusb bluetooth coretemp 
kvm_intel kvm ghash_clmulni_intel aesni_intel cryptd aes_x86_64 uvcvideo 
videobuf2_core videodev videobuf2_vmalloc videobuf2_memops snd_hda_intel 
snd_hda_codec snd_hwdep snd_pcm snd_seq_midi snd_rawmidi 
snd_seq_midi_event snd_seq arc4 snd_timer snd_seq_device microcode ath9k 
lpc_ich snd mac80211 ath9k_common psmouse serio_raw ath9k_hw ath 
soundcore snd_page_alloc cfg80211 nouveau i915 mei ttm drm_kms_helper 
drm mxm_wmi i2c_algo_bit joydev acer_wmi sparse_keymap wmi video mac_hid 
lp parport hid_logitech_dj usbhid hid ahci libahci sdhci_pci sdhci tg3

[7.2]
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping    : 9
microcode    : 0x17
cpu MHz        : 1200.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer 
aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm 
tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips    : 4788.93
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3]
pci_stub 12623 1 - Live 0x0000000000000000
vboxpci 23237 0 - Live 0x0000000000000000 (O)
vboxnetadp 25671 0 - Live 0x0000000000000000 (O)
vboxnetflt 27613 0 - Live 0x0000000000000000 (O)
vboxdrv 320275 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (O)
btrfs 781180 0 - Live 0x0000000000000000
zlib_deflate 27140 1 btrfs, Live 0x0000000000000000
libcrc32c 12645 1 btrfs, Live 0x0000000000000000
ufs 75309 0 - Live 0x0000000000000000
qnx4 13432 0 - Live 0x0000000000000000
hfsplus 89053 0 - Live 0x0000000000000000
hfs 54783 0 - Live 0x0000000000000000
minix 36416 0 - Live 0x0000000000000000
ntfs 101959 0 - Live 0x0000000000000000
msdos 17333 0 - Live 0x0000000000000000
jfs 186683 0 - Live 0x0000000000000000
xfs 852748 0 - Live 0x0000000000000000
reiserfs 249170 0 - Live 0x0000000000000000
ext2 73799 0 - Live 0x0000000000000000
parport_pc 32867 0 - Live 0x0000000000000000
ppdev 17114 0 - Live 0x0000000000000000
rfcomm 47562 0 - Live 0x0000000000000000
bnep 18240 2 - Live 0x0000000000000000
binfmt_misc 17541 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 32476 1 - Live 0x0000000000000000
snd_hda_codec_realtek 79855 1 - Live 0x0000000000000000
ath3k 12969 0 - Live 0x0000000000000000
btusb 22432 0 - Live 0x0000000000000000
bluetooth 212001 12 bnep,rfcomm,ath3k,btusb, Live 0x0000000000000000
coretemp 13642 0 - Live 0x0000000000000000
kvm_intel 137888 0 - Live 0x0000000000000000
kvm 422160 1 kvm_intel, Live 0x0000000000000000
ghash_clmulni_intel 13221 0 - Live 0x0000000000000000
aesni_intel 51134 1 - Live 0x0000000000000000
cryptd 20531 2 ghash_clmulni_intel,aesni_intel, Live 0x0000000000000000
aes_x86_64 17256 1 aesni_intel, Live 0x0000000000000000
uvcvideo 78117 0 - Live 0x0000000000000000
videobuf2_core 33025 1 uvcvideo, Live 0x0000000000000000
videodev 125126 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
videobuf2_vmalloc 12861 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13405 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_hda_intel 34063 2 - Live 0x0000000000000000
snd_hda_codec 135141 3 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live 
0x0000000000000000
snd_hwdep 17765 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 97523 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
snd_seq_midi 13325 0 - Live 0x0000000000000000
snd_rawmidi 30750 1 snd_seq_midi, Live 0x0000000000000000
snd_seq_midi_event 14900 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 61931 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
arc4 12530 2 - Live 0x0000000000000000
snd_timer 29990 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14498 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
microcode 23030 0 - Live 0x0000000000000000
ath9k 133095 0 - Live 0x0000000000000000
lpc_ich 17145 0 - Live 0x0000000000000000
snd 83674 14 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, 
Live 0x0000000000000000
mac80211 555272 1 ath9k, Live 0x0000000000000000
ath9k_common 14054 1 ath9k, Live 0x0000000000000000
psmouse 102541 0 - Live 0x0000000000000000
serio_raw 13216 0 - Live 0x0000000000000000
ath9k_hw 399752 2 ath9k,ath9k_common, Live 0x0000000000000000
ath 24124 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
soundcore 15092 1 snd, Live 0x0000000000000000
snd_page_alloc 18573 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
cfg80211 208382 3 ath9k,mac80211,ath, Live 0x0000000000000000
nouveau 924024 0 - Live 0x0000000000000000
i915 539443 4 - Live 0x0000000000000000
mei 41410 0 - Live 0x0000000000000000
ttm 88495 1 nouveau, Live 0x0000000000000000
drm_kms_helper 49259 2 nouveau,i915, Live 0x0000000000000000
drm 290595 7 nouveau,i915,ttm,drm_kms_helper, Live 0x0000000000000000
mxm_wmi 13022 1 nouveau, Live 0x0000000000000000
i2c_algo_bit 13565 2 nouveau,i915, Live 0x0000000000000000
joydev 17694 0 - Live 0x0000000000000000
acer_wmi 32845 0 - Live 0x0000000000000000
sparse_keymap 13891 1 acer_wmi, Live 0x0000000000000000
wmi 19257 3 nouveau,mxm_wmi,acer_wmi, Live 0x0000000000000000
video 19653 3 nouveau,i915,acer_wmi, Live 0x0000000000000000
mac_hid 13254 0 - Live 0x0000000000000000
lp 17800 0 - Live 0x0000000000000000
parport 46563 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_logitech_dj 18768 0 - Live 0x0000000000000000
usbhid 47259 1 hid_logitech_dj, Live 0x0000000000000000
hid 100815 2 hid_logitech_dj,usbhid, Live 0x0000000000000000
ahci 25869 5 - Live 0x0000000000000000
libahci 27338 1 ahci, Live 0x0000000000000000
sdhci_pci 18749 0 - Live 0x0000000000000000
sdhci 33145 1 sdhci_pci, Live 0x0000000000000000
tg3 156749 0 - Live 0x0000000000000000

[7.4]
cat /proc/ioports :
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
   0400-0453 : pnp 00:07
     0400-0403 : ACPI PM1a_EVT_BLK
     0404-0405 : ACPI PM1a_CNT_BLK
     0408-040b : ACPI PM_TMR
     0410-0415 : ACPI CPU throttle
     0420-042f : ACPI GPE0_BLK
     0450-0450 : ACPI PM2_CNT_BLK
   0454-0457 : pnp 00:09
   0458-047f : pnp 00:07
   0500-057f : pnp 00:07
   0680-069f : pnp 00:07
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-100f : pnp 00:07
   164e-164f : pnp 00:07
   2000-2fff : PCI Bus 0000:01
     2000-207f : 0000:01:00.0
   3000-303f : 0000:00:02.0
   3040-305f : 0000:00:1f.3
   3060-307f : 0000:00:1f.2
     3060-307f : ahci
   3080-3087 : 0000:00:1f.2
     3080-3087 : ahci
   3088-308f : 0000:00:1f.2
     3088-308f : ahci
   3090-3093 : 0000:00:1f.2
     3090-3093 : ahci
   3094-3097 : 0000:00:1f.2
     3094-3097 : ahci
   fd60-fd63 : pnp 00:07
   ffff-ffff : pnp 00:07
     ffff-ffff : pnp 00:07

cat /proc/iomem :
00000000-0000ffff : reserved
00010000-0009d3ff : System RAM
0009d400-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cefff : Video ROM
000cf000-000d1fff : Adapter ROM
000e0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
   01000000-016aac3a : Kernel code
   016aac3b-01cdc5ff : Kernel data
   01dd2000-01f32fff : Kernel bss
20000000-201fffff : reserved
   20000000-201fffff : pnp 00:0b
20200000-40003fff : System RAM
40004000-40004fff : reserved
   40004000-40004fff : pnp 00:0b
40005000-90daffff : System RAM
90db0000-921affff : reserved
921b0000-96abefff : System RAM
96abf000-96ebefff : reserved
96ebf000-96fbefff : ACPI Non-volatile Storage
96fbf000-96ffefff : ACPI Tables
96fff000-96ffffff : System RAM
97000000-9f9fffff : reserved
9fa00000-feafffff : PCI Bus 0000:00
   9fa00000-9fa00fff : pnp 00:0a
   9fb00000-9fbfffff : PCI Bus 0000:02
   9fc00000-9fcfffff : PCI Bus 0000:03
     9fc00000-9fc0ffff : 0000:03:00.0
   a0000000-b1ffffff : PCI Bus 0000:01
     a0000000-afffffff : 0000:01:00.0
     b0000000-b1ffffff : 0000:01:00.0
   b2000000-b2ffffff : PCI Bus 0000:01
     b2000000-b2ffffff : 0000:01:00.0
   b3000000-b33fffff : 0000:00:02.0
   b3400000-b34fffff : PCI Bus 0000:02
     b3400000-b340ffff : 0000:02:00.1
       b3400000-b340ffff : mmc0
     b3410000-b341ffff : 0000:02:00.2
     b3420000-b342ffff : 0000:02:00.3
     b3430000-b343ffff : 0000:02:00.0
       b3430000-b343ffff : tg3
     b3440000-b344ffff : 0000:02:00.0
       b3440000-b344ffff : tg3
     b3450000-b34507ff : 0000:02:00.0
   b3500000-b35fffff : PCI Bus 0000:03
     b3500000-b357ffff : 0000:03:00.0
       b3500000-b357ffff : ath9k
   b3600000-b360ffff : 0000:00:14.0
     b3600000-b360ffff : xhci_hcd
   b3610000-b3613fff : 0000:00:1b.0
     b3610000-b3613fff : ICH HD audio
   b3614000-b361400f : 0000:00:16.0
     b3614000-b361400f : mei
   b3615000-b36150ff : 0000:00:1f.3
   b3617000-b36177ff : 0000:00:1f.2
     b3617000-b36177ff : ahci
   b3618000-b36183ff : 0000:00:1d.0
     b3618000-b36183ff : ehci_hcd
   b3619000-b36193ff : 0000:00:1a.0
     b3619000-b36193ff : ehci_hcd
   c0000000-cfffffff : 0000:00:02.0
   f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f0000000-f3ffffff : reserved
       f0000000-f3ffffff : pnp 00:0a
feb00000-feb03fff : reserved
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed19fff : reserved
   fed10000-fed17fff : pnp 00:0a
   fed18000-fed18fff : pnp 00:0a
   fed19000-fed19fff : pnp 00:0a
fed1c000-fed1ffff : reserved
   fed1c000-fed1ffff : pnp 00:0a
fed20000-fed3ffff : pnp 00:0a
fed90000-fed93fff : pnp 00:0a
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ff000fff : pnp 00:0a
ffc80000-ffffffff : reserved
100000000-45f5fffff : System RAM
45f600000-45fffffff : RAM buffer

[7.5]
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM 
Controller (rev 09)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core 
processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: b2000000-b2ffffff
     Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [88] Subsystem: Acer Incorporated [ALI] Device 0647
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: feeff00c  Data: 4159
     Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 256 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed unknown, Width x16, ASPM L0s L1, 
Latency L0 <256ns, L1 <8us
             ClockPM- Surprise- LLActRep- BwNot+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt+ ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: Unknown, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -3.5dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [140 v1] Root Complex Link
         Desc:    PortNumber=02 ComponentID=01 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed19000
     Capabilities: [d94 v1] #19
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core 
processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 44
     Region 0: Memory at b3000000 (64-bit, non-prefetchable) [size=4M]
     Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
     Region 4: I/O ports at 3000 [size=64]
     Expansion ROM at <unassigned> [disabled]
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0100c  Data: 4181
     Capabilities: [d0] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a4] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: i915
     Kernel modules: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset 
Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 41
     Region 0: Memory at b3600000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 4161
     Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series 
Chipset Family MEI Controller #1 (rev 04)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 43
     Region 0: Memory at b3614000 (64-bit, non-prefetchable) [size=16]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000feeff00c  Data: 415a
     Kernel driver in use: mei
     Kernel modules: mei

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset 
Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at b3619000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci_hcd

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset 
Family High Definition Audio Controller (rev 04)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 45
     Region 0: Memory at b3610000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000feeff00c  Data: 4162
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE- FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, 
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=22
             Status:    NegoPending- InProgress-
     Capabilities: [130 v1] Root Complex Link
         Desc:    PortNumber=0f ComponentID=00 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset 
Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: 9fb00000-9fbfffff
     Prefetchable memory behind bridge: 00000000b3400000-00000000b34fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <512ns, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0647
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset 
Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: b3500000-b35fffff
     Prefetchable memory behind bridge: 000000009fc00000-000000009fcfffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <512ns, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0647
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset 
Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at b3618000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci_hcd

00:1f.0 ISA bridge: Intel Corporation HM77 Express Chipset LPC 
Controller (rev 04)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 
6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 42
     Region 0: I/O ports at 3088 [size=8]
     Region 1: I/O ports at 3094 [size=4]
     Region 2: I/O ports at 3080 [size=8]
     Region 3: I/O ports at 3090 [size=4]
     Region 4: I/O ports at 3060 [size=32]
     Region 5: Memory at b3617000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0100c  Data: 4171
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Capabilities: [b0] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ahci
     Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family 
SMBus Controller (rev 04)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 10
     Region 0: Memory at b3615000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at 3040 [size=32]
     Kernel modules: i2c-i801

01:00.0 VGA compatible controller: NVIDIA Corporation GK107M [GeForce GT 
730M] (rev a1) (prog-if 00 [VGA controller])
     Subsystem: Acer Incorporated [ALI] Device 0648
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at b2000000 (32-bit, non-prefetchable) [size=16M]
     Region 1: Memory at a0000000 (64-bit, prefetchable) [size=256M]
     Region 3: Memory at b0000000 (64-bit, prefetchable) [size=32M]
     Region 5: I/O ports at 2000 [size=128]
     Expansion ROM at <ignored> [disabled]
     Capabilities: [60] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [78] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 <64us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x16, ASPM L0s L1, 
Latency L0 <512ns, L1 <4us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range AB, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: Unknown, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB
     Capabilities: [b4] Vendor Specific Information: Len=14 <?>
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [128 v1] Power Budgeting <?>
     Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=024 <?>
     Capabilities: [900 v1] #19
     Kernel modules: nouveau, nvidiafb

02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM57785 
Gigabit Ethernet PCIe (rev 10)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at b3430000 (64-bit, prefetchable) [size=64K]
     Region 2: Memory at b3440000 (64-bit, prefetchable) [size=64K]
     Expansion ROM at b3450000 [disabled] [size=2K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
         Vector table: BAR=2 offset=00000000
         PBA: BAR=2 offset=00000120
     Capabilities: [ac] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <2us, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [13c v1] Device Serial Number 00-00-b8-88-e3-b4-d0-14
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Kernel driver in use: tg3
     Kernel modules: tg3

02:00.1 SD Host controller: Broadcom Corporation BCM57765/57785 SDXC/MMC 
Card Reader (rev 10) (prog-if 01)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 17
     Region 0: Memory at b3400000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [ac] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <2us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Kernel driver in use: sdhci-pci
     Kernel modules: sdhci-pci

02:00.2 System peripheral: Broadcom Corporation BCM57765/57785 MS Card 
Reader (rev 10)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 11
     Region 0: Memory at b3410000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [ac] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <2us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-

02:00.3 System peripheral: Broadcom Corporation BCM57765/57785 
xD-Picture Card Reader (rev 10)
     Subsystem: Acer Incorporated [ALI] Device 0647
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 11
     Region 0: Memory at b3420000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [ac] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <2us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-

03:00.0 Network controller: Qualcomm Atheros AR9462 Wireless Network 
Adapter (rev 01)
     Subsystem: Foxconn International, Inc. Device e052
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 17
     Region 0: Memory at b3500000 (64-bit, non-prefetchable) [size=512K]
     Expansion ROM at 9fc00000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [70] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <4us, L1 <64us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
     Capabilities: [140 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
     Kernel driver in use: ath9k
     Kernel modules: ath9k

[7.6]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST1000LM024 HN-M Rev: 2AR1
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: MATSHITA Model: BD-CMB UJ160     Rev: 1.00
   Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7]
1      1103  1282  1752  1908  2218  2617  421   4714  4733  55 
9922       dri            loadavg       stat
10006  1108  1288  1761  1910  252   2618  43    4715  4734  56 
9928       driver         locks         swaps
10009  1111  1289  1832  1914  253   2619  44    4716  4735  6 
9929       execdomains    mdstat        sys
10011  1113  1308  1834  1917  254   296   45    4717  4736  65 
998        fb             meminfo       sysrq-trigger
1025   1115  1336  1848  1922  255   297   46    4718  4737  669 
9990       filesystems    misc          sysvipc
1026   1117  1340  1850  1941  256   2972  47    4719  4738  674 
acpi       fs             modules       timer_list
10319  1180  1519  1853  2     257   3     4702  4720  4739  7 
asound     interrupts     mounts        timer_stats
10397  1184  1521  1858  2088  2602  3042  4703  4721  4741  70 
buddyinfo  iomem          mtrr          tty
10405  1190  1525  1860  2097  2603  320   4704  4722  50    862 
bus        ioports        net           uptime
10416  1244  1548  1866  2123  2605  36    4705  4723  5013  90 
cgroups    irq            pagetypeinfo  version
10473  1251  1623  1868  2124  2610  37    4706  4724  5014  904 
cmdline    kallsyms       partitions    version_signature
10484  1260  1658  1874  2131  2611  38    4708  4725  5017  91 
consoles   kcore          sched_debug   vmallocinfo
10684  1261  1661  1886  2138  2612  39    4709  4726  51    92 
cpuinfo    key-users      schedstat     vmstat
10685  1263  1662  1888  2146  2613  392   4710  4728  52    9558 
crypto     kmsg           scsi          zoneinfo
1069   1273  1675  1889  2154  2614  41    4711  4729  5257  960 
devices    kpagecount     self
1096   1278  1677  1899  2155  2615  4119  4712  4730  53    965 
diskstats  kpageflags     slabinfo
1098   1280  1686  1905  2181  2616  42    4713  4731  54    9796 
dma        latency_stats  softirqs

[X.]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1216583


I hope, Iget help from you. It would enjoy me to get information back. 
If you need some other information let me know it.

Thanks!



