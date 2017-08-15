From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: add gpio hard reset support
Date: Tue, 15 Aug 2017 15:43:25 -0700
Message-ID: <5993790D.40305@marvell.com>
References: <1502749156-22798-1-git-send-email-zjwu@marvell.com>
 <20170815105607.38071d88@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52398 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751635AbdHOWn3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 18:43:29 -0400
In-Reply-To: <20170815105607.38071d88@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, zmxu@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

Hi Jisheng,

On 08/14/2017 07:56 PM, Jisheng Zhang wrote:
> On Mon, 14 Aug 2017 15:19:16 -0700 Zhoujie Wu wrote:
>
>> On some platforms, like armada3700,  SD card need to
>> do hard reset by gpio toggling to make it work properly
>> after warm reset the board.
>> Add gpio hard reset feature for this purpose.
>>
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>> ---
>>   drivers/mmc/host/sdhci-xenon.c | 49 +++++++++++++++++++++++++++++++++++++++---
>>   drivers/mmc/host/sdhci-xenon.h |  4 ++++
>>   2 files changed, 50 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>> index edd4d915..54a7057 100644
>> --- a/drivers/mmc/host/sdhci-xenon.c
>> +++ b/drivers/mmc/host/sdhci-xenon.c
>> @@ -18,6 +18,8 @@
>>   #include <linux/ktime.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +
>>   
>>   #include "sdhci-pltfm.h"
>>   #include "sdhci-xenon.h"
>> @@ -210,12 +212,25 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
>>   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>   }
>>   
>> +static void xenon_hw_reset(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (priv->reset_gpio) {
>> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
>> +		msleep(30);
>> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> Does setting the pin to low means assert reset in your HW? You'd better
> invert the logic in the DT.
>
> As for reset gpio, logic "1" means assert the reset, logic "0" means
> de-assert the reset.

Actually what I want is to cut the sd card power and enable it after that.
the gpio is used to controller the power supply to sd card.
I need this gpio init as low, then set it from 0->1 to do a power cycle.
>
>> +	}
>> +}
>> +
>>   static const struct sdhci_ops sdhci_xenon_ops = {
>>   	.set_clock		= sdhci_set_clock,
>>   	.set_bus_width		= sdhci_set_bus_width,
>>   	.reset			= xenon_reset,
>>   	.set_uhs_signaling	= xenon_set_uhs_signaling,
>>   	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
>> +	.hw_reset		= xenon_hw_reset,
>>   };
>>   
>>   static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
>> @@ -373,10 +388,15 @@ static int xenon_probe_dt(struct platform_device *pdev)
>>   	struct device_node *np = pdev->dev.of_node;
>>   	struct sdhci_host *host = platform_get_drvdata(pdev);
>>   	struct mmc_host *mmc = host->mmc;
>> +	struct device *dev = mmc_dev(mmc);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>   	u32 sdhc_id, nr_sdhc;
>>   	u32 tuning_count;
>> +	int reset_gpio, ret;
>> +	enum of_gpio_flags flags;
>> +	char *reset_name;
>> +	unsigned long gpio_flags;
>>   
>>   	/* Disable HS200 on Armada AP806 */
>>   	if (of_device_is_compatible(np, "marvell,armada-ap806-sdhci"))
>> @@ -387,7 +407,7 @@ static int xenon_probe_dt(struct platform_device *pdev)
>>   		nr_sdhc = sdhci_readl(host, XENON_SYS_CFG_INFO);
>>   		nr_sdhc &= XENON_NR_SUPPORTED_SLOT_MASK;
>>   		if (unlikely(sdhc_id > nr_sdhc)) {
>> -			dev_err(mmc_dev(mmc), "SDHC Index %d exceeds Number of SDHCs %d\n",
>> +			dev_err(dev, "SDHC Index %d exceeds Number of SDHCs %d\n",
> is this related with "add gpio hard reset support"? You'd better put this
> change into a separate patch.

sure.
>
>>   				sdhc_id, nr_sdhc);
>>   			return -EINVAL;
>>   		}
>> @@ -398,14 +418,37 @@ static int xenon_probe_dt(struct platform_device *pdev)
>>   	if (!of_property_read_u32(np, "marvell,xenon-tun-count",
>>   				  &tuning_count)) {
>>   		if (unlikely(tuning_count >= XENON_TMR_RETUN_NO_PRESENT)) {
>> -			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
>> +			dev_err(dev, "Wrong Re-tuning Count. Set default value %d\n",
> ditto
>
>>   				XENON_DEF_TUNING_COUNT);
>>   			tuning_count = XENON_DEF_TUNING_COUNT;
>>   		}
>>   	}
>>   	priv->tuning_count = tuning_count;
>>   
>> -	return xenon_phy_parse_dt(np, host);
>> +	ret = xenon_phy_parse_dt(np, host);
>> +
>> +	reset_gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, &flags);
>> +	if (gpio_is_valid(reset_gpio)) {
>> +		if (flags & OF_GPIO_ACTIVE_LOW)
>> +			gpio_flags = GPIOF_ACTIVE_LOW | GPIOF_OUT_INIT_HIGH;
>> +		else
>> +			gpio_flags = GPIOF_OUT_INIT_LOW;
>> +
>> +		reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
>> +						dev_name(dev));
>> +		if (!reset_name)
>> +			return -ENOMEM;
>> +		ret = devm_gpio_request_one(dev, reset_gpio, gpio_flags,
>> +					    reset_name);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to request reset gpio\n");
>> +			return ret;
>> +		}
>> +
>> +		priv->reset_gpio = gpio_to_desc(reset_gpio);
>> +	}
> is devm_gpiod_get_optional() better?
yes, I can use that.
>
>> +
>> +	return ret;
>>   }
>>   
>>   static int xenon_sdhc_prepare(struct sdhci_host *host)
>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>> index 73debb4..cffb0fe 100644
>> --- a/drivers/mmc/host/sdhci-xenon.h
>> +++ b/drivers/mmc/host/sdhci-xenon.h
>> @@ -90,6 +90,10 @@ struct xenon_priv {
>>   	 */
>>   	void		*phy_params;
>>   	struct xenon_emmc_phy_regs *emmc_phy_regs;
>> +	/*
>> +	 * gpio pin for hw reset
>> +	 */
>> +	struct gpio_desc *reset_gpio;
>>   };
>>   
>>   int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);

