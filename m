From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/4 v5] mmc: atmel-mci: add device tree support
Date: Mon, 28 May 2012 09:37:33 +0200
Message-ID: <20120528073733.GQ3377@game.jcrosoft.org>
References: <1337872556-17667-1-git-send-email-ludovic.desroches@atmel.com>
 <1337872556-17667-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:45359 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751411Ab2E1HhZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 03:37:25 -0400
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 675D7FF86EE
	for <linux-mmc@vger.kernel.org>; Mon, 28 May 2012 09:40:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1337872556-17667-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

On 17:15 Thu 24 May     , ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/mmc/atmel-hsmci.txt        |   67 +++++++++++++++
>  drivers/mmc/host/atmel-mci.c                       |   85 +++++++++++++++++++-
>  2 files changed, 150 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> new file mode 100644
> index 0000000..81c20cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> @@ -0,0 +1,67 @@
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
> +- #address-cells: should be one. The cell is the slot id.
> +- #size-cells: should be zero.
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
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	[ child node definitions...]
> +};
> +
> +2) slot nodes
> +
> +Required properties:
> +- reg: should contain the slot id.
> +- bus-width: number of data lines connected to the controller
> +
> +Optional properties:
> +- cd-gpios: specify GPIOs for card detection
> +- cd-inverted: invert the value of external card detect gpio line
> +- wp-gpios: specify GPIOs for write protection
> +
> +Example slot node:
> +
> +slot@0 {
> +	reg = <0>;
> +	bus-width = <4>;
> +	cd-gpios = <&pioD 15 0>
> +	cd-inverted;
> +};
> +
> +Example full MCI node:
> +mmc0: mmc@f0008000 {
> +	compatible = "atmel,hsmci";
> +	reg = <0xf0008000 0x600>;
> +	interrupts = <12 4>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	slot@0 {
> +		reg = <0>;
> +		bus-width = <4>;
> +		cd-gpios = <&pioD 15 0>
> +		cd-inverted;
> +	};
> +	slot@1 {
> +		reg = <1>;
> +		bus-width = <4>;
> +	};
> +};
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index f2c115e..47421fc 100644
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
> @@ -493,6 +496,70 @@ err:
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
> +static struct mci_platform_data __devinit*
> +atmci_of_init(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *cnp;
> +	struct mci_platform_data *pdata;
> +	u32 slot_id;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "device node not found\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "could not allocate memory for pdata\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	for_each_child_of_node(np, cnp) {
> +		if (of_property_read_u32(cnp, "reg", &slot_id)) {
> +			dev_warn(&pdev->dev, "reg property is missing for %s\n",
> +				 cnp->full_name);
> +			continue;
> +		}
> +
> +		if (slot_id >= ATMCI_MAX_NR_SLOTS) {
> +			dev_warn(&pdev->dev, "can't have more than %d slots\n",
> +			         ATMCI_MAX_NR_SLOTS);
> +			break;
> +		}
> +
> +		if (of_property_read_u32(cnp, "bus-width",
> +		                         &pdata->slot[slot_id].bus_width))
> +			pdata->slot[slot_id].bus_width = 1;
> +
> +		pdata->slot[slot_id].detect_pin =
> +			of_get_named_gpio(cnp, "cd-gpios", 0);
> +
> +		pdata->slot[slot_id].detect_is_active_high =
> +			of_property_read_bool(cnp, "cd-inverted");
as this is going to be removed at once

please implement the gpio active low too

otherwise
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
