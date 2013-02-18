From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle
 mode.
Date: Mon, 18 Feb 2013 13:42:27 +0100
Message-ID: <20130218124227.GA24607@blumentopf>
References: <20121220220444.GA350@blumentopf>
 <1356041532-919-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <20130110202203.GD14149@atomide.com>
 <512201DE.1070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:53458 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab3BRMmi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Feb 2013 07:42:38 -0500
Received: from mailout-de.gmx.net ([10.1.76.31]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MJ0Rb-1U9txM0A7l-002YyN for
 <linux-mmc@vger.kernel.org>; Mon, 18 Feb 2013 13:42:37 +0100
Content-Disposition: inline
In-Reply-To: <512201DE.1070001@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

Hi,

On Mon, Feb 18, 2013 at 11:26:38AM +0100, Daniel Mack wrote:
> On 10.01.2013 21:22, Tony Lindgren wrote:
> > * Andreas Fenkart <andreas.fenkart@streamunlimited.com> [121220 14:15]:
> >> Without functional clock the omap_hsmmc module can't forward
> >> SDIO IRQs to the system. This patch reconfigures dat1 line
> >> as a gpio while the fclk is off. And uses SDIO IRQ detection of
> >> the module, while fclk is present.
> > 
> > Looks pretty good to me, however I could not figure out what
> > to apply this on for testing. It fails to apply at least against
> > current linux next, can you please update against that?
> >  
> >> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> >> +{
> >> +	struct omap_hsmmc_host *host = mmc_priv(mmc);
> >> +	u32 irq_mask;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&host->irq_lock, flags);
> >> +
> >> +	host->sdio_irq_en = (enable != 0) ? true : false;
> >> +
> >> +	if (host->active_pinmux) {
> >> +		irq_mask = OMAP_HSMMC_READ(host->base, ISE);
> >> +		if (enable)
> >> +			irq_mask |= CIRQ_ENABLE;
> >> +		else
> >> +			irq_mask &= ~CIRQ_ENABLE;
> >> +		OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
> >> +
> >> +		if (!host->req_in_progress)
> >> +			OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> >> +
> >> +#if 0
> >> +		OMAP_HSMMC_READ(host->base, IE); /* flush posted write */
> >> +#endif
> > 
> > Maybe just replace #if 0 with just a comment in case it turns out to be
> > needed for some cases?
> 
> Is there any update on this series? Andreas, did you do more tests?

Thanks for all the feedback so far. Yes I did more testing. After
reducing the autosuspend delay, I found two more bugs.

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -138,7 +138,7 @@ static void apply_clk_hack(void)
 #define SOFTRESET              (1 << 1)
 #define RESETDONE              (1 << 0)

-#define MMC_AUTOSUSPEND_DELAY  100
+#define MMC_AUTOSUSPEND_DELAY  1
 #define MMC_TIMEOUT_MS         20

One is already fixed[1], the other I'm still working on.
Hope to progress this week, then need to redo the testing.
Plan is to resubmit latest next week.

Andi

