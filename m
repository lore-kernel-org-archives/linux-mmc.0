From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for
 Samsung SoC
Date: Tue, 27 Jul 2010 21:21:58 +0900
Message-ID: <001201cb2d86$524d8230$f6e88690$%kim@samsung.com>
References: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
 <1279886191-9197-4-git-send-email-kgene.kim@samsung.com>
 <005d01cb2a69$5eeceff0$1cc6cfd0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39963 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab0G0MVy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jul 2010 08:21:54 -0400
In-reply-to: <005d01cb2a69$5eeceff0$1cc6cfd0$%szyprowski@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>, ben-linux@fluff.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> On Friday, July 23, 2010 1:57 PM Kukjin Kim wrote:
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
> >  drivers/mmc/host/sdhci-s3c.c |   43
> > ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c     |    3 ++
> >  drivers/mmc/host/sdhci.h     |    3 ++
> >  3 files changed, 49 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index 0d25285..0b75e57 100644
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
> > @@ -213,6 +214,36 @@ static void sdhci_s3c_set_clock(struct sdhci_host
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
> > +	struct sdhci_s3c *sc;
> > +	struct sdhci_host *host;
> > +
> > +	host = mmc_priv(mmc);
> > +	sc = sdhci_priv(host);
> > +
> > +	return gpio_get_value(sc->pdata->wp_gpio);
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
> > @@ -375,6 +406,9 @@ static int __devinit sdhci_s3c_probe(struct
> > platform_device *pdev)
> >  	if (pdata->cfg_gpio)
> >  		pdata->cfg_gpio(pdev, pdata->max_width);
> >
> > +	if (gpio_is_valid(pdata->wp_gpio))
> > +		sdhci_s3c_ops.get_ro = sdhci_s3c_get_ro;
> > +
> 
> There is still a problem here, but the opposite to the issue from V1 of
this
> patch.
> If one apply the current version, he would need to set pdata->wp_gpio to
-1 on
> all
> existing platforms to get old behavior of the driver. Leaving it as zero
means
> that
> the driver will try to use GPA(0) for write protection.
> 
> Adding one more field to pdata (like "bool has_gpio_wp") seems to be
> unavoidable
> in this case imho.
> 
Ok..thanks for your review.

Will fix it like your card detection method soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

