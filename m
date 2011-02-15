From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 15 Feb 2011 18:13:41 +0100
Message-ID: <20110215171341.GD10770@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
 <20110214165958.GH10709@pengutronix.de>
 <20110215223941.GJ10990@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56745 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab1BORNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 12:13:47 -0500
Content-Disposition: inline
In-Reply-To: <20110215223941.GJ10990@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


> Ah, yes.  I can also see the problem here after turning on
> DEBUG_SPINLOCK.

Ah, okay. After turning it off, it works a lot better :)

SD seems to work:

	mmc0: new high speed SD card at address b368
	mmcblk0: mmc0:b368 NCard 1.86 GiB 
	 mmcblk0: p1
	mmc0: card b368 removed

SDHC seems to work:

	mmc0: new high speed SDHC card at address 0007
	mmcblk0: mmc0:0007 SD04G 3.70 GiB 
	 mmcblk0: p1
	mmc0: card 0007 removed

MMC fails for me (note: the card works fine with an mx35-based board)

	mmc0: new high speed MMC card at address 0001
	mmcblk0: mmc0:0001 AF HMP 247 MiB 
	mmcblk0: retrying using single block read
	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 0
	mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 1
	mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 2
	mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 3
	mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 4
	mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 5
	mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 6
	mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 7
	Buffer I/O error on device mmcblk0, logical block 0
	mmcblk0: retrying using single block read
	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 0
	mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 1
	mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 2
	mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 3
	mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 4
	mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 5
	mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 6
	mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 7
	Buffer I/O error on device mmcblk0, logical block 0
	 mmcblk0: unable to read partition table
	mmc0: card 0001 removed

SDIO card locks the machine. Is it supposed to work already?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
