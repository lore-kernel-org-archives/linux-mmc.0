From: Viresh KUMAR <viresh.kumar@st.com>
Subject: Re: [PATCH] sdhci-spear: ST SPEAr based SDHCI controller glue
Date: Mon, 10 May 2010 08:57:31 +0530
Message-ID: <4BE77D23.7080705@st.com>
References: <1273052118-15513-1-git-send-email-viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:53276 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754919Ab0EJD14 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 May 2010 23:27:56 -0400
In-Reply-To: <1273052118-15513-1-git-send-email-viresh.kumar@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh KUMAR <viresh.kumar@st.com>
Cc: pierre@ossman.eu, linux-mmc@vger.kernel.org, shiraz.hashim@st.com

On 5/5/2010 3:05 PM, Viresh KUMAR wrote:
> This patch adds glue layer for support of sdhci driver on ST SPEAr platform.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  MAINTAINERS                     |    6 +
>  drivers/mmc/host/Kconfig        |   12 ++
>  drivers/mmc/host/Makefile       |    1 +
>  drivers/mmc/host/sdhci-spear.c  |  300 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/sdhci-spear.h |   42 ++++++
>  5 files changed, 361 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-spear.c
>  create mode 100644 include/linux/mmc/sdhci-spear.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0369b22..bbff70a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4938,6 +4938,12 @@ L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-s3c.c
>  
> +SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) ST SPEAR DRIVER
> +M:	Viresh Kumar <viresh.kumar@st.com>
> +L:	linux-mmc@vger.kernel.org
> +S:	Maintained
> +F:	drivers/mmc/host/sdhci-spear.c
> +
>  SECURITY SUBSYSTEM
>  M:	James Morris <jmorris@namei.org>
>  L:	linux-security-module@vger.kernel.org (suggested Cc:)
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2e13b94..40eae7e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -136,6 +136,18 @@ config MMC_SDHCI_S3C
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_SPEAR
> +	tristate "SDHCI support on ST SPEAr platform"
> +	depends on MMC_SDHCI && PLAT_SPEAR
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  often referrered to as the HSMMC block in some of the ST SPEAR range
> +	  of SoC
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_S3C_DMA
>  	bool "DMA support on S3C SDHCI"
>  	depends on MMC_SDHCI_S3C && EXPERIMENTAL
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index f480397..d00a9fa 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)	+= sdhci-pltfm.o
>  obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
> +obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
>  obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
>  obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
>  obj-$(CONFIG_MMC_OMAP)		+= omap.o
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> new file mode 100644
> index 0000000..6d3f740
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -0,0 +1,300 @@
> +/*
> + * drivers/mmc/host/sdhci-spear.c
> + *
> + * Support of SDHCI platform devices for spear soc family
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Viresh Kumar<viresh.kumar@st.com>
> + *
> + * Inspired by sdhci-pltfm.c
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/highmem.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sdhci-spear.h>
> +#include <linux/io.h>
> +#include "sdhci.h"
> +
> +struct spear_sdhci {
> +	struct clk *clk;
> +	struct sdhci_plat_data *data;
> +};
> +
> +/* sdhci ops */
> +static struct sdhci_ops sdhci_pltfm_ops = {
> +	/* Nothing to do for now. */
> +};
> +
> +/* gpio card detection interrupt handler */
> +static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct spear_sdhci *sdhci =
> +		(struct spear_sdhci *)(pdev->dev.platform_data);
> +	unsigned long gpio_irq_type;
> +	int val;
> +
> +	val = gpio_get_value(sdhci->data->card_int_gpio);
> +
> +	/* val == 1 -> card removed, val == 0 -> card inserted */
> +	/* if card removed - set irq for low level, else vice versa */
> +	gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
> +	set_irq_type(irq, gpio_irq_type);
> +
> +	if (sdhci->data->card_power_gpio >= 0) {
> +		if (!sdhci->data->power_always_enb) {
> +			/* if card inserted, give power, otherwise remove it */
> +			val = sdhci->data->power_active_high ? !val : val ;
> +			gpio_set_value(sdhci->data->card_power_gpio, val);
> +		}
> +	}
> +
> +	/* inform sdhci driver about card insertion/removal */
> +	tasklet_schedule(&host->card_tasklet);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit sdhci_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host;
> +	struct resource *iomem;
> +	struct spear_sdhci *sdhci;
> +	int ret;
> +
> +	BUG_ON(pdev == NULL);
> +
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iomem) {
> +		ret = -ENOMEM;
> +		dev_dbg(&pdev->dev, "memory resource not defined\n");
> +		goto err;
> +	}
> +
> +	if (!request_mem_region(iomem->start, resource_size(iomem),
> +				"spear-sdhci")) {
> +		ret = -EBUSY;
> +		dev_dbg(&pdev->dev, "cannot request region\n");
> +		goto err;
> +	}
> +
> +	sdhci = kzalloc(sizeof(*sdhci), GFP_KERNEL);
> +	if (!sdhci) {
> +		ret = -ENOMEM;
> +		dev_dbg(&pdev->dev, "cannot allocate memory for sdhci\n");
> +		goto err_kzalloc;
> +	}
> +
> +	/* clk enable */
> +	sdhci->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(sdhci->clk)) {
> +		ret = PTR_ERR(sdhci->clk);
> +		dev_dbg(&pdev->dev, "Error getting clock\n");
> +		goto err_clk_get;
> +	}
> +
> +	ret = clk_enable(sdhci->clk);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "Error enabling clock\n");
> +		goto err_clk_enb;
> +	}
> +
> +	/* overwrite platform_data */
> +	sdhci->data = (struct sdhci_plat_data *)(pdev->dev.platform_data);
> +	pdev->dev.platform_data = sdhci;
> +
> +	if (pdev->dev.parent)
> +		host = sdhci_alloc_host(pdev->dev.parent, 0);
> +	else
> +		host = sdhci_alloc_host(&pdev->dev, 0);
> +
> +	if (IS_ERR(host)) {
> +		ret = PTR_ERR(host);
> +		dev_dbg(&pdev->dev, "error allocating host\n");
> +		goto err_alloc_host;
> +	}
> +
> +	host->hw_name = "sdhci";
> +	host->ops = &sdhci_pltfm_ops;
> +	host->irq = platform_get_irq(pdev, 0);
> +	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
> +
> +	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
> +	if (!host->ioaddr) {
> +		ret = -ENOMEM;
> +		dev_dbg(&pdev->dev, "failed to remap registers\n");
> +		goto err_ioremap;
> +	}
> +
> +	ret = sdhci_add_host(host);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "error adding host\n");
> +		goto err_add_host;
> +	}
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	/*
> +	 * It is optional to use GPIOs for sdhci Power control & sdhci card
> +	 * interrupt detection. If sdhci->data is NULL, then use original sdhci
> +	 * lines otherwise GPIO lines.
> +	 * If GPIO is selected for power control, then power should be disabled
> +	 * after card removal and should be enabled when card insertion
> +	 * interrupt occurs
> +	 */
> +	if (!sdhci->data)
> +		return 0;
> +
> +	if (sdhci->data->card_power_gpio >= 0) {
> +		int val = 0;
> +
> +		ret = gpio_request(sdhci->data->card_power_gpio, "sdhci");
> +		if (ret < 0) {
> +			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
> +					sdhci->data->card_power_gpio);
> +			goto err_pgpio_request;
> +		}
> +
> +		if (sdhci->data->power_always_enb)
> +			val = sdhci->data->power_active_high;
> +		else
> +			val = !sdhci->data->power_active_high;
> +
> +		ret = gpio_direction_output(sdhci->data->card_power_gpio, val);
> +		if (ret) {
> +			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
> +					sdhci->data->card_power_gpio);
> +			goto err_pgpio_direction;
> +		}
> +
> +		gpio_set_value(sdhci->data->card_power_gpio, 1);
> +	}
> +
> +	if (sdhci->data->card_int_gpio >= 0) {
> +		ret = gpio_request(sdhci->data->card_int_gpio, "sdhci");
> +		if (ret < 0) {
> +			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
> +					sdhci->data->card_int_gpio);
> +			goto err_igpio_request;
> +		}
> +
> +		ret = gpio_direction_input(sdhci->data->card_int_gpio);
> +		if (ret) {
> +			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
> +					sdhci->data->card_int_gpio);
> +			goto err_igpio_direction;
> +		}
> +		ret = request_irq(gpio_to_irq(sdhci->data->card_int_gpio),
> +				sdhci_gpio_irq, IRQF_TRIGGER_LOW,
> +				mmc_hostname(host->mmc), pdev);
> +		if (ret) {
> +			dev_dbg(&pdev->dev, "gpio request irq fail: %d\n",
> +					sdhci->data->card_int_gpio);
> +			goto err_igpio_request_irq;
> +		}
> +
> +	}
> +
> +	return 0;
> +
> +err_igpio_request_irq:
> +err_igpio_direction:
> +	if (sdhci->data->card_int_gpio >= 0)
> +		gpio_free(sdhci->data->card_int_gpio);
> +err_igpio_request:
> +err_pgpio_direction:
> +	if (sdhci->data->card_power_gpio >= 0)
> +		gpio_free(sdhci->data->card_power_gpio);
> +err_pgpio_request:
> +	platform_set_drvdata(pdev, NULL);
> +	sdhci_remove_host(host, 1);
> +err_add_host:
> +	iounmap(host->ioaddr);
> +err_ioremap:
> +	sdhci_free_host(host);
> +err_alloc_host:
> +	clk_disable(sdhci->clk);
> +err_clk_enb:
> +	clk_put(sdhci->clk);
> +err_clk_get:
> +	kfree(sdhci);
> +err_kzalloc:
> +	release_mem_region(iomem->start, resource_size(iomem));
> +err:
> +	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
> +	return ret;
> +}
> +
> +static int __devexit sdhci_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct spear_sdhci *sdhci =
> +		(struct spear_sdhci *)(pdev->dev.platform_data);
> +	int dead;
> +	u32 scratch;
> +
> +	if (sdhci->data) {
> +		if (sdhci->data->card_int_gpio >= 0) {
> +			free_irq(gpio_to_irq(sdhci->data->card_int_gpio), pdev);
> +			gpio_free(sdhci->data->card_int_gpio);
> +		}
> +
> +		if (sdhci->data->card_power_gpio >= 0)
> +			gpio_free(sdhci->data->card_power_gpio);
> +	}
> +
> +	platform_set_drvdata(pdev, NULL);
> +	dead = 0;
> +	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> +	if (scratch == (u32)-1)
> +		dead = 1;
> +
> +	sdhci_remove_host(host, dead);
> +	iounmap(host->ioaddr);
> +	sdhci_free_host(host);
> +	clk_disable(sdhci->clk);
> +	clk_put(sdhci->clk);
> +	kfree(sdhci);
> +	if (iomem)
> +		release_mem_region(iomem->start, resource_size(iomem));
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdhci_driver = {
> +	.driver = {
> +		.name	= "sdhci",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= sdhci_probe,
> +	.remove		= __devexit_p(sdhci_remove),
> +};
> +
> +static int __init sdhci_init(void)
> +{
> +	return platform_driver_register(&sdhci_driver);
> +}
> +module_init(sdhci_init);
> +
> +static void __exit sdhci_exit(void)
> +{
> +	platform_driver_unregister(&sdhci_driver);
> +}
> +module_exit(sdhci_exit);
> +
> +MODULE_DESCRIPTION("SPEAr Secure Digital Host Controller Interface driver");
> +MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mmc/sdhci-spear.h b/include/linux/mmc/sdhci-spear.h
> new file mode 100644
> index 0000000..9188c97
> --- /dev/null
> +++ b/include/linux/mmc/sdhci-spear.h
> @@ -0,0 +1,42 @@
> +/*
> + * include/linux/mmc/sdhci-spear.h
> + *
> + * SDHCI declarations specific to ST SPEAr platform
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Viresh Kumar<viresh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef MMC_SDHCI_SPEAR_H
> +#define MMC_SDHCI_SPEAR_H
> +
> +#include <linux/platform_device.h>
> +/*
> + * struct sdhci_plat_data: spear sdhci platform data structure
> + *
> + * @card_power_gpio: gpio pin for enabling/disabling power to sdhci socket
> + * @power_active_high: if set, enable power to sdhci socket by setting
> + *			card_power_gpio
> + * @power_always_enb: If set, then enable power on probe, otherwise enable only
> + *			on card insertion and disable on card removal.
> + * card_int_gpio: gpio pin used for card detection
> + */
> +struct sdhci_plat_data {
> +	int card_power_gpio;
> +	int power_active_high;
> +	int power_always_enb;
> +	int card_int_gpio;
> +};
> +
> +/* This function is used to set platform_data field of pdev->dev */
> +static inline void
> +sdhci_set_plat_data(struct platform_device *pdev, struct sdhci_plat_data *data)
> +{
> +	pdev->dev.platform_data = data;
> +}
> +
> +#endif /* MMC_SDHCI_SPEAR_H */

Pierre,

Is this patch fine? Or do i need to do some modifications?

regards,
viresh kumar.
