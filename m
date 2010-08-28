From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 4/5] sdhci-s3c: add support for the non standard	minimal
 clock value
Date: Sat, 28 Aug 2010 09:54:03 +0900
Message-ID: <009d01cb464b$851ef080$8f5cd180$%kim@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
 <1276076383-24825-5-git-send-email-m.szyprowski@samsung.com>
 <20100827195452.GM23079@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15507 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0H1Axx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 20:53:53 -0400
In-reply-to: <20100827195452.GM23079@void.printf.net>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Marek Szyprowski' <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org

Chris Ball wrote:
> 
> Hi,
> 
Hi again ;-)

> Looks like this wasn't merged.  Any thoughts on doing so?
> 
Updated patch(v3) of this was merged.

http://marc.info/?l=linux-arm-kernel&m=128040710023029&w=2

(commit ID: ce5f036bbbfc6c21d7b55b8fdaa2e2bd56392d94)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> On Wed, Jun 09, 2010 at 11:39:42AM +0200, Marek Szyprowski wrote:
> > S3C SDHCI host controller can change the source for generating mmc
clock.
> > By default host bus clock is used, what causes some problems on machines
> > with 133MHz bus, because the SDHCI divider cannot be as high get proper
> > clock value for identification mode. This is not a problem for the
> > controller, because it can generate lower frequencies from other clock
> > sources. This patch adds a new quirk to SDHCI driver to calculate the
> > minimal supported clock frequency.
> >
> > This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
> > mmc0: Minimum clock frequency too high for identification mode
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c |    1 +
> >  drivers/mmc/host/sdhci-s3c.c      |   29
> +++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c          |    2 +-
> >  drivers/mmc/host/sdhci.h          |    2 ++
> >  4 files changed, 33 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
b/drivers/mmc/host/sdhci-of-
> esdhc.c
> > index c8623de..64b3f79 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -124,6 +124,7 @@ struct sdhci_of_data sdhci_esdhc = {
> >  		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> >  		  SDHCI_QUIRK_NO_BUSY_IRQ |
> >  		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
> > +		  SDHCI_QUIRK_NONSTANDARD_MINCLOCK |
> >  		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> >  		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
> >  		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index 2b6cb44..615008d 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -209,10 +209,37 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> *host, unsigned int clock)
> >  	}
> >  }
> >
> > +/**
> > + * sdhci_s3c_get_min_clock - callback to get minimal supported clock
value
> > + * @host: The SDHCI host being queried
> > + *
> > + * To init mmc host properly a minimal clock value is needed. For high
system
> > + * bus clock's values the standard formula gives values out of allowed
range.
> > + * The clock still can be set to lower values, if clock source other
then
> > + * system bus is selected.
> > +*/
> > +static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
> > +{
> > +	struct sdhci_s3c *ourhost = to_s3c(host);
> > +	unsigned int delta, min = UINT_MAX;
> > +	int src;
> > +
> > +	for (src = 0; src < MAX_BUS_CLK; src++) {
> > +		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
> > +		if (delta == UINT_MAX)
> > +			continue;
> > +		/* delta is a negative value in this case */
> > +		if (-delta < min)
> > +			min = -delta;
> > +	}
> > +	return min;
> > +}
> > +
> >  static struct sdhci_ops sdhci_s3c_ops = {
> >  	.get_max_clock		= sdhci_s3c_get_max_clk,
> >  	.get_timeout_clock	= sdhci_s3c_get_timeout_clk,
> >  	.set_clock		= sdhci_s3c_set_clock,
> > +	.get_min_clock		= sdhci_s3c_get_min_clock,
> >  };
> >
> >  static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> > @@ -316,6 +343,8 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> >  	host->quirks = 0;
> >  	host->irq = irq;
> >
> > +	host->quirks |= SDHCI_QUIRK_NONSTANDARD_MINCLOCK;
> > +
> >  	/* Setup quirks for the controller */
> >  	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c6d1bd8..8b3ee53 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1785,7 +1785,7 @@ int sdhci_add_host(struct sdhci_host *host)
> >  	 * Set host parameters.
> >  	 */
> >  	mmc->ops = &sdhci_ops;
> > -	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
> > +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_MINCLOCK &&
> >  			host->ops->set_clock && host->ops->get_min_clock)
> >  		mmc->f_min = host->ops->get_min_clock(host);
> >  	else
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index c846813..3fd87c2 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> >  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> >  /* Controller cannot support End Attribute in NOP ADMA descriptor */
> >  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> > +/* Controller has nonstandard clock management */
> > +#define SDHCI_QUIRK_NONSTANDARD_MINCLOCK		(1<<27)
> >
> >  	int			irq;		/* Device IRQ */
> >  	void __iomem *		ioaddr;		/* Mapped address */
> > --
> > 1.7.1.240.g225c
> 
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

