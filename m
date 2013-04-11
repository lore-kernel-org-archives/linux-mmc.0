From: Johannes Braun <jjo.braun@gmail.com>
Subject: arm: imx35: mmc0: "Timeout waiting for hardware interrupt" with
 various sdio wlan cards
Date: Thu, 11 Apr 2013 11:53:02 +0200
Message-ID: <CADwvPCurSFGpqjURs=ryv=wRD0WsvNyzJZ7JyVs0LaWo-idJ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:34475 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3DKJxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Apr 2013 05:53:04 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so730683iaf.4
        for <linux-mmc@vger.kernel.org>; Thu, 11 Apr 2013 02:53:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

our company built an embedded board which is based on the ARM
Freescale imx35 chip. Now I am trying to run a silex sdio wlan module
with this board. The Silex module is based on an atheros ar6003 chip.
The driver in /drivers/mmc/host/sdhci-esdhc-imx.c (config
MMC_SDHCI_ESDHC_IMX) is used for the imx35 processor. When I load the
module ath6kl_sdio.ko, I get the following error:
"mmc0: Timeout waiting for hardware interrupt".

Normal sdcards are working properly. The same timout error appears
also with another sdio wlan module which is based on a marvell chip.
Thats the reason why I don`t think that it`s an issue of the atheros
driver. I think it is an issue of the sdhci-esdhc-imx driver. I
searched in the web for a solution to fix it, but I had no success. I
hope someone can give me hint, what I can do to get sdio cards
working.

I enabled the logging for mmc and the following lines are the kernel messages.

sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87089e00, transferred
0x076200 bytes, next 0x87100000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
mmc0: starting CMD53 arg 10100080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x870c7200, transferred
0x038e00 bytes, next 0x87100000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 941f0080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000009
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87089c00, transferred
0x076400 bytes, next 0x87100000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
mmc0: starting CMD53 arg 10100080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x870c7400, transferred
0x038c00 bytes, next 0x87100000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 941f0080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000009
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87089e00, transferred
0x076200 bytes, next 0x87100000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
mmc0: starting CMD53 arg 10100080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x870c7600, transferred
0x038a00 bytes, next 0x87100000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 941f0080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000009
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87089c00, transferred
0x076400 bytes, next 0x87100000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
mmc0: starting CMD53 arg 10100080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87203c00, transferred
0x07c400 bytes, next 0x87280000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
mmc0: starting CMD53 arg 10100080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87087000, transferred
0x079000 bytes, next 0x87100000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 94083004 flags 000001b5
mmc0:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x871cdcac, transferred
0x032354 bytes, next 0x87200000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     4 bytes transferred: 0
mmc0: starting CMD53 arg 941f0080 flags 000001b5
mmc0:     blksz 128 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000009
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87089c00, transferred
0x076400 bytes, next 0x87100000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     128 bytes transferred: 0
mmc0: starting CMD53 arg 94083004 flags 000001b5
mmc0:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x871cdc74, transferred
0x03238c bytes, next 0x87200000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     4 bytes transferred: 0
SDIO: Enabling IRQ for mmc0:0001:1...
mmc0: starting CMD52 arg 00000800 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc0: starting CMD52 arg 80000803 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001003 00000000 00000000 00000000
mmc0: starting CMD53 arg 94083004 flags 000001b5
mmc0:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x871cdcb4, transferred
0x03234c bytes, next 0x87200000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     4 bytes transferred: 0
mmc0: IRQ thread started (poll period = 2147483647 jiffies)
mmc0: starting CMD52 arg 00000a00 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD52): 0: 00001002 00000000 00000000 00000000
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000b
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x87032da0, transferred
0x04d260 bytes, next 0x87080000
mmc0: req done (CMD53): 0: 00001000 00000000 00000000 00000000
mmc0:     24 bytes transferred: 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0
ath6kl: ar6003 hw 2.1.1 sdio fw 3.2.0.144 api 3
mmc0: Timeout waiting for hardware interrupt.
sdhci: =========== REGISTER DUMP (mmc0)===========
sdhci: Sys addr: 0x87029940 | Version:  0x00000000
sdhci: Blk size: 0x00000018 | Blk cnt:  0x00000000
sdhci: Argument: 0x14080018 | Trn mode: 0x00000013
sdhci: Present:  0xdd09028f | Host ctl: 0x0000002b
sdhci: Power:    0x00000001 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x0000010f
sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
sdhci: AC12 err: 0x00000000 | Slot int: 0x00001201
sdhci: Caps:     0x07eb0000 | Caps_1:   0x08100810
sdhci: Cmd:      0x0000353a | Max curr: 0x00000000
sdhci: Host ctl2: 0x00000000
sdhci: ===========================================
mmc0: req done (CMD53): 0: 00000000 00000000 00000000 00000000
mmc0:     0 bytes transferred: -110
------------[ cut here ]------------
WARNING: at drivers/net/wireless/ath/ath6kl/sdio.c:487
ath6kl_sdio_irq_handler+0x88/0x98 [ath6kl_sdio]()
Modules linked in: ath6kl_sdio(+) ath6kl_core lib80211 mac80211 cfg80211 ipv6
[<c00149fc>] (unwind_backtrace+0x0/0xfc) from [<c03a5114>]
(dump_stack+0x20/0x24)
[<c03a5114>] (dump_stack+0x20/0x24) from [<c001f15c>]
(warn_slowpath_common+0x5c/0x74)
[<c001f15c>] (warn_slowpath_common+0x5c/0x74) from [<c001f1a0>]
(warn_slowpath_null+0x2c/0x34)
[<c001f1a0>] (warn_slowpath_null+0x2c/0x34) from [<bf16c3b8>]
(ath6kl_sdio_irq_handler+0x88/0x98 [ath6kl_sdio])
[<bf16c3b8>] (ath6kl_sdio_irq_handler+0x88/0x98 [ath6kl_sdio]) from
[<c02cc1a0>] (sdio_irq_thread+0x1f8/0x2f4)
[<c02cc1a0>] (sdio_irq_thread+0x1f8/0x2f4) from [<c004175c>] (kthread+0xb4/0xc0)
[<c004175c>] (kthread+0xb4/0xc0) from [<c000e8a8>] (ret_from_fork+0x14/0x20)
---[ end trace f5bf3daf8b62ccd1 ]---
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
mmc0: starting CMD53 arg 14080018 flags 000001b5
mmc0:     blksz 24 blocks 1 flags 00000200 tsac 1000 ms nsac 0

---
Johannes
