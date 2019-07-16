From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
Date: Tue, 16 Jul 2019 13:39:37 +0300
Message-ID: <07e348a0-6a80-e176-d18d-6a1e54313fa6@intel.com>
References: <7ab490e5b311f6cb057c4663d69ef7cbe3318dae.1563266066.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ab490e5b311f6cb057c4663d69ef7cbe3318dae.1563266066.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc: vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 16/07/19 11:39 AM, Baolin Wang wrote:
> In sdhci_runtime_resume_host() function, we will always do software reset
> for all, which will cause Spreadtrum host controller work abnormally after
> resuming.
> 
> Thus for Spreadtrum platform that do not power down the SD/eMMC card during
> runtime suspend, we should not do software reset for all. To fix this
> issue, adding a specific reset operation that add one condition to validate
> the MMC_CAP_AGGRESSIVE_PM to decide if we can do software reset for all or
> just reset command and data lines.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> 
> Changes from v1:
>  - Add a specific reset operation instead of changing the core to avoid
>  affecting other hardware.
> ---
>  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 603a5d9..bc9393c 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>  	return 1 << 31;
>  }
>  
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +
> +	/*
> +	 * When try to reset controller after runtime suspend, we should not
> +	 * reset for all if the SD/eMMC card is not power down, just reset
> +	 * command and data lines instead. Otherwise will meet some strange
> +	 * behaviors for Spreadtrum host controller.
> +	 */
> +	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> +	    !(mmc->caps & MMC_CAP_AGGRESSIVE_PM))

MMC_CAP_AGGRESSIVE_PM does not necessarily mean that the card will have been
runtime suspended.

What about checking if the card power is on? i.e.

	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
	    mmc->ios.power_mode == MMC_POWER_ON)

> +		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +
> +	sdhci_reset(host, mask);
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>  	.read_l = sdhci_sprd_readl,
>  	.write_l = sdhci_sprd_writel,
> @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>  	.get_max_clock = sdhci_sprd_get_max_clock,
>  	.get_min_clock = sdhci_sprd_get_min_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_sprd_reset,
>  	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
>  	.hw_reset = sdhci_sprd_hw_reset,
>  	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> 
