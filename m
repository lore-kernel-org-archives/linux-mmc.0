From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 2/3] mmc: Add APM X-Gene SoC SDHC controller support
 to Arasan SDHCI driver
Date: Wed, 4 Jun 2014 08:09:12 +0200
Message-ID: <9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
 <1401829985-5212-2-git-send-email-lho@apm.com>
 <1401829985-5212-3-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:46068
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751963AbaFDGJT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jun 2014 02:09:19 -0400
In-Reply-To: <1401829985-5212-3-git-send-email-lho@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loc Ho <lho@apm.com>, chris@printf.net, ulf.hansson@linaro.org, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com

On 06/03/2014 11:13 PM, Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC SDHC controller
> to Arasan SDHCI driver.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/mmc/host/Kconfig           |    4 +-
>  drivers/mmc/host/sdhci-of-arasan.c |  126 +++++++++++++++++++++++++++++++++---
>  2 files changed, 120 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8aaf8c1..7ec5414 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -108,9 +108,11 @@ config MMC_SDHCI_OF_ARASAN
>  	tristate "SDHCI OF support for the Arasan SDHCI controllers"
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Arasan Secure Digital Host Controller Interface
> -	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
> +	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq and X-Gene
> +	  SoC.
>  
>  	  If you have a controller with this interface, say Y or M here.
>  
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index f7c7cf6..4f1313c 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -20,6 +20,8 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_device.h>

Keep headers sorted.

>  #include "sdhci-pltfm.h"
>  
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> @@ -34,6 +36,19 @@
>   */
>  struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
> +	struct platform_device *pdev;
> +	void __iomem	*ahb_aim_csr;
> +	const struct sdhci_arasan_ahb_ops *ahb_ops;
> +};
> +
> +/**
> + * struct sdhci_arasan_ahb_ops
> + * @init_ahb	Initialize translation bus
> + * @xlat_addr	Set up an 64-bit addressing translation

This definitely breaking kernel-doc format. Please fix.

> + */
> +struct sdhci_arasan_ahb_ops {
> +	int (*init_ahb)(struct sdhci_arasan_data *data);
> +	void (*xlat_addr)(struct sdhci_arasan_data *data, u64 dma_addr);
>  };
>  
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
> @@ -51,7 +66,21 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>  	return freq;
>  }
>  
> +static void sdhci_arasan_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> +
> +	if (reg == SDHCI_DMA_ADDRESS) {
> +		if (sdhci_arasan->ahb_ops && sdhci_arasan->ahb_ops->xlat_addr)

just one if here.

> +			sdhci_arasan->ahb_ops->xlat_addr(sdhci_arasan,
> +				sg_dma_address(host->data->sg));
> +	}
> +	writel(val, host->ioaddr + reg);
> +}

The same code was submitted in v1 and Arnd commented it but you are still keeping
it here. Why?

> +
>  static struct sdhci_ops sdhci_arasan_ops = {
> +	.write_l = sdhci_arasan_writel,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
>  };
> @@ -121,13 +150,83 @@ static int sdhci_arasan_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>  			 sdhci_arasan_resume);
>  
> +static int sdhci_arasan_xgene_init_ahb(struct sdhci_arasan_data *data)
> +{
> +	#define AIM_SIZE_CTL_OFFSET	0x00000004
> +	#define  AIM_EN_N_WR(src)	(((u32) (src) << 31) & 0x80000000)
> +	#define  ARSB_WR(src)		(((u32) (src) << 24) & 0x0f000000)
> +	#define  AWSB_WR(src)		(((u32) (src) << 20) & 0x00f00000)
> +	#define  AIM_MASK_N_WR(src)	(((u32) (src)) & 0x000fffff)

Remove that one more space between #define and name.
I am not fan of having these defines just here - move them to the top.

Also these macros are used just here at one location.
Isn't it better just to define that BITS you want to setup instead of
these macros which are hardly to read?

> +
> +	struct sdhci_host *host = platform_get_drvdata(data->pdev);
> +	int ret;
> +
> +	if (!data->ahb_aim_csr)
> +		return 0;
> +
> +	/*
> +	 * Setup AHB AIM windows ctrl register. The lower 32-bit is left
> +	 * at 0 while the upper bit are programmed when the buffer address
> +	 ( is set from function sdhci_arasn_writel.

broken comment.

> +	 */
> +	writel(AIM_EN_N_WR(1) | ARSB_WR(1) | AWSB_WR(1) | AIM_MASK_N_WR(0),
> +	       data->ahb_aim_csr + AIM_SIZE_CTL_OFFSET);
> +
> +	/* Set DMA mask */
> +	ret = dma_set_mask_and_coherent(&data->pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(&data->pdev->dev, "Unable to set dma mask\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * This shouldn't be necessary. Just in case the FW doesn't
> +	 * configure disable ADMA support as we can't support multiple
> +	 * DMA buffer whose address is 64-bit. The AHB translation bridge
> +	 * only has 8 entry max and that is required to be shared and
> +	 * upper layer can pass more than 8 buffer pointers.
> +	 */
> +	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +	return 0;
> +}
> +
> +static void sdhci_arasn_xgene_xlat_addr(struct sdhci_arasan_data *data,
> +				       u64 dma_addr)
> +{
> +	#define AIM_AXI_HI_OFFSET	0x0000000c
> +	#define  AIM_AXI_ADDRESS_HI_N_WR(src) \
> +					(((u32) (src) << 20) & 0xfff00000)

ditto with indentation.
20 should be shift
0xfff00000 is mask.

Also you should take this opportunity and add function description
in kernel doc to be exactly clear what this function is doing.

> +
> +	if (!data->ahb_aim_csr)
> +		return;
> +
> +	writel(AIM_AXI_ADDRESS_HI_N_WR(dma_addr >> 32),
> +		data->ahb_aim_csr + AIM_AXI_HI_OFFSET);
> +}
> +
> +static const struct sdhci_arasan_ahb_ops xgene_ahb_ops = {
> +	.init_ahb = sdhci_arasan_xgene_init_ahb,
> +	.xlat_addr = sdhci_arasn_xgene_xlat_addr,
> +};
> +
> +static const struct of_device_id sdhci_arasan_of_match[] = {
> +	{ .compatible = "arasan,sdhci-8.9a" },
> +	{ .compatible = "apm,arasan,sdhci-8.9a", .data = &xgene_ahb_ops },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> +
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
>  	int ret;
> -	struct clk *clk_xin;
> +	struct clk *clk_xin = NULL;
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_arasan_data *sdhci_arasan;
> +	const struct of_device_id *of_id =
> +			of_match_device(sdhci_arasan_of_match, &pdev->dev);
> +	struct resource *res;
>  
>  	sdhci_arasan = devm_kzalloc(&pdev->dev, sizeof(*sdhci_arasan),
>  			GFP_KERNEL);
> @@ -136,8 +235,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
>  	if (IS_ERR(sdhci_arasan->clk_ahb)) {
> -		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
> -		return PTR_ERR(sdhci_arasan->clk_ahb);
> +		/* Clock is optional */
> +		sdhci_arasan->clk_ahb = NULL;
> +		goto skip_clk;

Clocks are optional for your SoC but they are necessary for Zynq.
You can't just skip clocks for zynq because if DT is wrong clocks won't be enabled
and even checked.
Does it mean that there are no clocks for this IP?
Or do you miss clock driver?

Thanks,
Michal

