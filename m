From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2] mmc: sdhci: restore behavior when setting VDD via
 external regulator
Date: Fri, 11 Dec 2015 18:06:17 +0100
Message-ID: <20151211170617.GA2505@odux.rfo.atmel.com>
References: <1449840989-563-1-git-send-email-jszhang@marvell.com>
 <CAPDyKFpVqQREdiKm42cM7OxXHDpJffp3OMN6GqLAkn-gep6xOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:10457 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbLKRGp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2015 12:06:45 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpVqQREdiKm42cM7OxXHDpJffp3OMN6GqLAkn-gep6xOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 11, 2015 at 03:48:04PM +0100, Ulf Hansson wrote:
> + Ludovic (We had some discussions around this code recently as well)
> 

Thanks Ulf.

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
> > is supplied by external regulator.So the host in marvell berlin SoCs
> > still works fine after the commit.

I am not sure to understand this part. You explain that the controller
in berlin SoC requireis the voltage level programming even if there is an
external regulator for VDD. I agree this part, I am in the same
situation with atmel controller. It is not smart to rely on the voltage
level if we have an external regulator but it follows the sdhci specs.

That I don't understand is that you say it still works fine after this
commit... If you need to set the voltage level in the
SDHCI_POWER_CONTROL register, it is broken by this commit if you declare
an external regulator.

> > However, commit 3cbc6123a93d ("mmc:
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

I would be pleased to get this patch since it would solve one of my
issues.

Concerning the risk to take this patch. I would say one part of this
patch is safe, the other one maybe not.

Reading the log of commit 52221610dd84, it is not a bug fix. It was done
in this way because it seemed logical to not set the voltage level in
the SDHCI_POWER_CONTROL if we have an external regulator.

Moving mmc_regulator_set_ocr at the end could cause issue since it
changes the sequence order: the regulator is configured after the
SDHCI_POWER_CONTROL register.

Regards

Ludovic
