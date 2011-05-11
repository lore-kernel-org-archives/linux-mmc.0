From: Mikko Vinni <mmvinni@yahoo.com>
Subject: JMicron integrated card reader dead after s2ram (Refused to change power state)
Date: Wed, 11 May 2011 08:16:10 -0700 (PDT)
Message-ID: <749588.26439.qm@web161818.mail.bf1.yahoo.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm16-vm0.bullet.mail.bf1.yahoo.com ([98.139.212.253]:27009 "HELO
	nm16-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754389Ab1EKPno convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 11:43:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi all,

My Hewlett-Packard HP Pavilion dv5 Notebook (PC/3600, BIOS F.32 03/02/2=
009)
has an integrated card reader like this:
=2E..
08:00.0 Ethernet controller: Atheros Communications Inc. AR5001 Wireles=
s Network Adapter (rev 01)
09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/81=
68B PCI Express Gigabit Ethernet controller (rev 02)
0a:00.0 FireWire (IEEE 1394): JMicron Technology Corp. IEEE 1394 Host C=
ontroller
0a:00.1 System peripheral: JMicron Technology Corp. SD/MMC Host Control=
ler
0a:00.2 SD Host controller: JMicron Technology Corp. Standard SD Host C=
ontroller
0a:00.3 System peripheral: JMicron Technology Corp. MS Host Controller
0a:00.4 System peripheral: JMicron Technology Corp. xD Host Controller


As long as I can remember (it's not a new regression) the card reader h=
as not worked
after suspend to ram. The log has lines like:

May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xf (was 0xffffffff, writing 0x10a)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xe (was 0xffffffff, writing 0x0)

By not working I mean that the reader doesn't react to an SD card being=
 inserted. Haven't
tested with other card types.

Is this hardware supposed to work over s2ram? I couldn't find anything =
quite the same by googling.

More logs (kernel is custom 2.6.39-rc6+ merged with mmc-next from April=
 19th or so; the problem
is not new to this version):

=2E..
May=A0 9 10:19:43 koni kernel: ACPI: Power Button [PWRF]
May=A0 9 10:19:43 koni kernel: ACPI: Battery Slot [BAT0] (battery prese=
nt)
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.1: SDHCI controller=
 found [197b:2382] (rev 0)
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.1: found 1 slot(s)
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.1: PCI INT A -> GSI=
 18 (level, low) -> IRQ 18
May=A0 9 10:19:43 koni kernel: sdhci [sdhci_add_host()]: Disabling ADMA=
 as it is marked broken
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.1: setting latency =
timer to 64
May=A0 9 10:19:43 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 10:19:43 koni kernel: sdhci: Sys addr: 0x00000000 | Version:=A0=
 0x0000ab01
May=A0 9 10:19:43 koni kernel: sdhci: Blk size: 0x00000000 | Blk cnt:=A0=
 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Argument: 0x00000000 | Trn mode: =
0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Present:=A0 0x00080000 | Host ctl=
: 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Power:=A0=A0=A0 0x00000000 | Blk =
gap:=A0 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Wake-up:=A0 0x00000000 | Clock:=A0=
=A0=A0 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Timeout:=A0 0x00000000 | Int stat=
: 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Int enab: 0x00ff0003 | Sig enab: =
0x00ff0003
May=A0 9 10:19:43 koni kernel: sdhci: AC12 err: 0x00000000 | Slot int: =
0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0x014832b2 | Ca=
ps_1:=A0=A0 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x00000000 | =
Max curr: 0x00000000
May=A0 9 10:19:43 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 10:19:43 koni kernel: Registered led device: mmc0::
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: mmc_rescan_try_freq: trying to ini=
t card at 400000 Hz
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 1 cs=
 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: SDHCI controller on PCI [0000:0a:0=
0.1] using DMA
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.2: SDHCI controller=
 found [197b:2381] (rev 0)
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.2: found 1 slot(s)
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.2: PCI INT A -> GSI=
 18 (level, low) -> IRQ 18
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.2: Refusing to bind=
 to secondary interface.
May=A0 9 10:19:43 koni kernel: sdhci-pci 0000:0a:00.2: PCI INT A disabl=
ed
May=A0 9 10:19:43 koni kernel: mmc0: clock 400000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 00000c00 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 80000c08 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 400000Hz busmode 1 powermode=
 2 cs 1 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD0 arg 00000000 flags 0=
00000c0
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD0): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 400000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD8 arg 000001aa flags 0=
00002f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD8): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD5 arg 00000000 flags 0=
00002e1
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD5): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD1 arg 00000000 flags 0=
00000e1
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD1): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: mmc_rescan_try_freq: trying to ini=
t card at 300000 Hz
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 1 cs=
 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: jmb38x_ms 0000:0a:00.3: PCI INT A -> GSI=
 18 (level, low) -> IRQ 18
May=A0 9 10:19:43 koni kernel: jmb38x_ms 0000:0a:00.3: setting latency =
timer to 64
May=A0 9 10:19:43 koni kernel: mmc0: clock 300000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: ACPI: AC Adapter [ACAD] (on-line)
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 00000c00 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 80000c08 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 300000Hz busmode 1 powermode=
 2 cs 1 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD0 arg 00000000 flags 0=
00000c0
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD0): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 300000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD8 arg 000001aa flags 0=
00002f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD8): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD5 arg 00000000 flags 0=
00002e1
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD5): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD1 arg 00000000 flags 0=
00000e1
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD1): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: mmc_rescan_try_freq: trying to ini=
t card at 200000 Hz
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 1 cs=
 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: clock 200000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: hp_accel: hardware type HPDV5_A found
May=A0 9 10:19:43 koni kernel: lis3lv02d: 8 bits sensor found
May=A0 9 10:19:43 koni kernel: r8169 Gigabit Ethernet driver 2.3LK-NAPI=
 loaded
May=A0 9 10:19:43 koni kernel: r8169 0000:09:00.0: PCI INT A -> GSI 18 =
(level, low) -> IRQ 18
May=A0 9 10:19:43 koni kernel: r8169 0000:09:00.0: setting latency time=
r to 64
May=A0 9 10:19:43 koni kernel: r8169 0000:09:00.0: irq 45 for MSI/MSI-X
May=A0 9 10:19:43 koni kernel: r8169 0000:09:00.0: eth0: RTL8168c/8111c=
 at 0xffffc90000040000, 00:23:8b:6a:a5:72, XID 1c4000c0 IRQ 45
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 00000c00 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 80000c08 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 200000Hz busmode 1 powermode=
 2 cs 1 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD0 arg 00000000 flags 0=
00000c0
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD0): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 200000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD8 arg 000001aa flags 0=
00002f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD8): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD5 arg 00000000 flags 0=
00002e1
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD5): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD1 arg 00000000 flags 0=
00000e1
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD1): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: mmc_rescan_try_freq: trying to ini=
t card at 195312 Hz
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 1 cs=
 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: clock 195312Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: rtc_cmos 00:05: RTC can wake from S4
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 00000c00 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD52 arg 80000c08 flags =
00000195
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD52): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 195312Hz busmode 1 powermode=
 2 cs 1 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: input: ST LIS3LV02DL Accelerometer as /d=
evices/platform/lis3lv02d/input/input7
May=A0 9 10:19:43 koni kernel: Registered led device: hp::hddprotect
May=A0 9 10:19:43 koni kernel: hp_accel: driver loaded
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD0 arg 00000000 flags 0=
00000c0
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD0): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 195312Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD8 arg 000001aa flags 0=
00002f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD8): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD5 arg 00000000 flags 0=
00002e1
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req failed (CMD5): -123, retrying.=
=2E.
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD5): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD55 arg 00000000 flags =
000000f5
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD55): -123: 00000000 0=
0000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: starting CMD1 arg 00000000 flags 0=
00000e1
May=A0 9 10:19:43 koni kernel: mmc0: req done (CMD1): -123: 00000000 00=
000000 00000000 00000000
May=A0 9 10:19:43 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 10:19:43 koni kernel: rtc_cmos 00:05: rtc core: registered rtc=
_cmos as rtc0
May=A0 9 10:19:43 koni kernel: rtc0: alarms up to one day, 114 bytes nv=
ram, hpet irqs
May=A0 9 10:19:43 koni kernel: usbcore: registered new interface driver=
 usbfs
May=A0 9 10:19:43 koni kernel: usbcore: registered new interface driver=
 hub
May=A0 9 10:19:43 koni kernel: usbcore: registered new device driver us=
b
=2E..
May=A0 9 18:11:01 koni -- MARK --
May=A0 9 18:11:01 koni kernel: PM: Syncing filesystems ... done.
May=A0 9 18:11:01 koni kernel: PM: Preparing system for mem sleep
May=A0 9 18:11:01 koni kernel: Freezing user space processes ... (elaps=
ed 0.01 seconds) done.
May=A0 9 18:11:01 koni kernel: Freezing remaining freezable tasks ... (=
elapsed 0.01 seconds) done.
May=A0 9 18:11:01 koni kernel: PM: Entering mem sleep
May=A0 9 18:11:01 koni kernel: Suspending console(s) (use no_console_su=
spend to debug)
May=A0 9 18:11:01 koni kernel: r8169 0000:09:00.0: PME# disabled
May=A0 9 18:11:01 koni kernel: sd 0:0:0:0: [sda] Synchronizing SCSI cac=
he
May=A0 9 18:11:01 koni kernel: sd 0:0:0:0: [sda] Stopping disk
May=A0 9 18:11:01 koni kernel: i8042 aux 00:08: wake-up capability disa=
bled by ACPI
May=A0 9 18:11:01 koni kernel: i8042 kbd 00:07: wake-up capability enab=
led by ACPI
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: PCI INT A disabl=
ed
May=A0 9 18:11:01 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: PCI INT A disabl=
ed
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:13.2: PCI INT B disable=
d
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:13.1: PCI INT A disable=
d
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:13.0: PCI INT A disable=
d
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:12.1: PCI INT A disable=
d
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:12.2: PCI INT B disable=
d
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:12.0: PCI INT A disable=
d
May=A0 9 18:11:01 koni acpid: client 1464[0:0] has disconnected
May=A0 9 18:11:01 koni kernel: HDA Intel 0000:01:00.1: PCI INT B disabl=
ed
May=A0 9 18:11:01 koni kernel: ACPI handle has no context!
May=A0 9 18:11:01 koni kernel: HDA Intel 0000:00:14.2: PCI INT A disabl=
ed
May=A0 9 18:11:01 koni kernel: ACPI handle has no context!
May=A0 9 18:11:01 koni kernel: ahci 0000:00:11.0: PCI INT A disabled
May=A0 9 18:11:01 koni kernel: [drm] Disabling audio support
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: power state changed=
 by ACPI to D3
May=A0 9 18:11:01 koni kernel: PM: suspend of devices complete after 21=
15.590 msecs
May=A0 9 18:11:01 koni kernel: PM: late suspend of devices complete aft=
er 53.383 msecs
May=A0 9 18:11:01 koni kernel: ACPI: Preparing to enter system sleep st=
ate S3
May=A0 9 18:11:01 koni kernel: PM: Saving platform NVS memory
May=A0 9 18:11:01 koni kernel: Disabling non-boot CPUs ...
May=A0 9 18:11:01 koni kernel: CPU 1 is now offline
May=A0 9 18:11:01 koni kernel: ACPI: Low-level resume complete
May=A0 9 18:11:01 koni kernel: PM: Restoring platform NVS memory
May=A0 9 18:11:01 koni kernel: Enabling non-boot CPUs ...
May=A0 9 18:11:01 koni kernel: Booting Node 0 Processor 1 APIC 0x1
May=A0 9 18:11:01 koni kernel: smpboot cpu 1: start_ip =3D 9a000
May=A0 9 18:11:01 koni kernel: Switched to NOHz mode on CPU #1
May=A0 9 18:11:01 koni kernel: CPU1 is up
May=A0 9 18:11:01 koni kernel: ACPI: Waking up from system sleep state =
S3
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:02.0: restoring config =
space at offset 0x7 (was 0x20005151, writing 0x5151)
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:02.0: restoring config =
space at offset 0x1 (was 0x100007, writing 0x100407)
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:04.0: restoring config =
space at offset 0x1 (was 0x100007, writing 0x100407)
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:05.0: restoring config =
space at offset 0x1 (was 0x100007, writing 0x100407)
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:06.0: restoring config =
space at offset 0x7 (was 0x20002121, writing 0x2121)
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:06.0: restoring config =
space at offset 0x1 (was 0x100007, writing 0x100407)
May=A0 9 18:11:01 koni kernel: pcieport 0000:00:0a.0: restoring config =
space at offset 0x1 (was 0x100007, writing 0x100407)
May=A0 9 18:11:01 koni kernel: ahci 0000:00:11.0: restoring config spac=
e at offset 0x1 (was 0x2300003, writing 0x2300007)
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:12.0: restoring config =
space at offset 0x1 (was 0x2a00002, writing 0x2a00013)
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:12.2: BAR 0: set to [me=
m 0xd2408500-0xd24085ff] (PCI address [0xd2408500-0xd24085ff])
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:12.2: restoring config =
space at offset 0x1 (was 0x2b00000, writing 0x2b00013)
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:13.0: restoring config =
space at offset 0x1 (was 0x2a00002, writing 0x2a00013)
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:13.2: BAR 0: set to [me=
m 0xd2408400-0xd24084ff] (PCI address [0xd2408400-0xd24084ff])
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:13.2: restoring config =
space at offset 0x1 (was 0x2b00000, writing 0x2b00013)
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: restoring config sp=
ace at offset 0x1 (was 0x100003, writing 0x100407)
May=A0 9 18:11:01 koni kernel: r8169 0000:09:00.0: restoring config spa=
ce at offset 0x1 (was 0x100007, writing 0x100407)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: Refused to change powe=
r state, currently in D3
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0xf (was 0xffffffff, writing 0x10a)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0xe (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0xd (was 0xffffffff, writing 0x44)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0xc (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0xb (was 0xffffffff, writing 0x3600103c)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0xa (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x9 (was 0xffffffff, writing 0xd1100c00)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x8 (was 0xffffffff, writing 0xd1100c80)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x7 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x6 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x5 (was 0xffffffff, writing 0xd1100d00)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x4 (was 0xffffffff, writing 0xd1100000)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x3 (was 0xffffffff, writing 0x800000)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x2 (was 0xffffffff, writing 0xc001000)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x1 (was 0xffffffff, writing 0x100007)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.0: restoring config space=
 at offset 0x0 (was 0xffffffff, writing 0x2380197b)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xf (was 0xffffffff, writing 0x10a)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xe (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xd (was 0xffffffff, writing 0xa4)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xc (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xb (was 0xffffffff, writing 0x3600103c)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0xa (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x9 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x8 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x7 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x6 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x5 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x4 (was 0xffffffff, writing 0xd1100b00)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x3 (was 0xffffffff, writing 0x800000)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x2 (was 0xffffffff, writing 0x8800000)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x1 (was 0xffffffff, writing 0x100007)
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: restoring config=
 space at offset 0x0 (was 0xffffffff, writing 0x2382197b)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: Refused to change powe=
r state, currently in D3
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0xf (was 0xffffffff, writing 0x10a)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0xe (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0xd (was 0xffffffff, writing 0xa4)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0xc (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0xb (was 0xffffffff, writing 0x3600103c)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0xa (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x9 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x8 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x7 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x6 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x5 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x4 (was 0xffffffff, writing 0xd1100a00)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x3 (was 0xffffffff, writing 0x800000)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x2 (was 0xffffffff, writing 0x8050100)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x1 (was 0xffffffff, writing 0x100003)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.2: restoring config space=
 at offset 0x0 (was 0xffffffff, writing 0x2381197b)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0xf (was 0xffffffff, writing 0x10a)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0xe (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0xd (was 0xffffffff, writing 0xa4)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0xc (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0xb (was 0xffffffff, writing 0x3600103c)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0xa (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x9 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x8 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x7 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x6 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x5 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x4 (was 0xffffffff, writing 0xd1100900)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x3 (was 0xffffffff, writing 0x800000)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x2 (was 0xffffffff, writing 0x8800000)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x1 (was 0xffffffff, writing 0x100007)
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: restoring config=
 space at offset 0x0 (was 0xffffffff, writing 0x2383197b)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: Refused to change powe=
r state, currently in D3
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0xf (was 0xffffffff, writing 0x10a)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0xe (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0xd (was 0xffffffff, writing 0xa4)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0xc (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0xb (was 0xffffffff, writing 0x3600103c)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0xa (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x9 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x8 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x7 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x6 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x5 (was 0xffffffff, writing 0x0)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x4 (was 0xffffffff, writing 0xd1100800)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x3 (was 0xffffffff, writing 0x800000)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x2 (was 0xffffffff, writing 0x8800000)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x1 (was 0xffffffff, writing 0x100007)
May=A0 9 18:11:01 koni kernel: pci 0000:0a:00.4: restoring config space=
 at offset 0x0 (was 0xffffffff, writing 0x2384197b)
May=A0 9 18:11:01 koni kernel: PM: early resume of devices complete aft=
er 93.241 msecs
May=A0 9 18:11:01 koni kernel: ahci 0000:00:11.0: PCI INT A -> GSI 22 (=
level, low) -> IRQ 22
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:12.0: PCI INT A -> GSI =
16 (level, low) -> IRQ 16
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:12.1: PCI INT A -> GSI =
16 (level, low) -> IRQ 16
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:12.2: PCI INT B -> GSI =
17 (level, low) -> IRQ 17
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:13.0: PCI INT A -> GSI =
18 (level, low) -> IRQ 18
May=A0 9 18:11:01 koni kernel: ohci_hcd 0000:00:13.1: PCI INT A -> GSI =
18 (level, low) -> IRQ 18
May=A0 9 18:11:01 koni kernel: ehci_hcd 0000:00:13.2: PCI INT B -> GSI =
19 (level, low) -> IRQ 19
May=A0 9 18:11:01 koni kernel: HDA Intel 0000:00:14.2: PCI INT A -> GSI=
 16 (level, low) -> IRQ 16
May=A0 9 18:11:01 koni kernel: HDA Intel 0000:01:00.1: PCI INT B -> GSI=
 19 (level, low) -> IRQ 19
May=A0 9 18:11:01 koni kernel: HDA Intel 0000:01:00.1: setting latency =
timer to 64
May=A0 9 18:11:01 koni kernel: HDA Intel 0000:01:00.1: irq 46 for MSI/M=
SI-X
May=A0 9 18:11:01 koni kernel: sd 0:0:0:0: [sda] Starting disk
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: power state changed=
 by ACPI to D0
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: power state changed=
 by ACPI to D0
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: power state changed=
 by ACPI to D0
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: power state changed=
 by ACPI to D0
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: setting latency tim=
er to 64
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: radeon 0000:01:00.0: WB enabled
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: sdhci-pci 0000:0a:00.1: PCI INT A -> GSI=
 18 (level, low) -> IRQ 18
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: Refused to chang=
e power state, currently in D3
May=A0 9 18:11:01 koni kernel: jmb38x_ms 0000:0a:00.3: PCI INT A -> GSI=
 18 (level, low) -> IRQ 18
May=A0 9 18:11:01 koni kernel: [drm] ring test succeeded in 1 usecs
May=A0 9 18:11:01 koni kernel: [drm] ib test succeeded in 0 usecs
May=A0 9 18:11:01 koni kernel: [drm] Enabling audio support
May=A0 9 18:11:01 koni kernel: i8042 kbd 00:07: wake-up capability disa=
bled by ACPI
May=A0 9 18:11:01 koni kernel: mmc0: Reset 0x1 never completed.
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: usb 1-3: reset high speed USB device num=
ber 2 using ehci_hcd
May=A0 9 18:11:01 koni kernel: ata6: SATA link down (SStatus 0 SControl=
 300)
May=A0 9 18:11:01 koni kernel: ata3: SATA link down (SStatus 0 SControl=
 300)
May=A0 9 18:11:01 koni kernel: ata4: SATA link down (SStatus 0 SControl=
 300)
May=A0 9 18:11:01 koni kernel: ata5: SATA link down (SStatus 0 SControl=
 300)
May=A0 9 18:11:01 koni kernel: ata2: softreset failed (device not ready=
)
May=A0 9 18:11:01 koni kernel: ata2: applying SB600 PMP SRST workaround=
 and retrying
May=A0 9 18:11:01 koni kernel: ata2: SATA link up 1.5 Gbps (SStatus 113=
 SControl 300)
May=A0 9 18:11:01 koni kernel: ata2.00: configured for UDMA/100
May=A0 9 18:11:01 koni kernel: ata1: softreset failed (device not ready=
)
May=A0 9 18:11:01 koni kernel: ata1: applying SB600 PMP SRST workaround=
 and retrying
May=A0 9 18:11:01 koni kernel: ata1: SATA link up 3.0 Gbps (SStatus 123=
 SControl 300)
May=A0 9 18:11:01 koni kernel: ata1.00: configured for UDMA/100
May=A0 9 18:11:01 koni kernel: PM: resume of devices complete after 594=
2.875 msecs
May=A0 9 18:11:01 koni kernel: PM: Finishing wakeup.
May=A0 9 18:11:01 koni kernel: Restarting tasks ...
May=A0 9 18:11:01 koni kernel: r8169 0000:09:00.0: PME# enabled
May=A0 9 18:11:01 koni kernel: done.
May=A0 9 18:11:01 koni kernel: video LNXVIDEO:01: Restoring backlight s=
tate
May=A0 9 18:11:01 koni kernel: mmc0: mmc_rescan_try_freq: trying to ini=
t card at 400000 Hz
May=A0 9 18:11:01 koni kernel: mmc0: clock 0Hz busmode 1 powermode 1 cs=
 0 Vdd 21 width 0 timing 0
May=A0 9 18:11:01 koni kernel: mmc0: clock 400000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 18:11:01 koni kernel: mmc0: starting CMD52 arg 00000c00 flags =
00000195
May=A0 9 18:11:01 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: mmc0: req done (CMD52): -5: 00000000 000=
00000 00000000 00000000
May=A0 9 18:11:01 koni kernel: mmc0: starting CMD52 arg 80000c08 flags =
00000195
May=A0 9 18:11:01 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:01 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:01 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:01 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:01 koni laptop-mode: Laptop mode
May=A0 9 18:11:01 koni laptop-mode: enabled,
May=A0 9 18:11:01 koni laptop-mode: not active [unchanged]
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: req done (CMD52): -5: 00000000 000=
00000 00000000 00000000
May=A0 9 18:11:02 koni kernel: mmc0: clock 400000Hz busmode 1 powermode=
 2 cs 1 Vdd 21 width 0 timing 0
May=A0 9 18:11:02 koni kernel: mmc0: starting CMD0 arg 00000000 flags 0=
00000c0
May=A0 9 18:11:02 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni logger: ACPI action undefined: ACAD
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni acpid: client connected from 1464[0:0]
May=A0 9 18:11:02 koni acpid: 1 client rule loaded
May=A0 9 18:11:02 koni laptop-mode: Laptop mode
May=A0 9 18:11:02 koni laptop-mode: enabled,
May=A0 9 18:11:02 koni laptop-mode: not active [unchanged]
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: req done (CMD0): -5: 00000000 0000=
0000 00000000 00000000
May=A0 9 18:11:02 koni kernel: mmc0: clock 400000Hz busmode 1 powermode=
 2 cs 0 Vdd 21 width 0 timing 0
May=A0 9 18:11:02 koni kernel: mmc0: starting CMD8 arg 000001aa flags 0=
00002f5
May=A0 9 18:11:02 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni laptop-mode: Laptop mode
May=A0 9 18:11:02 koni laptop-mode: enabled,
May=A0 9 18:11:02 koni laptop-mode: not active [unchanged]
May=A0 9 18:11:02 koni laptop-mode: Laptop mode
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni laptop-mode: enabled, not active
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: req done (CMD8): -5: 00000000 0000=
0000 00000000 00000000
May=A0 9 18:11:02 koni kernel: mmc0: starting CMD5 arg 00000000 flags 0=
00002e1
May=A0 9 18:11:02 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: req failed (CMD5): -5, retrying...
May=A0 9 18:11:02 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:02 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:02 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:02 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:02 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:02 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:03 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:03 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:03 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:03 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:03 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:03 koni kernel: mmc0: req failed (CMD5): -5, retrying...
May=A0 9 18:11:03 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:03 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:03 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:03 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:03 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:03 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:03 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

=2E.. similar messages repeated until ...

May=A0 9 18:11:12 koni kernel: mmc0: req done (CMD55): -5: 00000000 000=
00000 00000000 00000000
May=A0 9 18:11:12 koni kernel: mmc0: starting CMD1 arg 00000000 flags 0=
00000e1
May=A0 9 18:11:12 koni kernel: mmc0: Controller never released inhibit =
bit(s).
May=A0 9 18:11:12 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:12 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:12 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:12 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:12 koni kernel: mmc0: Reset 0x2 never completed.
May=A0 9 18:11:12 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:12 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:12 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:12 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:12 koni kernel: mmc0: Reset 0x4 never completed.
May=A0 9 18:11:12 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:12 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:12 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:12 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:12 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:12 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:12 koni kernel: mmc0: req done (CMD1): -5: 00000000 0000=
0000 00000000 00000000
May=A0 9 18:11:12 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 18:11:13 koni kernel: mmc0: Reset 0x1 never completed.
May=A0 9 18:11:13 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:13 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:11:13 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:11:13 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:11:13 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:11:13 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:11:13 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:11:13 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:11:13 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:11:13 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:11:13 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:11:13 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:11:13 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:11:46 koni crond[1456]: time disparity of 419 minutes detec=
ted
May=A0 9 18:12:01 koni crond[1456]: FILE /var/spool/cron/root USER root=
 PID 4055 job sys-hourly
May=A0 9 18:12:01 koni crond[1456]: FILE /var/spool/cron/root USER root=
 PID 4056 job sys-daily
May=A0 9 18:12:05 koni kernel: usb 5-3: new full speed USB device numbe=
r 2 using ohci_hcd
May=A0 9 18:12:05 koni kernel: usb 5-3: New USB device found, idVendor=3D=
0af0, idProduct=3D6971
May=A0 9 18:12:05 koni kernel: usb 5-3: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D3
May=A0 9 18:12:05 koni kernel: usb 5-3: Product: Globetrotter HSDPA Mod=
em=20
May=A0 9 18:12:05 koni kernel: usb 5-3: Manufacturer: Option N.V.
May=A0 9 18:12:05 koni kernel: usb 5-3: SerialNumber: Serial Number
May=A0 9 18:12:05 koni kernel: hso 5-3:1.0: Not our interface
May=A0 9 18:12:05 koni kernel: usb-storage: probe of 5-3:1.0 failed wit=
h error -5
May=A0 9 18:12:05 koni kernel: usb 5-3: USB disconnect, device number 2
May=A0 9 18:12:06 koni kernel: usb 5-3: new full speed USB device numbe=
r 3 using ohci_hcd
May=A0 9 18:12:06 koni kernel: usb 5-3: New USB device found, idVendor=3D=
0af0, idProduct=3D6971
May=A0 9 18:12:06 koni kernel: usb 5-3: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D4
May=A0 9 18:12:06 koni kernel: usb 5-3: Product: Globetrotter HSDPA Mod=
em=20
May=A0 9 18:12:06 koni kernel: usb 5-3: Manufacturer: Option N.V.
May=A0 9 18:12:06 koni kernel: usb 5-3: SerialNumber: Serial Number
May=A0 9 18:12:34 koni crond[4145]: mailing cron output for user root j=
ob sys-daily
May=A0 9 18:12:34 koni crond[4145]: unable to exec /usr/sbin/sendmail: =
cron output for user root job sys-daily to /dev/null
May=A0 9 18:31:01 koni -- MARK --
May=A0 9 18:47:08 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 18:47:08 koni kernel: sdhci-pci 0000:0a:00.1: PCI INT A disabl=
ed
May=A0 9 18:47:17 koni kernel: sdhci: Secure Digital Host Controller In=
terface driver
May=A0 9 18:47:17 koni kernel: sdhci: Copyright(c) Pierre Ossman
May=A0 9 18:47:17 koni kernel: sdhci-pci 0000:0a:00.1: SDHCI controller=
 found [197b:2382] (rev 0)
May=A0 9 18:47:17 koni kernel: sdhci-pci 0000:0a:00.1: found 1 slot(s)
May=A0 9 18:47:17 koni kernel: sdhci-pci 0000:0a:00.1: enabling device =
(0000 -> 0002)
May=A0 9 18:47:17 koni kernel: sdhci-pci 0000:0a:00.1: PCI INT A -> GSI=
 18 (level, low) -> IRQ 18
May=A0 9 18:47:17 koni kernel: mmc0: Reset 0x1 never completed.
May=A0 9 18:47:17 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:47:17 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:47:17 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:47:17 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:47:17 koni kernel: mmc0: Unknown controller version (255). =
You may experience problems.
May=A0 9 18:47:17 koni kernel: sdhci-pci 0000:0a:00.1: setting latency =
timer to 64
May=A0 9 18:47:17 koni kernel: mmc0: Invalid maximum block size, assumi=
ng 512 bytes
May=A0 9 18:47:17 koni kernel: mmc0: Reset 0x1 never completed.
May=A0 9 18:47:17 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:47:17 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:47:17 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:47:17 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: ADMA Err: 0xffffffff | ADMA Ptr: =
0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:47:17 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:47:17 koni kernel: sdhci: Sys addr: 0xffffffff | Version:=A0=
 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Blk size: 0x0000ffff | Blk cnt:=A0=
 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Argument: 0xffffffff | Trn mode: =
0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Present:=A0 0xffffffff | Host ctl=
: 0x000000ff
May=A0 9 18:47:17 koni kernel: sdhci: Power:=A0=A0=A0 0x000000ff | Blk =
gap:=A0 0x000000ff
May=A0 9 18:47:17 koni kernel: sdhci: Wake-up:=A0 0x000000ff | Clock:=A0=
=A0=A0 0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Timeout:=A0 0x000000ff | Int stat=
: 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: Int enab: 0xffffffff | Sig enab: =
0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: AC12 err: 0x0000ffff | Slot int: =
0x0000ffff
May=A0 9 18:47:17 koni kernel: sdhci: Caps:=A0=A0=A0=A0 0xffffffff | Ca=
ps_1:=A0=A0 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: Cmd:=A0=A0=A0=A0=A0 0x0000ffff | =
Max curr: 0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: ADMA Err: 0xffffffff | ADMA Ptr: =
0xffffffff
May=A0 9 18:47:17 koni kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
May=A0 9 18:47:17 koni kernel: Registered led device: mmc0::
May=A0 9 18:47:17 koni kernel: mmc0: clock 0Hz busmode 1 powermode 0 cs=
 0 Vdd 0 width 0 timing 0
May=A0 9 18:47:17 koni kernel: mmc0: Reset 0x1 never completed.
=2E..

(around 18:47:08 is a modprobe -r sdhci-pci && modprobe sdhci-pci seque=
nce; doesn't help anything).


Since certain desktop environments are advogating for people to use mor=
e s2ram rather
than shutdown completely, it would be nice to get this working :)


Greetings,

Mikko
