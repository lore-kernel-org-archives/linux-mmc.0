From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 1/2] mmc: sdhci-msm: Add support to store supported
 vdd-io voltages
Date: Fri, 26 Jan 2018 10:10:56 +0200
Message-ID: <537c4fc7-6c0f-b356-ccc3-1bc306f45136@intel.com>
References: <1516262742-44326-1-git-send-email-vviswana@codeaurora.org>
 <1516262742-44326-2-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1516262742-44326-2-git-send-email-vviswana@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

On 18/01/18 10:05, Vijay Viswanath wrote:
> During probe check whether the vdd-io regulator of sdhc platform device
> can support 1.8V and 3V and store this information as a capability of
> platform device.
> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

Not sure why this is RFC, but for sdhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c283291..5c23e92 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -23,6 +23,7 @@
>  #include <linux/iopoll.h>
>  
>  #include "sdhci-pltfm.h"
> +#include <linux/regulator/consumer.h>
>  
>  #define CORE_MCI_VERSION		0x50
>  #define CORE_VERSION_MAJOR_SHIFT	28
> @@ -81,6 +82,9 @@
>  #define CORE_HC_SELECT_IN_HS400	(6 << 19)
>  #define CORE_HC_SELECT_IN_MASK	(7 << 19)
>  
> +#define CORE_3_0V_SUPPORT	(1 << 25)
> +#define CORE_1_8V_SUPPORT	(1 << 26)
> +
>  #define CORE_CSR_CDC_CTLR_CFG0		0x130
>  #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
>  #define CORE_HW_AUTOCAL_ENA		BIT(17)
> @@ -148,6 +152,7 @@ struct sdhci_msm_host {
>  	u32 curr_io_level;
>  	wait_queue_head_t pwr_irq_wait;
>  	bool pwr_irq_flag;
> +	u32 caps_0;
>  };
>  
>  static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
> @@ -1313,6 +1318,35 @@ static void sdhci_msm_writeb(struct sdhci_host *host, u8 val, int reg)
>  		sdhci_msm_check_power_status(host, req_type);
>  }
>  
> +static int sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
> +{
> +	struct mmc_host *mmc = msm_host->mmc;
> +	struct regulator *supply = mmc->supply.vqmmc;
> +	int i, count;
> +	u32 caps = 0, vdd_uV;
> +
> +	if (!IS_ERR(mmc->supply.vqmmc)) {
> +		count = regulator_count_voltages(supply);
> +		if (count < 0)
> +			return count;
> +		for (i = 0; i < count; i++) {
> +			vdd_uV = regulator_list_voltage(supply, i);
> +			if (vdd_uV <= 0)
> +				continue;
> +			if (vdd_uV > 2700000)
> +				caps |= CORE_3_0V_SUPPORT;
> +			if (vdd_uV < 1950000)
> +				caps |= CORE_1_8V_SUPPORT;
> +		}
> +	}
> +	msm_host->caps_0 |= caps;
> +	pr_debug("%s: %s: supported caps: 0x%08x\n", mmc_hostname(mmc),
> +			__func__, caps);
> +
> +	return 0;
> +}
> +
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4" },
>  	{},
> @@ -1530,6 +1564,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto pm_runtime_disable;
> +	ret = sdhci_msm_set_regulator_caps(msm_host);
> +	if (ret)
> +		dev_err(&pdev->dev, "%s: Failed to set regulator caps: %d\n",
> +				__func__, ret);
>  
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
> 
