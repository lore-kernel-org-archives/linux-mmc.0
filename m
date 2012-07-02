From: Roland Stigge <stigge@antcom.de>
Subject: mmci.c regression
Date: Mon, 02 Jul 2012 14:14:26 +0200
Message-ID: <4FF190A2.6@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:53104 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab2GBMOa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jul 2012 08:14:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: rmk+kernel@arm.linux.org.uk, Grant Likely <grant.likely@secretlab.ca>, cjb@laptop.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Hi,

I'm getting a strange regression with mmci.c at v3.5-rc4 -> v3.5-rc5: Bootup:

v3.5-rc4:

mmci-pl18x 20098000.sd: mmc0: PL180 manf 41 rev0 at 0x20098000 irq 15,13 (pio)
mmci-pl18x 20098000.sd: no DMA platform data
mmc0: new SD card at address bd34
mmcblk0: mmc0:bd34 SD02G 1.83 GiB 
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
mmcblk0: retrying using single block read
 mmcblk0: p1

v3.5-rc5:

mmci-pl18x 20098000.sd: mmc0: PL180 manf 41 rev0 at 0x20098000 irq 15,13 (pio)
mmci-pl18x 20098000.sd: no DMA platform data
mmc0: new SD card at address bd34
mmcblk0: mmc0:bd34 SD02G 1.83 GiB 
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x0, card status 0x900
mmcblk0: retrying using single block read
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x0, card status 0x0
end_request: I/O error, dev mmcblk0, sector 0
mmcblk0: error -5 transferring data, sector 1, nr 7, cmd response 0x0, card status 0x0
end_request: I/O error, dev mmcblk0, sector 1
mmcblk0: error -5 transferring data, sector 2, nr 6, cmd response 0x0, card status 0x0
end_request: I/O error, dev mmcblk0, sector 2
Buffer I/O error on device mmcblk0, logical block 0
 mmcblk0: unable to read partition table

This happens on bootup with _some_ cards that already have the "error -5" in v3.5-rc4. This
was ok where up to v3.5-rc4, it worked on a subsequent retry as above. Unfortunately, it
now fails with v3.5-rc5.

Unfortunately, I can't see a relevant change in the mmci driver or mmc host code.
An indirect timing issue on bootup?

Inserting cards _after_ bootup generally works. SoC is LPC32XX.

Thanks in advance.

Roland
