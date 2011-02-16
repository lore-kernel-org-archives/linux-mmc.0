From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 16 Feb 2011 16:33:32 +0100
Message-ID: <20110216153332.GC6365@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
 <20110214165958.GH10709@pengutronix.de>
 <20110215223941.GJ10990@S2100-06.ap.freescale.net>
 <20110215171341.GD10770@pengutronix.de>
 <20110215171917.GQ4152@n2100.arm.linux.org.uk>
 <20110215172948.GE10770@pengutronix.de>
 <20110216202818.GA11467@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60980 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab1BPPdm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 10:33:42 -0500
Content-Disposition: inline
In-Reply-To: <20110216202818.GA11467@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, arnd@arndb.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de

Hi Shawn,

[CRC failures on MMC]
> I guess you will also get the unknown partition table message if you
> test this card on mx35 right now.

No, I didn't see that message on MX35. (Doesn't matter much now).

> I just tested 7 mmc cards in total.  6 cards work fine, and 1 card
> (Transcend MMC plus 1GB) has the exactly same problem as yours. And
> if I remove the 8 bit cap, this card also works fine.  So I would
> agree with Russell that it's unrelated to the driver.

Ah, the 8_BIT_CAP was the right pointer. It works now and I can see the
partitions \o/ But IMHO it is related to the driver because it cannot set that
8_BIT_DATA_CAP unconditionally? Probably something like 'flags' should be added
to platform_data? One flag could then be 8_BIT_CAPABLE_SLOT or something.

> I tested the SDIO, but probably in different way from yours.  I had
> two card slots on my board, rootfs on mmc0 and SDIO card on mmc1.
> It seems working fine in this way.  However, when I use nfs and test
> SDIO on mmc0, my systems hangs too.  I will look into it.

The latter scenario is the only one I can test, because I don't have an
(active) second slot.

Thanks for keeping up with the driver!

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
