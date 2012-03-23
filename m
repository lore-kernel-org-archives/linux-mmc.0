From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/4] mmc: atmel-mci: add device tree support
Date: Fri, 23 Mar 2012 11:38:01 +0100
Message-ID: <20120323103801.GH3473@ldesroches-Latitude-E6320>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
 <1332352994-20983-2-git-send-email-ludovic.desroches@atmel.com>
 <4F6B3C48.90002@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:54631 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab2CWKig (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Mar 2012 06:38:36 -0400
Content-Disposition: inline
In-Reply-To: <4F6B3C48.90002@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>

On Thu, Mar 22, 2012 at 03:50:48PM +0100, Nicolas Ferre wrote:
> On 03/21/2012 07:03 PM, ludovic.desroches@atmel.com :

[...]

> > diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> > new file mode 100644
> > index 0000000..657f9de
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> > @@ -0,0 +1,55 @@
> > +* Atmel High Speed MultiMedia Card Interface
> > +
> > +This controller on atmel products provides an interface for MMC, SD and SDIO
> > +types of memory cards.
> > +
> > +1) MCI node
> > +
> > +Required properties:
> > +- compatible: no blank "atmel,hsmci"
> > +- reg: should contain HSMCI registers location and length
> > +- interrupts: should contain HSMCI interrupt number
> > +- at least one slot node
> > +
> > +The node contains child nodes for each slot that the platform uses
> > +
> > +Example MCI node:
> > +
> > +mmc0: mmc@f0008000 {
> > +	compatible = "atmel,hsmci";
> > +	reg = <0xf0008000 0x600>;
> > +	interrupts = <12 4>;
> > +
> > +	[ child node definitions...]
> > +};
> > +
> > +2) slot nodes
> > +
> > +Optional properties:
> > +- bus-width: number of data lines connected to the controller
> > +- cd-gpios: specify GPIOs for card detection
> > +- cd-invert: invert the value of external card detect gpio line
> > +- wp-gpios: specify GPIOs for write protection
> > +
> > +Example slot node:
> > +
> > +slot@0 {
> > +	bus-width = <4>;
> > +	cd-gpios = <&pioD 15 0>
> > +	cd-invert;
> > +};
> > +
> > +Example full MCI node:
> > +mmc0: mmc@f0008000 {
> > +	compatible = "atmel,hsmci";
> > +	reg = <0xf0008000 0x600>;
> > +	interrupts = <12 4>;
> > +	slot@0 {
> > +		bus-width = <4>;
> > +		cd-gpios = <&pioD 15 0>
> > +		cd-invert;
> > +	};
> > +	slot@1 {
> > +		bus-width = <4>;
> > +	};
> > +};

[...]

> > +static void __init
> > +atmci_get_of_slots(struct device *dev, struct mci_platform_data *pdata)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	struct device_node *cnp;
> > +	unsigned int slot_nb = 0;
> > +
> > +	if (!np)
> > +		return;
> > +
> > +	for_each_child_of_node(np, cnp) {
> > +		if (slot_nb > (ATMCI_MAX_NR_SLOTS-1)) {
> > +			dev_warn(dev, "can't have more than %d slots\n",
> > +			         ATMCI_MAX_NR_SLOTS);
> > +			break;
> > +		}
> > +		if (of_property_read_u32(cnp, "bus-width",
> > +		                         &pdata->slot[slot_nb].bus_width))
> > +			pdata->slot[slot_nb].bus_width = 1;
> > +
> > +		pdata->slot[slot_nb].detect_pin =
> > +			of_get_named_gpio(cnp, "cd-gpios", 0);
> > +
> > +		if (of_find_property(cnp, "cd-invert", NULL))
> > +			pdata->slot[slot_nb].detect_is_active_high = true;
> > +
> > +		pdata->slot[slot_nb].wp_pin =
> > +			of_get_named_gpio(cnp, "wp-gpios", 0);
> > +
> > +		slot_nb++;
> > +	}
> > +}

In fact this part of code is not correct. Each mci can have two slots: slot0
and slot1. If someone wants to use only slot1, I will fill only pdata->slot[0]
that is incorrect because later in the driver there is:

if (pdata->slot[0].bus_width) {
	ret = atmci_init_slot(host, &pdata->slot[0], 
			0, ATMCI_SDCSEL_SLOT_A, ATMCI_SDIOIRQA);
	if (!ret)
		nr_slots++;
}
if (pdata->slot[1].bus_width) {
	ret = atmci_init_slot(host, &pdata->slot[1],
			1, ATMCI_SDCSEL_SLOT_B, ATMCI_SDIOIRQB);
	if (!ret)
		nr_slots++;
}

So what is the best solution to solve this issue?

- Adding a property slot id? I would like to use only existing bindings hoping 
we can have a generic binding for mmc.

- Using aliases?
aliases {
	slot0 = &mmc-slot0;
}

mmc0: mmc@f0008000 {
	compatible = "atmel,hsmci";
	reg = <0xf0008000 0x600>;
	interrupts = <12 4>;              
	mmc-slot0: slot@0 {
	};                                                                
	status = "disabled";
};

- Using reg property as an index?


Thanks for your help.

Regards

Ludovic
