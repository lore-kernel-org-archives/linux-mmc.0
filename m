From: =?iso-8859-1?Q?=C1d=E1m?= <kricsek@yahoo.com>
Subject: Sony memory stick pro duo is not recognized
Date: Tue, 20 Nov 2012 00:25:58 -0800 (PST)
Message-ID: <1353399958.89616.YahooMailNeo@web126201.mail.ne1.yahoo.com>
Reply-To: =?iso-8859-1?Q?=C1d=E1m?= <kricsek@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm39-vm6.bullet.mail.ne1.yahoo.com ([98.138.229.166]:32383 "EHLO
	nm39-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727Ab2KTIc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 20 Nov 2012 03:32:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "1073887@bugs.launchpad.net" <1073887@bugs.launchpad.net>

Hi, I'd like to report a problem. I was following information provided =
here: https://wiki.ubuntu.com/Bugs/Upstream/kernel
Thanks.

[1.] One line summary of the problem:=A0
Sony memory stick pro duo is not recognized=A0

[2.] Full description of the problem/report:
I'm using Ubuntu 12.10 x64 on a Acer 5755G laptop. When I insert my Son=
y memory stick pro duo (with a memory stick duo adaptor) memory card no=
thing happens. It does work in Windows 7 on the same laptop. SD cards w=
ork in Ubuntu too with this card reader. (SD Host controller: Broadcom =
Corporation NetXtreme BCM57765 Memory Card Reader (rev 10))

[3.] Tags:
kernel, sdhci-pci driver

[4.] Kernel version (from /proc/version):=A0
Linux version 3.7.0-030700rc6-generic (apw@gomeisa) (gcc version 4.6.3 =
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201211162135 SMP Sat Nov 17 02:36:34 =
UTC 2012

[5.] Output of Oops.. message (if applicable) with symbolic information=
 resolved (see Documentation/oops-tracing.txt)=A0
n/a

[6.] A small shell script or example program which triggers the problem=
 (if possible)=A0
n/a

[7.] Environment:
lsb_release -rd:
Description:Ubuntu 12.10
Release:12.10

[7.1.] Software (add the output of the ver_linux script here)=A0
/usr/src/linux-headers-3.7.0-030700rc6/scripts/ver_linux=A0
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ultraviolence 3.7.0-030700rc6-generic #201211162135 SMP Sat Nov 1=
7 02:36:34 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

Gnu C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04.7
Gnu make =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.81
binutils =A0 =A0 =A0 =A0 =A0 =A0 =A0 2.22.90.20120924
util-linux =A0 =A0 =A0 =A0 =A0 =A0 from package #translated from Hungar=
ian for this bug report
mount =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0support
module-init-tools =A0 =A0 =A03.16
e2fsprogs =A0 =A0 =A0 =A0 =A0 =A0 =A01.42.5
pcmciautils =A0 =A0 =A0 =A0 =A0 =A0018
PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02.4.5
Linux C Library =A0 =A0 =A0 =A02.15
Dynamic linker (ldd) =A0 2.15
Procps =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.3.3
Net-tools =A0 =A0 =A0 =A0 =A0 =A0 =A01.60
Kbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01.15.3
Sh-utils =A0 =A0 =A0 =A0 =A0 =A0 =A0 8.13
Modules Loaded =A0 =A0 =A0 =A0 nls_iso8859_1 mmc_block parport_pc ppdev=
 bnep rfcomm binfmt_misc snd_hda_codec_hdmi snd_hda_codec_realtek coret=
emp kvm_intel kvm ghash_clmulni_intel aesni_intel ablk_helper snd_hda_i=
ntel cryptd lrw snd_hda_codec aes_x86_64 xts snd_hwdep snd_pcm gf128mul=
 uvcvideo snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer=
 snd_seq_device lib80211_crypt_tkip microcode videobuf2_core videodev w=
l nouveau videobuf2_vmalloc snd i915 soundcore snd_page_alloc videobuf2=
_memops mei ttm drm_kms_helper drm psmouse btusb lpc_ich i2c_algo_bit j=
oydev serio_raw acer_wmi bluetooth lib80211 sparse_keymap mxm_wmi mac_h=
id video lp parport wmi hid_generic hid_logitech_dj usbhid hid sdhci_pc=
i sdhci tg3

[7.2.] Processor information (from /proc/cpuinfo):=A0
cat /proc/cpuinfo=A0
processor: 0
vendor_id: GenuineIntel
cpu family: 6
model: 42
model name: Intel(R) Core(TM) i7-2670QM CPU @ 2.20GHz
stepping: 7
microcode: 0x25
cpu MHz: 800.000
cache size: 6144 KB
physical id: 0
siblings: 8
core id: 0
cpu cores: 4
apicid: 0
initial apicid: 0
fpu: yes
fpu_exception: yes
cpuid level: 13
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonsto=
p_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est t=
m2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_t=
imer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_sha=
dow vnmi flexpriority ept vpid
bogomips: 4389.95
clflush size: 64
cache_alignment: 64
address sizes: 36 bits physical, 48 bits virtual
power management:

(7 more cores)

[7.3.] Module information (from /proc/modules):=A0
cat /proc/modules=A0
nls_iso8859_1 12714 0 - Live 0x0000000000000000
mmc_block 27391 0 - Live 0x0000000000000000
parport_pc 32867 0 - Live 0x0000000000000000
ppdev 17114 0 - Live 0x0000000000000000
bnep 18400 2 - Live 0x0000000000000000
rfcomm 47923 12 - Live 0x0000000000000000
binfmt_misc 17541 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 37116 1 - Live 0x0000000000000000
snd_hda_codec_realtek 79808 1 - Live 0x0000000000000000
coretemp 13555 0 - Live 0x0000000000000000
kvm_intel 137787 0 - Live 0x0000000000000000
kvm 441559 1 kvm_intel, Live 0x0000000000000000
ghash_clmulni_intel 13260 0 - Live 0x0000000000000000
aesni_intel 55496 0 - Live 0x0000000000000000
ablk_helper 13598 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 38522 5 - Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x0000=
000000000000
lrw 13324 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 140413 3 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda=
_intel, Live 0x0000000000000000
aes_x86_64 17256 1 aesni_intel, Live 0x0000000000000000
xts 12952 1 aesni_intel, Live 0x0000000000000000
snd_hwdep 17765 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 102478 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0=
x0000000000000000
gf128mul 14952 2 lrw,xts, Live 0x0000000000000000
uvcvideo 82215 0 - Live 0x0000000000000000
snd_seq_midi 13325 0 - Live 0x0000000000000000
snd_rawmidi 30750 1 snd_seq_midi, Live 0x0000000000000000
snd_seq_midi_event 14900 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 61931 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
snd_timer 29990 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14498 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
000000000
lib80211_crypt_tkip 17391 0 - Live 0x0000000000000000
microcode 23076 0 - Live 0x0000000000000000
videobuf2_core 36138 1 uvcvideo, Live 0x0000000000000000
videodev 130085 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
wl 2573608 0 - Live 0x0000000000000000 (POF)
nouveau 955266 1 - Live 0x0000000000000000
videobuf2_vmalloc 12861 1 uvcvideo, Live 0x0000000000000000
snd 83674 19 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd=
_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_devi=
ce, Live 0x0000000000000000
i915 588292 3 - Live 0x0000000000000000
soundcore 15092 1 snd, Live 0x0000000000000000
snd_page_alloc 18799 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
videobuf2_memops 13405 1 videobuf2_vmalloc, Live 0x0000000000000000
mei 41468 0 - Live 0x0000000000000000
ttm 88495 1 nouveau, Live 0x0000000000000000
drm_kms_helper 46934 2 nouveau,i915, Live 0x0000000000000000
drm 286536 7 nouveau,i915,ttm,drm_kms_helper, Live 0x0000000000000000
psmouse 92405 0 - Live 0x0000000000000000
btusb 18292 0 - Live 0x0000000000000000
lpc_ich 17145 0 - Live 0x0000000000000000
i2c_algo_bit 13565 2 nouveau,i915, Live 0x0000000000000000
joydev 17614 0 - Live 0x0000000000000000
serio_raw 13216 0 - Live 0x0000000000000000
acer_wmi 32859 0 - Live 0x0000000000000000
bluetooth 219394 22 bnep,rfcomm,btusb, Live 0x0000000000000000
lib80211 14382 2 lib80211_crypt_tkip,wl, Live 0x0000000000000000
sparse_keymap 13891 1 acer_wmi, Live 0x0000000000000000
mxm_wmi 13022 1 nouveau, Live 0x0000000000000000
mac_hid 13254 0 - Live 0x0000000000000000
video 19413 3 nouveau,i915,acer_wmi, Live 0x0000000000000000
lp 17800 0 - Live 0x0000000000000000
parport 46563 3 parport_pc,ppdev,lp, Live 0x0000000000000000
wmi 19257 3 nouveau,acer_wmi,mxm_wmi, Live 0x0000000000000000
hid_generic 12541 0 - Live 0x0000000000000000
hid_logitech_dj 18768 0 - Live 0x0000000000000000
usbhid 47347 1 hid_logitech_dj, Live 0x0000000000000000
hid 100624 3 hid_generic,hid_logitech_dj,usbhid, Live 0x000000000000000=
0
sdhci_pci 18752 0 - Live 0x0000000000000000
sdhci 33265 1 sdhci_pci, Live 0x0000000000000000
tg3 157348 0 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iom=
em) =A0
cat /proc/ioports
=A00000-0cf7 : PCI Bus 0000:00
=A0 0000-001f : dma1
=A0 0020-0021 : pic1
=A0 0040-0043 : timer0
=A0 0050-0053 : timer1
=A0 0060-0060 : keyboard
=A0 0062-0062 : EC data
=A0 0064-0064 : keyboard
=A0 0066-0066 : EC cmd
=A0 0070-0077 : rtc0
=A0 0080-008f : dma page reg
=A0 00a0-00a1 : pic2
=A0 00c0-00df : dma2
=A0 00f0-00ff : fpu
=A0 0400-047f : pnp 00:05
=A0 =A0 0400-0403 : ACPI PM1a_EVT_BLK
=A0 =A0 0404-0405 : ACPI PM1a_CNT_BLK
=A0 =A0 0408-040b : ACPI PM_TMR
=A0 =A0 0410-0415 : ACPI CPU throttle
=A0 =A0 0420-042f : ACPI GPE0_BLK
=A0 =A0 0430-0433 : iTCO_wdt
=A0 =A0 0450-0450 : ACPI PM2_CNT_BLK
=A0 =A0 0454-0457 : pnp 00:07
=A0 =A0 0460-047f : iTCO_wdt
=A0 0500-057f : pnp 00:05
=A0 0680-069f : pnp 00:05
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
=A0 1000-100f : pnp 00:05
=A0 164e-164f : pnp 00:05
=A0 2000-2fff : PCI Bus 0000:01
=A0 =A0 2000-207f : 0000:01:00.0
=A0 3000-303f : 0000:00:02.0
=A0 3040-305f : 0000:00:1f.3
=A0 3060-307f : 0000:00:1f.2
=A0 =A0 3060-307f : ahci
=A0 3090-3097 : 0000:00:1f.2
=A0 =A0 3090-3097 : ahci
=A0 3098-309f : 0000:00:1f.2
=A0 =A0 3098-309f : ahci
=A0 30b8-30bb : 0000:00:1f.2
=A0 =A0 30b8-30bb : ahci
=A0 30bc-30bf : 0000:00:1f.2
=A0 =A0 30bc-30bf : ahci
=A0 ff2c-ff2f : pnp 00:05
=A0 ffff-ffff : pnp 00:05
=A0 =A0 ffff-ffff : pnp 00:05
cat /proc/iomem=A0
00000000-0000ffff : reserved
00010000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000ce7ff : Video ROM
000ce800-000d15ff : Adapter ROM
000e0000-000fffff : reserved
=A0 000f0000-000fffff : System ROM
00100000-96e3efff : System RAM
=A0 01000000-016d7780 : Kernel code
=A0 016d7781-01ce6abf : Kernel data
=A0 01de7000-01f46fff : Kernel bss
96e3f000-96ebefff : reserved
96ebf000-96fbefff : ACPI Non-volatile Storage
96fbf000-96ffefff : ACPI Tables
96fff000-96ffffff : System RAM
97000000-9f9fffff : reserved
9fa00000-feafffff : PCI Bus 0000:00
=A0 9fa00000-9fa00fff : pnp 00:0a
=A0 9fb00000-9fbfffff : PCI Bus 0000:02
=A0 a0000000-b1ffffff : PCI Bus 0000:01
=A0 =A0 a0000000-afffffff : 0000:01:00.0
=A0 =A0 b0000000-b1ffffff : 0000:01:00.0
=A0 c0000000-cfffffff : 0000:00:02.0
=A0 d0000000-d10fffff : PCI Bus 0000:01
=A0 =A0 d0000000-d0ffffff : 0000:01:00.0
=A0 =A0 d1000000-d107ffff : 0000:01:00.0
=A0 d1400000-d17fffff : 0000:00:02.0
=A0 d1800000-d18fffff : PCI Bus 0000:02
=A0 =A0 d1800000-d180ffff : 0000:02:00.1
=A0 =A0 =A0 d1800000-d180ffff : mmc0
=A0 =A0 d1810000-d181ffff : 0000:02:00.2
=A0 =A0 d1820000-d182ffff : 0000:02:00.3
=A0 =A0 d1830000-d183ffff : 0000:02:00.0
=A0 =A0 =A0 d1830000-d183ffff : tg3
=A0 =A0 d1840000-d184ffff : 0000:02:00.0
=A0 =A0 =A0 d1840000-d184ffff : tg3
=A0 =A0 d1850000-d18507ff : 0000:02:00.0
=A0 d1900000-d19fffff : PCI Bus 0000:05
=A0 =A0 d1900000-d1901fff : 0000:05:00.0
=A0 =A0 =A0 d1900000-d1901fff : xhci_hcd
=A0 d1a00000-d1afffff : PCI Bus 0000:03
=A0 =A0 d1a00000-d1a03fff : 0000:03:00.0
=A0 d1b00000-d1b03fff : 0000:00:1b.0
=A0 =A0 d1b00000-d1b03fff : ICH HD audio
=A0 d1b04000-d1b0400f : 0000:00:16.0
=A0 =A0 d1b04000-d1b0400f : mei
=A0 d1b06000-d1b060ff : 0000:00:1f.3
=A0 d1b08000-d1b087ff : 0000:00:1f.2
=A0 =A0 d1b08000-d1b087ff : ahci
=A0 d1b09000-d1b093ff : 0000:00:1d.0
=A0 =A0 d1b09000-d1b093ff : ehci_hcd
=A0 d1b0a000-d1b0a3ff : 0000:00:1a.0
=A0 =A0 d1b0a000-d1b0a3ff : ehci_hcd
=A0 e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
=A0 =A0 e0000000-efffffff : reserved
=A0 =A0 =A0 e0000000-efffffff : pnp 00:0a
feb00000-feb03fff : reserved
fec00000-fec00fff : reserved
=A0 fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed19fff : reserved
=A0 fed10000-fed17fff : pnp 00:0a
=A0 fed18000-fed18fff : pnp 00:0a
=A0 fed19000-fed19fff : pnp 00:0a
fed1c000-fed1ffff : reserved
=A0 fed1c000-fed1ffff : pnp 00:0a
=A0 =A0 fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:0a
fed90000-fed93fff : pnp 00:0a
fee00000-fee00fff : Local APIC
=A0 fee00000-fee00fff : reserved
ffd80000-ffffffff : reserved
100000000-25fdfffff : System RAM
25fe00000-25fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)=A0
sudo lspci -vvv=A0
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Fa=
mily DRAM Controller (rev 09)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core =
Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal dec=
ode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: d0000000-d10fffff
Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [88] Subsystem: Acer Incorporated [ALI] Device 0504
Capabilities: [80] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: feeff00c =A0Data: 4181
Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap:Port #2, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns,=
 L1 <4us
ClockPM- Surprise- LLActRep- BwNot+
LnkCtl:ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt+=
 ABWMgmt-
SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl:Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectab=
le De-emphasis: -3.5dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Equa=
lizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:NegoPending- InProgress-
Capabilities: [140 v1] Root Complex Link
Desc:PortNumber=3D02 ComponentID=3D01 EltType=3DConfig
Link0:Desc:TargetPort=3D00 TargetComponent=3D01 AssocRCRB- LinkType=3DM=
emMapped LinkValid+
Addr:00000000fed19000
Kernel driver in use: pcieport
Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Cor=
e Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 =
[VGA controller])
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 51
Region 0: Memory at d1400000 (64-bit, non-prefetchable) [size=3D4M]
Region 2: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
Region 4: I/O ports at 3000 [size=3D64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: feeff00c =A0Data: 4172
Capabilities: [d0] Power Management version 2
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915
Kernel modules: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200 Serie=
s Chipset Family MEI Controller #1 (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 50
Region 0: Memory at d1b04000 (64-bit, non-prefetchable) [size=3D16]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000feeff00c =A0Data: 4162
Kernel driver in use: mei
Kernel modules: mei

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset =
=46amily USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d1b0a000 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP+
Kernel driver in use: ehci_hcd

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Fa=
mily High Definition Audio Controller (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 52
Region 0: Memory at d1b00000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000feeff00c =A0Data: 4192
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 0=
0
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE- FLReset+
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns=
, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl:ASPM Disabled; Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt=
- ABWMgmt-
Capabilities: [100 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:
Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status:NegoPending- InProgress-
VC1:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D22
Status:NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc:PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
Link0:Desc:TargetPort=3D00 TargetComponent=3D00 AssocRCRB- LinkType=3DM=
emMapped LinkValid+
Addr:00000000fed1c000
Kernel driver in use: snd_hda_intel
Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Fami=
ly PCI Express Root Port 1 (rev b4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: 9fb00000-9fbfffff
Prefetchable memory behind bridge: 00000000d1800000-00000000d18fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl:
Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, =
L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt=
+ ABWMgmt-
SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl:Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectab=
le De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Equa=
lizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000 =A0Data: 0000
Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0504
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Fami=
ly PCI Express Root Port 2 (rev b4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: d1a00000-d1afffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, =
L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt=
+ ABWMgmt-
SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl:Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectab=
le De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Equa=
lizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000 =A0Data: 0000
Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0504
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Fami=
ly PCI Express Root Port 4 (rev b4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: d1900000-d19fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, =
L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl:ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ =
ABWMgmt-
SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl:Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectab=
le De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equali=
zationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000 =A0Data: 0000
Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0504
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset =
=46amily USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at d1b09000 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci_hcd

00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC C=
ontroller (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
Kernel driver in use: lpc_ich
Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset=
 Family 6 port SATA AHCI Controller (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 41
Region 0: I/O ports at 3098 [size=3D8]
Region 1: I/O ports at 30bc [size=3D4]
Region 2: I/O ports at 3090 [size=3D8]
Region 3: I/O ports at 30b8 [size=3D4]
Region 4: I/O ports at 3060 [size=3D32]
Region 5: Memory at d1b08000 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: feec000c =A0Data: 4191
Capabilities: [70] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-

Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SM=
Bus Controller (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 10
Region 0: Memory at d1b06000 (64-bit, non-prefetchable) [size=3D256]
Region 4: I/O ports at 3040 [size=3D32]
Kernel modules: i2c-i801

01:00.0 VGA compatible controller: NVIDIA Corporation GF108 [GeForce GT=
 540M] (rev a1) (prog-if 00 [VGA controller])
Subsystem: Acer Incorporated [ALI] Device 0505
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=3D16M]
Region 1: Memory at a0000000 (64-bit, prefetchable) [size=3D256M]
Region 3: Memory at b0000000 (64-bit, prefetchable) [size=3D32M]
Region 5: I/O ports at 2000 [size=3D128]
Expansion ROM at d1000000 [disabled] [size=3D512K]
Capabilities: [60] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-

Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [78] Express (v2) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64=
us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap:Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns,=
 L1 <4us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM L0s L1 Enabled; RCB 128 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectab=
le De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Equa=
lizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b4] Vendor Specific Information: Len=3D14 <?>
Capabilities: [100 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:NegoPending- InProgress-
Capabilities: [128 v1] Power Budgeting <?>
Capabilities: [600 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 L=
en=3D024 <?>
Kernel driver in use: nouveau
Kernel modules: nouveau, nvidiafb

02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM57785 Giga=
bit Ethernet PCIe (rev 10)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d1830000 (64-bit, prefetchable) [size=3D64K]
Region 2: Memory at d1840000 (64-bit, prefetchable) [size=3D64K]
Expansion ROM at d1850000 [disabled] [size=3D2K]
Capabilities: [48] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [a0] MSI-X: Enable+ Count=3D5 Masked-
Vector table: BAR=3D2 offset=3D00000000
PBA: BAR=3D2 offset=3D00000120
Capabilities: [ac] Express (v2) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, =
L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt=
- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equali=
zationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:
=46irst Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [13c v1] Device Serial Number 00-00-b8-70-f4-fe-09-98
Capabilities: [150 v1] Power Budgeting <?>
Capabilities: [160 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:
ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:NegoPending- InProgress-
Kernel driver in use: tg3
Kernel modules: tg3

02:00.1 SD Host controller: Broadcom Corporation NetXtreme BCM57765 Mem=
ory Card Reader (rev 10) (prog-if 01)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Region 0: Memory at d1800000 (64-bit, prefetchable) [size=3D64K]
Capabilities: [48] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
Capabilities: [58] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [ac] Express (v2) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, =
L1 <2us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt=
- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equali=
zationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [150 v1] Power Budgeting <?>
Capabilities: [160 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:
NegoPending- InProgress-
Kernel driver in use: sdhci-pci
Kernel modules: sdhci-pci

02:00.2 System peripheral: Broadcom Corporation Device 16be (rev 10)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 7
Region 0: Memory at d1810000 (64-bit, prefetchable) [size=3D64K]
Capabilities: [48] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
Capabilities: [58] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [ac] Express (v2) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, =
L1 <2us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt=
- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equali=
zationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [150 v1] Power Budgeting <?>
Capabilities: [160 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:
Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:NegoPending- InProgress-

02:00.3 System peripheral: Broadcom Corporation Device 16bf (rev 10)
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 7
Region 0: Memory at d1820000 (64-bit, prefetchable) [size=3D64K]
Capabilities: [48] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
Capabilities: [58] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [ac] Express (v2) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, =
L1 <2us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt=
- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equali=
zationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [150 v1] Power Budgeting <?>
Capabilities: [160 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:NegoPending- InProgress-

03:00.0 Network controller: Broadcom Corporation BCM43227 802.11b/g/n
Subsystem: Foxconn International, Inc. Device e040
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 17
Region 0: Memory at d1a00000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 PME-
Capabilities: [58] Vendor Specific Information: Len=3D78 <?>
Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [d0] Express (v1) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimite=
d
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Latency L0 <4us, L1 <=
64us
ClockPM+ Surprise- LLActRep+ BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt=
- ABWMgmt-
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [13c v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status:NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 00-00-78-ff-ff-71-cc-af
Capabilities: [16c v1] Power Budgeting <?>
Kernel driver in use: wl
Kernel modules: wl, bcma

05:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controll=
er (rev 04) (prog-if 30 [XHCI])
Subsystem: Acer Incorporated [ALI] Device 0504
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 19
Region 0: Memory at d1900000 (64-bit, non-prefetchable) [size=3D8K]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
Address: 0000000000000000 =A0Data: 0000
Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
Vector table: BAR=3D0 offset=3D00001000
PBA: BAR=3D0 offset=3D00001080
Capabilities: [a0] Express (v2) Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unl=
imited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap:Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1=
 unlimited
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- =
ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectab=
le De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equali=
zationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
Capabilities: [150 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Kernel driver in use: xhci_hcd

[7.6.] SCSI information (from /proc/scsi/scsi)=A0
cat /proc/scsi/scsi=A0
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
=A0 Vendor: ATA =A0 =A0 =A0Model: WDC WD7500BPVT-2 Rev: 01.0
=A0 Type: =A0 Direct-Access =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ANSI=
 =A0SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
=A0 Vendor: PIONEER =A0Model: DVD-RW DVRTD11RS Rev: 1.01
=A0 Type: =A0 CD-ROM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ANSI =A0SCSI revision: 05

[7.7.] Other information that might be relevant to the problem (please =
look in /proc and include all information that you think to be relevant=
):=A0
ls /proc=A0
1 =A0 =A0 1168 =A01501 =A01940 =A02038 =A02134 =A02241 =A02406 =A026 =A0=
 =A02850 =A032 =A0 =A045 =A0 61 =A0 82 =A0 955 =A0 =A0 =A0 =A0 =A0 =A0d=
iskstats =A0 =A0kpageflags =A0 =A0 slabinfo
10 =A0 =A0117 =A0 1522 =A01975 =A02039 =A02138 =A02245 =A02408 =A02602 =
=A02868 =A03281 =A046 =A0 62 =A0 83 =A0 957 =A0 =A0 =A0 =A0 =A0 =A0dma =
=A0 =A0 =A0 =A0 =A0latency_stats =A0softirqs
1001 =A0118 =A0 1523 =A01978 =A02046 =A02140 =A02251 =A02410 =A02610 =A0=
29 =A0 =A033 =A0 =A047 =A0 63 =A0 84 =A0 958 =A0 =A0 =A0 =A0 =A0 =A0dri=
 =A0 =A0 =A0 =A0 =A0loadavg =A0 =A0 =A0 =A0stat
1023 =A0119 =A0 1527 =A01979 =A02056 =A02151 =A02257 =A02412 =A02621 =A0=
2901 =A03343 =A048 =A0 64 =A0 85 =A0 964 =A0 =A0 =A0 =A0 =A0 =A0driver =
=A0 =A0 =A0 locks =A0 =A0 =A0 =A0 =A0swaps
1086 =A01191 =A01564 =A01981 =A02070 =A02153 =A02265 =A02414 =A02628 =A0=
291 =A0 3364 =A049 =A0 65 =A0 858 =A0969 =A0 =A0 =A0 =A0 =A0 =A0execdom=
ains =A0mdstat =A0 =A0 =A0 =A0 sys
11 =A0 =A01192 =A01582 =A01985 =A02072 =A02155 =A02278 =A02457 =A02649 =
=A02912 =A034 =A0 =A05 =A0 =A066 =A0 86 =A0 994 =A0 =A0 =A0 =A0 =A0 =A0=
fb =A0 =A0 =A0 =A0 =A0 meminfo =A0 =A0 =A0 =A0sysrq-trigger
1111 =A01195 =A016 =A0 =A01988 =A02077 =A02157 =A023 =A0 =A02496 =A0265=
8 =A0292 =A0 35 =A0 =A050 =A0 695 =A087 =A0 acpi =A0 =A0 =A0 =A0 =A0 fi=
lesystems =A0misc =A0 =A0 =A0 =A0 =A0 sysvipc
1118 =A012 =A0 =A01621 =A01999 =A02085 =A02159 =A02312 =A025 =A0 =A0266=
5 =A02923 =A036 =A0 =A0506 =A0696 =A0872 =A0asound =A0 =A0 =A0 =A0 fs =A0=
 =A0 =A0 =A0 =A0 modules =A0 =A0 =A0 =A0timer_list
1129 =A0120 =A0 1635 =A02 =A0 =A0 2090 =A02161 =A02316 =A02503 =A027 =A0=
 =A0293 =A0 37 =A0 =A051 =A0 7 =A0 =A0878 =A0brcm_monitor0 =A0interrupt=
s =A0 mounts =A0 =A0 =A0 =A0 timer_stats
1132 =A0127 =A0 17 =A0 =A02007 =A02094 =A02185 =A02317 =A02515 =A02725 =
=A02971 =A038 =A0 =A052 =A0 754 =A088 =A0 buddyinfo =A0 =A0 =A0iomem =A0=
 =A0 =A0 =A0mtrr =A0 =A0 =A0 =A0 =A0 tty
1137 =A013 =A0 =A01746 =A02011 =A02098 =A022 =A0 =A02318 =A02522 =A0273=
6 =A02973 =A039 =A0 =A053 =A0 755 =A09 =A0 =A0bus =A0 =A0 =A0 =A0 =A0 =A0=
ioports =A0 =A0 =A0net =A0 =A0 =A0 =A0 =A0 =A0uptime
114 =A0 1343 =A01750 =A02022 =A021 =A0 =A02201 =A02328 =A02534 =A02747 =
=A02981 =A0398 =A0 54 =A0 757 =A092 =A0 cgroups =A0 =A0 =A0 =A0irq =A0 =
=A0 =A0 =A0 =A0pagetypeinfo =A0 version
115 =A0 1351 =A018 =A0 =A02028 =A02101 =A02206 =A02352 =A02562 =A028 =A0=
 =A02982 =A040 =A0 =A055 =A0 77 =A0 926 =A0cmdline =A0 =A0 =A0 =A0kalls=
yms =A0 =A0 partitions =A0 =A0 vmallocinfo
1156 =A01369 =A01887 =A02033 =A02106 =A02218 =A02362 =A02564 =A02813 =A0=
3 =A0 =A0 41 =A0 =A056 =A0 786 =A0931 =A0consoles =A0 =A0 =A0 kcore =A0=
 =A0 =A0 =A0sched_debug =A0 =A0vmstat
116 =A0 14 =A0 =A01892 =A02034 =A02111 =A02222 =A024 =A0 =A02566 =A0282=
9 =A03039 =A042 =A0 =A057 =A0 8 =A0 =A094 =A0 cpuinfo =A0 =A0 =A0 =A0ke=
y-users =A0 =A0schedstat =A0 =A0 =A0zoneinfo
1163 =A01499 =A019 =A0 =A02035 =A02112 =A02228 =A02402 =A02583 =A02836 =
=A031 =A0 =A043 =A0 =A058 =A0 803 =A0943 =A0crypto =A0 =A0 =A0 =A0 kmsg=
 =A0 =A0 =A0 =A0 scsi
1166 =A015 =A0 =A01929 =A02036 =A02119 =A02235 =A02404 =A02595 =A02843 =
=A0311 =A0 44 =A0 =A060 =A0 81 =A0 946 =A0devices =A0 =A0 =A0 =A0kpagec=
ount =A0 self=A0=A0
