From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add pinctrl support
Date: Tue, 19 Jan 2016 11:07:23 +0100
Message-ID: <7857448.fZE0EdmvdR@phil>
References: <1453197165-20194-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:42099 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932623AbcASKHg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jan 2016 05:07:36 -0500
In-Reply-To: <1453197165-20194-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com

Hi Shawn,

Am Dienstag, 19. Januar 2016, 17:52:45 schrieb Shawn Lin:
> We find rk3368 fail to enumerate sd card since
> the default state is gpio function. Meahwhile, lots of
> rockchip platform dts file assign pinctrl to dw_mmc but actually
> dw_mmc never use it. Fortunately, those platforms' default io
> state is sdmmc function, but no always right for all.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I do believe any issue you see, must come from somewhere else, because the 
driver-core does in drivers/base/dd.c really_probe():
	pinctrl_bind_pins()
which in turn already does the needed pinctrl state handling.

So that default-state should be set up even before the dwmmc probe function 
is called.

The sharing between sdmmc and uart2 pins is the same on the rk3036 and so 
far Caesar seems to have been able to switch the pin-state to sdmmc without 
touching the dw_mmc driver itself.


Heiko


> ---
> 
>  drivers/mmc/host/dw_mmc-rockchip.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
> b/drivers/mmc/host/dw_mmc-rockchip.c index d9c92f3..308b424 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -9,6 +9,7 @@
> 
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/clk.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/dw_mmc.h>
> @@ -21,6 +22,8 @@
>  #define RK3288_CLKGEN_DIV       2
> 
>  struct dw_mci_rockchip_priv_data {
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pins_default;
>  	struct clk		*drv_clk;
>  	struct clk		*sample_clk;
>  	int			default_sample_phase;
> @@ -78,6 +81,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host,
> struct mmc_ios *ios) /* Make sure we use phases which we can enumerate
> with */
>  	if (!IS_ERR(priv->sample_clk))
>  		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> +
> +	/* Make sure we use correct pinctrl which we can enumerate with */
> +	if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_default))
> +		pinctrl_select_state(priv->pinctrl, priv->pins_default);
>  }
> 
>  #define NUM_PHASES			360
> @@ -223,6 +230,14 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci
> *host) if (IS_ERR(priv->sample_clk))
>  		dev_dbg(host->dev, "ciu_sample not available\n");
> 
> +	priv->pinctrl = devm_pinctrl_get(host->dev);
> +	if (!IS_ERR(priv->pinctrl)) {
> +		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
> +							  "default");
> +		if (IS_ERR(priv->pins_default))
> +			dev_dbg(host->dev, "pinctrl not available\n");
> +	}
> +
>  	host->priv = priv;
> 
>  	return 0;

