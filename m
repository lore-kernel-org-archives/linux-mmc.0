From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Thu, 6 Sep 2012 12:32:32 +0200
Message-ID: <20120906103232.GS26594@pengutronix.de>
References: <1346917248-6685-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56100 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461Ab2IFKci (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Sep 2012 06:32:38 -0400
Content-Disposition: inline
In-Reply-To: <1346917248-6685-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

On Thu, Sep 06, 2012 at 09:40:48AM +0200, Javier Martin wrote:
> The problem can be easily reproduced using a script that loops
> copying a file in an SD card to another place in the same SD card
> and its related to read transfers. This only happens with DMA enabled.
> 
> This is related to the fact that, when reading, an MMC irq signals
> the fact that all data from the SD card has been copied to the
> internal buffers. However, it doesn't signal whether the DMA transfer
> that is in charge of moving data from these internal buffers to RAM
> has finished or not. Thus, calling dmaengine_terminate_all() in the
> MMC irq routine can cancel an ongoing DMA transfer leaving some data
> in the internal buffers that produces an accumulative effect which,
> in the end, blocks a read data transfer forever.

Doesn't that mean that in case of a DMA read we just have to wait for
the DMA callback instead of the MMC irq? Something like:

static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
		unsigned int cmdat)
{
	...

	if (mxcmci_use_dma(host)) {
		if (host->dma_dir == DMA_FROM_DEVICE)
			setup_dma_callback();
		else
			int_cntr |= INT_WRITE_OP_DONE_EN;
	}

	...
}

That would be a cleaner solution I think.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
