From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix wakeup issue when using runtime
 pm
Date: Tue, 16 Feb 2016 16:22:04 +0100
Message-ID: <20160216152204.GE2607@odux.rfo.atmel.com>
References: <20160212120415.GJ14937@odux.rfo.atmel.com>
 <1455357400-32145-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFroVY0ZdqPScpGiJ8Y_QhhZ7asf0R0MzSx0WzVi5c2neg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFroVY0ZdqPScpGiJ8Y_QhhZ7asf0R0MzSx0WzVi5c2neg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 16, 2016 at 03:38:29PM +0100, Ulf Hansson wrote:
> On 13 February 2016 at 10:56, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > When suspending the sdhci host, the only hardware event that could wake
> > up the host is a sdio irq if they are enabled. If we want to wakeup on
> > card detect events, a gpio as to be used.
> > If we don't want to use a gpio but the card detect pio of the controller
> > then we need to keep enabled the clock of the controller interface to
> > get the interrupt and to not set the host in a suspended state to have the
> > interrupt handled.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  drivers/mmc/host/sdhci-of-at91.c | 46 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index efec736..2159c6e 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/mmc/host.h>
> > +#include <linux/mmc/slot-gpio.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -45,7 +46,6 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
> >
> >  static const struct sdhci_pltfm_data soc_data_sama5d2 = {
> >         .ops = &sdhci_at91_sama5d2_ops,
> > -       .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> 
> You probably have some leftovers from earlier local changes, as this
> isn't going to apply to my next branch.
> 

Yes, it is based on the first patch of this thread, it was only to
discuss about it.

> >         .quirks2 = SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST,
> >  };
> >
> > @@ -55,17 +55,37 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
> >  };
> >
> >  #ifdef CONFIG_PM
> > +static bool sdhci_at91_use_sdhci_runtime(struct sdhci_host *host)
> > +{
> > +       u32 caps = host->mmc->caps;
> > +
> > +       return (caps & MMC_CAP_NONREMOVABLE) ||
> > +              (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)));
> > +}
> > +
> >  static int sdhci_at91_runtime_suspend(struct device *dev)
> >  {
> >         struct sdhci_host *host = dev_get_drvdata(dev);
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >         struct sdhci_at91_priv *priv = pltfm_host->priv;
> > -       int ret;
> > +       int ret = 0;
> >
> > -       ret = sdhci_runtime_suspend_host(host);
> > +       /*
> > +        * If we call sdhci_runtime_suspend(), we could wakeup only if sdio
> > +        * irqs are enabled. If we want to wakeup on a card detect event there
> > +        * are two options:
> > +        * - do not call sdhci_runtime_suspend() but save power by disabling
> > +        *   all clocks excepting the one for the controller interface.
> > +        * - call sdhci_runtime_suspend(), save maximum power by disabling
> > +        *   all clocks but use a gpio for the card detect signal to have a way
> > +        *   to wakeup.
> > +        */
> > +       if (sdhci_at91_use_sdhci_runtime(host)) {
> 
> I am not sure this approach is safe, particularly for cases when
> sdhci_runtime_suspend() isn't invoked.
> 
> As I understand it, in those cases potentially the sdhci's IRQ handler
> may be invoked to serve even other IRQs than a card detect IRQ. Doing
> that while being runtime suspended doesn't seem like a good idea. Will
> it even work?
> 

Yes it is the idea. It will allow to save some power. I don't see how I can use
runtime PM if I need to invoke sdhci_runtime_suspend_host() without modifying
sdhci layer to handle card detect irq.

I was also afraid to have some side effects but it works, at least for the
card detect case.

> > +               ret = sdhci_runtime_suspend_host(host);
> > +               clk_disable_unprepare(priv->hclock);
> > +       }
> >
> >         clk_disable_unprepare(priv->gck);
> > -       clk_disable_unprepare(priv->hclock);
> >         clk_disable_unprepare(priv->mainck);
> >
> >         return ret;
> > @@ -84,19 +104,23 @@ static int sdhci_at91_runtime_resume(struct device *dev)
> >                 return ret;
> >         }
> >
> > -       ret = clk_prepare_enable(priv->hclock);
> > -       if (ret) {
> > -               dev_err(dev, "can't enable hclock\n");
> > -               return ret;
> > -       }
> > -
> >         ret = clk_prepare_enable(priv->gck);
> >         if (ret) {
> >                 dev_err(dev, "can't enable gck\n");
> >                 return ret;
> >         }
> >
> > -       return sdhci_runtime_resume_host(host);
> > +       if (sdhci_at91_use_sdhci_runtime(host)) {
> > +               ret = clk_prepare_enable(priv->hclock);
> > +               if (ret) {
> > +                       dev_err(dev, "can't enable hclock\n");
> > +                       return ret;
> > +               }
> > +
> > +               ret = sdhci_runtime_resume_host(host);
> > +       }
> > +
> > +       return ret;
> >  }
> >  #endif /* CONFIG_PM */

Regards

Ludovic
