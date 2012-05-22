From: ludovic.desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mmc: atmel-mci: add device tree support
Date: Tue, 22 May 2012 16:48:54 +0200
Message-ID: <4FBBA756.8030501@atmel.com>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
 <1337681352-18521-2-git-send-email-ludovic.desroches@atmel.com>
 <20120522140845.GA3377@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120522140845.GA3377-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Le 05/22/2012 04:08 PM, Jean-Christophe PLAGNIOL-VILLARD a =E9crit :
> On 12:09 Tue 22 May     , ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>> From: Ludovic Desroches<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>> ---
>>   .../devicetree/bindings/mmc/atmel-hsmci.txt        |   67 ++++++++++++=
+++
>>   drivers/mmc/host/atmel-mci.c                       |   89 ++++++++++++=
+++++++-
>>   2 files changed, 154 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.t=
xt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Doc=
umentation/devicetree/bindings/mmc/atmel-hsmci.txt
>> new file mode 100644
>> index 0000000..81c20cc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
>> @@ -0,0 +1,67 @@
>> +* Atmel High Speed MultiMedia Card Interface
>> +
>> +This controller on atmel products provides an interface for MMC, SD and=
 SDIO
>> +types of memory cards.
>> +
>> +1) MCI node
>> +
>> +Required properties:
>> +- compatible: no blank "atmel,hsmci"
>> +- reg: should contain HSMCI registers location and length
>> +- interrupts: should contain HSMCI interrupt number
>> +- #address-cells: should be one. The cell is the slot id.
>> +- #size-cells: should be zero.
>> +- at least one slot node
>> +
>> +The node contains child nodes for each slot that the platform uses
>> +
>> +Example MCI node:
>> +
>> +mmc0: mmc@f0008000 {
>> +	compatible =3D "atmel,hsmci";
>> +	reg =3D<0xf0008000 0x600>;
>> +	interrupts =3D<12 4>;
>> +	#address-cells =3D<1>;
>> +	#size-cells =3D<0>;
>> +
>> +	[ child node definitions...]
>> +};
>> +
>> +2) slot nodes
>> +
>> +Required properties:
>> +- reg: should contain the slot id.
>> +- bus-width: number of data lines connected to the controller
>> +
>> +Optional properties:
>> +- cd-gpios: specify GPIOs for card detection
>> +- cd-inverted: invert the value of external card detect gpio line
> why this
>
> no need you can use the third field and OF_GPIO_ACTIVE_LOW
> as done on ohci-at91.c
>

It's a property from the common mmc binding so why not using it?

>> +- wp-gpios: specify GPIOs for write protection
>> +
>> +Example slot node:
>> +
>> +slot@0 {
>> +	reg =3D<0>;
>> +	bus-width =3D<4>;
>> +	cd-gpios =3D<&pioD 15 0>
>> +	cd-inverted;
>> +};
>> +
>> +Example full MCI node:
>> +mmc0: mmc@f0008000 {
>> +	compatible =3D "atmel,hsmci";
>> +	reg =3D<0xf0008000 0x600>;
>> +	interrupts =3D<12 4>;
>> +	#address-cells =3D<1>;
>> +	#size-cells =3D<0>;
>> +	slot@0 {
>> +		reg =3D<0>;
>> +		bus-width =3D<4>;
>> +		cd-gpios =3D<&pioD 15 0>
>> +		cd-inverted;
>> +	};
>> +	slot@1 {
>> +		reg =3D<1>;
>> +		bus-width =3D<4>;
>> +	};
>> +};
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index 556d384..43f98fc 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -19,6 +19,9 @@
>>   #include<linux/interrupt.h>
>>   #include<linux/ioport.h>
>>   #include<linux/module.h>
>> +#include<linux/of.h>
>> +#include<linux/of_device.h>
>> +#include<linux/of_gpio.h>
>>   #include<linux/platform_device.h>
>>   #include<linux/scatterlist.h>
>>   #include<linux/seq_file.h>
>> @@ -493,6 +496,74 @@ err:
>>   	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
>>   }
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id atmci_dt_ids[] =3D {
>> +	{ .compatible =3D "atmel,hsmci" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, atmci_dt_ids);
>> +
>> +static struct mci_platform_data __devinit*
>> +atmci_of_init(struct platform_device *pdev)
>> +{
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +	struct device_node *cnp;
>> +	struct mci_platform_data *pdata;
>> +	unsigned int slot_id;
>> +	const __be32 *reg;
>> +
>> +	if (!np) {
>> +		dev_err(&pdev->dev, "device node not found\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "could not allocate memory for pdata\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	for_each_child_of_node(np, cnp) {
>> +		reg =3D of_get_property(cnp, "reg", NULL);
>> +		if (!reg) {
>> +			dev_warn(&pdev->dev, "reg property is missing for %s\n",
>> +				 cnp->full_name);
>> +			continue;
>> +		}
>> +
>> +		slot_id =3D be32_to_cpu(reg[0]);
> read_u32

ok

>> +
>> +		if (slot_id>  (ATMCI_MAX_NR_SLOTS-1)) {
>> +			dev_warn(&pdev->dev, "can't have more than %d slots\n",
>> +			         ATMCI_MAX_NR_SLOTS);
>> +			break;
>> +		}
>> +
>> +		if (of_property_read_u32(cnp, "bus-width",
>> +		&pdata->slot[slot_id].bus_width))
>> +			pdata->slot[slot_id].bus_width =3D 1;
>> +
>> +		pdata->slot[slot_id].detect_pin =3D
>> +			of_get_named_gpio(cnp, "cd-gpios", 0);
>> +
>> +		if (of_find_property(cnp, "cd-inverted", NULL))
>> +			pdata->slot[slot_id].detect_is_active_high =3D true;
>> +
>> +		pdata->slot[slot_id].wp_pin =3D
>> +			of_get_named_gpio(cnp, "wp-gpios", 0);
>> +	}
>> +
>> +	return pdata;
>> +}
>> +#else /* CONFIG_OF */
>> +static inline struct mci_platform_data*
>> +atmci_of_init(struct platform_device *dev)
>> +{
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +#endif
>> +
>>   static inline unsigned int atmci_get_version(struct atmel_mci *host)
>>   {
>>   	return atmci_readl(host, ATMCI_VERSION)&  0x00000fff;
>> @@ -2038,6 +2109,13 @@ static int __init atmci_init_slot(struct atmel_mc=
i *host,
>>   	slot->sdc_reg =3D sdc_reg;
>>   	slot->sdio_irq =3D sdio_irq;
>>
>> +	dev_dbg(&mmc->class_dev,
>> +	        "slot[%u]: bus_width=3D%u, detect_pin=3D%d, "
>> +		"detect_is_active_high=3D%s, wp_pin=3D%d\n",
>> +		id, slot_data->bus_width, slot_data->detect_pin,
>> +		slot_data->detect_is_active_high ? "true" : "false",
>> +		slot_data->wp_pin);
>> +
>>   	mmc->ops =3D&atmci_ops;
>>   	mmc->f_min =3D DIV_ROUND_UP(host->bus_hz, 512);
>>   	mmc->f_max =3D host->bus_hz / 2;
>> @@ -2258,8 +2336,14 @@ static int __init atmci_probe(struct platform_dev=
ice *pdev)
>>   	if (!regs)
>>   		return -ENXIO;
>>   	pdata =3D pdev->dev.platform_data;
>> -	if (!pdata)
>> -		return -ENXIO;
> check the node and then check the return
>

Sorry but what do you mean? The node is checked into atmci_of_init and =

the return is checked:

+	if (!pdata) {
+		pdata =3D atmci_of_init(pdev);
+		if (IS_ERR(pdata)) {
+			dev_err(&pdev->dev, "platform data not available\n");
+			return -EINVAL;
+		}
+	}


Regards

Ludovic
