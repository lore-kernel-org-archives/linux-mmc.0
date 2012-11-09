From: "Dan 'Da Man'" <heymrdjd@gmail.com>
Subject: Problem: 058f:9360 8GB MicroSD card not recognized in Alcor Micro
 Corp. 8-in-1 Media Card Reader
Date: Fri, 9 Nov 2012 01:25:29 -0600
Message-ID: <CAFRBeaRVCkqQ2sh1AQL9_dTHzxGyU5AC5sRqPATUB_gx+eeTJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44532 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab2KIH0L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 02:26:11 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so3718947obb.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Nov 2012 23:26:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 1069289@bugs.launchpad.net

Bug Short Description: 058f:9360 8GB MicroSD card not recognized in
Alcor Micro Corp. 8-in-1 Media Card Reader

When I insert a 8GB MicroSD into my integrated Alcor Micro Corp.
8-in-1 Media Card Reader using Oneiric it is not recognized. However,
the same MicroSD card works in a different laptop's card reader.

As well, in 10.04.4 through 11.10, when I insert a 2GB SD card it is
recognized, automatically mounted, and a window opens to display what
files are on the card.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1069289

Linux version 3.7.0-030700rc4-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201211041435 SMP Sun Nov 4 19:43:27
UTC 2012

Description:    Ubuntu 11.10
Release:    11.10


Linux casino 3.7.0-030700rc4-generic #201211041435 SMP Sun Nov 4
19:43:27 UTC 2012 i686 i686 i386 GNU/Linux

Gnu C                  4.6.1
Gnu make               3.81
binutils               2.21.53.20110810
util-linux             2.19.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.41.14
pcmciautils            015
Linux C Library        2.13
Dynamic linker (ldd)   2.13
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.5
wireless-tools         30
Modules Loaded         nls_iso8859_1 binfmt_misc snd_intel8x0 snd_ac97_codec
joydev hid_generic radeon ac97_bus snd_pcm snd_seq_midi ppdev snd_rawmidi
ttm snd_seq_midi_event drm_kms_helper snd_seq drm snd_timer i2c_algo_bit
snd_seq_device snd psmouse soundcore microcode lpc_ich snd_page_alloc shpchp
serio_raw mac_hid parport_pc lp parport usbhid hid usb_storage uas 8139too
firewire_ohci 8139cp firewire_core crc_itu_t


processor    : 0
vendor_id    : GenuineIntel
cpu family    : 15
model        : 2
model name    : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping    : 9
microcode    : 0x21
cpu MHz        : 3200.317
cache size    : 512 KB
physical id    : 0
siblings    : 1
core id        : 0
cpu cores    : 1
apicid        : 0
initial apicid    : 0
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pebs bts cid xtpr
bogomips    : 6400.63
clflush size    : 64
cache_alignment    : 128
address sizes    : 36 bits physical, 32 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 15
model        : 2
model name    : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping    : 9
microcode    : 0x21
cpu MHz        : 3200.317
cache size    : 512 KB
physical id    : 0
siblings    : 1
core id        : 0
cpu cores    : 0
apicid        : 1
initial apicid    : 1
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pebs bts cid xtpr
bogomips    : 6400.58
clflush size    : 64
cache_alignment    : 128
address sizes    : 36 bits physical, 32 bits virtual
power management:

nls_iso8859_1 12617 1 - Live 0x00000000 (F)
binfmt_misc 17292 1 - Live 0x00000000 (F)
snd_intel8x0 33490 1 - Live 0x00000000 (F)
snd_ac97_codec 110219 1 snd_intel8x0, Live 0x00000000 (F)
joydev 17329 0 - Live 0x00000000 (F)
hid_generic 12445 0 - Live 0x00000000 (F)
radeon 845326 2 - Live 0x00000000 (F)
ac97_bus 12670 1 snd_ac97_codec, Live 0x00000000 (F)
snd_pcm 81801 2 snd_intel8x0,snd_ac97_codec, Live 0x00000000 (F)
snd_seq_midi 13132 0 - Live 0x00000000 (F)
ppdev 12849 0 - Live 0x00000000 (F)
snd_rawmidi 25425 1 snd_seq_midi, Live 0x00000000 (F)
ttm 76325 1 radeon, Live 0x00000000 (F)
snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000 (F)
drm_kms_helper 45429 1 radeon, Live 0x00000000 (F)
snd_seq 51568 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000 (F)
drm 228757 4 radeon,ttm,drm_kms_helper, Live 0x00000000 (F)
snd_timer 28931 2 snd_pcm,snd_seq, Live 0x00000000 (F)
i2c_algo_bit 13316 1 radeon, Live 0x00000000 (F)
snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000 (F)
snd 62674 9
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0x00000000 (F)
psmouse 77485 0 - Live 0x00000000 (F)
soundcore 14635 1 snd, Live 0x00000000 (F)
microcode 18433 0 - Live 0x00000000 (F)
lpc_ich 17048 0 - Live 0x00000000 (F)
snd_page_alloc 18398 2 snd_intel8x0,snd_pcm, Live 0x00000000 (F)
shpchp 32325 0 - Live 0x00000000 (F)
serio_raw 13031 0 - Live 0x00000000 (F)
mac_hid 13077 0 - Live 0x00000000 (F)
parport_pc 32114 1 - Live 0x00000000 (F)
lp 17455 0 - Live 0x00000000 (F)
parport 40930 3 ppdev,parport_pc,lp, Live 0x00000000 (F)
usbhid 46094 0 - Live 0x00000000 (F)
hid 82340 2 hid_generic,usbhid, Live 0x00000000 (F)
usb_storage 48053 1 - Live 0x00000000 (F)
uas 17936 0 - Live 0x00000000 (F)
8139too 23311 0 - Live 0x00000000 (F)
firewire_ohci 36109 0 - Live 0x00000000 (F)
8139cp 26759 0 - Live 0x00000000 (F)
firewire_core 62086 1 firewire_ohci, Live 0x00000000 (F)
crc_itu_t 12627 1 firewire_core, Live 0x00000000 (F)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:1f.1
  0170-0177 : ata_piix
01f0-01f7 : 0000:00:1f.1
  01f0-01f7 : ata_piix
0376-0376 : 0000:00:1f.1
  0376-0376 : ata_piix
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : 0000:00:1f.1
  03f6-03f6 : ata_piix
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-041f : pnp 00:08
0480-04bf : pnp 00:08
04d0-04d1 : pnp 00:08
0680-06ff : pnp 00:07
0778-077a : parport0
0800-087f : pnp 00:08
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0828-082f : ACPI GPE0_BLK
  0830-0833 : iTCO_wdt
  0860-087f : iTCO_wdt
0cf8-0cff : PCI conf1
a000-afff : PCI Bus 0000:01
  a800-a8ff : 0000:01:00.0
b000-bfff : PCI Bus 0000:02
  b400-b4ff : 0000:02:0f.0
    b400-b4ff : 8139too
  b800-b8ff : 0000:02:0b.0
  bc00-bc07 : 0000:02:0b.0
c400-c40f : 0000:00:1f.2
  c400-c40f : ata_piix
c800-c803 : 0000:00:1f.2
  c800-c803 : ata_piix
cc00-cc07 : 0000:00:1f.2
  cc00-cc07 : ata_piix
d000-d003 : 0000:00:1f.2
  d000-d003 : ata_piix
d400-d407 : 0000:00:1f.2
  d400-d407 : ata_piix
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel ICH5
dc00-dc3f : 0000:00:1f.5
  dc00-dc3f : Intel ICH5
e000-e01f : 0000:00:1d.0
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:1d.1
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:1d.2
  e800-e81f : uhci_hcd
ec00-ec1f : 0000:00:1d.3
  ec00-ec1f : uhci_hcd
fc00-fc0f : 0000:00:1f.1
  fc00-fc0f : ata_piix

00000000-0000ffff : reserved
  00000000-00000000 : iTCO_wdt
00010000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cafff : Video ROM
000e8000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-7ffbffff : System RAM
  01000000-01611e0e : Kernel code
  01611e0f-0191673f : Kernel data
  019e0000-01abafff : Kernel bss
7ffc0000-7ffcefff : ACPI Tables
7ffcf000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
80000000-800003ff : 0000:00:1f.1
d7f00000-f7efffff : PCI Bus 0000:01
  e0000000-e7ffffff : 0000:01:00.1
  e8000000-efffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fe900000-fe9fffff : PCI Bus 0000:01
  fe9c0000-fe9dffff : 0000:01:00.0
  fe9e0000-fe9effff : 0000:01:00.1
  fe9f0000-fe9fffff : 0000:01:00.0
fea00000-feafffff : PCI Bus 0000:02
  feaf8000-feafbfff : 0000:02:0e.0
  feaff000-feaff7ff : 0000:02:0e.0
    feaff000-feaff7ff : firewire_ohci
  feaff800-feaff8ff : 0000:02:0f.0
    feaff800-feaff8ff : 8139too
  feaffc00-feaffcff : 0000:02:0b.0
febff400-febff4ff : 0000:00:1f.5
  febff400-febff4ff : Intel ICH5
febff800-febff9ff : 0000:00:1f.5
  febff800-febff9ff : Intel ICH5
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
fec00000-fec003ff : IOAPIC 0
fecf0000-fecf0fff : 0000:00:06.0
fed20000-fed8ffff : pnp 00:08
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : pnp 00:09
ffb80000-ffffffff : reserved
  fff80000-ffffffff : pnp 00:08

00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)
    Subsystem: ASUSTeK Computer Inc. Device 80a5
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [e4] Vendor Specific Information: Len=06 <?>
    Capabilities: [a0] AGP version 3.0
        Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3+ Rate=x4,x8
        Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
    Kernel driver in use: agpgart-intel

00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev
02) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
    I/O behind bridge: 0000a000-0000afff
    Memory behind bridge: fe900000-fe9fffff
    Prefetchable memory behind bridge: d7f00000-f7efffff
    Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Kernel modules: shpchp

00:06.0 System peripheral: Intel Corporation 82865G/PE/P Processor to I/O
Memory Interface (rev 02)
    Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Region 0: Memory at fecf0000 (32-bit, non-prefetchable) [size=4K]

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #1 (rev 02) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. P4P800/P5P800 series motherboard
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 4: I/O ports at e000 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #2 (rev 02) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. P4P800/P5P800 series motherboard
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 19
    Region 4: I/O ports at e400 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #3 (rev 02) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. P4P800/P5P800 series motherboard
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 18
    Region 4: I/O ports at e800 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #4 (rev 02) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. P4P800/P5P800 series motherboard
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 4: I/O ports at ec00 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
    Subsystem: ASUSTeK Computer Inc. P4P800/P5P800 series motherboard
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin D routed to IRQ 23
    Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00
[Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
    I/O behind bridge: 0000b000-0000bfff
    Memory behind bridge: fea00000-feafffff
    Prefetchable memory behind bridge: fff00000-000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Kernel modules: shpchp

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface
Bridge (rev 02)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Kernel driver in use: lpc_ich
    Kernel modules: lpc_ich, intel-rng

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02) (prog-if 8a [Master SecP PriP])
    Subsystem: ASUSTeK Computer Inc. P4P800/P5P800 series motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
    Latency: 0
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at 01f0 [size=8]
    Region 1: I/O ports at 03f4 [size=1]
    Region 2: I/O ports at 0170 [size=8]
    Region 3: I/O ports at 0374 [size=1]
    Region 4: I/O ports at fc00 [size=16]
    Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]
    Kernel driver in use: ata_piix

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev
02) (prog-if 8f [Master SecP SecO PriP PriO])
    Subsystem: ASUSTeK Computer Inc. P4P800 series motherboard
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at d400 [size=8]
    Region 1: I/O ports at d000 [size=4]
    Region 2: I/O ports at cc00 [size=8]
    Region 3: I/O ports at c800 [size=4]
    Region 4: I/O ports at c400 [size=16]
    Kernel driver in use: ata_piix

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller
(rev 02)
    Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin B routed to IRQ 6
    Region 4: I/O ports at 0400 [size=32]
    Kernel modules: i2c-i801

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TSSTcorp Model: CDDVDW SH-S222A  Rev: SB02
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD5000AAKS-0 Rev: 01.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD5000AAKS-0 Rev: 12.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: JetFlash Model: TS4GJFV30        Rev: 8.07
  Type:   Direct-Access                    ANSI  SCSI revision: 02
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: USB SD Reader    Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi5 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic  Model: USB CF Reader    Rev: 1.01
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi5 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic  Model: USB SM Reader    Rev: 1.02
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi5 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic  Model: USB MS Reader    Rev: 1.03
  Type:   Direct-Access                    ANSI  SCSI revision: 00

1     1176  13    19    1991  2022  2118  2237  2680  32   53   930
    cgroups      interrupts     meminfo       stat
10    1187  1357  1903  1993  2031  2122  224   2681  33   544  931
    cmdline      iomem          misc          swaps
1003  1197  1381  1940  1997  2039  2140  2284  2683  332  55   938
    consoles     ioports        modules       sys
1012  1199  14    1941  1998  2042  2141  23    2685  336  683  939
    cpuinfo      irq            mounts        sysrq-trigger
1022  12    16    1944  2     2065  2144  2310  2690  34   7    942
    crypto       kallsyms       mtrr          sysvipc
1023  1202  1642  1945  20    2068  2150  2349  277   35   75   943
    devices      kcore          net           timer_list
1026  1216  17    1947  2003  2074  2151  24    278   46   76   946
    diskstats    key-users      pagetypeinfo  timer_stats
1029  1219  1704  1952  2004  2076  2163  25    28    47   769  947
    dma          kmsg           partitions    tty
1033  1222  1705  1963  2005  2081  2175  26    29    48   77   974
    dri          kpagecount     sched_debug   uptime
1040  1223  1748  1972  2011  2082  2195  2629  297   49   794  988
    driver       kpageflags     schedstat     version
1065  1237  1750  1974  2012  2092  22    2655  298   5    8    acpi
    execdomains  latency_stats  scsi          vmallocinfo
1071  1251  18    1978  2014  21    2201  2666  3     51   80   asound
    fb           loadavg        self          vmstat
1081  1256  1870  1980  2018  2103  2216  2667  30    52   897
buddyinfo  filesystems  locks          slabinfo      zoneinfo
11    1285  1894  1989  2020  2116  2219  2669  31    526  9    bus
    fs           mdstat         softirqs
11    13    1903  1997  2042  2141  23    278   47   769  947  dri
kpageflags     scsi          vmstat
1176  1357  1940  1998  2065  2144  2310  28    48   77   974  driver
latency_stats  self          zoneinfo


dmesg log:

[    0.000000] Kernel command line:
BOOT_IMAGE=/vmlinuz-3.7.0-030700rc4-generic
root=UUID=88ecbf58-14dc-403e-a906-c0472828fe5b ro
usb-storage.delay_use=5
[    0.193199] ACPI: bus type usb registered
[    0.193199] usbcore: registered new device driver usb
[    2.650762] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.650926] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned
bus number 1
[    2.664029] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    2.664141] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.664186] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.664236] usb usb1: Product: EHCI Host Controller
[    2.664279] usb usb1: Manufacturer: Linux 3.7.0-030700rc4-generic
ehci_hcd
[    2.664323] usb usb1: SerialNumber: 0000:00:1d.7
[    2.664544] hub 1-0:1.0: USB hub found
[    2.664852] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.664928] uhci_hcd: USB Universal Host Controller Interface driver
[    2.665060] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 2
[    2.665233] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.665279] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.665329] usb usb2: Product: UHCI Host Controller
[    2.665371] usb usb2: Manufacturer: Linux 3.7.0-030700rc4-generic
uhci_hcd
[    2.665415] usb usb2: SerialNumber: 0000:00:1d.0
[    2.665628] hub 2-0:1.0: USB hub found
[    2.665901] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned
bus number 3
[    2.666070] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.666115] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.666166] usb usb3: Product: UHCI Host Controller
[    2.666208] usb usb3: Manufacturer: Linux 3.7.0-030700rc4-generic
uhci_hcd
[    2.666253] usb usb3: SerialNumber: 0000:00:1d.1
[    2.666451] hub 3-0:1.0: USB hub found
[    2.666703] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned
bus number 4
[    2.666860] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.666905] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.666955] usb usb4: Product: UHCI Host Controller
[    2.666997] usb usb4: Manufacturer: Linux 3.7.0-030700rc4-generic
uhci_hcd
[    2.667041] usb usb4: SerialNumber: 0000:00:1d.2
[    2.667234] hub 4-0:1.0: USB hub found
[    2.667486] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned
bus number 5
[    2.667643] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    2.667688] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.667738] usb usb5: Product: UHCI Host Controller
[    2.667781] usb usb5: Manufacturer: Linux 3.7.0-030700rc4-generic
uhci_hcd
[    2.667825] usb usb5: SerialNumber: 0000:00:1d.3
[    2.668054] hub 5-0:1.0: USB hub found
[    2.833085] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    2.833262] sd 2:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/465 GiB)
[    2.833454] sd 2:0:0:0: [sda] Write Protect is off
[    2.833457] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.833525] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.833826] sd 3:0:0:0: [sdb] 976773168 512-byte logical blocks:
(500 GB/465 GiB)
[    2.833982] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    2.834206] sd 3:0:0:0: [sdb] Write Protect is off
[    2.834261] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.834328] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.882407] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.894856] sd 3:0:0:0: [sdb] Attached SCSI disk
[    3.032107] usb 1-5: new high-speed USB device number 3 using ehci_hcd
[    3.502054] usb 1-5: New USB device found, idVendor=058f, idProduct=6387
[    3.502106] usb 1-5: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    3.502152] usb 1-5: Product: Mass Storage Device
[    3.502195] usb 1-5: Manufacturer: JetFlash
[    3.502238] usb 1-5: SerialNumber: 4GMCPGAI
[    3.680479] Initializing USB Mass Storage driver...
[    3.680941] scsi4 : usb-storage 1-5:1.0
[    3.681164] usbcore: registered new interface driver usb-storage
[    3.681216] USB Mass Storage support registered.
[    3.908113] usb 2-1: new low-speed USB device number 2 using uhci_hcd
[    4.089000] usb 2-1: New USB device found, idVendor=03f0, idProduct=050c
[    4.089052] usb 2-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    4.089098] usb 2-1: Product: USB Multimedia Cordless Kit
[    4.089142] usb 2-1: Manufacturer: BTC
[    4.178215] usbhid: USB HID core driver
[    4.728038] usb 5-1: new low-speed USB device number 2 using uhci_hcd
[    4.899278] usb 5-1: New USB device found, idVendor=03f0, idProduct=040c
[    4.899330] usb 5-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    4.899375] usb 5-1: Product: EverestFBB
[    4.899417] usb 5-1: Manufacturer: HP
[    5.156035] usb 5-2: new full-speed USB device number 3 using uhci_hcd
[    5.329230] usb 5-2: New USB device found, idVendor=058f, idProduct=9360
[    5.329300] usb 5-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    5.329357] usb 5-2: Product: USB Reader
[    5.329410] usb 5-2: Manufacturer:
[    5.329468] usb 5-2: SerialNumber: 9206051
[    5.332401] scsi5 : usb-storage 5-2:1.0
[    8.438998] input: BTC USB Multimedia Cordless Kit   as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/input/input2
[    8.439487] hid-generic 0003:03F0:050C.0001: input,hidraw0: USB HID
v1.00 Keyboard [BTC USB Multimedia Cordless Kit  ] on
usb-0000:00:1d.0-1/input0
[    8.442174] input: BTC USB Multimedia Cordless Kit   as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.1/input/input3
[    8.442668] hid-generic 0003:03F0:050C.0002: input,hiddev0,hidraw1:
USB HID v1.00 Mouse [BTC USB Multimedia Cordless Kit  ] on
usb-0000:00:1d.0-1/input1
[    8.456189] hid-generic 0003:03F0:040C.0003: input,hiddev0,hidraw2:
USB HID v1.10 Device [HP EverestFBB] on usb-0000:00:1d.3-1/input0
[    8.721034] sd 4:0:0:0: Attached scsi generic sg3 type 0
[    8.722369] sd 4:0:0:0: [sdc] 7987200 512-byte logical blocks:
(4.08 GB/3.80 GiB)
[    8.722986] sd 4:0:0:0: [sdc] Write Protect is off
[    8.722992] sd 4:0:0:0: [sdc] Mode Sense: 03 00 00 00
[    8.723886] sd 4:0:0:0: [sdc] No Caching mode page present
[    8.724103] sd 4:0:0:0: [sdc] Assuming drive cache: write through
[    8.727638] sd 4:0:0:0: [sdc] No Caching mode page present
[    8.727832] sd 4:0:0:0: [sdc] Assuming drive cache: write through
[    8.731491] sd 4:0:0:0: [sdc] No Caching mode page present
[    8.731681] sd 4:0:0:0: [sdc] Assuming drive cache: write through
[    8.731870] sd 4:0:0:0: [sdc] Attached SCSI removable disk
[   10.340458] scsi 5:0:0:0: Direct-Access     Generic  USB SD Reader
  1.00 PQ: 0 ANSI: 0
[   10.343410] scsi 5:0:0:1: Direct-Access     Generic  USB CF Reader
  1.01 PQ: 0 ANSI: 0
[   10.346423] scsi 5:0:0:2: Direct-Access     Generic  USB SM Reader
  1.02 PQ: 0 ANSI: 0
[   10.349455] scsi 5:0:0:3: Direct-Access     Generic  USB MS Reader
  1.03 PQ: 0 ANSI: 0
[   10.354927] sd 5:0:0:0: Attached scsi generic sg4 type 0
[   10.355541] sd 5:0:0:1: Attached scsi generic sg5 type 0
[   10.356123] sd 5:0:0:2: Attached scsi generic sg6 type 0
[   10.356684] sd 5:0:0:3: Attached scsi generic sg7 type 0
[   10.568127] sd 5:0:0:3: [sdg] Attached SCSI removable disk
[   10.587375] sd 5:0:0:0: [sdd] Attached SCSI removable disk
[   10.599413] sd 5:0:0:1: [sde] Attached SCSI removable disk
[   10.606949] sd 5:0:0:2: [sdf] Attached SCSI removable disk
[  837.200060] usb 5-2: reset full-speed USB device number 3 using uhci_hcd
[  847.520043] usb 5-2: reset full-speed USB device number 3 using uhci_hcd
[  863.848037] usb 5-2: reset full-speed USB device number 3 using uhci_hcd
[  864.112068] usb 5-2: reset full-speed USB device number 3 using uhci_hcd
[  874.432040] usb 5-2: reset full-speed USB device number 3 using uhci_hcd
[  874.591002] sd 5:0:0:0: Device offlined - not ready after error recovery
