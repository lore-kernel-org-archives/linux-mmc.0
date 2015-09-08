From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
Date: Tue, 8 Sep 2015 15:04:41 +0530
Message-ID: <55EEABB1.8010806@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150908145254.6807dffc@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33700 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbbIHJex (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2015 05:34:53 -0400
Received: by pacex6 with SMTP id ex6so119716330pac.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2015 02:34:53 -0700 (PDT)
In-Reply-To: <20150908145254.6807dffc@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Liu <kliu5@marvell.com>



On Tuesday 08 September 2015 12:22 PM, Jisheng Zhang wrote:
> On Mon, 7 Sep 2015 16:48:38 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>> Different bus clock may need different pin setting.
>> For example, fast bus clock like 208Mhz need pin drive fast
>> while slow bus clock prefer pin drive slow to guarantee
>> signal quality.
>>
>> So this patch creates two states,
>>    - Default (slow/normal) pin state
>>    - And fast pin state for higher freq bus speed.
>>
>> And selection of pin state is done based on timing mode.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>   drivers/mmc/host/sdhci-pxav3.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index c2b2b78..d933f75 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/pm.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/mbus.h>
>> +#include <linux/pinctrl/consumer.h>
>>
>>   #include "sdhci.h"
>>   #include "sdhci-pltfm.h"
>> @@ -92,6 +93,10 @@ struct sdhci_pxa {
>>   	void __iomem *io_pwr_reg;
>>   	void __iomem *io_pwr_lock_reg;
>>   	struct sdhci_pxa_data *data;
>> +
>> +	struct pinctrl *pinctrl;
>> +	struct pinctrl_state *pins_default;
>> +	struct pinctrl_state *pins_fast;
>>   };
>>
>>   static struct sdhci_pxa_data pxav3_data_v1 = {
>> @@ -298,6 +303,33 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
>>   	pxa->power_mode = power_mode;
>>   }
>>
>> +static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_pxa *pxa = pltfm_host->priv;
>> +	struct pinctrl_state *pinctrl;
>> +
>> +	if (IS_ERR(pxa->pinctrl) ||
>> +		IS_ERR(pxa->pins_default) ||
>> +		IS_ERR(pxa->pins_fast))
>> +		return -EINVAL;
>> +
>> +	switch (uhs) {
>> +	case MMC_TIMING_UHS_SDR50:
>> +	case MMC_TIMING_UHS_SDR104:
>> +	case MMC_TIMING_MMC_HS200:
>> +	case MMC_TIMING_MMC_HS400:
>> +		pinctrl = pxa->pins_fast;
>> +		break;
>> +	default:
>> +		/* back to default state for other legacy timing */
>> +		pinctrl = pxa->pins_default;
>> +		break;
>> +	}
>> +
>> +	return pinctrl_select_state(pxa->pinctrl, pinctrl);
>> +}
>> +
>>   static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -353,6 +385,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   	dev_dbg(mmc_dev(host->mmc),
>>   		"%s uhs = %d, ctrl_2 = %04X\n",
>>   		__func__, uhs, ctrl_2);
>> +
>> +	pxav3_select_pinstate(host, uhs);
>
> return pxav3_select_pinstate(host, uhs);?
>

Its void function, so don't need it.

> And could we ignore this call for those SDHCI hosts that don't need it?
>

I do not want to introduce flags here.
And also, it is already ignored for those who don't need it.

The first thing in the function pxav3_select_pinstate() is


	if (IS_ERR(pxa->pinctrl) ||
		IS_ERR(pxa->pins_default) ||
		IS_ERR(pxa->pins_fast))
		return -EINVAL;


So its already handled.

>>   }
>>
>>   static void pxav3_voltage_switch(struct sdhci_host *host,
>> @@ -416,7 +450,6 @@ static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
>>   		/* TX internal clock selection */
>>   		pxav3_set_tx_clock(host);
>>   	}
>> -
>
> why not fix this in patch 3?
>

Oops. it got missed from my eyes :)
Will fix in next version.

>>   }
>>
>>   static const struct sdhci_ops pxav3_sdhci_ops = {
>> @@ -586,6 +619,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>
>> +	pxa->pinctrl = devm_pinctrl_get(dev);
>
> could we ignore this for those SDHCI hosts that don't need it?
>

Again, no need to introduce flags here. This is standard call and
handled properly. So for the platforms not using this, it really should
not matter.
Also, lookup is getting executed only when pinctrl is populated.

So I do not see any need here.

>> +	if (!IS_ERR(pxa->pinctrl)) {
>> +		pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
>> +		if (IS_ERR(pxa->pins_default))
>> +			dev_err(dev, "could not get default pinstate\n");
>
> Why those SDHCI hosts that don't need pinctl setting should got this error?
>

It won't.

If Host does not need pinctrl, the execution would never reach this
point.
The if condition check would handle it, isn't it?

	pxa->pinctrl = devm_pinctrl_get(dev);
	if (!IS_ERR(pxa->pinctrl)) {

		...

	}

So I do not see why is it issue here?


Thanks,
Vaibhav
