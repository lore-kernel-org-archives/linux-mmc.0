From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for
 Samsung	SoC
Date: Wed, 28 Jul 2010 14:21:45 +0900
Message-ID: <009701cb2e14$c8232080$58696180$%kim@samsung.com>
References: <1280234628-27303-1-git-send-email-kgene.kim@samsung.com>
 <1280234628-27303-4-git-send-email-kgene.kim@samsung.com>
 <003e01cb2d92$054871a0$0fd954e0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34864 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab0G1FVk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 01:21:40 -0400
In-reply-to: <003e01cb2d92$054871a0$0fd954e0$%szyprowski@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>, ben-linux@fluff.org

Marek Szyprowski wrote:
> 
> Hello,

Hi :-)
> 
> On Tuesday, July 27, 2010 2:44 PM Kukjin Kim wrote:
> 
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > If host controller doesn't have WP pin which should be connnected with
> > SDMMC
> > card WP pin, can implement get_ro function with using the allocated
gpio.
> > In order to use this quirk wp_gpio in the platform data must be set.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-s3c.c |   36
> ++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c     |    3 +++
> >  drivers/mmc/host/sdhci.h     |    3 +++
> >  3 files changed, 42 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index 0d25285..98a8ec8 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -22,6 +22,7 @@
> >
> >  #include <linux/mmc/host.h>
> >
> > +#include <plat/gpio-cfg.h>
> >  #include <plat/sdhci.h>
> >  #include <plat/regs-sdhci.h>
> >
> > @@ -213,6 +214,32 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> > *host, unsigned int clock)
> >  }
> >
> >  /**
> > + * sdhci_s3c_get_ro - callback for get_ro
> > + * @host: The SDHCI host being changed
> > + *
> > + * If the WP pin is connected with GPIO, can get the value which
indicates
> > + * the card is locked or not.
> > +*/
> > +static int sdhci_s3c_get_ro(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_s3c *ourhost = to_s3c(mmc_priv(mmc));
> > +
> > +	return gpio_get_value(ourhost->pdata->wp_gpio);
> > +}
> > +
> > +/**
> > + * sdhci_s3c_cfg_wp - configure GPIO for WP pin
> > + * @gpio_num: GPIO number which connected with WP line from SD/MMC slot
> > + *
> > + * Configure GPIO for using WP line
> > +*/
> > +static void sdhci_s3c_cfg_wp(unsigned int gpio_num)
> > +{
> > +	s3c_gpio_cfgpin(gpio_num, S3C_GPIO_INPUT);
> > +	s3c_gpio_setpull(gpio_num, S3C_GPIO_PULL_UP);
> > +}
> > +
> > +/**
> >   * sdhci_s3c_get_min_clock - callback to get minimal supported clock
value
> >   * @host: The SDHCI host being queried
> >   *
> > @@ -408,6 +435,15 @@ static int __devinit sdhci_s3c_probe(struct
> > platform_device *pdev)
> >  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
> >  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
> >
> > +	/* Controller's WP pin doesn't connected with SD card and there is
an
> > +	 * allocated GPIO for getting WP data form SD card, use this quirk
> > and
> > +	 * send the GPIO number in pdata->wp_gpio. */
> > +	if (gpio_is_valid(pdata->wp_gpio) && pdata->has_wp_gpio) {
> 
> IMHO the opposite order would make much more sense:
> if (pdata->has_wp_gpio && gpio_is_valid(pdata->wp_gpio))
> 
Ok..will modify.

> > +		sdhci_s3c_ops.get_ro = sdhci_s3c_get_ro;
> > +		host->quirks |= SDHCI_QUIRK_NO_WP_BIT;
> > +		sdhci_s3c_cfg_wp(pdata->wp_gpio);
> > +	}
> > +
> >  	ret = sdhci_add_host(host);
> >  	if (ret) {
> >  		dev_err(dev, "sdhci_add_host() failed\n");
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index f9ca4c6..7fba401 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1198,6 +1198,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> >
> >  	host = mmc_priv(mmc);
> >
> > +	if ((host->quirks & SDHCI_QUIRK_NO_WP_BIT) && host->ops->get_ro)
> > +		return host->ops->get_ro(mmc);
> > +
> >  	spin_lock_irqsave(&host->lock, flags);
> >
> >  	if (host->flags & SDHCI_DEVICE_DEAD)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 0de8b38..dd9a233 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -247,6 +247,8 @@ struct sdhci_host {
> >  #define SDHCI_QUIRK_MISSING_CAPS			(1<<28)
> >  /* Controller has nonstandard clock management */
> >  #define SDHCI_QUIRK_NONSTANDARD_MINCLOCK		(1<<29)
> > +/* Controller has no write-protect pin connected with SD card */
> > +#define SDHCI_QUIRK_NO_WP_BIT				(1<<30)
> >
> >  	int			irq;		/* Device IRQ */
> >  	void __iomem *		ioaddr;		/* Mapped address */
> > @@ -321,6 +323,7 @@ struct sdhci_ops {
> >  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
> >  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
> >  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> > +	int		(*get_ro)(struct mmc_host *mmc);
> >  };
> >
> >  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
> Otherwise looks fine.
> 
Thanks for your comment.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

