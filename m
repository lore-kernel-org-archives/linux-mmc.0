From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 08/14] mmc: meson-gx: rework clock init function
Date: Mon, 21 Aug 2017 14:05:46 +0200
Message-ID: <1503317146.7032.3.camel@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
         <20170804174353.16486-9-jbrunet@baylibre.com> <7h4ltjoyep.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7h4ltjoyep.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 2017-08-07 at 14:34 -0700, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
> > Perform basic initialisation of the clk register before providing it to
> > the CCF.
> > 
> > Thanks to devm, carrying the clock structure around after init is not
> > necessary. Rework the function to remove these from the controller host
> > data.
> > 
> > Finally, set initial mmc clock rate before enabling it, simplifying the
> > exit condition.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/mmc/host/meson-gx-mmc.c | 101 +++++++++++++++++++----------------
> > -----
> >  1 file changed, 49 insertions(+), 52 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-
> > mmc.c
> > index 8f9ba5190c18..4cc7d6530536 100644
> > --- a/drivers/mmc/host/meson-gx-mmc.c
> > +++ b/drivers/mmc/host/meson-gx-mmc.c
> > @@ -42,10 +42,7 @@
> >  
> >  #define SD_EMMC_CLOCK 0x0
> >  #define   CLK_DIV_MASK GENMASK(5, 0)
> > -#define   CLK_DIV_MAX 63
> >  #define   CLK_SRC_MASK GENMASK(7, 6)
> > -#define   CLK_SRC_XTAL 0   /* external crystal */
> > -#define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
> >  #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
> >  #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
> >  #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
> > @@ -137,13 +134,9 @@ struct meson_host {
> >  	spinlock_t lock;
> >  	void __iomem *regs;
> >  	struct clk *core_clk;
> > -	struct clk_mux mux;
> > -	struct clk *mux_clk;
> > +	struct clk *signal_clk;
> >  	unsigned long req_rate;
> >  
> > -	struct clk_divider cfg_div;
> > -	struct clk *cfg_div_clk;
> > -
> >  	unsigned int bounce_buf_size;
> >  	void *bounce_buf;
> >  	dma_addr_t bounce_dma_addr;
> > @@ -291,7 +284,7 @@ static int meson_mmc_clk_set(struct meson_host *host,
> > unsigned long clk_rate)
> >  		return 0;
> >  	}
> >  
> > -	ret = clk_set_rate(host->cfg_div_clk, clk_rate);
> > +	ret = clk_set_rate(host->signal_clk, clk_rate);
> 
> minor nit: where does the name "signal" come from?  I called this
> "div_clk" because it's the output of the divider right before the
> sd/emmc IP block. 

Actually, no before but inside.

> Admittedly, that's not a great name either, and I'm
> not too picky about the naming, just curious...

Well, I thought div_clk was not great name too ... since the clock is actually
the one used for the mmc signal (as opposed to the clock gate named "core") I
thought it was ok.

In the v2, I added the handling of clock phase through CCF. With this change,
div_clk does not make sense anymore.

According to the datasheet, It should be named "core_clk" (it is the clock
coming out of the CORE_PHASE setting), unfortunately we already used this name
for the clock gate ... changing it would mean changing the clock names in the
bindings as well, which would probably be very confusing.

In the v2, I named it mmc_clk ... probably not great either :( If you have
another idea, I'm happy to sed it.

> 
> Looking at the diagram we have since I initially wrote the driver, this
> is more commonly referred to as device_clk.
> 
> Anyways, if you're going to rename...
> 
> [...]
> 
> >  static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
> > @@ -987,7 +984,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
> >  	dma_free_coherent(host->dev, host->bounce_buf_size,
> >  			  host->bounce_buf, host->bounce_dma_addr);
> >  err_div_clk:
> 
> ... probably should rename this too.

Indeed !

> 
> Otherwise,
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> Kevin
