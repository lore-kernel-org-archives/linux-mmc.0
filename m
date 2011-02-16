From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 16 Feb 2011 16:59:18 +0100
Message-ID: <201102161659.18475.arnd@arndb.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com> <20110215172948.GE10770@pengutronix.de> <20110216202818.GA11467@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53738 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1BPQAC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 11:00:02 -0500
In-Reply-To: <20110216202818.GA11467@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@karo-electronics.de

On Wednesday 16 February 2011, Shawn Guo wrote:
> It's caused by spinlock recursion introduced by mxs-dma functions
> mxs_dma_tx_submit and mxs_dma_tasklet.  We have mmc_request_done
> invoked in the dma callback tasklet.  At the meantime,
> mmc_request_done will issue retries in some case, which will call in
> mxs_dma_tx_submit.
> 
> I added the lock by referring to other dma driver implementation, but
> now I'm considering to remove the lock completely, as I do not see
> any global data needs to be protected there.  Comments?

You need to be sure that the data accessed in the tasklet does not
need to be locked against mxs_dma_tx_submit.

I haven't looked at the dmaengine code for this, but it's quite likely
that you actually need it, because you need to serialize adding an
element to the DMA device with removing it again.

Also, since the lock is taken in a tasklet, every thread that takes
it outside of a tasklet must do spin_lock_bh(), not spin_lock(), to
prevent the tasklet from running.

	Arnd
