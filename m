From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/4] mmc: atmel-mci: add device tree support
Date: Thu, 22 Mar 2012 15:50:48 +0100
Message-ID: <4F6B3C48.90002@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com> <1332352994-20983-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:4000 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105Ab2CVOvB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Mar 2012 10:51:01 -0400
In-Reply-To: <1332352994-20983-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>

On 03/21/2012 07:03 PM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  .../devicetree/bindings/mmc/atmel-hsmci.txt        |   55 +++++++++++++++
>  drivers/mmc/host/atmel-mci.c                       |   74 +++++++++++++++++++-
>  2 files changed, 126 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> new file mode 100644
> index 0000000..657f9de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> @@ -0,0 +1,55 @@
> +* Atmel High Speed MultiMedia Card Interface
> +
> +This controller on atmel products provides an interface for MMC, SD and SDIO
> +types of memory cards.
> +
> +1) MCI node
> +
> +Required properties:
> +- compatible: no blank "atmel,hsmci"
> +- reg: should contain HSMCI registers location and length
> +- interrupts: should contain HSMCI interrupt number
> +- at least one slot node
> +
> +The node contains child nodes for each slot that the platform uses
> +
> +Example MCI node:
> +
> +mmc0: mmc@f0008000 {
> +	compatible = "atmel,hsmci";
> +	reg = <0xf0008000 0x600>;
> +	interrupts = <12 4>;
> +
> +	[ child node definitions...]
> +};
> +
> +2) slot nodes
> +
> +Optional properties:
> +- bus-width: number of data lines connected to the controller
> +- cd-gpios: specify GPIOs for card detection
> +- cd-invert: invert the value of external card detect gpio line
> +- wp-gpios: specify GPIOs for write protection
> +
> +Example slot node:
> +
> +slot@0 {
> +	bus-width = <4>;
> +	cd-gpios = <&pioD 15 0>
> +	cd-invert;
> +};
> +
> +Example full MCI node:
> +mmc0: mmc@f0008000 {
> +	compatible = "atmel,hsmci";
> +	reg = <0xf0008000 0x600>;
> +	interrupts = <12 4>;
> +	slot@0 {
> +		bus-width = <4>;
> +		cd-gpios = <&pioD 15 0>
> +		cd-invert;
> +	};
> +	slot@1 {
> +		bus-width = <4>;
> +	};
> +};
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index b5693fd..2d6a04a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -19,6 +19,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/seq_file.h>
> @@ -477,6 +480,54 @@ err:
>  	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id atmci_dt_ids[] = {
> +	{ .compatible = "atmel,hsmci" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, atmci_dt_ids);
> +
> +static void __init
> +atmci_get_of_slots(struct device *dev, struct mci_platform_data *pdata)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *cnp;
> +	unsigned int slot_nb = 0;
> +
> +	if (!np)
> +		return;
> +
> +	for_each_child_of_node(np, cnp) {
> +		if (slot_nb > (ATMCI_MAX_NR_SLOTS-1)) {
> +			dev_warn(dev, "can't have more than %d slots\n",
> +			         ATMCI_MAX_NR_SLOTS);
> +			break;
> +		}
> +		if (of_property_read_u32(cnp, "bus-width",
> +		                         &pdata->slot[slot_nb].bus_width))
> +			pdata->slot[slot_nb].bus_width = 1;
> +
> +		pdata->slot[slot_nb].detect_pin =
> +			of_get_named_gpio(cnp, "cd-gpios", 0);
> +
> +		if (of_find_property(cnp, "cd-invert", NULL))
> +			pdata->slot[slot_nb].detect_is_active_high = true;
> +
> +		pdata->slot[slot_nb].wp_pin =
> +			of_get_named_gpio(cnp, "wp-gpios", 0);
> +
> +		slot_nb++;
> +	}
> +}
> +#else /* CONFIG_OF */
> +static inline void
> +atmci_get_of_slots(struct device *dev, struct mci_platform_data *pdata)
> +{
> +	return;
> +}
> +#endif
> +
>  static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
>  					unsigned int ns)
>  {
> @@ -1847,6 +1898,13 @@ static int __init atmci_init_slot(struct atmel_mci *host,
>  	slot->sdc_reg = sdc_reg;
>  	slot->sdio_irq = sdio_irq;
>  
> +	dev_dbg(&mmc->class_dev,
> +	        "slot[%u]: bus_width=%u, detect_pin=%d, "
> +		"detect_is_active_high=%s, wp_pin=%d\n",
> +		id, slot_data->bus_width, slot_data->detect_pin,
> +		slot_data->detect_is_active_high ? "true" : "false",
> +		slot_data->wp_pin);
> +
>  	mmc->ops = &atmci_ops;
>  	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
>  	mmc->f_max = host->bus_hz / 2;
> @@ -2047,9 +2105,17 @@ static int __init atmci_probe(struct platform_device *pdev)
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!regs)
>  		return -ENXIO;
> -	pdata = pdev->dev.platform_data;
> -	if (!pdata)
> -		return -ENXIO;
> +
> +	if (pdev->dev.of_node) {
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +	} else {
> +		pdata = pdev->dev.platform_data;
> +		if (!pdata)
> +			return -ENXIO;
> +	}
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> @@ -2109,6 +2175,7 @@ static int __init atmci_probe(struct platform_device *pdev)
>  	/* We need at least one slot to succeed */
>  	nr_slots = 0;
>  	ret = -ENODEV;
> +	atmci_get_of_slots(&pdev->dev, pdata);
>  	if (pdata->slot[0].bus_width) {
>  		ret = atmci_init_slot(host, &pdata->slot[0],
>  				0, ATMCI_SDCSEL_SLOT_A, ATMCI_SDIOIRQA);
> @@ -2242,6 +2309,7 @@ static struct platform_driver atmci_driver = {
>  	.driver		= {
>  		.name		= "atmel_mci",
>  		.pm		= ATMCI_PM_OPS,
> +		.of_match_table	= of_match_ptr(atmci_dt_ids),
>  	},
>  };
>  


-- 
Nicolas Ferre
