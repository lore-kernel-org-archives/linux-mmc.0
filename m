From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 6/7] mmc: sdhci-omap: Add OMAP SDHCI driver
Date: Thu, 17 Aug 2017 09:43:37 +0300
Message-ID: <0b109f07-f7f3-1a12-0c65-45d96eb23b13@intel.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-7-kishon@ti.com>
 <a45cf402-26c9-d9d0-1ca0-cbeeddad388c@intel.com>
 <46568bdf-c11f-e04b-edd4-25d5363ae504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46568bdf-c11f-e04b-edd4-25d5363ae504@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 17/08/17 08:57, Kishon Vijay Abraham I wrote:
> Hi Adrian,
> 
> On Tuesday 15 August 2017 01:52 PM, Adrian Hunter wrote:
>> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
>>> Create a new sdhci-omap driver to configure the eMMC/SD/SDIO controller
>>> in TI's OMAP SoCs making use of the SDHCI core library. For OMAP specific
>>> configurations, populate sdhci_ops with OMAP specific callbacks and use
>>> SDHCI quirks.
>>> Enable only high speed mode for both SD and eMMC here and add other
>>> UHS mode support later.
>>
>> I only have a couple of comments below.
>>
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/mmc/host/Kconfig      |  12 +
>>>  drivers/mmc/host/Makefile     |   1 +
>>>  drivers/mmc/host/sdhci-omap.c | 593 ++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 606 insertions(+)
>>>  create mode 100644 drivers/mmc/host/sdhci-omap.c
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 5755b69f2f72..9aa7e5ce43ba 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -871,3 +871,15 @@ config MMC_SDHCI_XENON
>>>  	  This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
>>>  	  If you have a controller with this interface, say Y or M here.
>>>  	  If unsure, say N.
>>> +
>>> +config MMC_SDHCI_OMAP
>>> +	tristate "TI SDHCI Controller Support"
>>> +	depends on MMC_SDHCI_PLTFM
>>> +	help
>>> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
>>> +	  support present in TI's DRA7 SOCs. The controller supports
>>> +	  SD/MMC/SDIO devices.
>>> +
>>> +	  If you have a controller with this interface, say Y or M here.
>>> +
>>> +	  If unsure, say N.
>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>> index 4d4547116311..30fb8b0fd0e1 100644
>>> --- a/drivers/mmc/host/Makefile
>>> +++ b/drivers/mmc/host/Makefile
>>> @@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
>>>  obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
>>>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
>>>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
>>> +obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
>>>  
>>>  ifeq ($(CONFIG_CB710_DEBUG),y)
>>>  	CFLAGS-cb710-mmc	+= -DDEBUG
>>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>>> new file mode 100644
>>> index 000000000000..c067c428a0cd
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/sdhci-omap.c
>>> @@ -0,0 +1,593 @@
>>> +/*
>>> + * SDHCI Controller driver for TI's OMAP SoCs
>>> + *
>>> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com
>>> + *
>>> + * Authors: Kishon Vijay Abraham I <kishon@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/mmc/slot-gpio.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/regulator/consumer.h>
>>> +
>>> +#include "sdhci-pltfm.h"
>>> +
>>> +#define SDHCI_OMAP_CON		0x12c
>>> +#define CON_DW8			BIT(5)
>>> +#define CON_DMA_MASTER		BIT(20)
>>> +#define CON_INIT		BIT(1)
>>> +#define CON_OD			BIT(0)
>>> +
>>> +#define SDHCI_OMAP_CMD		0x20c
>>> +
>>> +#define SDHCI_OMAP_HCTL		0x228
>>> +#define HCTL_SDBP		BIT(8)
>>> +#define HCTL_SDVS_SHIFT		9
>>> +#define HCTL_SDVS_MASK		(0x7 << HCTL_SDVS_SHIFT)
>>> +#define HCTL_SDVS_33		(0x7 << HCTL_SDVS_SHIFT)
>>> +#define HCTL_SDVS_30		(0x6 << HCTL_SDVS_SHIFT)
>>> +#define HCTL_SDVS_18		(0x5 << HCTL_SDVS_SHIFT)
>>> +
>>> +#define SDHCI_OMAP_SYSCTL	0x22c
>>> +#define SYSCTL_CEN		BIT(2)
>>> +#define SYSCTL_CLKD_SHIFT	6
>>> +#define SYSCTL_CLKD_MASK	0x3ff
>>> +
>>> +#define SDHCI_OMAP_STAT		0x230
>>> +
>>> +#define SDHCI_OMAP_IE		0x234
>>> +#define INT_CC_EN		BIT(0)
>>> +
>>> +#define SDHCI_OMAP_AC12		0x23c
>>> +#define AC12_V1V8_SIGEN		BIT(19)
>>> +
>>> +#define SDHCI_OMAP_CAPA		0x240
>>> +#define CAPA_VS33		BIT(24)
>>> +#define CAPA_VS30		BIT(25)
>>> +#define CAPA_VS18		BIT(26)
>>> +
>>> +#define MMC_TIMEOUT		1		/* 1 msec */
>>
>> This name "MMC_TIMEOUT" is too generic.  SDHCI_OMAP_TIMEOUT would be better.
> 
> okay.
>>
>>> +
>>> +#define SYSCTL_CLKD_MAX		0x3FF
>>> +
>>> +#define IOV_1V8			1800000		/* 180000 uV */
>>> +#define IOV_3V0			3000000		/* 300000 uV */
>>> +#define IOV_3V3			3300000		/* 330000 uV */
>>> +
>>> +struct sdhci_omap_data {
>>> +	u32 offset;
>>> +};
>>> +
>>> +struct sdhci_omap_host {
>>> +	void __iomem		*base;
>>> +	struct device		*dev;
>>> +	struct	regulator	*pbias;
>>> +	bool			pbias_enabled;
>>> +	struct sdhci_host	*host;
>>> +	unsigned int		flags;
>>> +
>>> +#define SDHCI_OMAP_SUPPORTS_DUAL_VOLT	BIT(0)
>>> +#define SDHCI_OMAP_NO_1_8_V		BIT(1)
>>> +
>>> +	u8			power_mode;
>>> +	bool			io_3_3v_support;
>>> +};
>>> +
> .
> .
> <<snip>>
> .
> .
>>> +static int sdhci_omap_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	u32 offset;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct sdhci_host *host;
>>> +	struct sdhci_pltfm_host *pltfm_host;
>>> +	struct sdhci_omap_host *omap_host;
>>> +	struct mmc_host *mmc;
>>> +	const struct of_device_id *match;
>>> +	struct sdhci_omap_data *data;
>>> +
>>> +	match = of_match_device(omap_sdhci_match, dev);
>>> +	if (!match)
>>> +		return -EINVAL;
>>> +
>>> +	data = (struct sdhci_omap_data *)match->data;
>>> +	if (!data) {
>>> +		dev_err(dev, "no sdhci omap data\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	offset = data->offset;
>>> +
>>> +	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
>>> +				sizeof(*omap_host));
>>> +	if (IS_ERR(host)) {
>>> +		dev_err(dev, "Failed sdhci_pltfm_init\n");
>>> +		return PTR_ERR(host);
>>> +	}
>>> +
>>> +	pltfm_host = sdhci_priv(host);
>>> +	omap_host = sdhci_pltfm_priv(pltfm_host);
>>> +	omap_host->host = host;
>>> +	omap_host->base = host->ioaddr;
>>> +	omap_host->dev = dev;
>>> +	sdhci_omap_get_of_property(omap_host);
>>> +
>>> +	host->ioaddr += offset;
>>> +
>>> +	mmc = host->mmc;
>>> +	ret = mmc_of_parse(mmc);
>>> +	if (ret)
>>> +		goto err_of_parse;
>>> +
>>> +	pltfm_host->clk = devm_clk_get(dev, "fck");
>>> +	if (IS_ERR(pltfm_host->clk)) {
>>> +		ret = PTR_ERR(pltfm_host->clk);
>>> +		goto err_of_parse;
>>> +	}
>>> +
>>> +	ret = clk_set_rate(pltfm_host->clk, mmc->f_max);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to set clock to %d\n", mmc->f_max);
>>> +		goto err_of_parse;
>>> +	}
>>> +
>>> +	omap_host->pbias = devm_regulator_get_optional(dev, "pbias");
>>> +	if (IS_ERR(omap_host->pbias)) {
>>> +		ret = PTR_ERR(omap_host->pbias);
>>> +		if (ret != -ENODEV) {
>>> +			dev_err(dev, "CONFIG_REGULATOR_PBIAS not enabled??\n");
>>> +			return ret;
>>> +		}
>>> +		dev_dbg(dev, "unable to get pbias regulator %ld\n",
>>> +			PTR_ERR(omap_host->pbias));
>>> +	} else {
>>> +		if (regulator_is_supported_voltage(omap_host->pbias, IOV_3V3,
>>> +						   IOV_3V3))
>>> +			omap_host->io_3_3v_support = true;
>>> +		dev_vdbg(dev, "Max PBIAS support Voltage: %dmv\n",
>>> +			 omap_host->io_3_3v_support ? IOV_3V3 : IOV_3V0);
>>> +	}
>>> +	omap_host->pbias_enabled = false;
>>> +
>>> +	pm_runtime_enable(dev);
>>> +	ret = pm_runtime_get_sync(dev);
>>
>> What are you trying to do with runtime pm?  There don't seem to be any pm
>> callbacks, so does this do anything?
> 
> yeah, pm_runtime_get_sync enables the functional clock and also configures the
> SYSCONFIG regiters present in the controller. It gets the details for
> configuring those from arch/arm/mach-omap2/omap_hwmod_*

You mean it will do those things when you add the callbacks?  I would prefer
you leave out runtime pm until you can add the callbacks as well.
