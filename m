From: Timo Teras <timo.teras@iki.fi>
Subject: error -110 sending stop command
Date: Tue, 24 May 2016 09:37:46 +0300
Message-ID: <20160524093747.12bfe046@vostro.util.wtbts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36354 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbcEXGhz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2016 02:37:55 -0400
Received: by mail-lf0-f52.google.com with SMTP id e130so2417853lfe.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2016 23:37:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Richard Ash <richardashaudacity@googlemail.com>, Tor Krill <tor@openproducts.com>

Hi,

I'm having the following errors on my SD-card when writing to them:

mmc0: Timeout waiting for hardware interrupt.
mmcblk0: error -110 sending stop command, original cmd response 0x900,
card status 0x400e00

Basically this happens when writing to the SD, and after this the
SD-card becomes unusable.

After this, the kernel [mmcqd/0] task is hogging CPU, and mmc0
interrupts are coming in at very fast pace (seems 10k+ interrupts
per second). Waiting long enough the following messages appear too:

[  896.871617] mmc0: Card stuck in programming state! mmcblk0 card_busy_detect
[  898.235070] mmc0: card never left busy state
[  898.235078] mmc0: tried to reset card
[  898.235087] blk_update_request: I/O error, dev mmcblk0, sector 16384
[  898.235098] Buffer I/O error on dev mmcblk0p1, logical block 8192, lost async page write
[  898.235107] blk_update_request: I/O error, dev mmcblk0, sector 16385
[  898.235114] Buffer I/O error on dev mmcblk0p1, logical block 8193, lost async page write
[  898.237103] mmcblk0: error -110 sending status command, retrying
[  898.238069] mmcblk0: error -110 sending status command, retrying
[  898.239057] mmcblk0: error -110 sending status command, aborting

After which the SD does not work at all until reboot.

This is pretty much what Richard Ash described in the thread 'error -110
sending stop command' on Zynq platform. Also the thread 'Unstable mmc
operation on armada38x' from Tor Krill looks the same issue.

The hardware I have is http://www.pcengines.ch/apu2c4.htm and on bootup
dmesg says:
[    3.082221] sdhci: Secure Digital Host Controller Interface driver
[    3.082228] sdhci: Copyright(c) Pierre Ossman
[    3.083135] sdhci-pci 0000:00:14.7: SDHCI controller found [1022:7813] (rev 1)
[    3.083495] sdhci-pci 0000:00:14.7: No vmmc regulator found
[    3.083503] sdhci-pci 0000:00:14.7: No vqmmc regulator found
[    3.084994] mmc0: SDHCI controller on PCI [0000:00:14.7] using ADMA 64-bit
[    3.156461] mmc0: new high speed SDHC card at address 0007
[    3.347692] mmcblk0: mmc0:0007 SD04G 3.71 GiB 
[    3.349924]  mmcblk0: p1

I have verified that this issues exist in 4.1.20 and 4.4.10.

Any suggestions how to debug this further? Perhaps some quirks to test?
Or already committed patches/fixes that might resolve this issue?

Thanks,
Timo
