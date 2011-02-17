From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Thu, 17 Feb 2011 10:44:09 +0800
Message-ID: <20110217024408.GA1273@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <20110215172948.GE10770@pengutronix.de>
 <20110216202818.GA11467@S2100-06.ap.freescale.net>
 <201102161659.18475.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:31233
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755935Ab1BQCpO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 21:45:14 -0500
Received: from mail50-va3 (localhost.localdomain [127.0.0.1])	by
 mail50-va3-R.bigfish.com (Postfix) with ESMTP id 31BCA1500D7	for
 <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 02:45:12 +0000 (UTC)
Received: from VA3EHSMHS032.bigfish.com (unknown [10.7.14.236])	by
 mail50-va3.bigfish.com (Postfix) with ESMTP id 4CAF38B00AF	for
 <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 02:44:37 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1H2iUNH004037	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 19:44:30
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1H2iThc005574	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 20:44:30
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <201102161659.18475.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@karo-electronics.de

Hi Arnd,

On Wed, Feb 16, 2011 at 04:59:18PM +0100, Arnd Bergmann wrote:
> On Wednesday 16 February 2011, Shawn Guo wrote:
> > It's caused by spinlock recursion introduced by mxs-dma functions
> > mxs_dma_tx_submit and mxs_dma_tasklet.  We have mmc_request_done
> > invoked in the dma callback tasklet.  At the meantime,
> > mmc_request_done will issue retries in some case, which will call in
> > mxs_dma_tx_submit.
> > 
> > I added the lock by referring to other dma driver implementation, but
> > now I'm considering to remove the lock completely, as I do not see
> > any global data needs to be protected there.  Comments?
> 
> You need to be sure that the data accessed in the tasklet does not
> need to be locked against mxs_dma_tx_submit.
> 
The only thing we actually put in tasklet is just the callback
registered by client device driver, which should not have anything
that mxs_dma_tx_submit would concern.

> I haven't looked at the dmaengine code for this, but it's quite likely
> that you actually need it, because you need to serialize adding an
> element to the DMA device with removing it again.
> 
I'm not sure that I understand your comment. If the adding/removing
an element means what mxs_dma_alloc_chan_resources and 
mxs_dma_free_chan_resources do, I do not think it's a problem, as
client driver is calling them in probe/remove for once.

-- 
Regards,
Shawn

