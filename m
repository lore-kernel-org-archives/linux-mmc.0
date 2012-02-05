From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tegra: Explicitly support Tegra30
Date: Sat, 04 Feb 2012 21:59:32 -0500
Message-ID: <m2ehua6l4b.fsf@bob.laptop.org>
References: <1328139055-25714-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36281 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab2BEC7m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 21:59:42 -0500
In-Reply-To: <1328139055-25714-1-git-send-email-swarren@nvidia.com> (Stephen
	Warren's message of "Wed, 1 Feb 2012 16:30:55 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 01 2012, Stephen Warren wrote:
> Tegra30 differs from Tegra20 in a number of ways. This patch implements a
> minimal set of differences in order to get the Cardhu board's SD slot and
> eMMC working. Given the diffs between the mainline sdhci-tegra.c and our
> downstream versions, I expect we'll eventually need to add many more
> differences, hence the seemingly heavy-weight addition of the soc_data
> structure.
>
> * Tegra30 doesn't need to override register access to SDHCI_HOST_VERSION or
>   SDHCI_INT_ENABLE.
>
> * Tegra30 needs quirk SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK.
>
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c |   98 +++++++++++++++++++++++++++++++++++-----
>  1 files changed, 86 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 78a36eb..f159dd6 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/gpio.h>
>  #include <linux/mmc/card.h>
> @@ -32,6 +33,19 @@
>  
>  #include "sdhci-pltfm.h"
>  
> +#define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
> +#define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
> +
> +struct sdhci_tegra_soc_data {
> +	struct sdhci_pltfm_data *pdata;
> +	u32 nvquirks;
> +};
> +
> +struct sdhci_tegra {
> +	const struct tegra_sdhci_platform_data *plat;
> +	const struct sdhci_tegra_soc_data *soc_data;
> +};
> +
>  static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
>  {
>  	u32 val;
> @@ -47,7 +61,12 @@ static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
>  {
> -	if (unlikely(reg == SDHCI_HOST_VERSION)) {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> +	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +
> +	if (unlikely((soc_data->nvquirks & NVQUIRK_FORCE_SDHCI_SPEC_200) &&
> +			(reg == SDHCI_HOST_VERSION))) {
>  		/* Erratum: Version register is invalid in HW. */
>  		return SDHCI_SPEC_200;
>  	}
> @@ -57,6 +76,10 @@ static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
>  
>  static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> +	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +
>  	/* Seems like we're getting spurious timeout and crc errors, so
>  	 * disable signalling of them. In case of real errors software
>  	 * timers should take care of eventually detecting them.
> @@ -66,7 +89,8 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
>  
>  	writel(val, host->ioaddr + reg);
>  
> -	if (unlikely(reg == SDHCI_INT_ENABLE)) {
> +	if (unlikely((soc_data->nvquirks & NVQUIRK_ENABLE_BLOCK_GAP_DET) &&
> +			(reg == SDHCI_INT_ENABLE))) {
>  		/* Erratum: Must enable block gap interrupt detection */
>  		u8 gap_ctrl = readb(host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
>  		if (val & SDHCI_INT_CARD_INT)
> @@ -77,10 +101,11 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
>  	}
>  }
>  
> -static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
> +static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
>  {
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(sdhci);
> -	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> +	const struct tegra_sdhci_platform_data *plat = tegra_host->plat;
>  
>  	if (!gpio_is_valid(plat->wp_gpio))
>  		return -1;
> @@ -99,7 +124,8 @@ static irqreturn_t carddetect_irq(int irq, void *data)
>  static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
> +	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> +	const struct tegra_sdhci_platform_data *plat = tegra_host->plat;
>  	u32 ctrl;
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> @@ -125,16 +151,44 @@ static struct sdhci_ops tegra_sdhci_ops = {
>  	.platform_8bit_width = tegra_sdhci_8bit,
>  };
>  
> -static struct sdhci_pltfm_data sdhci_tegra_pdata = {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +static struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_NO_HISPD_BIT |
> +		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
> +	.ops  = &tegra_sdhci_ops,
> +};
> +
> +static struct sdhci_tegra_soc_data soc_data_tegra20 = {
> +	.pdata = &sdhci_tegra20_pdata,
> +	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
> +		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
> +};
> +#endif
> +
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +static struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
>  	.ops  = &tegra_sdhci_ops,
>  };
>  
> +static struct sdhci_tegra_soc_data soc_data_tegra30 = {
> +	.pdata = &sdhci_tegra30_pdata,
> +};
> +#endif
> +
>  static const struct of_device_id sdhci_tegra_dt_match[] __devinitdata = {
> -	{ .compatible = "nvidia,tegra20-sdhci", },
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30},
> +#endif
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20},
> +#endif
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
> @@ -165,13 +219,22 @@ static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
>  
>  static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
> +	const struct sdhci_tegra_soc_data *soc_data;
> +	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct tegra_sdhci_platform_data *plat;
> -	struct sdhci_host *host;
> +	struct sdhci_tegra *tegra_host;
>  	struct clk *clk;
>  	int rc;
>  
> -	host = sdhci_pltfm_init(pdev, &sdhci_tegra_pdata);
> +	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
> +	if (match)
> +		soc_data = match->data;
> +	else
> +		soc_data = &soc_data_tegra20;
> +
> +	host = sdhci_pltfm_init(pdev, soc_data->pdata);
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> @@ -188,7 +251,17 @@ static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
>  		goto err_no_plat;
>  	}
>  
> -	pltfm_host->priv = plat;
> +	tegra_host = devm_kzalloc(&pdev->dev, sizeof(*tegra_host), GFP_KERNEL);
> +	if (!tegra_host) {
> +		dev_err(mmc_dev(host->mmc), "failed to allocate tegra_host\n");
> +		rc = -ENOMEM;
> +		goto err_no_plat;
> +	}
> +
> +	tegra_host->plat = plat;
> +	tegra_host->soc_data = soc_data;
> +
> +	pltfm_host->priv = tegra_host;
>  
>  	if (gpio_is_valid(plat->power_gpio)) {
>  		rc = gpio_request(plat->power_gpio, "sdhci_power");
> @@ -284,7 +357,8 @@ static int __devexit sdhci_tegra_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
> +	struct sdhci_tegra *tegra_host = pltfm_host->priv;
> +	const struct tegra_sdhci_platform_data *plat = tegra_host->plat;
>  	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
>  
>  	sdhci_remove_host(host, dead);

Thanks, pushed to mmc-next for 3.4 with trivial changes on top:

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f159dd6..ccbca0b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -184,10 +184,10 @@ static struct sdhci_tegra_soc_data soc_data_tegra30 = {
 
 static const struct of_device_id sdhci_tegra_dt_match[] __devinitdata = {
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
-	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30},
+	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 #endif
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20},
+	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
 #endif
 	{}
 };
@@ -401,5 +401,5 @@ static struct platform_driver sdhci_tegra_driver = {
 module_platform_driver(sdhci_tegra_driver);
 
 MODULE_DESCRIPTION("SDHCI driver for Tegra");
-MODULE_AUTHOR(" Google, Inc.");
+MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL v2");

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
