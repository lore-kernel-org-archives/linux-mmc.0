From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: mmc0: Timeout waiting for hardware interrupt.
Date: Fri, 23 Aug 2013 11:54:53 +0200
Message-ID: <CAH9NwWcQ6528NxSShnO2Nfa4dyqD0j68wO9CqfR3i=cpGXQjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:48517 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab3HWJzP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 05:55:15 -0400
Received: by mail-qe0-f51.google.com with SMTP id cy11so207182qeb.24
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 02:55:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all.

I am trying to get some eMMC issues fixed I have with our custom imx6
based board. I need
to say that I am quite new to mmc in general and hope somebody has
some hints for me.
I think that I need to do the one-time setup of a fresh soldered eMMC
chip but I am not
sure if there is a linux tool for that.

This is a detailed log of the timeout problem I am seeing:
..
[    3.344404] mmcblk0: mmc0:0001 SEM04G 3.68 GiB
[    3.344453] mmc0: calculated max. discard sectors 0 for timeout 677 ms
[    3.344530] mmcblk0boot0: mmc0:0001 SEM04G partition 1 2.00 MiB
[    3.344570] mmc0: calculated max. discard sectors 0 for timeout 677 ms
[    3.344649] mmcblk0boot1: mmc0:0001 SEM04G partition 2 2.00 MiB
[    3.344700] mmc0: calculated max. discard sectors 0 for timeout 677 ms
[    3.344775] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 2.00 MiB
[    3.364797] <mmc0: starting CMD23 arg 00000008 flags 00000015>
[    3.364801] mmc0: starting CMD18 arg 00000000 flags 000000b5
[    3.364807] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[    3.364810] mmc0:     CMD12 arg 00000000 flags 0000049d
[    3.364859] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    3.365267] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    3.365350] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    3.365354] mmc0:     4096 bytes transferred: 0
[    3.365358] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[    3.365449]  mmcblk0: p1 p2
..
[   37.885114] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   47.894309] mmc0: Timeout waiting for hardware interrupt.
[   47.901584] sdhci: =========== REGISTER DUMP (mmc0)===========
[   47.909275] sdhci: Sys addr: 0x2de5c000 | Version:  0x00000002
[   47.916957] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[   47.924626] sdhci: Argument: 0x00010000 | Trn mode: 0x00000000
[   47.932270] sdhci: Present:  0xff8d8089 | Host ctl: 0x0000002b
[   47.939907] sdhci: Power:    0x00000001 | Blk gap:  0x00000080
[   47.947522] sdhci: Wake-up:  0x00000000 | Clock:    0x0000011f
[   47.955151] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[   47.962760] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[   47.970366] sdhci: AC12 err: 0x00000082 | Slot int: 0x00000003
[   47.977943] sdhci: Caps:     0x07eb0000 | Caps_1:   0x08100810
[   47.985517] sdhci: Cmd:      0x00000d1a | Max curr: 0x000000b3
[   47.993077] sdhci: Host ctl2: 0x00000000
[   47.998696] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x2d885008
[   48.006241] sdhci: ===========================================
[   48.013837] mmc0: req failed (SEND_STATUS(CMD13)): -110, retrying...
[   48.020842] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.028884] mmc0: req done (SEND_STATUS(CMD13)): 0: 00000900
00000000 00000000 00000000
[   48.037559] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.045159] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000ff0
flags 000000b5
[   48.052573] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.061217] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.068220] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.076233] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.084239] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.092836] mmc0:     4096 bytes transferred: 0
[   48.099076] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.107404] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   48.114840] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.122820] mmc0: req done (SEND_STATUS(CMD13)): 0: 00000900
00000000 00000000 00000000
[   48.131460] mmc0: starting SWITCH(CMD6) arg 03b30001 flags 0000049d
[   48.138776] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.146766] mmc0: req done (SWITCH(CMD6)): 0: 00000800 00000000
00000000 00000000
[   48.155294] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   48.162707] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.170738] mmc0: req done (SEND_STATUS(CMD13)): 0: 00000900
00000000 00000000 00000000
[   48.179401] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.186998] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200800
flags 000000b5
[   48.194410] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.203028] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.210023] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.218027] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.226035] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.234637] mmc0:     4096 bytes transferred: 0
[   48.240875] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.249137] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.256745] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000808
flags 000000b5
[   48.264166] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.272839] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.279890] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.287971] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.296073] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.304795] mmc0:     4096 bytes transferred: 0
[   48.311415] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.319765] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.327465] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200808
flags 000000b5
[   48.335000] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.343737] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.350867] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.358990] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.367109] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.375826] mmc0:     4096 bytes transferred: 0
[   48.382168] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.390511] mmc0: starting SWITCH(CMD6) arg 03b30101 flags 0000049d
[   48.397973] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.406091] mmc0: req done (SWITCH(CMD6)): 0: 00000800 00000000
00000000 00000000
[   48.414785] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   48.422326] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.430488] mmc0: req done (SEND_STATUS(CMD13)): 0: 00000900
00000000 00000000 00000000
[   48.439300] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.447049] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000000
flags 000000b5
[   48.454585] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.463331] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.470463] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.478607] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.486735] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.495459] mmc0:     4096 bytes transferred: 0
[   48.501805] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.510223] mmc0: starting SWITCH(CMD6) arg 03b30001 flags 0000049d
[   48.517678] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.525802] mmc0: req done (SWITCH(CMD6)): 0: 00000800 00000000
00000000 00000000
[   48.534449] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   48.541949] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.550069] mmc0: req done (SEND_STATUS(CMD13)): 0: 00000900
00000000 00000000 00000000
[   48.558858] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.566580] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 0075fff8
flags 000000b5
[   48.574095] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.582854] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.589984] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.598129] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.606268] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.615012] mmc0:     4096 bytes transferred: 0
[   48.621369] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.629709] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.637426] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002007f8
flags 000000b5
[   48.644955] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.653704] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.660834] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.668978] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.677117] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.685856] mmc0:     4096 bytes transferred: 0
[   48.692214] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.700573] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.708317] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 0075fef8
flags 000000b5
[   48.715854] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.724625] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.731746] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.739886] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.748021] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.756746] mmc0:     4096 bytes transferred: 0
[   48.763099] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.771397] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.779065] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002006f8
flags 000000b5
[   48.786560] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.795278] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.802352] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.810507] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.818651] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.827380] mmc0:     4096 bytes transferred: 0
[   48.833723] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.842028] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.849722] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00201000
flags 000000b5
[   48.857217] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.865937] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.872997] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.881126] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.889211] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.897885] mmc0:     4096 bytes transferred: 0
[   48.904184] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.912442] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.920090] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00001000
flags 000000b5
[   48.927541] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   48.936248] mmc0:     CMD12 arg 00000000 flags 0000049d
[   48.943303] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   48.951369] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   48.959437] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   48.968106] mmc0:     4096 bytes transferred: 0
[   48.974420] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   48.982653] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   48.990281] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200818
flags 000000b5
[   48.997730] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.006431] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.013481] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.021546] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.029617] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.038285] mmc0:     4096 bytes transferred: 0
[   49.044600] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.052835] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.060465] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000818
flags 000000b5
[   49.067904] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.076609] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.083652] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.091715] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.099780] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.108446] mmc0:     4096 bytes transferred: 0
[   49.114758] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.122993] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.130635] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200838
flags 000000b5
[   49.138078] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.146784] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.153824] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.161888] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.169949] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.178610] mmc0:     4096 bytes transferred: 0
[   49.184920] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.193149] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.200774] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000838
flags 000000b5
[   49.208217] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.216923] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.223968] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.232033] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.240096] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.248764] mmc0:     4096 bytes transferred: 0
[   49.255071] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.263307] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.270931] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200878
flags 000000b5
[   49.278375] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.287082] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.294127] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.302190] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.310262] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.318930] mmc0:     4096 bytes transferred: 0
[   49.325520] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.333786] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.341432] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000878
flags 000000b5
[   49.348882] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.357584] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.364660] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.372737] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.380813] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.389484] mmc0:     4096 bytes transferred: 0
[   49.395800] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.404033] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.411659] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200810
flags 000000b5
[   49.419105] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.427808] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.434877] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.442945] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.451020] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.459710] mmc0:     4096 bytes transferred: 0
[   49.466020] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.474256] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.481885] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000810
flags 000000b5
[   49.489330] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.498029] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.505097] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.505462] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.505510] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.505513] mmc0:     4096 bytes transferred: 0
[   49.505518] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.505538] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.505542] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200880
flags 000000b5
[   49.505547] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.505550] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.505595] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.505870] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.505914] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.505917] mmc0:     4096 bytes transferred: 0
[   49.505921] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.506047] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.506052] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200840
flags 000000b5
[   49.506056] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.506060] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.506112] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.506380] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.506421] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.506425] mmc0:     4096 bytes transferred: 0
[   49.506429] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.506540] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.506544] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200900
flags 000000b5
[   49.506549] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.506553] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.506605] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.506875] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.506919] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.506922] mmc0:     4096 bytes transferred: 0
[   49.506926] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.507029] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.507033] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200908
flags 000000b5
[   49.507038] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.507042] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.507114] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.507382] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.507455] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.507458] mmc0:     4096 bytes transferred: 0
[   49.507461] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.507561] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.507565] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200910
flags 000000b5
[   49.507570] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.507574] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.507651] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.507920] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.508002] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.508005] mmc0:     4096 bytes transferred: 0
[   49.508010] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.508114] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.508118] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200918
flags 000000b5
[   49.508123] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.508126] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.508203] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.508472] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.508549] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.508552] mmc0:     4096 bytes transferred: 0
[   49.508556] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.508655] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.508660] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200920
flags 000000b5
[   49.508665] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.508668] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.508746] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.509014] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.509096] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.509099] mmc0:     4096 bytes transferred: 0
[   49.509103] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.509204] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.509208] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200928
flags 000000b5
[   49.509213] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.509216] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.509294] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.509562] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.509645] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.509648] mmc0:     4096 bytes transferred: 0
[   49.509652] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.509752] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.509756] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200930
flags 000000b5
[   49.509761] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.509764] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.509842] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.510111] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.510193] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.510196] mmc0:     4096 bytes transferred: 0
[   49.510200] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.510300] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.510304] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200938
flags 000000b5
[   49.510309] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.510312] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.510389] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.510658] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.510752] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.510755] mmc0:     4096 bytes transferred: 0
[   49.510760] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.510860] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.510864] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200940
flags 000000b5
[   49.510869] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.510873] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.510957] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.511226] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.511320] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.511323] mmc0:     4096 bytes transferred: 0
[   49.511327] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.511428] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.511432] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200948
flags 000000b5
[   49.511437] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.511440] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.511520] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.511793] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.511887] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.511890] mmc0:     4096 bytes transferred: 0
[   49.511894] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.512000] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.512004] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200950
flags 000000b5
[   49.512009] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.512012] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.512092] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.512365] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.512460] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.512463] mmc0:     4096 bytes transferred: 0
[   49.512467] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.512565] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.512569] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200958
flags 000000b5
[   49.512574] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.512578] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.512658] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.512931] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.513025] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.513029] mmc0:     4096 bytes transferred: 0
[   49.513032] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.513132] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.513137] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200960
flags 000000b5
[   49.513141] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.513145] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.513224] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.513498] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.513536] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.513539] mmc0:     4096 bytes transferred: 0
[   49.513543] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.513644] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.513649] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200968
flags 000000b5
[   49.513653] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.513657] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.513704] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.513977] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.514015] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.514018] mmc0:     4096 bytes transferred: 0
[   49.514022] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.514123] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.514127] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200970
flags 000000b5
[   49.514132] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.514135] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.514183] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.514458] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.514505] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.514508] mmc0:     4096 bytes transferred: 0
[   49.514513] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.514620] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.514624] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200978
flags 000000b5
[   49.514629] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.514632] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.514683] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.514957] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.515000] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.515004] mmc0:     4096 bytes transferred: 0
[   49.515008] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.515115] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.515119] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200980
flags 000000b5
[   49.515124] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.515128] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.515175] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.515448] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.515530] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.515533] mmc0:     4096 bytes transferred: 0
[   49.515537] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.515642] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.515646] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200988
flags 000000b5
[   49.515651] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.515654] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.515728] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.516001] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.516083] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.516086] mmc0:     4096 bytes transferred: 0
[   49.516090] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.516196] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.516200] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200990
flags 000000b5
[   49.516205] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.516208] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.516280] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.516554] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.516629] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.516633] mmc0:     4096 bytes transferred: 0
[   49.516636] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.516740] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.516745] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200998
flags 000000b5
[   49.516750] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.516753] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.516826] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.517100] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.517182] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.517185] mmc0:     4096 bytes transferred: 0
[   49.517189] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.517295] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.517299] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009a0
flags 000000b5
[   49.517304] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.517307] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.517380] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.517653] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.517736] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.517739] mmc0:     4096 bytes transferred: 0
[   49.517743] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.517849] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.517854] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009a8
flags 000000b5
[   49.517858] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.517862] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.517930] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.518203] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.518279] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.518282] mmc0:     4096 bytes transferred: 0
[   49.518286] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.518392] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.518397] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009b0
flags 000000b5
[   49.518402] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.518405] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.518477] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.518751] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.518846] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.518849] mmc0:     4096 bytes transferred: 0
[   49.518853] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.518961] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.518965] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009b8
flags 000000b5
[   49.518970] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.518973] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.519054] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.519328] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.519423] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.519426] mmc0:     4096 bytes transferred: 0
[   49.519430] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.519540] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.519544] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009c0
flags 000000b5
[   49.519549] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.519552] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.519632] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.519905] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.520000] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.520003] mmc0:     4096 bytes transferred: 0
[   49.520007] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.520110] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.520114] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009c8
flags 000000b5
[   49.520119] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.520123] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.520203] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.520480] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.520575] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.520578] mmc0:     4096 bytes transferred: 0
[   49.520582] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.520687] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.520692] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009d0
flags 000000b5
[   49.520696] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.520700] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.520779] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.521054] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.521150] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.521153] mmc0:     4096 bytes transferred: 0
[   49.521157] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.521263] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.521267] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009d8
flags 000000b5
[   49.521272] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.521275] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.521354] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.521630] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.521668] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.521671] mmc0:     4096 bytes transferred: 0
[   49.521675] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.521782] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.521787] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009e0
flags 000000b5
[   49.521792] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.521795] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.521843] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.522116] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.522152] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.522155] mmc0:     4096 bytes transferred: 0
[   49.522159] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.522268] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.522272] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009e8
flags 000000b5
[   49.522277] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.522280] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.522328] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.522601] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.522634] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.522637] mmc0:     4096 bytes transferred: 0
[   49.522641] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.522748] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.522752] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009f0
flags 000000b5
[   49.522757] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.522760] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.522809] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.523083] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.523126] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.523129] mmc0:     4096 bytes transferred: 0
[   49.523133] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.523240] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.523244] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 002009f8
flags 000000b5
[   49.523249] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.523252] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.523302] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.523576] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.523658] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.523661] mmc0:     4096 bytes transferred: 0
[   49.523666] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.523774] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.523778] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b00
flags 000000b5
[   49.523783] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.523786] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.523859] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.524132] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.524215] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.524218] mmc0:     4096 bytes transferred: 0
[   49.524222] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.524345] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.524349] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b08
flags 000000b5
[   49.524354] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.524357] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.524430] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.524705] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.524788] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.524791] mmc0:     4096 bytes transferred: 0
[   49.524795] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.524901] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.524906] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b10
flags 000000b5
[   49.524911] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.524914] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.524988] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.525263] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.525345] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.525348] mmc0:     4096 bytes transferred: 0
[   49.525351] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.525458] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.525463] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b18
flags 000000b5
[   49.525467] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.525471] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.525543] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.525818] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.525900] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.525903] mmc0:     4096 bytes transferred: 0
[   49.525907] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.526021] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.526025] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b20
flags 000000b5
[   49.526030] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.526033] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.526103] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.526376] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.526452] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.526455] mmc0:     4096 bytes transferred: 0
[   49.526459] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.526570] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.526574] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b28
flags 000000b5
[   49.526579] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.526582] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.526655] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.526929] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.527006] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.527009] mmc0:     4096 bytes transferred: 0
[   49.527013] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.527117] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.527121] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b30
flags 000000b5
[   49.527126] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.527129] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.527202] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.527478] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.527572] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.527575] mmc0:     4096 bytes transferred: 0
[   49.527579] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.527683] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.527687] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b38
flags 000000b5
[   49.527692] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.527695] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.527775] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.528050] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.528144] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.528147] mmc0:     4096 bytes transferred: 0
[   49.528151] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.528256] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.528261] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b40
flags 000000b5
[   49.528266] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.528269] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.528350] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.528623] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.528717] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.528720] mmc0:     4096 bytes transferred: 0
[   49.528724] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.528829] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.528834] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b48
flags 000000b5
[   49.528839] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.528842] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.528922] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.529195] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.529290] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.529293] mmc0:     4096 bytes transferred: 0
[   49.529297] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.529402] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.529406] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b50
flags 000000b5
[   49.529411] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.529415] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.529495] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.529769] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.529863] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.529866] mmc0:     4096 bytes transferred: 0
[   49.529870] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.529976] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.529980] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b58
flags 000000b5
[   49.529985] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.529988] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.530068] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.530343] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.530385] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.530388] mmc0:     4096 bytes transferred: 0
[   49.530392] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.530495] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.530499] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b60
flags 000000b5
[   49.530504] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.530507] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.530548] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.530820] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.530863] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.530867] mmc0:     4096 bytes transferred: 0
[   49.530871] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.530972] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.530976] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b68
flags 000000b5
[   49.530981] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.530984] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.531032] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.531304] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.531348] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.531351] mmc0:     4096 bytes transferred: 0
[   49.531355] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.531457] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.531461] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b70
flags 000000b5
[   49.531466] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.531469] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.531513] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.531787] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.531829] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.531832] mmc0:     4096 bytes transferred: 0
[   49.531836] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.531938] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.531943] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b78
flags 000000b5
[   49.531948] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.531951] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.531990] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.532264] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.532341] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.532344] mmc0:     4096 bytes transferred: 0
[   49.532348] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.532449] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.532454] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b80
flags 000000b5
[   49.532458] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.532462] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.532534] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.532807] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.532888] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.532891] mmc0:     4096 bytes transferred: 0
[   49.532896] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.532998] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.533002] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b88
flags 000000b5
[   49.533007] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.533010] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.533084] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.533357] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.533440] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.533443] mmc0:     4096 bytes transferred: 0
[   49.533447] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.533549] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.533553] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b90
flags 000000b5
[   49.533558] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.533561] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.533632] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.533906] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.534001] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.534004] mmc0:     4096 bytes transferred: 0
[   49.534007] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.534114] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.534118] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200b98
flags 000000b5
[   49.534123] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.534126] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.534206] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.534485] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.534581] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.534584] mmc0:     4096 bytes transferred: 0
[   49.534588] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.534606] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.534610] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000880
flags 000000b5
[   49.534615] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.534618] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.534700] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.534974] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.535070] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.535073] mmc0:     4096 bytes transferred: 0
[   49.535077] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.535094] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.535098] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200ba0
flags 000000b5
[   49.535103] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.535106] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.535187] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.535461] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.535557] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.535560] mmc0:     4096 bytes transferred: 0
[   49.535564] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.535582] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.535585] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000840
flags 000000b5
[   49.535590] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.535593] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.535676] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.535948] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.536044] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.536047] mmc0:     4096 bytes transferred: 0
[   49.536051] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.536068] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.536072] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200ba8
flags 000000b5
[   49.536077] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.536080] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.536162] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.536436] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.536532] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.536535] mmc0:     4096 bytes transferred: 0
[   49.536539] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.536556] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.536560] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000900
flags 000000b5
[   49.536565] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.536568] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.536649] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.536923] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.536973] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.536976] mmc0:     4096 bytes transferred: 0
[   49.536980] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.536998] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.537002] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bb0
flags 000000b5
[   49.537006] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.537010] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.537061] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.537336] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.537376] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.537379] mmc0:     4096 bytes transferred: 0
[   49.537383] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.537400] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.537404] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000908
flags 000000b5
[   49.537409] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.537412] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.537464] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.537737] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.537789] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.537792] mmc0:     4096 bytes transferred: 0
[   49.537796] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.537813] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.537817] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bb8
flags 000000b5
[   49.537822] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.537826] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.537876] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.538150] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.538193] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.538196] mmc0:     4096 bytes transferred: 0
[   49.538200] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.538217] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.538220] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000910
flags 000000b5
[   49.538225] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.538228] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.538276] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.538550] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.538593] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.538597] mmc0:     4096 bytes transferred: 0
[   49.538600] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.538617] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.538622] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bc0
flags 000000b5
[   49.538627] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.538630] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.538705] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.538978] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.539061] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.539064] mmc0:     4096 bytes transferred: 0
[   49.539069] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.539087] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.539091] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000918
flags 000000b5
[   49.539096] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.539099] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.539166] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.539441] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.539514] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.539517] mmc0:     4096 bytes transferred: 0
[   49.539521] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.539538] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.539542] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bc8
flags 000000b5
[   49.539546] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.539550] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.539626] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.539900] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.539980] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.539984] mmc0:     4096 bytes transferred: 0
[   49.539988] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.540004] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.540008] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000920
flags 000000b5
[   49.540013] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.540016] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.540090] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.540364] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.540448] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.540451] mmc0:     4096 bytes transferred: 0
[   49.540455] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.540472] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.540476] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bd0
flags 000000b5
[   49.540480] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.540484] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.540554] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.540829] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.540903] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.540906] mmc0:     4096 bytes transferred: 0
[   49.540910] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.540928] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.540931] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000928
flags 000000b5
[   49.540936] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.540939] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.541013] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.541286] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.541369] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.541372] mmc0:     4096 bytes transferred: 0
[   49.541376] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.541393] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.541397] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bd8
flags 000000b5
[   49.541402] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.541405] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.541479] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.541755] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.541838] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.541841] mmc0:     4096 bytes transferred: 0
[   49.541845] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.541862] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.541866] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000930
flags 000000b5
[   49.541871] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.541874] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.541944] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.542218] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.542313] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.542317] mmc0:     4096 bytes transferred: 0
[   49.542321] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.542338] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.542342] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200be0
flags 000000b5
[   49.542347] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.542350] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.542433] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.542707] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.542802] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.542806] mmc0:     4096 bytes transferred: 0
[   49.542810] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.542827] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.542831] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000938
flags 000000b5
[   49.542836] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.542839] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.542921] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.543195] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.543290] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.543293] mmc0:     4096 bytes transferred: 0
[   49.543297] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.543315] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.543319] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200be8
flags 000000b5
[   49.543324] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.543327] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.543408] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.543682] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.543777] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.543780] mmc0:     4096 bytes transferred: 0
[   49.543785] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.543801] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.543805] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000940
flags 000000b5
[   49.543810] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.543813] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.543894] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.544168] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.544264] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.544267] mmc0:     4096 bytes transferred: 0
[   49.544271] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.544288] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.544310] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bf0
flags 000000b5
[   49.544315] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.544319] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.544401] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.544676] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.544772] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.544775] mmc0:     4096 bytes transferred: 0
[   49.544779] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.544795] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.544799] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000948
flags 000000b5
[   49.544804] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.544807] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.544888] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.545162] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.545205] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.545208] mmc0:     4096 bytes transferred: 0
[   49.545212] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.545229] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.545234] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200bf8
flags 000000b5
[   49.545238] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.545241] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.545293] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.545568] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.545611] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.545614] mmc0:     4096 bytes transferred: 0
[   49.545618] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.545634] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.545638] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000950
flags 000000b5
[   49.545643] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.545646] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.545693] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.545968] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.546018] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.546022] mmc0:     4096 bytes transferred: 0
[   49.546026] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.546043] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.546047] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200a00
flags 000000b5
[   49.546052] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.546056] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.546104] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.546378] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.546417] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.546421] mmc0:     4096 bytes transferred: 0
[   49.546425] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.546442] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.546446] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000958
flags 000000b5
[   49.546451] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.546455] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.546504] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.546779] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.546825] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.546828] mmc0:     4096 bytes transferred: 0
[   49.546832] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.546849] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.546853] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00200820
flags 000000b5
[   49.546858] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.546861] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.546912] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.547186] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.547269] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.547272] mmc0:     4096 bytes transferred: 0
[   49.547276] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.547293] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.547297] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000960
flags 000000b5
[   49.547301] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.547305] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.547373] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.547646] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.547720] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.547723] mmc0:     4096 bytes transferred: 0
[   49.547727] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.547744] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.547748] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00201800
flags 000000b5
[   49.547753] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.547756] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.547830] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.548103] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.548186] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.548189] mmc0:     4096 bytes transferred: 0
[   49.548193] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.548211] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.548215] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000968
flags 000000b5
[   49.548220] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.548223] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.548297] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.548571] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.548658] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.548661] mmc0:     4096 bytes transferred: 0
[   49.548665] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.548780] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.548784] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000000
flags 000000b5
[   49.548789] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.548792] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.548869] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.549193] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.549276] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.549279] mmc0:     4096 bytes transferred: 0
[   49.549283] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.549301] <mmc0: starting SET_BLOCK_COUNT(CMD23) arg 00000008
flags 00000015>
[   49.549305] mmc0: starting READ_MULTIPLE_BLOCK(CMD18) arg 00000970
flags 000000b5
[   49.549310] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[   49.549313] mmc0:     CMD12 arg 00000000 flags 0000049d
[   49.549389] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.549663] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   49.549748] mmc0: req done (READ_MULTIPLE_BLOCK(CMD18)): 0:
00000900 00000000 00000000 00000000
[   49.549751] mmc0:     4096 bytes transferred: 0
[   49.549755] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   49.552274] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   49.552300] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.552314] mmc0: req done (SEND_STATUS(CMD13)): 0: 00000900
00000000 00000000 00000000
[   49.552347] mmc0: starting SWITCH(CMD6) arg 03b30301 flags 0000049d
[   49.552368] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   49.552380] mmc0: req done (SWITCH(CMD6)): 0: 00000800 00000000
00000000 00000000
[   49.552397] mmc0: starting SEND_STATUS(CMD13) arg 00010000 flags 00000195
[   59.574307] mmc0: Timeout waiting for hardware interrupt.
[   59.581457] sdhci: =========== REGISTER DUMP (mmc0)===========
[   59.589017] sdhci: Sys addr: 0x2cb4e000 | Version:  0x00000002
[   59.596581] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[   59.604124] sdhci: Argument: 0x00010000 | Trn mode: 0x00000000
[   59.611682] sdhci: Present:  0xff8d8089 | Host ctl: 0x0000002b
[   59.619214] sdhci: Power:    0x00000001 | Blk gap:  0x00000080
[   59.626732] sdhci: Wake-up:  0x00000000 | Clock:    0x0000011f
[   59.634241] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[   59.641729] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[   59.649211] sdhci: AC12 err: 0x00000082 | Slot int: 0x00000003
[   59.656679] sdhci: Caps:     0x07eb0000 | Caps_1:   0x08100810
[   59.664143] sdhci: Cmd:      0x00000d1a | Max curr: 0x000000b3
[   59.671589] sdhci: Host ctl2: 0x00000000
[   59.677145] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x2d885008
[   59.684605] sdhci: ===========================================
[   59.692140] mmc0: req failed (SEND_STATUS(CMD13)): -110, retrying...

thanks
--
Christian Gmeiner, MSc
