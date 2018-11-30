From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200
 tuning failures (i929)
Date: Fri, 30 Nov 2018 16:14:59 +0530
Message-ID: <0ede4e5c-0447-87ef-440e-871d076232eb@ti.com>
References: <20181129190503.6040-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129190503.6040-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

I forgot to mention that this patch goes on top of my series "Tuning
Fixes for sdhci-omap" series.

https://patchwork.kernel.org/project/linux-mmc/list/?series=44725

Thanks,
Faiz

On 30/11/18 12:35 AM, Faiz Abbas wrote:
> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> unexpected tuning pattern errors. A small failure band may be present
> in the tuning range which may be missed by the current algorithm.
> Furthermore, the failure bands vary with temperature leading to
> different optimum tuning values for different temperatures.
> 
> As suggested in the related Application Report (SPRACA9B - October 2017
> - Revised July 2018 [2]), tuning should be done in two stages.
> In stage 1, assign the optimum ratio in the maximum pass window for the
> current temperature. In stage 2, if the chosen value is close to the
> small failure band, move away from it in the appropriate direction.
> 
> References:
> [1] http://www.ti.com/lit/pdf/sprz426
> [2] http://www.ti.com/lit/pdf/SPRACA9
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/Kconfig      |  2 +
>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739d9744..6d3553f06f27 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -969,6 +969,8 @@ config MMC_SDHCI_XENON
>  config MMC_SDHCI_OMAP
>  	tristate "TI SDHCI Controller Support"
>  	depends on MMC_SDHCI_PLTFM && OF
> +	select THERMAL
> +	select TI_SOC_THERMAL
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's DRA7 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index b3cb39d0db6f..9ccce7ef3a60 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -27,6 +27,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sys_soc.h>
> +#include <linux/thermal.h>
>  
>  #include "sdhci-pltfm.h"
>  
> @@ -286,14 +287,18 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +	struct thermal_zone_device *thermal_dev;
>  	struct device *dev = omap_host->dev;
>  	struct mmc_ios *ios = &mmc->ios;
>  	u32 start_window = 0, max_window = 0;
> +	bool single_point_failure = false;
>  	u8 cur_match, prev_match = 0;
>  	u32 length = 0, max_len = 0;
>  	u32 phase_delay = 0;
> +	int temperature;
>  	int ret = 0;
>  	u32 reg;
> +	int i;
>  
>  	/* clock tuning is not needed for upto 52MHz */
>  	if (ios->clock <= 52000000)
> @@ -303,6 +308,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
>  		return 0;
>  
> +	thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
> +	if (IS_ERR(thermal_dev)) {
> +		dev_err(dev, "Unable to get thermal zone for tuning\n");
> +		return PTR_ERR(thermal_dev);
> +	}
> +
> +	ret = thermal_zone_get_temp(thermal_dev, &temperature);
> +	if (ret)
> +		return ret;
> +
>  	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_DLL);
>  	reg |= DLL_SWT;
>  	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
> @@ -317,6 +332,11 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	omap_host->is_tuning = true;
>  
> +	/*
> +	 * Stage 1: Search for a maximum pass window ignoring any
> +	 * any single point failures. If the tuning value ends up
> +	 * near it, move away from it in stage 2 below
> +	 */
>  	while (phase_delay <= MAX_PHASE_DELAY) {
>  		sdhci_omap_set_dll(omap_host, phase_delay);
>  
> @@ -324,10 +344,15 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		if (cur_match) {
>  			if (prev_match) {
>  				length++;
> +			} else if (single_point_failure) {
> +				/* ignore single point failure */
> +				length++;
>  			} else {
>  				start_window = phase_delay;
>  				length = 1;
>  			}
> +		} else {
> +			single_point_failure = prev_match;
>  		}
>  
>  		if (length > max_len) {
> @@ -345,13 +370,76 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		goto tuning_error;
>  	}
>  
> +	/*
> +	 * Assign tuning value as a ratio of maximum pass window based
> +	 * on temperature
> +	 */
> +	if (temperature < -20000)
> +		phase_delay = min(max_window + 4 * max_len - 24,
> +				  max_window +
> +				  DIV_ROUND_UP(13 * max_len, 16) * 4);
> +	else if (temperature < 20000)
> +		phase_delay = max_window + DIV_ROUND_UP(9 * max_len, 16) * 4;
> +	else if (temperature < 40000)
> +		phase_delay = max_window + DIV_ROUND_UP(8 * max_len, 16) * 4;
> +	else if (temperature < 70000)
> +		phase_delay = max_window + DIV_ROUND_UP(7 * max_len, 16) * 4;
> +	else if (temperature < 90000)
> +		phase_delay = max_window + DIV_ROUND_UP(5 * max_len, 16) * 4;
> +	else if (temperature < 120000)
> +		phase_delay = max_window + DIV_ROUND_UP(4 * max_len, 16) * 4;
> +	else
> +		phase_delay = max_window + DIV_ROUND_UP(3 * max_len, 16) * 4;
> +
> +	/*
> +	 * Stage 2: Search for a single point failure near the chosen tuning
> +	 * value in two steps. First in the +3 to +10 range and then in the
> +	 * +2 to -10 range. If found, move away from it in the appropriate
> +	 * direction by the appropriate amount depending on the temperature.
> +	 */
> +	for (i = 3; i <= 10; i++) {
> +		sdhci_omap_set_dll(omap_host, phase_delay + i);
> +
> +		if (mmc_send_tuning(mmc, opcode, NULL)) {
> +			if (temperature < 10000)
> +				phase_delay += i + 6;
> +			else if (temperature < 20000)
> +				phase_delay += i - 12;
> +			else if (temperature < 70000)
> +				phase_delay += i - 8;
> +			else
> +				phase_delay += i - 6;
> +
> +			goto single_failure_found;
> +		}
> +	}
> +
> +	for (i = 2; i >= -10; i--) {
> +		sdhci_omap_set_dll(omap_host, phase_delay + i);
> +
> +		if (mmc_send_tuning(mmc, opcode, NULL)) {
> +			if (temperature < 10000)
> +				phase_delay += i + 12;
> +			else if (temperature < 20000)
> +				phase_delay += i + 8;
> +			else if (temperature < 70000)
> +				phase_delay += i + 8;
> +			else if (temperature < 90000)
> +				phase_delay += i + 10;
> +			else
> +				phase_delay += i + 12;
> +
> +			goto single_failure_found;
> +		}
> +	}
> +
> +single_failure_found:
>  	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
>  	if (!(reg & AC12_SCLK_SEL)) {
>  		ret = -EIO;
>  		goto tuning_error;
>  	}
>  
> -	phase_delay = max_window + 4 * (max_len >> 1);
>  	sdhci_omap_set_dll(omap_host, phase_delay);
>  
>  	omap_host->is_tuning = false;
> 
