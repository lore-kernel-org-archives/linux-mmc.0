From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC
 dirver
Date: Wed, 11 Jul 2018 15:21:18 +0300
Message-ID: <1a96aba4-911e-5103-ac12-8c9ff1e6a8a4@intel.com>
References: <20180704174524.5f6d50fb@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180704174524.5f6d50fb@xhacker.debian>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Manjunath M B <Manjunath.MB@synopsys.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 04/07/18 12:45, Jisheng Zhang wrote:
> Add a driver for SDHCI OF Synopsys DesignWare Cores Mobile Storage
> Host Controller.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Apart from Ulf's comment:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++
>  drivers/mmc/host/Kconfig                      |  10 ++
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 117 ++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> new file mode 100644
> index 000000000000..ee4253b33be2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> @@ -0,0 +1,20 @@
> +* Synopsys DesignWare Cores Mobile Storage Host Controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "snps,dwcmshc-sdhci"
> +- reg: offset and length of the register set for the device.
> +- interrupts: a single interrupt specifier.
> +- clocks: Array of clocks required for SDHCI; requires at least one for
> +    core clock.
> +- clock-names: Array of names corresponding to clocks property; shall be
> +    "core" for core clock and "bus" for optional bus clock.
> +
> +Example:
> +	sdhci2: sdhci@aa0000 {
> +		compatible = "snps,dwcmshc-sdhci";
> +		reg = <0xaa0000 0x1000>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&emmcclk>;
> +		bus-width = <8>;
> +	}
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c199c996..23beb9ec6dbf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -176,6 +176,16 @@ config MMC_SDHCI_OF_HLWD
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_DWCMSHC
> +	tristate "SDHCI OF support for the Synopsys DWC MSHC"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  This selects Synopsys DesignWare Cores Mobile Storage Controller.
> +	  If you have a controller with this interface, say Y or M here.
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CADENCE
>  	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 85dc1322c3de..a18fbba1b97e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> +obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> new file mode 100644
> index 000000000000..93b613cd7c33
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Synopsys DesignWare Cores Mobile Storage Host Controller
> + *
> + * Copyright (C) 2018 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +struct dwcmshc_priv {
> +	/* bus clock */
> +	struct clk	*bus_clk;
> +};
> +
> +static const struct sdhci_ops sdhci_dwcmshc_ops = {
> +	.set_clock		= sdhci_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +	.reset			= sdhci_reset,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> +	.ops = &sdhci_dwcmshc_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +};
> +
> +static int dwcmshc_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct dwcmshc_priv *priv;
> +	int err;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> +				sizeof(struct dwcmshc_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> +	if (IS_ERR(pltfm_host->clk)) {
> +		err = PTR_ERR(pltfm_host->clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> +		goto free_pltfm;
> +	}
> +	err = clk_prepare_enable(pltfm_host->clk);
> +	if (err)
> +		goto free_pltfm;
> +
> +	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +	if (!IS_ERR(priv->bus_clk))
> +		clk_prepare_enable(priv->bus_clk);
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		goto err_clk;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	err = sdhci_add_host(host);
> +	if (err)
> +		goto err_clk;
> +
> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(priv->bus_clk);
> +free_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return err;
> +}
> +
> +static int dwcmshc_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhci_remove_host(host, 0);
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(priv->bus_clk);
> +
> +	sdhci_pltfm_free(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +	{ .compatible = "snps,dwcmshc-sdhci" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> +
> +static struct platform_driver sdhci_dwcmshc_driver = {
> +	.driver	= {
> +		.name	= "sdhci-dwcmshc",
> +		.of_match_table = sdhci_dwcmshc_dt_ids,
> +	},
> +	.probe	= dwcmshc_probe,
> +	.remove	= dwcmshc_remove,
> +};
> +module_platform_driver(sdhci_dwcmshc_driver);
> +
> +MODULE_DESCRIPTION("SDHCI platform driver for Synopsys DWC MSHC");
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> +MODULE_LICENSE("GPL v2");
> 
