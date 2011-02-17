From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Thu, 17 Feb 2011 12:17:14 +0800
Message-ID: <20110217041713.GB1273@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
 <20110214165958.GH10709@pengutronix.de>
 <20110215223941.GJ10990@S2100-06.ap.freescale.net>
 <20110215171341.GD10770@pengutronix.de>
 <20110215171917.GQ4152@n2100.arm.linux.org.uk>
 <20110215172948.GE10770@pengutronix.de>
 <20110216202818.GA11467@S2100-06.ap.freescale.net>
 <20110216153332.GC6365@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:43617
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1BQERn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 23:17:43 -0500
Received: from mail199-va3 (localhost.localdomain [127.0.0.1])	by
 mail199-va3-R.bigfish.com (Postfix) with ESMTP id 879EE1A280ED	for
 <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 04:17:42 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.240])	by
 mail199-va3.bigfish.com (Postfix) with ESMTP id 3118C1000050	for
 <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 04:17:42 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id p1H4HZWj022997	for
 <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 21:17:36 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1H4HYdS011293	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 22:17:35
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110216153332.GC6365@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, arnd@arndb.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de

Hi Wolfram,

On Wed, Feb 16, 2011 at 04:33:32PM +0100, Wolfram Sang wrote:
> Hi Shawn,
> 
> [CRC failures on MMC]
> > I guess you will also get the unknown partition table message if you
> > test this card on mx35 right now.
> 
> No, I didn't see that message on MX35. (Doesn't matter much now).
> 
> > I just tested 7 mmc cards in total.  6 cards work fine, and 1 card
> > (Transcend MMC plus 1GB) has the exactly same problem as yours. And
> > if I remove the 8 bit cap, this card also works fine.  So I would
> > agree with Russell that it's unrelated to the driver.
> 
> Ah, the 8_BIT_CAP was the right pointer. It works now and I can see the
> partitions \o/ But IMHO it is related to the driver because it cannot set that
> 8_BIT_DATA_CAP unconditionally? Probably something like 'flags' should be added
> to platform_data? One flag could then be 8_BIT_CAPABLE_SLOT or something.
> 
If a platform is designed to support 8-bit mode (e.g. all 8 data
lines are routed), I do not think the 8-bit cap will be removed from
this platform just because one particular card has problem to work
in 8-bit mode.

But I would anyway let platform_data tell the 4 BIT_CAP and 8_BIT_CAP
just like what Freescale BSP is doing, as some platforms may design
this cap differently.

> > I tested the SDIO, but probably in different way from yours.  I had
> > two card slots on my board, rootfs on mmc0 and SDIO card on mmc1.
> > It seems working fine in this way.  However, when I use nfs and test
> > SDIO on mmc0, my systems hangs too.  I will look into it.
> 
> The latter scenario is the only one I can test, because I don't have an
> (active) second slot.
> 
It's a board thing.  I just rechecked the schematics of mx28evk
board, and found that the power supply of the two slots are
different.  The mmc1 uses the external regulator REG_3V3 which can
supply up to 1.5 A current, while mmc0 uses mx28 internal regulator
VDDIO_3V3 which has very limited current capability.  That's why my
SDIO WiFi card works on mmc1 slot while hangs system on mmc0.  When
I reworked the board to supply mmc0 with REG_3V3, the card works on
mmc0 too.

So your board supplies mmc0 slot with VDDIO_3V3 as well?

-- 
Regards,
Shawn

