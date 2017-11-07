From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] sdhci-fujitsu: add support for setting the
 CMD_DAT_DELAY attribute
Date: Tue, 7 Nov 2017 10:52:14 +0200
Message-ID: <d8d0bd22-d04c-f90a-638c-d0f0fc7910f0@intel.com>
References: <20171106152923.32114-1-ard.biesheuvel@linaro.org>
 <20171106152923.32114-2-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171106152923.32114-2-ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 06/11/17 17:29, Ard Biesheuvel wrote:
> The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
> requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
> F_SDH30_ESD_CONTROL control register. So set this bit if the
> DT node has the 'fujitsu,cmd-dat-delay-select' property.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
> v3: don't reorder struct members to reduce padding
>     remove pr_info() and simplify conditional assignment
> v2: no change
> 
>  drivers/mmc/host/sdhci_f_sdh30.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 111b66f5439b..04ca0d33a521 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/clk.h>
>  
>  #include "sdhci-pltfm.h"
> @@ -47,6 +48,7 @@ struct f_sdhost_priv {
>  	struct clk *clk;
>  	u32 vendor_hs200;
>  	struct device *dev;
> +	bool enable_cmd_dat_delay;
>  };
>  
>  static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
> @@ -84,10 +86,19 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>  
>  static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>  {
> +	struct f_sdhost_priv *priv = sdhci_priv(host);
> +	u32 ctl;
> +
>  	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
>  		sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
>  
>  	sdhci_reset(host, mask);
> +
> +	if (priv->enable_cmd_dat_delay) {
> +		ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
> +		ctl |= F_SDH30_CMD_DAT_DELAY;
> +		sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
> +	}
>  }
>  
>  static const struct sdhci_ops sdhci_f_sdh30_ops = {
> @@ -126,6 +137,9 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
>  			SDHCI_QUIRK2_TUNING_WORK_AROUND;
>  
> +	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
> +						"fujitsu,cmd-dat-delay-select");
> +
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto err;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
