From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Date: Fri, 28 Dec 2018 10:58:00 +0200
Message-ID: <317b5abe-894a-097a-cbfa-0cab5e253a0d@intel.com>
References: <1545947882-18875-1-git-send-email-skomatineni@nvidia.com>
 <1545947882-18875-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545947882-18875-3-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, mperttunen@nvidia.com
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27/12/18 11:58 PM, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
> 
> Tegra SDHCI with Quirk SDHCI_QUIRK2_BROKEN_64_BIT_DMA disables the
> use of 64_BIT DMA to disable 64-bit addressing mode access to the
> system memory and sdhci_cqe_enable using flag SDHCI_USE_64_BIT_DMA
> for ADMA32/ADMA2 Vs ADMA64/ADMA3 DMA selection.
> 
> CQE need to use ADMA3 as it need to fetch task descriptor along
> with transfer descriptor, so this patch forces DMA Select to be
> ADMA3 for CQE.

I don't understand why you use the term "ADMA3" since it is not CQE
terminology, can be 32-bit or 64-bit, and, from the driver point of view,
has quite different requirements from CQE.

It seems you are saying that Tegra supports only 32-bit DMA but must select
64-bit DMA for CQE?  Can you clarify this a bit?

> 
> Tegra SDMMC Host design prevents write access to BLOCK_COUNT
> registers when CQE is enabled to prevent SW from updating block
> size during Command Queue mode.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 107 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c       |   6 ++-
>  3 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739d9744..5aa2de2c7609 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,7 @@ config MMC_SDHCI_TEGRA
>  	depends on ARCH_TEGRA
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Tegra SD/MMC controller. If you have a Tegra
>  	  platform with SD or MMC devices, say Y or M here.
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7b95d088fdef..7beecd1da94a 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -33,6 +33,7 @@
>  #include <linux/ktime.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "cqhci.h"
>  
>  /* Tegra SDHOST controller vendor register definitions */
>  #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
> @@ -89,6 +90,9 @@
>  #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
>  #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
>  
> +/* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> +#define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> +
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u32 nvquirks;
> @@ -128,6 +132,7 @@ struct sdhci_tegra {
>  	u32 default_tap;
>  	u32 default_trim;
>  	u32 dqs_trim;
> +	bool enable_hwcq;
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -836,6 +841,49 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  		tegra_host->pad_calib_required = true;
>  }
>  
> +static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u32 cqcfg = 0;
> +
> +	/* Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
> +	 * registers when CQE is enabled.
> +	 */
> +	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
> +	if (cqcfg & CQHCI_ENABLE)
> +		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
> +
> +	sdhci_cqe_enable(mmc);
> +
> +	if (cqcfg & CQHCI_ENABLE)
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
> +}
> +
> +static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
> +	.enable	= sdhci_tegra_cqe_enable,
> +	.disable = sdhci_cqe_disable,
> +	.dumpregs = sdhci_tegra_dumpregs,
> +};
> +
>  static const struct sdhci_ops tegra_sdhci_ops = {
>  	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
> @@ -989,6 +1037,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch = tegra_sdhci_voltage_switch,
>  	.get_max_clock = tegra_sdhci_get_max_clock,
> +	.irq = sdhci_tegra_cqhci_irq,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> @@ -1030,6 +1079,55 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
>  
> +static int sdhci_tegra_add_host(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	if (!tegra_host->enable_hwcq)
> +		return sdhci_add_host(host);
> +
> +	host->v4_mode = true;
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	cq_host = devm_kzalloc(host->mmc->parent,
> +				sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
> +	cq_host->ops = &sdhci_tegra_cqhci_ops;
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +
> +}
> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -1039,6 +1137,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	struct sdhci_tegra *tegra_host;
>  	struct clk *clk;
>  	int rc;
> +	struct resource *iomem;
>  
>  	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
>  	if (!match)
> @@ -1056,6 +1155,12 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	tegra_host->pad_control_available = false;
>  	tegra_host->soc_data = soc_data;
>  
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (resource_size(iomem) > SDHCI_TEGRA_CQE_BASE_ADDR)
> +		tegra_host->enable_hwcq = true;
> +	else
> +		tegra_host->enable_hwcq = false;
> +
>  	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
>  		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
>  		if (rc == 0)
> @@ -1117,7 +1222,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  
>  	usleep_range(2000, 4000);
>  
> -	rc = sdhci_add_host(host);
> +	rc = sdhci_tegra_add_host(host);
>  	if (rc)
>  		goto err_add_host;
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fde984d10619..25683a935b30 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3308,7 +3308,11 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  	ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -	if (host->flags & SDHCI_USE_64_BIT_DMA)
> +	/* CQE need to use ADMA3 as it need to fetch task descriptor along
> +	 * with transfer descriptor, so force DMA Select to ADMA64 during CQE
> +	 */
> +	if ((host->flags & SDHCI_USE_64_BIT_DMA) ||
> +			(host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA))

SDHCI_QUIRK2_BROKEN_64_BIT_DMA is not meant for this purpose.  I guess one
alternative would be to set/clear SDHCI_USE_64_BIT_DMA before/after the call
to sdhci_cqe_enable().

>  		ctrl |= SDHCI_CTRL_ADMA64;
>  	else
>  		ctrl |= SDHCI_CTRL_ADMA32;
> 
