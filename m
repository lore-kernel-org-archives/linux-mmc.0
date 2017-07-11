From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: set clocks and presets after
 resume from deepest PM
Date: Tue, 11 Jul 2017 15:33:55 +0200
Message-ID: <20170711133355.wzdw7nwrr3hpckj3@rfolt0960.corp.atmel.com>
References: <20170616072929.3266-1-quentin.schulz@free-electrons.com>
 <20170616072929.3266-2-quentin.schulz@free-electrons.com>
 <CAPDyKFp2M_t4nCRNyqTm3PEx7tq+hb3TjmGWmg2XkJwbDa4FuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4898 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbdGKNeU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 09:34:20 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFp2M_t4nCRNyqTm3PEx7tq+hb3TjmGWmg2XkJwbDa4FuQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Adrian Hunter <adrian.hunter@intel.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, nicolas.ferre@microchip.com

On Tue, Jul 11, 2017 at 02:42:44PM +0200, Ulf Hansson wrote:
> On 16 June 2017 at 09:29, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
> > SoC's SDHCI controller.
> >
> > When resuming from deepest state, it is required to restore preset
> > registers as the registers are lost since VDD core has been shut down
> > when entering deepest state on the SAMA5D2. The clocks need to be
> > reconfigured as well.
> 
> Right, so compared to runtime resume there is some additional
> operations that is needed during system resume. Fair enough.
> 
> However by looking at the changes below, you also change the system
> suspend operations, as it now calls sdhci_suspend_host(). Is that
> change needed? Then why?
> 
> >
> > The other registers and init process are taken care of by the SDHCI
> > core.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> >  drivers/mmc/host/sdhci-of-at91.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index fb8c6011f13d..300513fc1068 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -207,6 +207,37 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
> >  }
> >
> >  #ifdef CONFIG_PM
> > +static int sdhci_at91_suspend(struct device *dev)
> > +{
> > +       struct sdhci_host *host = dev_get_drvdata(dev);
> > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +       struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +       int ret;
> > +
> > +       ret = sdhci_suspend_host(host);
> > +
> 
> This is wrong, you can't call sdhci_suspend_host() unless the device
> is runtime resumed...
> 
> > +       if (host->runtime_suspended)
> > +               return ret;
> 
> ... and this is weird...
> 
> > +
> > +       clk_disable_unprepare(priv->gck);
> > +       clk_disable_unprepare(priv->hclock);
> > +       clk_disable_unprepare(priv->mainck);
> > +
> > +       return ret;
> > +}
> > +
> > +static int sdhci_at91_resume(struct device *dev)
> > +{
> > +       struct sdhci_host *host = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = sdhci_at91_set_clks_presets(dev);
> > +       if (ret)
> > +               return ret;
> 
> Instead of doing it like this, I suggest you set a new flag to true
> here, let's call it "restore_needed".
> 
> In the ->runtime_resume() callback, you check the restore_needed flag
> and performs the extra operations in that case. When that's done, the
> ->runtime_resume() callback clears the flag, as to avoid the next
> runtime resume from unnecessary doing the extra operations.
> 
> > +
> > +       return sdhci_resume_host(host);
> 
> Remove this and call pm_runtime_force_resume().
> 
> > +}
> > +
> >  static int sdhci_at91_runtime_suspend(struct device *dev)
> >  {
> >         struct sdhci_host *host = dev_get_drvdata(dev);
> > @@ -256,8 +287,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
> >  #endif /* CONFIG_PM */
> >
> >  static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
> > -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> 
> Leave the pm_runtime_force_suspend() here, unless you have other
> reasons not being described in the change log, to change the system
> suspend operations.

I think we need to keep it to be able to set the restore_needed flag, isn't it?

Regards

Ludovic

> 
> > -                               pm_runtime_force_resume)
> > +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, sdhci_at91_resume)
> >         SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
> >                            sdhci_at91_runtime_resume,
> >                            NULL)
> > --
> > 2.11.0
> >
> 
> Adopting my changes should simplify the code, avoid unnecessary
> resuming the device but instead deferring that until really needed via
> runtime PM.
> 
> Kind regards
> Uffe
