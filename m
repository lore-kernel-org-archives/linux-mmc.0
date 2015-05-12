From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/7 v4] mmc: sh_mmcif: calculate best clock with parent clock
Date: Tue, 12 May 2015 13:22:36 +0300
Message-ID: <8472238.ZvlxlsYeIr@avalon>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com> <87d22vgt8u.wl%kuninori.morimoto.gx@renesas.com> <874mo7gsza.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <874mo7gsza.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon <horms@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, kobayashi <keita.kobayashi.ym@renesas.com>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

I'm CC'ing the device-tree mailing list as well as Mike Turquette, please see 
below for the discussion.

On Thursday 23 April 2015 08:17:23 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> MMCIF IP on R-Car series has parent clock which can be set
> several rate, and it was not implemented on old SH-Mobile series
> (= SH-Mobile series parent clock was fixed rate)
> R-Car series MMCIF can use more high speed access if it setup
> parent clock. This patch adds parent clock setup method,
> and r8a7790/r8a7791 can use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
> v3 -> v4
> 
>  - add new clk-range on DT
>  - use clk_round_rate() for parent_clk
>  - struct sh_mmcif_ver instead of sh_mmcif_parent_clk
> 
>  .../devicetree/bindings/mmc/renesas,mmcif.txt      |  3 +
>  drivers/mmc/host/sh_mmcif.c                        | 89 ++++++++++++++++++-
>  2 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt index
> 299081f..eb50f4e 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -14,6 +14,8 @@ Required properties:
> 
>  - clocks: reference to the functional clock
> 
> +- clk-range: parent clock range
> +

I think the idea of a DT property to specify the admissible range for clock 
frequencies is good. However, I have a couple of small comments regarding the 
implementation.

First of all, this doesn't seem Renesas-specific to me (feel free to disagree, 
but in that case the property should probably be called renesas,clk-range). 
Wouldn't it make sense to specify the property in 
Documentation/devicetree/bindings/clock/clock-bindings.txt instead ?

Then, I think the documentation should be clarified a bit, as "parent clock 
range" is probably a bit vague for people who haven't followed the development 
of this patch series. How about something like "range of admissible 
frequencies for the input clock" ?

There's already a clock-ranges property with a totally different meaning. 
That's quite confusing, it would thus be good to rename clk-range. How about 
clock-freq-range or clock-frequency-range ?

Finally, if a DT node references several clocks in its clocks property, we 
need a way to specify the range for each of them.

>  - dmas: reference to the DMA channels, one per channel name listed in the
>    dma-names property.
>  - dma-names: must contain "tx" for the transmit DMA channel and "rx" for
> the @@ -29,4 +31,5 @@ Example: R8A7790 (R-Car H2) MMCIF0
>  		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
>  		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
>  		dma-names = "tx", "rx";
> +		clk-range = <12187500 97500000>;
>  	};
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index d2f1158..437aa3c 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -57,6 +57,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_qos.h>
> @@ -224,6 +225,13 @@ enum mmcif_wait_for {
>  	MMCIF_WAIT_FOR_STOP,
>  };
> 
> +/*
> + * difference for each SoC
> + */
> +struct sh_mmcif_ver {
> +	u32 clkdiv_map;	 /* see CE_CLK_CTRL::CLKDIV */
> +};
> +
>  struct sh_mmcif_host {
>  	struct mmc_host *mmc;
>  	struct mmc_request *mrq;
> @@ -248,6 +256,7 @@ struct sh_mmcif_host {
>  	bool ccs_enable;		/* Command Completion Signal support */
>  	bool clk_ctrl2_enable;
>  	struct mutex thread_lock;
> +	const struct sh_mmcif_ver *ver;
> 
>  	/* DMA support */
>  	struct dma_chan		*chan_rx;
> @@ -256,8 +265,14 @@ struct sh_mmcif_host {
>  	bool			dma_active;
>  };
> 
> +static const struct sh_mmcif_ver sh_mmcif_gen2 = {
> +	.clkdiv_map = 0x3ff,
> +};
> +
>  static const struct of_device_id mmcif_of_match[] = {
>  	{ .compatible = "renesas,sh-mmcif" },
> +	{ .compatible = "renesas,mmcif-r8a7790", .data = &sh_mmcif_gen2},
> +	{ .compatible = "renesas,mmcif-r8a7791", .data = &sh_mmcif_gen2},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mmcif_of_match);
> @@ -490,12 +505,50 @@ static void sh_mmcif_clock_control(struct
> sh_mmcif_host *host, unsigned int clk)
> 
>  	if (!clk)
>  		return;
> -	if (sup_pclk && clk == current_clk)
> +
> +	if (host->ver) {
> +		const struct sh_mmcif_ver *ver = host->ver;
> +		unsigned int freq, best_freq, myclk, clkdiv, div, diff_min, diff;
> +		int i;
> +
> +		clkdiv = 0;
> +		diff_min = ~0;
> +		best_freq = 0;
> +		for (i = fls(ver->clkdiv_map); i >= 0; i--) {
> +			if (!((1 << i) & ver->clkdiv_map))
> +				continue;
> +
> +			/*
> +			 * clk = parent_freq / div
> +			 * -> parent_freq = clk x div
> +			 */
> +
> +			div = 1 << (i + 1);
> +			freq = clk_round_rate(host->clk, clk * div);
> +			myclk = freq / div;
> +			diff = (myclk > clk) ? myclk - clk : clk - myclk;
> +
> +			if (diff <= diff_min) {
> +				best_freq = freq;
> +				clkdiv = i;
> +				diff_min = diff;
> +			}
> +		}
> +
> +		dev_dbg(&host->pd->dev, "clk %u/%u (%u, 0x%x)\n",
> +			(best_freq / (1 << (clkdiv + 1))), clk,
> +			best_freq, clkdiv);
> +
> +		clk_set_rate(host->clk, best_freq);
> +		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL,
> +				CLK_CLEAR & (clkdiv << 16));
> +	} else if (sup_pclk && clk == current_clk) {
>  		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
> -	else
> +	} else {
>  		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
>  				((fls(DIV_ROUND_UP(current_clk,
>  						   clk) - 1) - 1) << 16));
> +	}
> 
>  	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
>  }
> @@ -980,10 +1033,42 @@ static void sh_mmcif_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
> 
>  static void sh_mmcif_clk_setup(struct sh_mmcif_host *host)
>  {
> +	struct device *dev = &host->pd->dev;
> +	const struct of_device_id *of_id = of_match_device(mmcif_of_match, dev);
>  	unsigned int clk = clk_get_rate(host->clk);
> 
> +	if (of_id) {
> +		struct device_node *np = dev->of_node;
> +		const struct sh_mmcif_ver *ver = of_id->data;
> +		u32 range[2]; /* min/max */
> +
> +		if (!ver)
> +			goto sh_mmcif_clk_setup_default;
> +
> +		if (0 != of_property_read_u32_array(np, "clk-range",
> +						    range, ARRAY_SIZE(range)))
> +			goto sh_mmcif_clk_setup_default;
> +
> +		if (range[0] > range[1])
> +			goto sh_mmcif_clk_setup_default;
> +
> +		host->mmc->f_min = range[0] / (1 << fls(ver->clkdiv_map));
> +		host->mmc->f_max = range[1] / (1 << ffs(ver->clkdiv_map));
> +
> +		dev_dbg(dev, "parent clk <%d - %d> (%d/%d)\n",
> +			range[0], range[1],
> +			host->mmc->f_max, host->mmc->f_min);
> +
> +		host->ver = ver;
> +		return;
> +	}
> +
> +sh_mmcif_clk_setup_default:
>  	host->mmc->f_max = clk / 2;
>  	host->mmc->f_min = clk / 512;
> +
> +	dev_dbg(dev, "clk max/min = %d/%d\n",
> +		host->mmc->f_max, host->mmc->f_min);
>  }
> 
>  static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios
> *ios)

-- 
Regards,

Laurent Pinchart

