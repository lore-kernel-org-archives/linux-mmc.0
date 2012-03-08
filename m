From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use device
 tree
Date: Thu, 08 Mar 2012 09:58:13 -0600
Message-ID: <4F58D715.5080708@gmail.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-2-git-send-email-rnayak@ti.com> <4F582B79.60001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39389 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab2CHP6Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Mar 2012 10:58:16 -0500
In-Reply-To: <4F582B79.60001@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org

On 03/07/2012 09:46 PM, Rajendra Nayak wrote:
> Hi Rob/Grant,
> 
> On Thursday 23 February 2012 05:31 PM, Rajendra Nayak wrote:
>> Define dt bindings for the ti-omap-hsmmc, and adapt
>> the driver to extract data (which was earlier passed as
>> platform_data) from device tree.
> 
> Any comments on these bindings for omap hsmmc? All the dependent
> patches/series on which this series was based have now made it to
> the respective -next of Mark and Chris.
> 

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   31 +++++++++
>>   drivers/mmc/host/omap_hsmmc.c                      |   68
>> ++++++++++++++++++++
>>   2 files changed, 99 insertions(+), 0 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> new file mode 100644
>> index 0000000..e4fa8f0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -0,0 +1,31 @@
>> +* TI Highspeed MMC host controller for OMAP
>> +
>> +The Highspeed MMC Host Controller on TI OMAP family
>> +provides an interface for MMC, SD, and SDIO types of memory cards.
>> +
>> +Required properties:
>> +- compatible:
>> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers
>> + Should be "ti,omap4-hsmmc", for OMAP4 controllers
>> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
>> +- reg : should contain hsmmc registers location and length
>> +
>> +Optional properties:
>> +ti,dual-volt: boolean, supports dual voltage cards
>> +<supply-name>-supply: phandle to the regulator device tree node
>> +"supply-name" examples are "vmmc", "vmmc_aux" etc
>> +ti,bus-width: Number of data lines, default assumed is 1 if the
>> property is missing.
>> +cd-gpios: GPIOs for card detection
>> +wp-gpios: GPIOs for write protection
>> +ti,non-removable: non-removable slot (like eMMC)
>> +
>> +Example:
>> +    mmc1: mmc@0x4809c000 {
>> +        compatible = "ti,omap4-hsmmc";
>> +        reg =<0x4809c000 0x400>;
>> +        ti,hwmods = "mmc1";
>> +        ti,dual-volt;
>> +        ti,bus-width =<4>;
>> +        vmmc-supply =<&vmmc>; /* phandle to regulator node */
>> +        ti,non-removable;
>> +    };
>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>> b/drivers/mmc/host/omap_hsmmc.c
>> index 35f6dc1..0c93d58 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -26,6 +26,9 @@
>>   #include<linux/platform_device.h>
>>   #include<linux/timer.h>
>>   #include<linux/clk.h>
>> +#include<linux/of.h>
>> +#include<linux/of_gpio.h>
>> +#include<linux/of_device.h>
>>   #include<linux/mmc/host.h>
>>   #include<linux/mmc/core.h>
>>   #include<linux/mmc/mmc.h>
>> @@ -1718,6 +1721,46 @@ static void omap_hsmmc_debugfs(struct mmc_host
>> *mmc)
>>
>>   #endif
>>
>> +#ifdef CONFIG_OF
>> +static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct
>> device *dev)
>> +{
>> +    struct omap_mmc_platform_data *pdata;
>> +    struct device_node *np = dev->of_node;
>> +    u32 bus_width;
>> +
>> +    pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +    if (!pdata)
>> +        return NULL; /* out of memory */
>> +
>> +    if (of_find_property(np, "ti,dual-volt", NULL))
>> +        pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
>> +
>> +    /* This driver only supports 1 slot */
>> +    pdata->nr_slots = 1;
>> +    pdata->slots[0].switch_pin = of_get_named_gpio(np, "cd-gpios", 0);
>> +    pdata->slots[0].gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
>> +
>> +    if (of_find_property(np, "ti,non-removable", NULL)) {
>> +        pdata->slots[0].nonremovable = true;
>> +        pdata->slots[0].no_regulator_off_init = true;
>> +    }
>> +    of_property_read_u32(np, "ti,bus-width",&bus_width);
>> +    if (bus_width == 4)
>> +        pdata->slots[0].caps |= MMC_CAP_4_BIT_DATA;
>> +    else if (bus_width == 8)
>> +        pdata->slots[0].caps |= MMC_CAP_8_BIT_DATA;
>> +    return pdata;
>> +}
>> +#else
>> +static inline struct omap_mmc_platform_data
>> +            *of_get_hsmmc_pdata(struct device *dev)
>> +{
>> +    return NULL;
>> +}
>> +#endif
>> +
>> +static const struct of_device_id omap_mmc_of_match[];
>> +
>>   static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>   {
>>       struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
>> @@ -1725,6 +1768,14 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>>       struct omap_hsmmc_host *host = NULL;
>>       struct resource *res;
>>       int ret, irq;
>> +    const struct of_device_id *match;
>> +
>> +    match = of_match_device(omap_mmc_of_match,&pdev->dev);
>> +    if (match) {
>> +        pdata = of_get_hsmmc_pdata(&pdev->dev);
>> +        if (match->data)
>> +            pdata->reg_offset = *(u16 *)match->data;
>> +    }
>>
>>       if (pdata == NULL) {
>>           dev_err(&pdev->dev, "Platform Data is missing\n");
>> @@ -2120,12 +2171,29 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops
>> = {
>>       .runtime_resume = omap_hsmmc_runtime_resume,
>>   };
>>
>> +#if defined(CONFIG_OF)
>> +static u16 omap4_reg_offset = 0x100;
>> +
>> +static const struct of_device_id omap_mmc_of_match[] = {
>> +    {
>> +        .compatible = "ti,omap2-hsmmc",
>> +    },
>> +    {
>> +        .compatible = "ti,omap4-hsmmc",
>> +        .data =&omap4_reg_offset,
>> +    },
>> +    {},
>> +}
>> +MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>> +#endif
>> +
>>   static struct platform_driver omap_hsmmc_driver = {
>>       .remove        = omap_hsmmc_remove,
>>       .driver        = {
>>           .name = DRIVER_NAME,
>>           .owner = THIS_MODULE,
>>           .pm =&omap_hsmmc_dev_pm_ops,
>> +        .of_match_table = of_match_ptr(omap_mmc_of_match),
>>       },
>>   };
>>
> 

