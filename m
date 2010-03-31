From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ARM: MXC: mxcmmc: Teach the driver SDIO operations
Date: Wed, 31 Mar 2010 15:29:46 +0200
Message-ID: <20100331132946.GH30807@buzzloop.caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
 <1269973921-29611-2-git-send-email-daniel@caiaq.de>
 <20100331130339.GX2241@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:50202 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab0CaN3v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2010 09:29:51 -0400
Content-Disposition: inline
In-Reply-To: <20100331130339.GX2241@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Volker Ernst <volker.ernst@txtr.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Mar 31, 2010 at 03:03:39PM +0200, Sascha Hauer wrote:
> On Tue, Mar 30, 2010 at 08:32:00PM +0200, Daniel Mack wrote:
> > +static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> > +{
> > +	struct mxcmci_host *host = mmc_priv(mmc);
> > +	unsigned long flags;
> > +	u32 int_cntr;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	host->use_sdio = enable;
> > +	int_cntr = readl(host->base + MMC_REG_INT_CNTR);
> > +
> > +	if (enable)
> > +		int_cntr |= INT_SDIO_IRQ_EN;
> > +	else
> > +		int_cntr &= ~INT_SDIO_IRQ_EN;
> > +
> > +	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
> > +	spin_unlock_irqrestore(&host->lock, flags);
> 
> The other places where MMC_REG_INT_CNTR is touched should be protected
> by this spinlock aswell.

Hmm, all other place don't do a read/modify/write cycle, so I'd say the
don't need protection?

Daniel
