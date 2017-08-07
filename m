From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 08/14] mmc: meson-gx: rework clock init function
Date: Mon, 07 Aug 2017 14:34:06 -0700
Message-ID: <7h4ltjoyep.fsf@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
        <20170804174353.16486-9-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:38678 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGVeN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 17:34:13 -0400
Received: by mail-pg0-f53.google.com with SMTP id l64so6310524pge.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 14:34:13 -0700 (PDT)
In-Reply-To: <20170804174353.16486-9-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 4 Aug 2017 19:43:47 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Perform basic initialisation of the clk register before providing it to
> the CCF.
>
> Thanks to devm, carrying the clock structure around after init is not
> necessary. Rework the function to remove these from the controller host
> data.
>
> Finally, set initial mmc clock rate before enabling it, simplifying the
> exit condition.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 101 +++++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8f9ba5190c18..4cc7d6530536 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -42,10 +42,7 @@
>  
>  #define SD_EMMC_CLOCK 0x0
>  #define   CLK_DIV_MASK GENMASK(5, 0)
> -#define   CLK_DIV_MAX 63
>  #define   CLK_SRC_MASK GENMASK(7, 6)
> -#define   CLK_SRC_XTAL 0   /* external crystal */
> -#define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
>  #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
>  #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
>  #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
> @@ -137,13 +134,9 @@ struct meson_host {
>  	spinlock_t lock;
>  	void __iomem *regs;
>  	struct clk *core_clk;
> -	struct clk_mux mux;
> -	struct clk *mux_clk;
> +	struct clk *signal_clk;
>  	unsigned long req_rate;
>  
> -	struct clk_divider cfg_div;
> -	struct clk *cfg_div_clk;
> -
>  	unsigned int bounce_buf_size;
>  	void *bounce_buf;
>  	dma_addr_t bounce_dma_addr;
> @@ -291,7 +284,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>  		return 0;
>  	}
>  
> -	ret = clk_set_rate(host->cfg_div_clk, clk_rate);
> +	ret = clk_set_rate(host->signal_clk, clk_rate);

minor nit: where does the name "signal" come from?  I called this
"div_clk" because it's the output of the divider right before the
sd/emmc IP block.   Admittedly, that's not a great name either, and I'm
not too picky about the naming, just curious...

Looking at the diagram we have since I initially wrote the driver, this
is more commonly referred to as device_clk.

Anyways, if you're going to rename...

[...]

>  static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
> @@ -987,7 +984,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	dma_free_coherent(host->dev, host->bounce_buf_size,
>  			  host->bounce_buf, host->bounce_dma_addr);
>  err_div_clk:

... probably should rename this too.

Otherwise,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
