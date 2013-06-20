From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in
 idle mode
Date: Thu, 20 Jun 2013 00:24:23 -0700
Message-ID: <20130620072422.GG5523@atomide.com>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214952.18581.90049.stgit@localhost>
 <CAPDyKFq+==Bca+AaZwD=A5v6HzL8ShKatq+8U-S=atZUFh8=rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61361 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab3FTHY3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2013 03:24:29 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFq+==Bca+AaZwD=A5v6HzL8ShKatq+8U-S=atZUFh8=rQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, cjb@laptop.org, Balaji T K <balajitk@ti.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [130614 04:55]:
> On 7 June 2013 23:49, Tony Lindgren <tony@atomide.com> wrote:
> > From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> > +{
> > +       struct omap_hsmmc_host *host = mmc_priv(mmc);
> > +       u32 irq_mask;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&host->irq_lock, flags);
> > +
> > +       if (host->sdio_irq_en == enable) {
> > +               dev_dbg(host->dev, "en/disable:%d already set", enable);
> > +               spin_unlock_irqrestore(&host->irq_lock, flags);
> > +               return;
> > +       }
> > +
> 
> Hi Tony/Andreas,
> 
> I belive a "pm_runtime_get_sync" would be needed here, outside the
> spinlock ofcourse. Before returning from this function, obviusly
> return the references by a pm_runtime_put* in some form.
> 
> Then you will be able to remove the "active_pinmux" variable entirely,
> since you know the runtime callbacks is the only place were you need
> to handle the gpio irq enable|disable.

Thanks for the review, that's a good point. I'll check this as
soon as I have a chance.

Regards,

Tony
