From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v3] mmc: sdhci at91: add PM support
Date: Tue, 10 Nov 2015 15:40:24 +0100
Message-ID: <20151110144024.GG15706@odux.rfo.atmel.com>
References: <1447161830-27205-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFrcKRn3ht-+EoNU64RyG+vfNjygLfbEFv1kd4-XtUn+OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrcKRn3ht-+EoNU64RyG+vfNjygLfbEFv1kd4-XtUn+OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 10, 2015 at 03:03:57PM +0100, Ulf Hansson wrote:
> On 10 November 2015 at 14:23, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Add runtime PM support and use runtime_force_suspend|resume() for system
> > PM.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >
> > Changes:
> > - from v2: cleanup thanks to Ulf feedback
> > - from v1: take a runtime PM centric approach
> >
> >  drivers/mmc/host/sdhci-of-at91.c | 67 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index 06d0b50..bbac18e 100644
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
> > @@ -51,6 +53,60 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
> >         {}
> >  };
> >
> > +#ifdef CONFIG_PM
> > +static int sdhci_at91_runtime_suspend(struct device *dev)
> > +{
> > +       struct sdhci_host *host = dev_get_drvdata(dev);
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
> > +       struct sdhci_host *host = dev_get_drvdata(dev);
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
> > +#endif /* CONFIG_PM */
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
> > @@ -144,6 +200,11 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> >
> >         sdhci_get_of_property(pdev);
> >
> > +       pm_runtime_set_active(&pdev->dev);
> > +       pm_runtime_enable(&pdev->dev);
> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> > +       pm_runtime_use_autosuspend(&pdev->dev);
> > +
> >         ret = sdhci_add_host(host);
> >         if (ret)
> >                 goto clocks_disable_unprepare;
> 
> You need to add error handling of runtime PM after this point.
> 
> Typically:
> pm_runtime_disable() and pm_runtime_set_suspended() needs to be done.

I am not confortable with pm_runtime helpers, having a look to several
drivers, I see different ways to manage a probe failing and the device
removing.

I'll trust you and I'll dig later into this subject.

Regards

Ludovic

> 
> > @@ -165,6 +226,10 @@ static int sdhci_at91_remove(struct platform_device *pdev)
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >         struct sdhci_at91_priv  *priv = pltfm_host->priv;
> >
> > +       pm_runtime_get_sync(&pdev->dev);
> > +       pm_runtime_disable(&pdev->dev);
> > +       pm_runtime_put_noidle(&pdev->dev);
> > +
> >         sdhci_pltfm_unregister(pdev);
> >
> >         clk_disable_unprepare(priv->gck);
> > @@ -178,7 +243,7 @@ static struct platform_driver sdhci_at91_driver = {
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
> Kind regards
> Uffe
