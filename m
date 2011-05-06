From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4] mmc: add runtime and system power-management support
 to the MMCIF driver
Date: Fri, 6 May 2011 11:06:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105060955120.10445@axis700.grange>
References: <Pine.LNX.4.64.1105051813270.29735@axis700.grange>
 <201105052350.33332.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201105052350.33332.rjw@sisk.pl>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Thu, 5 May 2011, Rafael J. Wysocki wrote:

> On Thursday, May 05, 2011, Guennadi Liakhovetski wrote:
> > Adding support for runtime power-management to the MMCIF driver allows
> > it to save power as long as no card is present. To also allow to turn
> > off the power domain at that time, we release DMA channels during that
> > time, since on some sh-mobile systems the DMA controller(s) and the
> > MMCIF block belong to the same power domain. System-wide power
> > management has been tested with experimental PM patches on AP4-based
> > systems.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > This patch supersedes:
> > 
> > [PATCH 2/3 v3] MMC: add runtime and system power-management support to the MMCIF driver
> > 
> > and has been tested to work with Rafael's suspend git-tree, power-domains 
> > branch.
> > 
> >  drivers/mmc/host/sh_mmcif.c |   78 ++++++++++++++++++++++++++++++++++++++-----
> >  1 files changed, 69 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index d3871b6..14f8edb 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c

[snip]

> > @@ -1112,15 +1135,52 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
> >  
> >  	clk_disable(host->hclk);
> >  	mmc_free_host(host->mmc);
> > +	pm_runtime_put_sync(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> >  
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int sh_mmcif_suspend(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
> > +	int ret = mmc_suspend_host(host->mmc);
> > +
> > +	if (!ret) {
> > +		sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
> > +		clk_disable(host->hclk);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int sh_mmcif_resume(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
> > +
> > +	clk_enable(host->hclk);
> > +
> > +	return mmc_resume_host(host->mmc);
> > +}
> > +#else
> > +#define sh_mmcif_suspend	NULL
> > +#define sh_mmcif_resume		NULL
> > +#endif	/* CONFIG_PM */
> > +
> > +static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
> > +	.suspend = sh_mmcif_suspend,
> > +	.resume = sh_mmcif_resume,
> > +};
> 
> So this means the driver only has system-wide suspend/resume callbacks.
> I guess hibernation is not supported by the target platform(s) yet, so
> the freeze/thaw etc. callbacks are not necessary at the moment, but in case
> they are supposed to be the same as the suspend/resume ones, it wouldn't
> hurt to use SET_SYSTEM_SLEEP_PM_OPS (as defined in include/linux/pm.h).

Hm, I've tested this with experimental STR patches from Magnus. He has 
also sent some patches for that to the ML a week ago. So, not sure I need 
SET_SYSTEM_SLEEP_PM_OPS.

> Also, runtime PM callbacks are not present.  Is it intentional?  I thought
> they would be necessary to save/restore the device state over the power
> domain power down/power up, wouldn't they?

This is intentional. We only allow runtime suspend with no cards plugged 
in, and then there isn't much to save and restore there, on each new card 
insertion a complete initialisation is taking place anyway.

> > +
> >  static struct platform_driver sh_mmcif_driver = {
> >  	.probe		= sh_mmcif_probe,
> >  	.remove		= sh_mmcif_remove,
> >  	.driver		= {
> >  		.name	= DRIVER_NAME,
> > +		.pm	= &sh_mmcif_dev_pm_ops,
> >  	},
> >  };
> 
> Thanks,
> Rafael

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
