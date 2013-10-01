From: Detlef <racinggoat@gmx.de>
Subject: Fwd: Sandisk ExtremePro 32GB not readable in Acer Aspire V3-571G
Date: Tue, 01 Oct 2013 13:28:30 +0200
Message-ID: <524AB1DE.2020706@gmx.de>
References: <524A76DA.6040007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:57406 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab3JAL2e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Oct 2013 07:28:34 -0400
Received: from [10.144.16.28] ([77.179.87.229]) by mail.gmx.com (mrgmx003)
 with ESMTPA (Nemesis) id 0LwrPM-1VtSEw3gtM-016Q79 for
 <linux-mmc@vger.kernel.org>; Tue, 01 Oct 2013 13:28:31 +0200
In-Reply-To: <524A76DA.6040007@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org



Hallo!


Yesterday I sent a Mail, but it was with a false kernel (3.5.0.41). Sorry for that and thanks to Christopher M. Penalver for saying me this.

Now the right results (hope so).

First sorry for my bad English. I do this first, please don't be angry.
Thanks!

[1]
Sandisk ExtremePro 32GB not readable in Acer Aspire V3-571G

[2]
I bought a new Notebook Acer Aspire V3-571G with Windows 8 , I installed ubuntu 12.04. and updated to 12.04.3. And I bought a new SD-card for my
camera (Sandisk ExtremePro 32GB). It doesn't work with ubuntu. With Windows 8 it works fine. My old card ADATA 16 GB class 10 works fine
with ubuntu too. After using 3.12.0 I can see the card in gparted, but there ist no partition table, but there is a partition table and data on the card.

[3]
Sandisk, ExtremPro, 32GB, Acer Aspire V3-571G, cardreader, ubuntu 12.04

[4]
Linux version 3.12.0-031200rc2-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201309231935 SMP Mon Sep 23 23:37:12 UTC 2013

[5]
-------

[6]
-------

[7]
Description:	Ubuntu 12.04.3 LTS
Release:	12.04


[7.1]
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
   
Linux muede-nb 3.12.0-031200rc2-generic #201309231935 SMP Mon Sep 23 23:37:12 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
   
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
Modules Loaded         md4 nls_utf8 cifs fscache hid_logitech_dj usbhid hid mmc_block rfcomm parport_pc ppdev binfmt_misc bnep snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_intel snd_hda_codec ath3k btusb snd_hwdep bluetooth snd_pcm snd_seq_midi arc4 snd_rawmidi snd_seq_midi_event snd_seq ath9k snd_timer snd_seq_device mac80211 nouveau ath9k_common ath9k_hw ttm uvcvideo lp i915 snd joydev ath videobuf2_core mei_me psmouse mei drm_kms_helper cfg80211 drm videodev parport soundcore i2c_algo_bit mxm_wmi acer_wmi serio_raw sparse_keymap videobuf2_vmalloc video videobuf2_memops snd_page_alloc wmi mac_hid lpc_ich sdhci_pci sdhci tg3 ahci ptp libahci pps_core


[7.2]
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2184.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2856.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2712.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2208.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2808.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2808.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2736.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2928.000
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 4789.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:



[7.3]
md4 12595 0 - Live 0x0000000000000000
nls_utf8 12557 0 - Live 0x0000000000000000
cifs 461497 0 - Live 0x0000000000000000
fscache 59345 1 cifs, Live 0x0000000000000000
hid_logitech_dj 18767 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_logitech_dj,usbhid, Live 0x0000000000000000
mmc_block 36316 0 - Live 0x0000000000000000
rfcomm 74658 0 - Live 0x0000000000000000
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 41732 1 - Live 0x0000000000000000
snd_hda_codec_realtek 56649 1 - Live 0x0000000000000000
snd_hda_intel 57183 2 - Live 0x0000000000000000
snd_hda_codec 194881 3 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live 0x0000000000000000
ath3k 13368 0 - Live 0x0000000000000000
btusb 28326 0 - Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
bluetooth 391597 12 rfcomm,bnep,ath3k,btusb, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
ath9k 165738 0 - Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
mac80211 634661 1 ath9k, Live 0x0000000000000000
nouveau 984490 1 - Live 0x0000000000000000
ath9k_common 13793 1 ath9k, Live 0x0000000000000000
ath9k_hw 457778 2 ath9k,ath9k_common, Live 0x0000000000000000
ttm 84699 1 nouveau, Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
i915 733800 2 - Live 0x0000000000000000
snd 73802 15 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
ath 24123 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
videobuf2_core 40903 1 uvcvideo, Live 0x0000000000000000
mei_me 18418 0 - Live 0x0000000000000000
psmouse 104113 0 - Live 0x0000000000000000
mei 78609 1 mei_me, Live 0x0000000000000000
drm_kms_helper 53165 2 nouveau,i915, Live 0x0000000000000000
cfg80211 504229 3 ath9k,mac80211,ath, Live 0x0000000000000000
drm 303133 6 nouveau,ttm,i915,drm_kms_helper, Live 0x0000000000000000
videodev 139144 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
i2c_algo_bit 13564 2 nouveau,i915, Live 0x0000000000000000
mxm_wmi 13021 1 nouveau, Live 0x0000000000000000
acer_wmi 32938 0 - Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
sparse_keymap 13890 1 acer_wmi, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
video 19574 3 nouveau,i915,acer_wmi, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
wmi 19363 3 nouveau,mxm_wmi,acer_wmi, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
sdhci_pci 19116 0 - Live 0x0000000000000000
sdhci 43126 1 sdhci_pci, Live 0x0000000000000000
tg3 170345 0 - Live 0x0000000000000000
ahci 30063 5 - Live 0x0000000000000000
ptp 18980 1 tg3, Live 0x0000000000000000
libahci 32088 1 ahci, Live 0x0000000000000000
pps_core 19352 1 ptp, Live 0x0000000000000000



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
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt
    0450-0450 : ACPI PM2_CNT_BLK
    0454-0457 : pnp 00:08
    0458-047f : pnp 00:06
      0460-047f : iTCO_wdt
    0500-057f : pnp 00:06
    0680-069f : pnp 00:06
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
    1000-100f : pnp 00:06
    164e-164f : pnp 00:06
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
    fd60-fd63 : pnp 00:06
    ffff-ffff : pnp 00:06
      ffff-ffff : pnp 00:06


cat /proc/iomem :
00000000-00000fff : reserved
00001000-0009d3ff : System RAM
0009d400-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cefff : Video ROM
000cf000-000d1fff : Adapter ROM
000e0000-000fffff : reserved
    000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
    01000000-01761e71 : Kernel code
    01761e72-01d189bf : Kernel data
    01e71000-01fe3fff : Kernel bss
20000000-201fffff : reserved
    20000000-201fffff : pnp 00:0a
20200000-40003fff : System RAM
40004000-40004fff : reserved
    40004000-40004fff : pnp 00:0a
40005000-90daffff : System RAM
90db0000-921affff : reserved
921b0000-96abefff : System RAM
96abf000-96ebefff : reserved
96ebf000-96fbefff : ACPI Non-volatile Storage
96fbf000-96ffefff : ACPI Tables
96fff000-96ffffff : System RAM
97000000-9f9fffff : reserved
    97a00000-9f9fffff : Graphics Stolen Memory
9fa00000-feafffff : PCI Bus 0000:00
    9fa00000-9fa00fff : pnp 00:09
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
      b3614000-b361400f : mei_me
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
        f0000000-f3ffffff : pnp 00:09
feb00000-feb03fff : reserved
fec00000-fec00fff : reserved
    fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed19fff : reserved
    fed10000-fed17fff : pnp 00:09
    fed18000-fed18fff : pnp 00:09
    fed19000-fed19fff : pnp 00:09
fed1c000-fed1ffff : reserved
    fed1c000-fed1ffff : pnp 00:09
      fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:09
fed90000-fed93fff : pnp 00:09
fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
ff000000-ff000fff : pnp 00:09
ffc80000-ffffffff : reserved
100000000-45f5fffff : System RAM
45f600000-45fffffff : RAM buffer


[7.5]
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b2000000-b2ffffff
	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Acer Incorporated [ALI] Device 0647
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: feeff00c  Data: 4171
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr+ UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed unknown, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Capabilities: [d94 v1] #19
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at b3000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 3000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee3000c  Data: 41d1
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at b3600000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4191
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at b3614000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 41c1
	Kernel driver in use: mei_me
	Kernel modules: mei-me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at b3619000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at b3610000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 4122
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 9fb00000-9fbfffff
	Prefetchable memory behind bridge: 00000000b3400000-00000000b34fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0647
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: b3500000-b35fffff
	Prefetchable memory behind bridge: 000000009fc00000-000000009fcfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0647
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at b3618000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation HM77 Express Chipset LPC Controller (rev 04)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 42
	Region 0: I/O ports at 3088 [size=8]
	Region 1: I/O ports at 3094 [size=4]
	Region 2: I/O ports at 3080 [size=8]
	Region 3: I/O ports at 3090 [size=4]
	Region 4: I/O ports at 3060 [size=32]
	Region 5: Memory at b3617000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 41b1
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at b3615000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 3040 [size=32]
	Kernel modules: i2c-i801

01:00.0 VGA compatible controller: NVIDIA Corporation GK107M [GeForce GT 730M] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Acer Incorporated [ALI] Device 0648
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at b2000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at a0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at b0000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at 2000 [size=128]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4142
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x16, ASPM L0s L1, Latency L0 <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [b4] Vendor Specific Information: Len=14 <?>
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
	Capabilities: [900 v1] #19
	Kernel driver in use: nouveau
	Kernel modules: nouveau, nvidiafb

02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM57785 Gigabit Ethernet PCIe (rev 10)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at b3430000 (64-bit, prefetchable) [size=64K]
	Region 2: Memory at b3440000 (64-bit, prefetchable) [size=64K]
	Expansion ROM at b3450000 [disabled] [size=2K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000120
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Device Serial Number 00-00-b8-88-e3-b4-d0-14
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: tg3
	Kernel modules: tg3

02:00.1 SD Host controller: Broadcom Corporation BCM57765/57785 SDXC/MMC Card Reader (rev 10) (prog-if 01)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at b3400000 (64-bit, prefetchable) [size=64K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci-pci

02:00.2 System peripheral: Broadcom Corporation BCM57765/57785 MS Card Reader (rev 10)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at b3410000 (64-bit, prefetchable) [size=64K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-

02:00.3 System peripheral: Broadcom Corporation BCM57765/57785 xD-Picture Card Reader (rev 10)
	Subsystem: Acer Incorporated [ALI] Device 0647
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at b3420000 (64-bit, prefetchable) [size=64K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-

03:00.0 Network controller: Qualcomm Atheros AR9462 Wireless Network Adapter (rev 01)
	Subsystem: Foxconn International, Inc. Device e052
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at b3500000 (64-bit, non-prefetchable) [size=512K]
	Expansion ROM at 9fc00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
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
1     1085  1222  1303  1828  2321  2460  2517  2602  2713  29    3152  3547  43   57   70   83    asound       fb           latency_stats  schedstat      uptime
10    1086  1224  14    1854  2355  2463  2520  2604  2721  290   3159  3548  432  576  71   831   buddyinfo    filesystems  loadavg        scsi           version
1000  1090  123   1476  1855  2366  2466  2522  2611  2737  291   3176  3549  44   58   72   835   bus          fs           locks          self           vmallocinfo
1003  11    1234  1479  19    24    2473  2525  2616  2776  292   32    3557  46   59   73   84    cgroups      interrupts   mdstat         slabinfo       vmstat
1006  1116  1238  1494  1902  2401  2474  2532  2619  28    293   322   3561  47   61   74   85    cmdline      iomem        meminfo        softirqs       zoneinfo
1007  1119  124   15    1915  2404  2475  2534  2620  2826  3     323   36    48   62   75   86    consoles     ioports      misc           stat
101   1120  1245  1518  2     2405  2477  2537  2677  2827  30    3263  37    49   63   78   880   cpuinfo      irq          modules        swaps
1031  1122  1246  16    20    2425  2478  2539  2683  2833  301   33    38    5    64   8    9     crypto       kallsyms     mounts         sys
104   1161  1247  1620  21    2434  2482  2546  2688  2839  31    3383  39    51   65   80   921   devices      kcore        mtrr           sysrq-trigger
1069  12    1270  1665  2166  2436  2493  2547  2698  2848  3100  34    4     52   66   81   98    diskstats    key-users    net            sysvipc
1071  1205  1271  17    2172  2446  2497  2571  2699  2874  3108  3518  41    53   67   82   980   dma          kmsg         pagetypeinfo   timer_list
1079  1213  1299  18    22    2448  25    2588  27    288   3147  3519  414   54   69   825  989   driver       kpagecount   partitions     timer_stats
1083  1221  13    1820  23    2454  2514  26    2706  289   3150  3520  42    56   7    827  acpi  execdomains  kpageflags   sched_debug    tty


[X.]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1216583


I hope, Iget help from you. It would enjoy me to get information back.
If you need some other information let me know it.

Thanks!








