From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2] mmc: sdhci at91: add PM support
Date: Tue, 10 Nov 2015 14:21:05 +0100
Message-ID: <20151110132105.GF15706@odux.rfo.atmel.com>
References: <1447151810-21864-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFoAwmkw0D8QbA4UV3uhhNS7hmfOiRv3ZUhMp8uoxzWnrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:7585 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbKJNVb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2015 08:21:31 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFoAwmkw0D8QbA4UV3uhhNS7hmfOiRv3ZUhMp8uoxzWnrw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 10, 2015 at 12:12:30PM +0100, Ulf Hansson wrote:
> On 10 November 2015 at 11:36, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Add runtime PM support and use runtime_force_suspend|resume() for system
> > PM.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >
> > Changes:
> > - from v1: take a runtime PM centric approach
> >
> >  drivers/mmc/host/sdhci-of-at91.c | 66 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index 06d0b50..5dbe0ce 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include "sdhci-pltfm.h"
> >
> > @@ -51,6 +53,62 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
> >         {}
> >  };
> >
> > +#ifdef CONFIG_PM
> > +static int sdhci_at91_runtime_suspend(struct device *dev)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct sdhci_host *host = platform_get_drvdata(pdev);
> 
> These two lines can be replaced by:
> struct sdhci_host *host = dev_get_drvdata(dev);
> 

Oh yes, trying to complicate things!

> > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +       struct sdhci_at91_priv *priv = pltfm_host->priv;
> > +       int ret;
> > +
> > +       ret = sdhci_runtime_suspend_host(host);
> > +
> > +       clk_disable_unprepare(priv->gck);
> > +       clk_disable_unprepare(priv->hclock);
> > +       clk_disable_unprepare(priv->mainck);
> > +
> > +       return ret;
> > +}
> > +
> > +static int sdhci_at91_runtime_resume(struct device *dev)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct sdhci_host *host = platform_get_drvdata(pdev);
> 
> Same comment as above.
> 
> > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +       struct sdhci_at91_priv *priv = pltfm_host->priv;
> > +       int ret;
> > +
> > +       ret = clk_prepare_enable(priv->mainck);
> > +       if (ret) {
> > +               dev_err(dev, "can't enable mainck\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_prepare_enable(priv->hclock);
> > +       if (ret) {
> > +               dev_err(dev, "can't enable hclock\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_prepare_enable(priv->gck);
> > +       if (ret) {
> > +               dev_err(dev, "can't enable gck\n");
> > +               return ret;
> > +       }
> > +
> > +       return sdhci_runtime_resume_host(host);
> > +}
> > +#endif /* CONFIG_PM_RUNTIME */
> 
> /s/CONFIG_PM_RUNTIME/CONFIG_PM
> 
> > +
> > +static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +                               pm_runtime_force_resume)
> > +       SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
> > +                          sdhci_at91_runtime_resume,
> > +                          NULL)
> > +};
> > +
> >  static int sdhci_at91_probe(struct platform_device *pdev)
> >  {
> >         const struct of_device_id       *match;
> > @@ -148,6 +206,11 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto clocks_disable_unprepare;
> >
> > +       pm_runtime_set_active(&pdev->dev);
> > +       pm_runtime_enable(&pdev->dev);
> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> > +       pm_runtime_use_autosuspend(&pdev->dev);
> 
> Move these four runtime PM calls above sdhci_add_host(), as after that
> point the host is used and thus runtime PM operations starts.
> 

Ok.

> > +
> >         return 0;
> >
> >  clocks_disable_unprepare:
> > @@ -165,6 +228,7 @@ static int sdhci_at91_remove(struct platform_device *pdev)
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >         struct sdhci_at91_priv  *priv = pltfm_host->priv;
> >
> 
> Add:
> pm_runtime_get_sync();
> 
> > +       pm_runtime_disable(&pdev->dev);
> 
> Add:
> pm_runtime_put_noidle();
> 

This time I should complicate things a bit more.

> >         sdhci_pltfm_unregister(pdev);
> >
> >         clk_disable_unprepare(priv->gck);
> > @@ -178,7 +242,7 @@ static struct platform_driver sdhci_at91_driver = {
> >         .driver         = {
> >                 .name   = "sdhci-at91",
> >                 .of_match_table = sdhci_at91_dt_match,
> > -               .pm     = SDHCI_PLTFM_PMOPS,
> > +               .pm     = &sdhci_at91_dev_pm_ops,
> >         },
> >         .probe          = sdhci_at91_probe,
> >         .remove         = sdhci_at91_remove,
> > --
> > 2.5.0
> >
> 
> Otherwise, this looks good!

Thanks for your feedback, v3 is coming.

Regards

Ludovic
