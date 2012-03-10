From: harvey yang <harvey.huawei.yang@gmail.com>
Subject: [PROBLEM]sdhci:adma error with CMD 53
Date: Sat, 10 Mar 2012 17:15:27 +0800
Message-ID: <CAFCUKTTCKzEMsutq5f5jTt_kfs9FKc3mMd4_xesxL3r+rQJFTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47706 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab2CJJP1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Mar 2012 04:15:27 -0500
Received: by dajr28 with SMTP id r28so2490756daj.19
        for <linux-mmc@vger.kernel.org>; Sat, 10 Mar 2012 01:15:27 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all
I fail to download firmware to a wifi card with SDIO interface, the
following is debug log:


*********************************************************************************************************************
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00108000
mmc1: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc1:     0 bytes transferred: -110
mwifiex_sdio mmc1:0001:1: read mp_regs failed
mmc1: starting CMD52 arg 1000c000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD52 arg 1000c200 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD52 arg 1000c000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD52 arg 10006000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 0000100d 00000000 00000000 00000000
mmc1: starting CMD52 arg 10008000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001010 00000000 00000000 00000000
mmc1: starting CMD52 arg 10008200 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD53 arg 92000100 flags 000001b5
mmc1:     blksz 256 blocks 1 flags 00000100 tsac 1000 ms nsac 0
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x02000001
mmc1: ADMA error
sdhci: =========== REGISTER DUMP (mmc1)===========
sdhci: Sys addr: 0x5fb23900 | Version:  0x00000401
sdhci: Blk size: 0x00007100 | Blk cnt:  0x00000001
sdhci: Argument: 0x92000100 | Trn mode: 0x00000003
sdhci: Present:  0x01fa3106 | Host ctl: 0x00000013
sdhci: Power:    0x0000000e | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x0000020f
sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
sdhci: Int enab: 0x02ff010b | Sig enab: 0x02ff010b
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x05e80080 | Caps_1:   0x00000000
sdhci: Cmd:      0x0000353a | Max curr: 0x00000000
sdhci: Host ctl2: 0x00000000
sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x5f8c3800
sdhci: ===========================================
sdhci [sdhci_show_adma_error()]: mmc1: cf8c3800: DMA 0x5fb09000, LEN 0x0100, At3
mmc1: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc1:     0 bytes transferred: -5
mwifiex_sdio mmc1:0001:1: FW download, write iomem (0) failed @ 0
mmc1: starting CMD52 arg 90000004 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001004 00000000 00000000 00000000
mwifiex_sdio mmc1:0001:1: prog_fw failed ret=0xffffffff
mwifiex: mwifiex_add_card: firmware init failed
SDIO: Disabling IRQ for mmc1:0001:1...
mmc1: IRQ thread exiting with code 1
mmc1: starting CMD52 arg 00000800 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001003 00000000 00000000 00000000
mmc1: starting CMD52 arg 80000800 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
SDIO: Disabling device mmc1:0001:1...
mmc1: starting CMD52 arg 00000400 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001002 00000000 00000000 00000000
mmc1: starting CMD52 arg 80000400 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
SDIO: Disabled device mmc1:0001:1
mwifiex_sdio: mwifiex_sdio_probe: add card failed
SDIO: Disabling device mmc1:0001:1...
mmc1: starting CMD52 arg 00000400 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD52 arg 80000400 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
SDIO: Disabled device mmc1:0001:1
mwifiex_sdio: probe of mmc1:0001:1 failed with error -1
*******************************************************************************************************************************
I have no idea about that , it worked fine just two days ago. I wonder
if it is due to broken hardware.

Thanks,
Harvey
