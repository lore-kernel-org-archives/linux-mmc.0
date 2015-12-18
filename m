From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2] mmc: sdhci: restore behavior when setting VDD via
 external regulator
Date: Fri, 18 Dec 2015 09:11:38 +0100
Message-ID: <20151218081138.GB15968@odux.rfo.atmel.com>
References: <1449840989-563-1-git-send-email-jszhang@marvell.com>
 <CAPDyKFpVqQREdiKm42cM7OxXHDpJffp3OMN6GqLAkn-gep6xOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpVqQREdiKm42cM7OxXHDpJffp3OMN6GqLAkn-gep6xOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf, Jisheng,

On Fri, Dec 11, 2015 at 03:48:04PM +0100, Ulf Hansson wrote:
> + Ludovic (We had some discussions around this code recently as well)
> 
> On 11 December 2015 at 14:36, Jisheng Zhang <jszhang@marvell.com> wrote:
> > After commit 52221610dd84 ("mmc: sdhci: Improve external VDD regulator
> > support"), for the VDD is supplied via external regulators, we ignore
> > the code to convert a VDD voltage request into one of the standard
> > SDHCI voltage levels, then program it in the SDHCI_POWER_CONTROL. This
> > brings two issues:
> >
> > 1. SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk isn't handled properly any
> > more.
> >
> > 2. What's more, once SDHCI_POWER_ON bit is set, some controllers such
> > as the sdhci-pxav3 used in marvell berlin SoCs require the voltage
> > levels programming in the SDHCI_POWER_CONTROL register, even the VDD
> > is supplied by external regulator. So the host in marvell berlin SoCs
> > still works fine after the commit. However, commit 3cbc6123a93d ("mmc:
> > sdhci: Set SDHCI_POWER_ON with external vmmc") sets the SDHCI_POWER_ON
> > bit, this would make the host in marvell berlin SoCs won't work any
> > more with external vmmc.
> >
> > This patch restores the behavior when setting VDD through external
> > regulator by moving the call of mmc_regulator_set_ocr() to the end
> > of sdhci_set_power() function.
> >
> > After this patch, the sdcard on Marvell Berlin SoC boards work again.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > Fixes: 52221610dd84 ("mmc: sdhci: Improve external VDD ...")

Reviewed-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Even if the patch sounds good for me, I wanted to test it. As planned,
with this patch, I can describe my vcc regulator without breaking the
behavior of my sdhci controller.


Regards

Ludovic

> > ---
> > Since v1:
> >  - add more details about why the sdhci-pxav3 used in marvell berlin
> >    SoCs need this patch.
> >
> >  drivers/mmc/host/sdhci.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index b48565e..616aa90 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1274,19 +1274,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >         struct mmc_host *mmc = host->mmc;
> >         u8 pwr = 0;
> >
> > -       if (!IS_ERR(mmc->supply.vmmc)) {
> > -               spin_unlock_irq(&host->lock);
> > -               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > -               spin_lock_irq(&host->lock);
> > -
> > -               if (mode != MMC_POWER_OFF)
> > -                       sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> > -               else
> > -                       sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > -
> > -               return;
> > -       }
> > -
> >         if (mode != MMC_POWER_OFF) {
> >                 switch (1 << vdd) {
> >                 case MMC_VDD_165_195:
> > @@ -1345,6 +1332,12 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >                 if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> >                         mdelay(10);
> >         }
> > +
> > +       if (!IS_ERR(mmc->supply.vmmc)) {
> > +               spin_unlock_irq(&host->lock);
> > +               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +               spin_lock_irq(&host->lock);
> > +       }
> >  }
> >
> >  /*****************************************************************************\
> > --
> > 2.6.3
> >
> 
> My concern with this patch is that it might fix the problem for your
> SDHCI variant, but will break it for others.
> I guess we can give it try, unless or until someone reports a problem.
> 
> Although, I would like to get Ludovic's input on this change, before I
> decide to do anything.
> 
> Kind regards
> Uffe
