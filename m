From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Fri, 27 Sep 2013 08:38:59 +0200
Message-ID: <CALtMJEDKxTcaNHmrVqMv7tznxB0uqYxuOix+ks+Bs_huiOCL4A@mail.gmail.com>
References: <20130925234544.3745.55170.stgit@localhost>
	<20130925234740.3745.50637.stgit@localhost>
	<CALtMJEBKbbpM47uhM-KeSRHRkM5CJkgBx4kFq4j+GG9sKXEfag@mail.gmail.com>
	<20130926141936.GE8949@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130926141936.GE8949@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

2013/9/26 Tony Lindgren <tony@atomide.com>:
> Hi,
>
> * Andreas Fenkart <afenkart@gmail.com> [130926 01:34]:
>> 2013/9/26 Tony Lindgren <tony@atomide.com>:
>> > @@ -463,27 +469,34 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
>> >  static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>> >                                   struct mmc_command *cmd)
>> >  {
>> > -       unsigned int irq_mask;
>> > +       u32 irq_mask = INT_EN_MASK;
>> > +       unsigned long flags;
>> >
>> >         if (host->use_dma)
>> > -               irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
>> > -       else
>> > -               irq_mask = INT_EN_MASK;
>> > +               irq_mask &= ~(BRR_EN | BWR_EN);
>> >
>> >         /* Disable timeout for erases */
>> >         if (cmd->opcode == MMC_ERASE)
>> >                 irq_mask &= ~DTO_EN;
>> >
>> > +       spin_lock_irqsave(&host->irq_lock, flags);
>> >         OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>> >         OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>> > +       if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
>> > +               irq_mask |= CIRQ_EN;
>> >         OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>> > +       spin_unlock_irqrestore(&host->irq_lock, flags);
>> >  }
>> >
>> >  static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
>> >  {
>> > +       unsigned long flags;
>> > +
>> > +       spin_lock_irqsave(&host->irq_lock, flags);
>> >         OMAP_HSMMC_WRITE(host->base, ISE, 0);
>> >         OMAP_HSMMC_WRITE(host->base, IE, 0);
>> >         OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>
>> This is wrong. SDIO IRQ must not be disabled upon host initiated transfer.
>> see omap_hsmmc_request_done

It's what Balaji already pointed out.

+   /* no transfer running, need to signal cirq if */
+   if (host->sdio_irq_en)
+       irq_mask |= CIRQ_EN;


omap_hsmmc_request_done calls omap_hsmmc_disable_irq

imagine this case:
1. host issues transfer from host->card (e.g. get RSSI)
2. at end of this transfer, SDIO IRQ are being masked
3. card wants to reply, raises an SDIO IRQ
4. nothing happens, since in 2. SDIO IRQ are masked

I verified this with my 88W8787 card. It is a problem

>
>> > +       spin_unlock_irqrestore(&host->irq_lock, flags);
>> >  }
>> >
>> >  /* Calculate divisor for the given clock frequency */
>> > @@ -1040,8 +1053,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>> >         int status;
>> >
>> >         status = OMAP_HSMMC_READ(host->base, STAT);
>> > -       while (status & INT_EN_MASK && host->req_in_progress) {
>> > -               omap_hsmmc_do_irq(host, status);
>> > +       while (status & (INT_EN_MASK | CIRQ_EN)) {
>> > +               if (host->req_in_progress)
>> > +                       omap_hsmmc_do_irq(host, status);
>> > +
>> > +               if (status & CIRQ_EN)
>> > +                       mmc_signal_sdio_irq(host->mmc);
>> >
>> >                 /* Flush posted write */
>> >                 status = OMAP_HSMMC_READ(host->base, STAT);
>> > @@ -1556,6 +1573,43 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>> >                 mmc_slot(host).init_card(card);
>> >  }
>> >
>> > +static void omap_hsmmc_enable_sdio_irq_nolock(struct omap_hsmmc_host *host,
>> > +                                        int enable)
>> > +{
>> > +       u32 irq_mask;
>> > +
>> > +       if (enable)
>> > +               host->flags |= HSMMC_SDIO_IRQ_ENABLED;
>> > +       else
>> > +               host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
>> > +
>> > +       /* SDIO IRQ will be enabled as appropriate in runtime resume */
>> > +       if (host->flags & HSMMC_RUNTIME_SUSPENDED)
>> > +               goto out;
>>
>> Not sure here, will the module still come out of suspend even with
>> SDIO IRQ disabled?
>> Otherwise nak, sdio irq must enabled independent of pm runtime state. In the
>> worst case need pm_runtime_get().
>
> Well this handling is similar to what's done in sdhci.c and
> seems to work for me for off-idle on 3730. In that case the
> whole MMC block is powered off and the wake up follows the
> dedicated io chain path. For the am33xx off-idle case, the
> wake-up path would be remuxed to the GPIO in the first GPIO
> bank that's always on, so again the whole MMC block is off.

Something like this but shorter as a comment:

/*
 * Must not touch registers while fclk if off, otherwise SIGBUS.
 * Card will still wake up upon SDIO IRQ, and we'll complete
 * the request in pm_runtime_resume
 */

Another interpretation of your code could be:

/* Sorry I'm having Siesta right now, try later */

>
> Maybe try to test this with your case with some additional
> patches?
>
>> >  static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>> >  {
>> >         u32 hctl, capa, value;
>> > @@ -1608,7 +1662,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>> >         .get_cd = omap_hsmmc_get_cd,
>> >         .get_ro = omap_hsmmc_get_ro,
>> >         .init_card = omap_hsmmc_init_card,
>> > -       /* NYET -- enable_sdio_irq */
>> > +       .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>
>> What about am335x, if this patch goes in, it will break that platform.
>> quirk flag via device tree?
>
> I think it should still work, except the wake-up won't work for
> the off-idle case unless the SDIO interrupt is remux to the
> GPIO input?
>
> If there are other issues then yes, we can use the compatible
> flags.

Compatible section you mean, that sounds to good to me.
But do we know platform have the deficiency?

There used to be an if statement like this in one of your previous
patches.

+   if (match) {
+       mmc->caps |= MMC_CAP_SDIO_IRQ;
+       if (of_find_property(host->dev->of_node,
+                    "ti,quirk-swakeup-missing", NULL)) {
+           /* no wakeup from deeper power states, use polling */
+           mmc->caps &= ~MMC_CAP_SDIO_IRQ;
+       }
+   }

Either or is needed, otherwise existing platforms will break, and will have
to apply patches on top of yours to reenable polling (e.g. beaglebone)

>
> Thanks for the review and comments,
>
> Tony
>
