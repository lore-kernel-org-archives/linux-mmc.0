From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v3, 2/7] mmc: sdhci-of-esdhc: add support for signal voltage
 switch
Date: Mon, 10 Apr 2017 15:37:50 +0300
Message-ID: <e7e08c87-ecd6-ab24-636c-7707a5172b08@intel.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <1490600982-5410-3-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17997 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753165AbdDJMnd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Apr 2017 08:43:33 -0400
In-Reply-To: <1490600982-5410-3-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 27/03/17 10:49, Yangbo Lu wrote:
> eSDHC supports signal voltage switch from 3.3v to 1.8v by
> eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
> signal SDHC_VS, and there must be a control circuit out of eSDHC
> to change the signal voltage according to SDHC_VS output signal.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Apart from minor comment below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes for v2:
> 	- Used Adrain's method to support voltage switching:
>           host->mmc_host_ops.start_signal_voltage_switch =
>                      esdhc_signal_voltage_switch;
> Changes for v3:
> 	- Put .start_signal_voltage_switch assigning after IS_ERR(host) check.
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  1 +
>  drivers/mmc/host/sdhci-of-esdhc.c | 74 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 5343fc0..6869567 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -37,6 +37,7 @@
>  
>  /* Protocol Control Register */
>  #define ESDHC_PROCTL			0x28
> +#define ESDHC_VOLT_SEL			0x00000400
>  #define ESDHC_CTRL_4BITBUS		(0x1 << 1)
>  #define ESDHC_CTRL_8BITBUS		(0x2 << 1)
>  #define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7ce1caf..a70499a 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/sys_soc.h>
> @@ -559,6 +560,76 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
>  
> +/* The SCFG, Supplemental Configuration Unit, provides SoC specific
> + * configuration and status registers for the device. There is a
> + * SDHC IO VSEL control register on SCFG for some platforms. It's
> + * used to support SDHC IO voltage switching.
> + */
> +static const struct of_device_id scfg_device_ids[] = {
> +	{ .compatible = "fsl,t1040-scfg", },
> +	{ .compatible = "fsl,ls1012a-scfg", },
> +	{ .compatible = "fsl,ls1046a-scfg", },
> +	{}
> +};
> +
> +/* SDHC IO VSEL control register definition */
> +#define SCFG_SDHCIOVSELCR	0x408
> +#define SDHCIOVSELCR_TGLEN	0x80000000
> +#define SDHCIOVSELCR_VSELVAL	0x60000000
> +#define SDHCIOVSELCR_SDHC_VS	0x00000001
> +
> +static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
> +				       struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct device_node *scfg_node;
> +	void __iomem *scfg_base = NULL;
> +	u32 sdhciovselcr;
> +	u32 val;
> +
> +	/*
> +	 * Signal Voltage Switching is only applicable for Host Controllers
> +	 * v3.00 and above.
> +	 */
> +	if (host->version < SDHCI_SPEC_300)
> +		return 0;
> +
> +	val = sdhci_readl(host, ESDHC_PROCTL);
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		val &= ~ESDHC_VOLT_SEL;
> +		sdhci_writel(host, val, ESDHC_PROCTL);
> +		return 0;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		scfg_node = of_find_matching_node(NULL, scfg_device_ids);
> +		if (scfg_node)
> +			scfg_base = of_iomap(scfg_node, 0);
> +		if (scfg_base) {
> +			sdhciovselcr = SDHCIOVSELCR_TGLEN |
> +				       SDHCIOVSELCR_VSELVAL;
> +			iowrite32be(sdhciovselcr,
> +				scfg_base + SCFG_SDHCIOVSELCR);

In other places there is support for little endian also, so why not here?

> +
> +			val |= ESDHC_VOLT_SEL;
> +			sdhci_writel(host, val, ESDHC_PROCTL);
> +			mdelay(5);
> +
> +			sdhciovselcr = SDHCIOVSELCR_TGLEN |
> +				       SDHCIOVSELCR_SDHC_VS;
> +			iowrite32be(sdhciovselcr,
> +				scfg_base + SCFG_SDHCIOVSELCR);
> +			iounmap(scfg_base);
> +		} else {
> +			val |= ESDHC_VOLT_SEL;
> +			sdhci_writel(host, val, ESDHC_PROCTL);
> +		}
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static u32 esdhc_proctl;
>  static int esdhc_of_suspend(struct device *dev)
> @@ -714,6 +785,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	host->mmc_host_ops.start_signal_voltage_switch =
> +		esdhc_signal_voltage_switch;
> +
>  	esdhc_init(pdev, host);
>  
>  	sdhci_get_of_property(pdev);
> 

