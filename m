From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 1/2] mmc: sdhci-brcmstb: Add driver for Broadcom
 BRCMSTB SoCs
Date: Wed, 15 Jun 2016 12:12:27 +0300
Message-ID: <57611BFB.6030205@intel.com>
References: <1465918636-21034-1-git-send-email-alcooperx@gmail.com>
 <1465918636-21034-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32047 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459AbcFOJQc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Jun 2016 05:16:32 -0400
In-Reply-To: <1465918636-21034-2-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 14/06/16 18:37, Al Cooper wrote:
> Add SDHCI driver for Broadcom BRCMSTB SoCs.
> This driver works with all ARM based SoCs and the 7425, 7429
> and 7435 MIPS based SoCs.
> 
> The driver disables all UHS speed modes by default and relies
> on the Device Tree node properties to enable these modes for
> SoC/Board combinations that support them.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Apart from a minor comment below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  MAINTAINERS                      |   7 ++
>  drivers/mmc/host/Kconfig         |  11 +++
>  drivers/mmc/host/Makefile        |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c | 143 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-brcmstb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a929db8..5b76de9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10190,6 +10190,13 @@ F:	tools/testing/selftests/seccomp/*
>  K:	\bsecure_computing
>  K:	\bTIF_SECCOMP\b
>  
> +SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-mmc@vger.kernel.org
> +L:	bcm-kernel-feedback-list@broadcom.com
> +S:	Maintained
> +F:	drivers/mmc/host/sdhci-brcmstb*
> +
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
>  M:	Ben Dooks <ben-linux@fluff.org>
>  M:	Jaehoon Chung <jh80.chung@samsung.com>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0aa484c..1038c9a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -798,3 +798,14 @@ config MMC_SDHCI_MICROCHIP_PIC32
>            If you have a controller with this interface, say Y or M here.
>  
>            If unsure, say N.
> +config MMC_SDHCI_BRCMSTB
> +	tristate "Broadcom SDIO/SD/MMC support"
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +	depends on MMC_SDHCI_PLTFM
> +	default y
> +	select MMC_SDHCI_IO_ACCESSORS

Doesn't look like you are using SDHCI I/O accessors.

> +	help
> +	  This selects support for the SDIO/SD/MMC Host Controller on
> +	  Broadcom STB SoCs.
> +
> +	  If unsure, say Y.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index af918d2..2075c11 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
>  obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
> +obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
>  
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+= -DDEBUG
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> new file mode 100644
> index 0000000..cce10fe
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -0,0 +1,143 @@
> +/*
> + * sdhci-brcmstb.c Support for SDHCI on Broadcom BRCMSTB SoC's
> + *
> + * Copyright (C) 2015 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int sdhci_brcmstb_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int res;
> +
> +	res = sdhci_suspend_host(host);
> +	if (res)
> +		return res;
> +	clk_disable_unprepare(pltfm_host->clk);
> +	return res;
> +}
> +
> +static int sdhci_brcmstb_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int err;
> +
> +	err = clk_prepare_enable(pltfm_host->clk);
> +	if (err)
> +		return err;
> +	return sdhci_resume_host(host);
> +}
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
> +			sdhci_brcmstb_resume);
> +
> +static const struct sdhci_ops sdhci_brcmstb_ops = {
> +	.set_clock = sdhci_set_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
> +	.ops = &sdhci_brcmstb_ops,
> +};
> +
> +static int sdhci_brcmstb_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct clk *clk;
> +	int res;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Clock not found in Device Tree\n");
> +		clk = NULL;
> +	}
> +	res = clk_prepare_enable(clk);
> +	if (res)
> +		return res;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_brcmstb_pdata, 0);
> +	if (IS_ERR(host)) {
> +		res = PTR_ERR(host);
> +		goto err_clk;
> +	}
> +
> +	/* Enable MMC_CAP2_HC_ERASE_SZ for better max discard calculations */
> +	host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
> +
> +	sdhci_get_of_property(pdev);
> +	mmc_of_parse(host->mmc);
> +
> +	/*
> +	 * Supply the existing CAPS, but clear the UHS modes. This
> +	 * will allow these modes to be specified by device tree
> +	 * properties through mmc_of_parse().
> +	 */
> +	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
> +			SDHCI_SUPPORT_DDR50);
> +	host->quirks |= SDHCI_QUIRK_MISSING_CAPS |
> +		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +
> +	res = sdhci_add_host(host);
> +	if (res)
> +		goto err;
> +
> +	pltfm_host = sdhci_priv(host);
> +	pltfm_host->clk = clk;
> +	return res;
> +
> +err:
> +	sdhci_pltfm_free(pdev);
> +err_clk:
> +	clk_disable_unprepare(clk);
> +	return res;
> +}
> +
> +static const struct of_device_id sdhci_brcm_of_match[] = {
> +	{ .compatible = "brcm,bcm7425-sdhci" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> +
> +static struct platform_driver sdhci_brcmstb_driver = {
> +	.driver		= {
> +		.name	= "sdhci-brcmstb",
> +		.owner	= THIS_MODULE,
> +		.pm	= &sdhci_brcmstb_pmops,
> +		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
> +	},
> +	.probe		= sdhci_brcmstb_probe,
> +	.remove		= sdhci_pltfm_unregister,
> +};
> +
> +module_platform_driver(sdhci_brcmstb_driver);
> +
> +MODULE_DESCRIPTION("SDHCI driver for Broadcom BRCMSTB SoCs");
> +MODULE_AUTHOR("Broadcom");
> +MODULE_LICENSE("GPL v2");
> 

