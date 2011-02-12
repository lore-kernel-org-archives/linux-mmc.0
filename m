From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 22:04:19 +0800
Message-ID: <20110212140417.GA9821@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <201102111651.35530.arnd@arndb.de>
 <20110212005506.GE9289@S2100-06.ap.freescale.net>
 <201102112104.23643.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.185]:35710
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab1BLGFK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 01:05:10 -0500
Received: from mail200-ch1 (localhost.localdomain [127.0.0.1])	by
 mail200-ch1-R.bigfish.com (Postfix) with ESMTP id 9BC40700273	for
 <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 06:05:08 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail200-ch1.bigfish.com (Postfix) with ESMTP id
 349634C004B	for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 06:05:08 +0000
 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1C650Mt002401	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 23:05:00
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1C64xN7028490	for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 00:04:59
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <201102112104.23643.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Fri, Feb 11, 2011 at 09:04:23PM +0100, Arnd Bergmann wrote:
> On Saturday 12 February 2011 01:55:07 Shawn Guo wrote:
> > On Fri, Feb 11, 2011 at 04:51:35PM +0100, Arnd Bergmann wrote:
> > > I have not looked much at other dmaengine drivers, but I'd be
> > > surprised if they require the device driver to be written
> > > for a specific implementation. If that was the case, you would
> > > not even need a dmaengine API but could just as well write
> > > to the DMA controller registers from the device driver directly.
> > > 
> > We need a specific implementation, but it's not so specific that we
> > have to access dma controller directly.  Even it is, we still need
> > an API/interface, as there are so many client devices need to do the
> > same thing, right? ;)
> 
> I looked at all mmc drivers that use the dmaengine API: 
> atmel-mci.c does the same as what you propose here, while sh_mmcif.c

Actually, it's not me who propose the implementation.  Sascha sent a
patch (under review) to change mxcmmc.c to use generic damengine api
several weeks ago.  I followed that as the example.

> and tmio_mmc.c more or less do what I'm suggesting you do instead.
> 
> Looking at sh_mmcif:
> 
>       host->chan_tx = dma_request_channel(mask, sh_mmcif_filter,
>                                           &pdata->dma->chan_priv_tx);
> 
> 
> This is the only place where dma engine specific data is used
> in the driver, and chan_priv_tx is part of the platform data, so the
> mmc driver can simply pass it down as a void pointer without knowing
> the type. The platform data as defined in the machine file ties
> both the dma controller and the mmc device together, but neither
> of the two drivers needs to know anything about the implementation
> of the other.
> 
Not really.  Though mmc does not need to know anything about dma
driver, dma knows that mmc driver has to pass .slave_id via
chan->private.  The snippet below is copied from shdma.

	struct sh_dmae_slave_config {
		unsigned int                    slave_id;
		dma_addr_t                      addr;
		u32                             chcr;
		char                            mid_rid;
	};
---
        if (chan->private) {
                /* The caller is holding dma_list_mutex */
                struct sh_dmae_slave *param = chan->private;
                clear_bit(param->slave_id, sh_dmae_slave_used);
        }

And it only works when slave_id is the first member of
sh_dmae_slave_config.

For me, it's more natural to define device's dma related things like
dma channel id and irq as its resources than platform data.  So I
still maintain the current approach.

Regards,
Shawn

