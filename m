From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 6/8] mmc: dw_mmc-rockchip: MMC tuning with the clock
 phase framework
Date: Thu, 08 Oct 2015 10:16:06 +0900
Message-ID: <5615C3D6.3030005@samsung.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <1443622064-14362-7-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46814 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbJHBQJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2015 21:16:09 -0400
In-reply-to: <1443622064-14362-7-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org

Hi, Heiko.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung


On 09/30/2015 11:07 PM, Heiko Stuebner wrote:
> From: Alexandru M Stan <amstan@chromium.org>
> 
> This algorithm will try 1 degree increments, since there's no way to tell
> what resolution the underlying phase code uses. As an added bonus, doing
> many tunings yields better results since some tests are run more than once
> (ex: if the underlying driver uses 45 degree increments, the tuning code
> will try the same angle more than once).
> 
> It will then construct a list of good phase ranges (even ranges that cross
> 360/0), will pick the biggest range then it will set the sample_clk to the
> middle of that range.
> 
> We do not touch ciu_drive (and by extension define default-drive-phase).
> Drive phase is mostly used to define minimum hold times, while one could
> write some code to determine what phase meets the minimum hold time (ex 10
> degrees) this will not work with the current clock phase framework (which
> floors angles, so we'll get 0 deg, and there's no way to know what
> resolution the floors happen at). We assume that the default drive angles
> set by the hardware are good enough.
> 
> If a device has device specific code (like exynos) then that will still
> take precedence, otherwise this new code will execute. If the device wants
> to tune, but has no sample_clk defined we'll return EIO with an error
> message.
> 
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 162 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index bc76aa2..4b3650f 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -13,12 +13,19 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/dw_mmc.h>
>  #include <linux/of_address.h>
> +#include <linux/slab.h>
>  
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>  
>  #define RK3288_CLKGEN_DIV       2
>  
> +struct dw_mci_rockchip_priv_data {
> +	struct clk		*drv_clk;
> +	struct clk		*sample_clk;
> +	int			default_sample_phase;
> +};
> +
>  static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
>  {
>  	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
> @@ -33,6 +40,7 @@ static int dw_mci_rk3288_setup_clock(struct dw_mci *host)
>  
>  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
> +	struct dw_mci_rockchip_priv_data *priv = host->priv;
>  	int ret;
>  	unsigned int cclkin;
>  	u32 bus_hz;
> @@ -66,6 +74,158 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  		/* force dw_mci_setup_bus() */
>  		host->current_speed = 0;
>  	}
> +
> +	/* Make sure we use phases which we can enumerate with */
> +	if (!IS_ERR(priv->sample_clk))
> +		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> +}
> +
> +#define NUM_PHASES			360
> +#define TUNING_ITERATION_TO_PHASE(i)	(DIV_ROUND_UP((i) * 360, NUM_PHASES))
> +
> +static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot)
> +{
> +	struct dw_mci *host = slot->host;
> +	struct dw_mci_rockchip_priv_data *priv = host->priv;
> +	struct mmc_host *mmc = slot->mmc;
> +	int ret = 0;
> +	int i;
> +	bool v, prev_v = 0, first_v;
> +	struct range_t {
> +		int start;
> +		int end; /* inclusive */
> +	};
> +	struct range_t *ranges;
> +	unsigned int range_count = 0;
> +	int longest_range_len = -1;
> +	int longest_range = -1;
> +	int middle_phase;
> +
> +	if (IS_ERR(priv->sample_clk)) {
> +		dev_err(host->dev, "Tuning clock (sample_clk) not defined.\n");
> +		return -EIO;
> +	}
> +
> +	ranges = kmalloc_array(NUM_PHASES / 2 + 1, sizeof(*ranges), GFP_KERNEL);
> +	if (!ranges)
> +		return -ENOMEM;
> +
> +	/* Try each phase and extract good ranges */
> +	for (i = 0; i < NUM_PHASES; ) {
> +		clk_set_phase(priv->sample_clk, TUNING_ITERATION_TO_PHASE(i));
> +
> +		v = !mmc_send_tuning(mmc);
> +
> +		if (i == 0)
> +			first_v = v;
> +
> +		if ((!prev_v) && v) {
> +			range_count++;
> +			ranges[range_count-1].start = i;
> +		}
> +		if (v) {
> +			ranges[range_count-1].end = i;
> +			i++;
> +		} else if (i == NUM_PHASES - 1) {
> +			/* No extra skipping rules if we're at the end */
> +			i++;
> +		} else {
> +			/*
> +			 * No need to check too close to an invalid
> +			 * one since testing bad phases is slow.  Skip
> +			 * 20 degrees.
> +			 */
> +			i += DIV_ROUND_UP(20 * NUM_PHASES, 360);
> +
> +			/* Always test the last one */
> +			if (i >= NUM_PHASES)
> +				i = NUM_PHASES - 1;
> +		}
> +
> +		prev_v = v;
> +	}
> +
> +	if (range_count == 0) {
> +		dev_warn(host->dev, "All phases bad!");
> +		ret = -EIO;
> +		goto free;
> +	}
> +
> +	/* wrap around case, merge the end points */
> +	if ((range_count > 1) && first_v && v) {
> +		ranges[0].start = ranges[range_count-1].start;
> +		range_count--;
> +	}
> +
> +	if (ranges[0].start == 0 && ranges[0].end == NUM_PHASES - 1) {
> +		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> +		dev_info(host->dev, "All phases work, using default phase %d.",
> +			 priv->default_sample_phase);
> +		goto free;
> +	}
> +
> +	/* Find the longest range */
> +	for (i = 0; i < range_count; i++) {
> +		int len = (ranges[i].end - ranges[i].start + 1);
> +
> +		if (len < 0)
> +			len += NUM_PHASES;
> +
> +		if (longest_range_len < len) {
> +			longest_range_len = len;
> +			longest_range = i;
> +		}
> +
> +		dev_dbg(host->dev, "Good phase range %d-%d (%d len)\n",
> +			TUNING_ITERATION_TO_PHASE(ranges[i].start),
> +			TUNING_ITERATION_TO_PHASE(ranges[i].end),
> +			len
> +		);
> +	}
> +
> +	dev_dbg(host->dev, "Best phase range %d-%d (%d len)\n",
> +		TUNING_ITERATION_TO_PHASE(ranges[longest_range].start),
> +		TUNING_ITERATION_TO_PHASE(ranges[longest_range].end),
> +		longest_range_len
> +	);
> +
> +	middle_phase = ranges[longest_range].start + longest_range_len / 2;
> +	middle_phase %= NUM_PHASES;
> +	dev_info(host->dev, "Successfully tuned phase to %d\n",
> +		 TUNING_ITERATION_TO_PHASE(middle_phase));
> +
> +	clk_set_phase(priv->sample_clk,
> +		      TUNING_ITERATION_TO_PHASE(middle_phase));
> +
> +free:
> +	kfree(ranges);
> +	return ret;
> +}
> +
> +static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> +{
> +	struct device_node *np = host->dev->of_node;
> +	struct dw_mci_rockchip_priv_data *priv;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32(np, "rockchip,default-sample-phase",
> +					&priv->default_sample_phase))
> +		priv->default_sample_phase = 0;
> +
> +	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
> +	if (IS_ERR(priv->drv_clk))
> +		dev_dbg(host->dev, "ciu_drv not available\n");
> +
> +	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
> +	if (IS_ERR(priv->sample_clk))
> +		dev_dbg(host->dev, "ciu_sample not available\n");
> +
> +	host->priv = priv;
> +
> +	return 0;
>  }
>  
>  static int dw_mci_rockchip_init(struct dw_mci *host)
> @@ -95,6 +255,8 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
>  	.caps			= dw_mci_rk3288_dwmmc_caps,
>  	.prepare_command        = dw_mci_rockchip_prepare_command,
>  	.set_ios		= dw_mci_rk3288_set_ios,
> +	.execute_tuning		= dw_mci_rk3288_execute_tuning,
> +	.parse_dt		= dw_mci_rk3288_parse_dt,
>  	.setup_clock    = dw_mci_rk3288_setup_clock,
>  	.init			= dw_mci_rockchip_init,
>  };
> 

