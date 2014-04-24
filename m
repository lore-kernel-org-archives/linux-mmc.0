From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 27/38] mmc: sdhci-of-esdhc: remove
	platform_suspend/platform_resume callbacks
Date: Thu, 24 Apr 2014 12:18:25 +0100
Message-ID: <20140424111825.GQ26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2Wy-0003w6-9y@rmk-PC.arm.linux.org.uk> <CAPDyKFrNpxFPfKQNWZ9iwzh=NKZpCzkA8gYnrqnPb-683QcgwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:47904 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753825AbaDXLTR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 07:19:17 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrNpxFPfKQNWZ9iwzh=NKZpCzkA8gYnrqnPb-683QcgwA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 24, 2014 at 09:32:30AM +0200, Ulf Hansson wrote:
> On 23 April 2014 21:08, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > We don't need these hooks in order to insert code in these paths, we
> > can just provide our own handlers and call the main sdhci handlers as
> > appropriate.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c | 55 +++++++++++++++++++++++++--------------
> >  1 file changed, 36 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> > index fcaeae5f55b8..605815e52f5f 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -241,20 +241,6 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
> >         mdelay(1);
> >  }
> >
> > -#ifdef CONFIG_PM
...
> > +#ifdef CONFIG_PM
> 
> This should be CONFIG_PM_SLEEP

That may be the case, but that would be an additional modification, and so
should be a separate patch.
> 
> > +
> > +static u32 esdhc_proctl;
> > +static int esdhc_of_suspend(struct device *dev)
> > +{
> > +       struct sdhci_host *host = dev_get_drvdata(dev);
> > +
> > +       esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
> > +
> > +       return sdhci_suspend_host(host);
> > +}
> > +
> > +static void esdhc_of_resume(device *dev)
> > +{
> > +       struct sdhci_host *host = dev_get_drvdata(dev);
> > +       int ret = sdhci_resume_host(host);
> > +
> > +       if (ret == 0) {
> > +               /* Isn't this already done by sdhci_resume_host() ? --rmk */
> > +               esdhc_of_enable_dma(host);
> > +               sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct dev_pm_ops esdhc_pmops = {
> > +       .suspend        = esdhci_of_suspend,
> > +       .resume         = esdhci_of_resume,
> > +};
> > +#define ESDHC_PMOPS (&esdhc_pmops)
> > +#else
> > +#define ESDHC_PMOPS NULL
> > +#endif
> > +
> 
> I would suggest to use the SIMPLE_DEV_PM_OPS macro to simplify code a bit.

That is dependent on changing the ifdef.  As I say, that should be a
separate patch - possibly one which comes before this one.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
