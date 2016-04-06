From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: introduce sdhci_compute_clock_config
Date: Wed, 6 Apr 2016 17:13:23 +0200
Message-ID: <20160406151323.GB32232@odux.rfo.atmel.com>
References: <1459783675-7798-1-git-send-email-ludovic.desroches@atmel.com>
 <1459783675-7798-2-git-send-email-ludovic.desroches@atmel.com>
 <57050308.2070006@intel.com>
 <20160406150445.GA32232@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160406150445.GA32232@odux.rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 06, 2016 at 05:04:45PM +0200, Ludovic Desroches wrote:
> On Wed, Apr 06, 2016 at 03:37:28PM +0300, Adrian Hunter wrote:
> > On 04/04/16 18:27, Ludovic Desroches wrote:
> > > In order to remove the SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST and to
> > > reduce code duplication, put the code relative to the SD clock
> > > configuration in a function which can be used by hosts for the
> > > implementation of the set_clock() callback.
> > > 
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > ---
> > >  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++++++++-----------
> > >  drivers/mmc/host/sdhci.h |  1 +
> > >  2 files changed, 23 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index 6bd3d17..2c3dede 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1091,23 +1091,13 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> > >  	return preset;
> > >  }
> > >  
> > > -void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > > +u16 sdhci_compute_clock_config(struct sdhci_host *host, unsigned int clock)
> > 
> > The function name 'sdhci_compute_clock_config' seems a bit long.  How about
> > just sdhci_calc_clk.
> 
> Ok.
> 
> > 
> > Also it needs to calculate 'actual_clock' too, so it needs to do that and
> > return the value.
> > 
> 
> actual_clock is updated at the end of the function.

Maybe it makes more sens to keep it in sdhci_set_clock().

> 
> Which value has to be returned? actual_clock or clock configuration?
> 
> Regards
> 
> Ludovic
> 
> > >  {
> > >  	int div = 0; /* Initialized for compiler warning */
> > >  	int real_div = div, clk_mul = 1;
> > >  	u16 clk = 0;
> > > -	unsigned long timeout;
> > >  	bool switch_base_clk = false;
> > >  
> > > -	host->mmc->actual_clock = 0;
> > > -
> > > -	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > > -	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> > > -		mdelay(1);
> > > -
> > > -	if (clock == 0)
> > > -		return;
> > > -
> > >  	if (host->version >= SDHCI_SPEC_300) {
> > >  		if (host->preset_enabled) {
> > >  			u16 pre_val;
> > > @@ -1188,6 +1178,27 @@ clock_set:
> > >  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> > >  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
> > >  		<< SDHCI_DIVIDER_HI_SHIFT;
> > > +
> > > +	return clk;
> > > +}
> > > +EXPORT_SYMBOL_GPL(sdhci_compute_clock_config);
> > > +
> > > +void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > > +{
> > > +	u16 clk;
> > > +	unsigned long timeout;
> > > +
> > > +	host->mmc->actual_clock = 0;
> > > +
> > > +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > > +	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> > > +		mdelay(1);
> > > +
> > > +	if (clock == 0)
> > > +		return;
> > > +
> > > +	clk = sdhci_compute_clock_config(host, clock);
> > > +
> > >  	clk |= SDHCI_CLOCK_INT_EN;
> > >  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > >  
> > > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > > index 0f39f4f..23ddd6e 100644
> > > --- a/drivers/mmc/host/sdhci.h
> > > +++ b/drivers/mmc/host/sdhci.h
> > > @@ -661,6 +661,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
> > >  	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
> > >  }
> > >  
> > > +u16 sdhci_compute_clock_config(struct sdhci_host *host, unsigned int clock);
> > >  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> > >  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> > >  		     unsigned short vdd);
> > > 
> > 
