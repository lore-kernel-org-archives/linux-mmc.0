From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: sdhci-esdhc-imx : cannot read eMMC
Date: Tue, 2 Sep 2014 11:20:13 +0200
Message-ID: <CAL8zT=gJtnyGSnVz+YWW3Z1LPXPp-Oe3SsGqvBvV=2LBpZ-t9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:57014 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbaIBJU3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 05:20:29 -0400
Received: by mail-oa0-f49.google.com with SMTP id jd19so4549017oac.36
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 02:20:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>

Hi there,

I start a new thread, as I have done lots of test and this will be clearer.
I have problems reading and writing eMMC on my i.MX6 board with 3.17-rc3.
Sometimes I don't have read errors explicitly in dmesg, but fdisk has
no effects.
I activated MMC debug in my config file, and here is an extract of
mmc0 register dump and all mmc1 part.
On Freescale kernel, I confirm it works well with the same board and
sample, I can write a partition on mmc1.

If you have any idea of anything I could test... :)
Thanks !

[    3.034708] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.035692] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high
speed state, work on normal mode
[    3.036732] sdhci [sdhci_add_host()]: mmc0: Auto-CMD23 available
[    3.036773] sdhci-esdhc-imx 2198000.usdhc: No vmmc regulator found
[    3.036779] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
[    3.049366] sdhci: =========== REGISTER DUMP (mmc0)===========
[    3.049374] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
[    3.049381] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
[    3.049387] sdhci: Argument: 0x009a9200 | Trn mode: 0x00000000
[    3.049393] sdhci: Present:  0x01fd8088 | Host ctl: 0x00000022
[    3.049398] sdhci: Power:    0x00000000 | Blk gap:  0x00000080
[    3.049404] sdhci: Wake-up:  0x00000000 | Clock:    0x0000011f
[    3.049409] sdhci: Timeout:  0x0000008b | Int stat: 0x00000000
[    3.049415] sdhci: Int enab: 0x007f0003 | Sig enab: 0x007f0003
[    3.049420] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
[    3.049426] sdhci: Caps:     0x07eb0000 | Caps_1:   0x00002007
[    3.049432] sdhci: Cmd:      0x0000113a | Max curr: 0x00ffffff
[    3.049436] sdhci: Host ctl2: 0x00000000
[    3.049441] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[    3.049445] sdhci: ===========================================
[    3.050355] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width
0 timing 0
[    3.050436] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.056127] sdhci-esdhc-imx 2198000.usdhc: Initial signal voltage of 3.3v
[    3.074509] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.074528] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.075546] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.075556] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.094542] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc]
using ADMA
[    3.095766] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.096785] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.096796] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.099853] sdhci [sdhci_add_host()]: mmc1: Auto-CMD23 available
[    3.100143] sdhci-esdhc-imx 219c000.usdhc: No vqmmc regulator found
[    3.101358] sdhci: =========== REGISTER DUMP (mmc1)===========
[    3.101366] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
[    3.101374] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000001
[    3.101380] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    3.101386] sdhci: Present:  0x01fd8088 | Host ctl: 0x00000020
[    3.101392] sdhci: Power:    0x00000000 | Blk gap:  0x00000080
[    3.101398] sdhci: Wake-up:  0x00000008 | Clock:    0x0000800f
[    3.101405] sdhci: Timeout:  0x00000080 | Int stat: 0x00000000
[    3.101412] sdhci: Int enab: 0x007f0003 | Sig enab: 0x007f0003
[    3.101418] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
[    3.101424] sdhci: Caps:     0x07eb0000 | Caps_1:   0x00002007
[    3.101430] sdhci: Cmd:      0x00000000 | Max curr: 0x00ffffff
[    3.101434] sdhci: Host ctl2: 0x00000000
[    3.101440] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[    3.101445] sdhci: ===========================================
[    3.102047] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width
0 timing 0
[    3.102096] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.103588] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    3.103601] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    3.103983] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010000
[    3.106030] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.106295] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    3.106652] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010000
[    3.108704] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.108751] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 0 timing 0
[    3.108772] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.108784] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.110801] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    3.110842] sdhci-esdhc-imx 219c000.usdhc: Initial signal voltage of 3.3v
[    3.110998] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.111021] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.112068] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.112087] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.112099] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.114116] mmc0: starting CMD8 arg 000001aa flags 000002f5
[    3.114469] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.114493] mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
[    3.114542] mmc0: starting CMD5 arg 00000000 flags 000002e1
[    3.114899] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010000
[    3.116950] mmc0: req failed (CMD5): -110, retrying...
[    3.117298] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010000
[    3.119344] mmc0: req failed (CMD5): -110, retrying...
[    3.119693] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010000
[    3.121738] mmc0: req failed (CMD5): -110, retrying...
[    3.122089] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00010000
[    3.124116] mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    3.124154] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.124501] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.124523] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
[    3.124558] mmc0: starting CMD41 arg 00000000 flags 000000e1
[    3.124904] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.124925] mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
[    3.124965] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 0 timing 0
[    3.124985] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.124997] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.127012] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    3.127209] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.127230] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.128265] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.128284] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[    3.128296] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.130312] mmc0: starting CMD8 arg 000001aa flags 000002f5
[    3.130656] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.130677] mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
[    3.130713] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.131057] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.131078] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
[    3.131112] mmc0: starting CMD41 arg 50200000 flags 000000e1
[    3.131457] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.131479] mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
[    3.134447] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.134467] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.135495] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.135507] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.144580] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
using ADMA
[    3.146877] usbcore: registered new interface driver usbhid
[    3.146881] usbhid: USB HID core driver
[    3.151146] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    3.151502] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.151528] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
[    3.151594] mmc0: starting CMD41 arg 50200000 flags 000000e1
[    3.151941] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.151966] mmc0: req done (CMD41): 0: 80ff8000 00000000 00000000 00000000
[    3.152015] mmc0: starting CMD2 arg 00000000 flags 00000067
[    3.152624] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.152655] mmc0: req done (CMD2): 0: 1b534d30 30303030 102d1fad c300aa00
[    3.152738] mmc0: starting CMD3 arg 00000000 flags 00000075
[    3.152828] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.152834] [drm] No driver support for vblank timestamp query.
[    3.153122] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.153148] mmc0: req done (CMD3): 0: 00020520 00000000 00000000 00000000
[    3.153196] mmc0: starting CMD9 arg 00020000 flags 00000007
[    3.153519] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops
ipu_crtc_ops)
[    3.153736] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops
ipu_crtc_ops)
[    3.153779] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.153809] mmc0: req done (CMD9): 0: 007fff32 5b5a83ba f6dbdfff 0e800000
[    3.153871] mmc0: starting CMD7 arg 00020000 flags 00000015
[    3.154133] imx-drm display-subsystem: bound imx-ipuv3-crtc.4 (ops
ipu_crtc_ops)
[    3.154226] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.154252] mmc0: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[    3.154296] mmc0: starting CMD55 arg 00020000 flags 00000095
[    3.154564] imx-drm display-subsystem: bound imx-ipuv3-crtc.5 (ops
ipu_crtc_ops)
[    3.154650] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.154676] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 00000000
[    3.154740] mmc0: starting CMD51 arg 00000000 flags 000000b5
[    3.154750] mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    3.155174] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.155433] imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[    3.155741] imx-drm display-subsystem: bound 120000.hdmi (ops hdmi_ops)
[    3.156138] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    3.156178] mmc0: req done (CMD51): 0: 00000920 00000000 00000000 00000000
[    3.156185] mmc0:     8 bytes transferred: 0
[    3.156245] mmc0: starting CMD55 arg 00020000 flags 00000095
[    3.156393] imx-drm display-subsystem: No connectors reported
connected with modes
[    3.156407] [drm] Cannot find any crtc or sizes - going 1024x768
[    3.156612] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.156647] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 00000000
[    3.156752] mmc0: starting CMD13 arg 00000000 flags 000001b5
[    3.156763] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    3.157103] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.158560] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    3.158608] mmc0: req done (CMD13): 0: 00000920 00000000 00000000 00000000
[    3.158615] mmc0:     64 bytes transferred: 0
[    3.173759] mmc0: starting CMD6 arg 00fffff0 flags 000000b5
[    3.173768] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    3.174110] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.176339] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    3.176370] mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
[    3.176377] mmc0:     64 bytes transferred: 0
[    3.176425] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    3.176438] mmc0: starting CMD6 arg 80fffff1 flags 000000b5
[    3.176447] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    3.176783] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.179343] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    3.179371] mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
[    3.179377] mmc0:     64 bytes transferred: 0
[    3.179418] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 2
[    3.179443] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[    3.179455] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
400000, actual: 386718
[    3.180470] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd
21 width 0 timing 2
[    3.180482] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[    3.181497] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[    3.181506] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[    3.182521] mmc0: starting CMD55 arg 00020000 flags 00000095
[    3.182549] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.182571] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 00000000
[    3.182598] mmc0: starting CMD6 arg 00000002 flags 00000015
[    3.182627] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.182647] mmc0: req done (CMD6): 0: 00000920 00000000 00000000 00000000
[    3.182674] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd
21 width 2 timing 2
[    3.182692] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[    3.182702] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[    3.183724] mmc0: new high speed SD card at address 0002
[    3.184931] mmc0: calculated max. discard sectors 0 for timeout 677 ms
[    3.185514] mmcblk0: mmc0:0002 00000 1.86 GiB
[    3.187281] mmc0: starting CMD18 arg 00000000 flags 000000b5
[    3.187291] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[    3.187297] mmc0:     CMD12 arg 00000000 flags 00000095
[    3.187377] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.190374] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    3.190445] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.190470] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    3.190475] mmc0:     4096 bytes transferred: 0
[    3.190482] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[    3.190800]  mmcblk0: p1 p2
[    3.193341] mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    3.193354] mmc1: starting CMD52 arg 00000c00 flags 00000195
[    3.194449] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.195538] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.195551] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.202458] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.204511] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.204638] mmc1: starting CMD52 arg 80000c08 flags 00000195
[    3.204996] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.207024] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.207066] mmc1: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 0 timing 0
[    3.207098] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.207111] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.209127] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    3.209321] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.209342] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.210378] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.210406] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.210418] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.212436] mmc1: starting CMD8 arg 000001aa flags 000002f5
[    3.212789] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.214840] mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[    3.214930] mmc1: starting CMD5 arg 00000000 flags 000002e1
[    3.215286] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.217336] mmc1: req failed (CMD5): -110, retrying...
[    3.217684] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.219731] mmc1: req failed (CMD5): -110, retrying...
[    3.220078] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.222125] mmc1: req failed (CMD5): -110, retrying...
[    3.222473] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.224519] mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    3.224608] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.224961] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.226990] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.227028] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.227382] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.229408] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.229443] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.229796] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.231821] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.231857] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.232208] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
[    3.234235] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.234273] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.234302] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.234314] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.235378] mmc1: starting CMD1 arg 00000000 flags 000000e1
[    3.235749] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.235771] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.235811] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.235840] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.235852] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.236867] mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21
width 0 timing 0
[    3.236892] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.236903] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.238919] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    3.239114] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.239135] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.240171] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.240198] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.240210] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.242226] mmc1: starting CMD1 arg 40200000 flags 000000e1
[    3.242571] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.242592] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.264470] mmc1: starting CMD1 arg 40200000 flags 000000e1
[    3.264820] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.264843] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.294471] mmc1: starting CMD1 arg 40200000 flags 000000e1
[    3.294819] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.294841] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.314464] mmc1: starting CMD1 arg 40200000 flags 000000e1
[    3.314810] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.314832] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.334463] mmc1: starting CMD1 arg 40200000 flags 000000e1
[    3.334811] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.334833] mmc1: req done (CMD1): 0: 80ff8080 00000000 00000000 00000000
[    3.334868] mmc1: starting CMD2 arg 00000000 flags 00000067
[    3.335442] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.335465] mmc1: req done (CMD2): 0: 45010053 454d3032 47907161 38756e00
[    3.335525] mmc1: starting CMD3 arg 00010000 flags 00000015
[    3.335887] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.335909] mmc1: req done (CMD3): 0: 00000500 00000000 00000000 00000000
[    3.335946] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    3.335975] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 0
[    3.335988] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.337005] mmc1: starting CMD9 arg 00010000 flags 00000007
[    3.337585] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.337609] mmc1: req done (CMD9): 0: d00f0032 0f5a03a5 fffffcff 92404000
[    3.337646] mmc1: starting CMD7 arg 00010000 flags 00000015
[    3.337999] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.338020] mmc1: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[    3.338056] mmc1: starting CMD8 arg 00000000 flags 000000b5
[    3.338066] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    3.338423] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.349874] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    3.349908] mmc1: req done (CMD8): 0: 00000900 00000000 00000000 00000000
[    3.349914] mmc1:     512 bytes transferred: 0
[    3.349959] mmc1: starting CMD6 arg 03af0101 flags 0000049d
[    3.350328] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.350350] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.350388] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.350742] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.350763] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.350797] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.351155] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.351176] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.351209] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.351569] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.351590] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.351625] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.351982] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.352003] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.352038] mmc1: starting CMD6 arg 03b90101 flags 0000049d
[    3.352396] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.352417] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.352453] mmc1: starting CMD13 arg 00010000 flags 00000191
[    3.352810] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.352831] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.352864] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 1
[    3.352894] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 1
[    3.352906] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
400000, actual: 386718
[    3.353923] mmc1: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd
21 width 0 timing 1
[    3.353936] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
52000000, actual: 49500000
[    3.355027] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 1
[    3.355037] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
52000000, actual: 49500000
[    3.356055] mmc1: starting CMD6 arg 03b70101 flags 0000049d
[    3.356083] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.356106] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.356132] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.356177] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.356197] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.356232] mmc1: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd
21 width 2 timing 1
[    3.356260] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 1
[    3.356271] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
52000000, actual: 49500000
[    3.357287] mmc1: starting CMD8 arg 00000000 flags 000000b5
[    3.357296] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    3.357341] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.357480] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    3.357512] mmc1: req done (CMD8): 0: 00000900 00000000 00000000 00000000
[    3.357519] mmc1:     512 bytes transferred: 0
[    3.357558] mmc1: starting CMD6 arg 03b70501 flags 0000049d
[    3.357587] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.357610] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.357637] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.357663] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.357684] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.357709] mmc1: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd
21 width 2 timing 8
[    3.357739] sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 8
[    3.357749] sdhci-esdhc-imx 219c000.usdhc: desired SD clock:
52000000, actual: 49500000
[    3.358773] mmc1: new DDR MMC card at address 0001
[    3.359485] mmc1: calculated max. discard sectors 0 for timeout 677 ms
[    3.359633] mmcblk1: mmc1:0001 SEM02G 1.82 GiB
[    3.359732] mmc1: calculated max. discard sectors 0 for timeout 677 ms
[    3.364534] mmcblk1boot0: mmc1:0001 SEM02G partition 1 1.00 MiB
[    3.364636] mmc1: calculated max. discard sectors 0 for timeout 677 ms
[    3.364811] mmcblk1boot1: mmc1:0001 SEM02G partition 2 1.00 MiB
[    3.364917] mmc1: calculated max. discard sectors 0 for timeout 677 ms
[    3.365089] mmcblk1rpmb: mmc1:0001 SEM02G partition 3 128 KiB
[    3.366368] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[    3.366377] mmc1: starting CMD18 arg 00000000 flags 000000b5
[    3.366385] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[    3.366392] mmc1:     CMD12 arg 00000000 flags 00000095
[    3.366477] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.367989] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    3.368053] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    3.368059] mmc1:     4096 bytes transferred: 0
[    3.368067] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[    3.368165]  mmcblk1: p1
[    3.371561] mmc1: starting CMD6 arg 03b30201 flags 0000049d
[    3.371594] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.371616] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.371646] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.371690] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.371712] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.371748] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.371787] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.371809] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.371841] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.371875] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.371896] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.371926] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.371961] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.371982] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372011] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372039] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372060] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372084] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372117] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372138] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372168] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372202] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372222] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372254] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372289] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372310] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372339] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372375] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372395] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372426] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372459] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372480] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372510] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372536] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372556] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372580] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372615] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372641] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372673] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372708] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372729] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372759] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372793] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372814] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.372844] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.372878] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.372898] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.372933] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[    3.372940] mmc1: starting CMD18 arg 00000000 flags 000000b5
[    3.372948] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[    3.372953] mmc1:     CMD12 arg 00000000 flags 00000095
[    3.373033] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.373668] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    3.373731] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    3.373736] mmc1:     4096 bytes transferred: 0
[    3.373744] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[    3.373829]  mmcblk1boot1: unknown partition table
[    3.375544] mmc1: starting CMD6 arg 03b30101 flags 0000049d
[    3.375577] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.375603] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.375632] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.375668] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.375689] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.375722] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.375757] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.375778] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.375809] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.375844] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.375865] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.375895] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.375930] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.375950] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.375980] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.376014] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.376035] mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[    3.376065] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.376100] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.376121] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.376153] <mmc1: starting CMD23 arg 00000008 flags 00000015>
[    3.376161] mmc1: starting CMD18 arg 00000000 flags 000000b5
[    3.376169] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[    3.376175] mmc1:     CMD12 arg 00000000 flags 00000095
[    3.376258] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.377320] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    3.377382] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    3.377388] mmc1:     4096 bytes transferred: 0
[    3.377396] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
[    3.377484]  mmcblk1boot0: unknown partition table
