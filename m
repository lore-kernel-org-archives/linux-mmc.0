From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: make sure usdhc clock enabled
 while doing suspend
Date: Sat, 22 Oct 2016 09:07:47 +0800
Message-ID: <20161022010747.GB15754@b29396-OptiPlex-7040>
References: <1476776340-23718-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFpwEKjyd02oj20_fQkLEPaAniAHZTo6AYJDdqzsdSWH2g@mail.gmail.com>
 <CAA+hA=SOk4K6QrQ4T_FCTpuZs1tKfpTA=wHnhvFX7A=30qsLsA@mail.gmail.com>
 <AM4PR0401MB23247C544FE16359ACE6847C90D50@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35397 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbcJUJIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 05:08:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id s8so8102456pfj.2
        for <linux-mmc@vger.kernel.org>; Fri, 21 Oct 2016 02:08:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AM4PR0401MB23247C544FE16359ACE6847C90D50@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "A.S. Dong" <aisheng.dong@nxp.com>

On Thu, Oct 20, 2016 at 10:21:46AM +0000, Bough Chen wrote:
> 
> 
> > -----Original Message-----
> > From: Dong Aisheng [mailto:dongas86@gmail.com]
> > Sent: Wednesday, October 19, 2016 5:18 PM
> > To: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Bough Chen <haibo.chen@nxp.com>; Adrian Hunter
> > <adrian.hunter@intel.com>; linux-mmc <linux-mmc@vger.kernel.org>; A.S.
> > Dong <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: make sure usdhc clock enabled
> > while doing suspend
> > 
> > Hi Ulf,
> > 
> > On Tue, Oct 18, 2016 at 5:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On 18 October 2016 at 09:39, Haibo Chen <haibo.chen@nxp.com> wrote:
> > >> When suspend usdhc, it will access usdhc register. So usdhc clock
> > >> should be enabled, otherwise the access usdhc register will return
> > >> error or cause system hung.
> > >>
> > >> Take this into consideration, if system enable a usdhc and do not
> > >> connect any SD/SDIO/MMC card, after system boot up, this usdhc will
> > >> do runtime suspend, and close all usdhc clock. At this time, if
> > >> suspend the system, due to no card persent, usdhc runtime resume will
> > >> not be called. So usdhc clock still closed, then in suspend, once
> > >> access usdhc register, system hung or bus error return.
> > >>
> > >> This patch make sure usdhc clock always enabled while doing usdhc
> > >> suspend.
> > >
> > > Yes, and since the clocks are kept enabled during system suspend that
> > > means wasting power, doesn't it!?
> > >
> > 
> > IMX SoCs will disable all modules clocks in system stop mode automatically by
> > hardware even it's enabled before CCGR value Clock Activity Description:
> > 00 clock is off during all modes. stop enter hardware handshake is disabled.
> > 01 clock is on in run mode, but off in wait and stop modes
> > 10 Not applicable (Reserved).
> > 11 clock is on during all modes, except stop mode.
> > 
> > Although HW will gate off it automatically, but i think it's still good to align the
> > state between SW and HW.
> >
>  
> Agree
> 
> > > May I propose another solution. Currently you deal only with clock
> > > gating/ungating during runtime suspend/resume. I am wondering whether
> > > you could extend those operations to be similar to what is needed
> > > during system suspend/resume?
> > >
> > 
> > IMX driver are calling sdhci_runtime_suspend_host() and
> > sdhci_suspend_host() for runtime
> > suspend and system sleep case respectively.
> > Those two APIs definitions are different.
> > e.g. sdhci_suspend_host will disable card detection and enable wakeup if any
> > while
> > sdhci_runtime_suspend_host() not.
> > 
> > It may not be suitable to extend runtime operations to be similar as sleep pm
> > operations if using common sdhci suspend function, unless we implement
> > totoally IMX specific PM/Runtime PM function.
> > 
> > 
> > Another option may be like what omap_hsmmc does:
> > 
> > Something like:
> > 
> > int sdhci_esdhc_suspend(struct device *dev) {
> >         pm_runtime_get_sync(host->dev);
> >         ret = sdhci_pltfm_suspend(dev);
> >         pm_runtime_put_sync(host->dev);
> > 
> >         return ret;
> > }
> > 
> 
> I think this method still has the same issue.
> According to the /Documentation/power/runtime_pm.txt
> 
> 370   int pm_runtime_get_sync(struct device *dev);
> 371     - increment the device's usage counter, run pm_runtime_resume(dev) and
> 372       return its result
> 
> 385   int pm_runtime_put_sync(struct device *dev);
> 386     - decrement the device's usage counter; if the result is 0 then run
> 387       pm_runtime_idle(dev) and return its result
> 
> pm_runtime_put_sync() will not call pm_runtime_suspend(), so clock still enabled, the same issue.
> 

Yes, you're right.
Device may be already in runtime resumed state before.

Regards
Dong Aisheng

> > int sdhci_esdhc_resume(struct device *dev) {
> >         pm_runtime_get_sync(host->dev);
> > 
> >         ...
> >         ret = sdhci_pltfm_resume(dev);
> > 
> >         pm_runtime_mark_last_busy(host->dev);
> >         pm_runtime_put_autosuspend(host->dev);
> > 
> >         return ret;
> > }
> > 
> > Does that seem ok?
> > 
> > > If that is possible, you can instead deploy the runtime PM centric
> > > approach and get system suspend/resume for free. All you would have to
> > > do is to assign the system PM callbacks to
> > > pm_runtime_force_suspend|resume(). In that way, the above problem
> > > would be solved and you don't need to keep the clocks enabled during
> > > system suspend/resume.
> > >
> > > Kind regards
> > > Uffe
> > >
> > 
> > Regards
> > Dong Aisheng
> > 
> > >>
> > >> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > >> ---
> > >>  drivers/mmc/host/sdhci-esdhc-imx.c | 13 ++++++++++++-
> > >>  1 file changed, 12 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > >> b/drivers/mmc/host/sdhci-esdhc-imx.c
> > >> index 7123ef9..1df3846 100644
> > >> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > >> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > >> @@ -1322,17 +1322,28 @@ static int sdhci_esdhc_suspend(struct device
> > >> *dev)  {
> > >>         struct sdhci_host *host = dev_get_drvdata(dev);
> > >>
> > >> +#ifdef CONFIG_PM
> > >> +       pm_runtime_get_sync(host->mmc->parent);
> > >> +#endif
> > >> +
> > >>         return sdhci_suspend_host(host);  }
> > >>
> > >>  static int sdhci_esdhc_resume(struct device *dev)  {
> > >>         struct sdhci_host *host = dev_get_drvdata(dev);
> > >> +       int ret;
> > >>
> > >>         /* re-initialize hw state in case it's lost in low power mode */
> > >>         sdhci_esdhc_imx_hwinit(host);
> > >> +       ret = sdhci_resume_host(host);
> > >>
> > >> -       return sdhci_resume_host(host);
> > >> +#ifdef CONFIG_PM
> > >> +       pm_runtime_mark_last_busy(host->mmc->parent);
> > >> +       pm_runtime_put_autosuspend(host->mmc->parent);
> > >> +#endif
> > >> +
> > >> +       return ret;
> > >>  }
> > >>  #endif
> > >>
> > >> --
> > >> 1.9.1
> > >>
