From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci: introduce sdhci_compute_clock_config
Date: Tue, 12 Apr 2016 14:59:49 +0200
Message-ID: <20160412125949.GB17614@odux.rfo.atmel.com>
References: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
 <1460020390-503-2-git-send-email-ludovic.desroches@atmel.com>
 <570CEAB2.6050203@intel.com>
 <20160412125336.GA17614@odux.rfo.atmel.com>
 <CAPDyKFqF9Z2R51M-QHZdk0iK7r_hYJ+hvag+mvCMmZdHBpK1iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:18596 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbcDLNAo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2016 09:00:44 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqF9Z2R51M-QHZdk0iK7r_hYJ+hvag+mvCMmZdHBpK1iQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

On Tue, Apr 12, 2016 at 02:59:15PM +0200, Ulf Hansson wrote:
> On 12 April 2016 at 14:53, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > On Tue, Apr 12, 2016 at 03:31:46PM +0300, Adrian Hunter wrote:
> >> On 07/04/16 12:13, Ludovic Desroches wrote:
> >> > In order to remove the SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST and to
> >> > reduce code duplication, put the code relative to the SD clock
> >> > configuration in a function which can be used by hosts for the
> >> > implementation of the set_clock() callback.
> >> >
> >> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>
> >> The subject needs changing to reflect the new function name i.e.
> >> sdhci_compute_clock_config -> sdhci_calc_clk
> >
> > Oh yes... sorry. Ulf, do you want me to resend it?
> 
> No worries, I can amend the patch.

Great, thx.

> 
> Kind regards
> Uffe
> 
> >
> >>
> >> Otherwise, for all 3 patches:
> >>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>
> >> > ---
> >> >  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
> >> >  drivers/mmc/host/sdhci.h |  2 ++
> >> >  2 files changed, 26 insertions(+), 12 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> > index 6bd3d17..abd34d1 100644
> >> > --- a/drivers/mmc/host/sdhci.c
> >> > +++ b/drivers/mmc/host/sdhci.c
> >> > @@ -1091,23 +1091,14 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> >> >     return preset;
> >> >  }
> >> >
> >> > -void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >> > +u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >> > +              unsigned int *actual_clock)
> >> >  {
> >> >     int div = 0; /* Initialized for compiler warning */
> >> >     int real_div = div, clk_mul = 1;
> >> >     u16 clk = 0;
> >> > -   unsigned long timeout;
> >> >     bool switch_base_clk = false;
> >> >
> >> > -   host->mmc->actual_clock = 0;
> >> > -
> >> > -   sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >> > -   if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> >> > -           mdelay(1);
> >> > -
> >> > -   if (clock == 0)
> >> > -           return;
> >> > -
> >> >     if (host->version >= SDHCI_SPEC_300) {
> >> >             if (host->preset_enabled) {
> >> >                     u16 pre_val;
> >> > @@ -1184,10 +1175,31 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >> >
> >> >  clock_set:
> >> >     if (real_div)
> >> > -           host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
> >> > +           *actual_clock = (host->max_clk * clk_mul) / real_div;
> >> >     clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> >> >     clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
> >> >             << SDHCI_DIVIDER_HI_SHIFT;
> >> > +
> >> > +   return clk;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(sdhci_calc_clk);
> >> > +
> >> > +void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >> > +{
> >> > +   u16 clk;
> >> > +   unsigned long timeout;
> >> > +
> >> > +   host->mmc->actual_clock = 0;
> >> > +
> >> > +   sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >> > +   if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> >> > +           mdelay(1);
> >> > +
> >> > +   if (clock == 0)
> >> > +           return;
> >> > +
> >> > +   clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> >> > +
> >> >     clk |= SDHCI_CLOCK_INT_EN;
> >> >     sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> >> >
> >> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >> > index 0f39f4f..9db5090 100644
> >> > --- a/drivers/mmc/host/sdhci.h
> >> > +++ b/drivers/mmc/host/sdhci.h
> >> > @@ -661,6 +661,8 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
> >> >     return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
> >> >  }
> >> >
> >> > +u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >> > +              unsigned int *actual_clock);
> >> >  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> >> >  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >> >                  unsigned short vdd);
> >> >
> >>
