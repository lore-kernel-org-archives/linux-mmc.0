From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 3/3] sdhci-s3c: add support for new card detection methods
Date: Mon, 12 Jul 2010 13:04:09 +0200
Message-ID: <000101cb21b1$f9accad0$ed066070$%szyprowski@samsung.com>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
 <1276670996-17729-4-git-send-email-m.szyprowski@samsung.com>
 <20100709142440.3ce31714.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100709142440.3ce31714.akpm@linux-foundation.org>
Content-language: pl
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hello,

On Friday, July 09, 2010 11:25 PM Andrew Morton wrote:

On Wed, 16 Jun 2010 08:49:56 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> > line. For some embedded designs it is not even needed, because ususally
> > the device (like SDIO flash memory or wifi controller) is permanently
> > wired to the controller. There are also systems which have a card detect
> > line connected to some of the external interrupt lines or the presence
> > of the card depends on some other actions (like enabling a power
> > regulator).
> >
> > This patch adds support for all these cases. The following card
> > detection methods are possible:
> >
> > 1. internal sdhci host card detect line
> > 2. external event
> > 3. external gpio interrupt
> > 4. no card detect line, controller will poll for the card
> > 5. no card detect line, card is permanently wired to the controller
> > (once detected host won't poll it any more)
> >
> > By default, all existing code would use method #1, what is compatible
> > with the previous version of the driver.
> >
> > In case of external event, two callbacks must be provided in platdata:
> > ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
> > function that notifies the s3c-sdhci host contoller as their argument.
> > That callback function should be called from the even dispatcher to let
> > host notice the card insertion/removal.
> >
> > In case of external gpio interrupt, a gpio pin number must be provided
> > in platdata (ext_cd_gpio parameter), as well as the information about
> > the polarity of that gpio pin (ext_cd_gpio_invert). By default
> > (ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed',
> > but this can be changed to 'card has been removed' when
> > ext_cd_gpio_invert == 1.
> >
> > This patch adds changes to sdhci-s3c driver.
> >
> > ...
> >
> > +static void sdhci_s3c_notify_change(struct platform_device *dev, int
> state)
> > +{
> > +	struct sdhci_host *host;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	host = platform_get_drvdata(dev);
> > +	if (host) {
> > +		if (state) {
> > +			dev_dbg(&dev->dev, "card inserted.\n");
> > +			host->flags &= ~SDHCI_DEVICE_DEAD;
> > +			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > +			tasklet_schedule(&host->card_tasklet);
> > +		} else {
> > +			dev_dbg(&dev->dev, "card removed.\n");
> > +			host->flags |= SDHCI_DEVICE_DEAD;
> > +			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > +			tasklet_schedule(&host->card_tasklet);
> > +		}
> > +	}
> > +	local_irq_restore(flags);
> > +}
> 
> What's the local_irq_save() there for?
> 
> Presumably it is for local-cpu-only protection of some data.  But which
> data is it there to protect?
> 
> It doesn't provide protection on SMP systems and if I'm guessing
> correctly about why it was added, it would be much better to use
> spin_lock_irq[save]() here.  That sets a better example, it means the
> code has a hope of working correctly on SMP systems and will devolve to
> local_irq_save() on UP kernels anyway.

Ok. I will change local_irq_save to spin_lock_irqsave. Thanks for spotting
this!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
