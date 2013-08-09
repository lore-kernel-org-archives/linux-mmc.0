From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
Date: Fri, 9 Aug 2013 11:34:31 +0800
Message-ID: <52046347.80407@freescale.com>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com> <20130809001540.GB7427@lizard.mcd01528.sjc.wayport.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:3433
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967394Ab3HIDdM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2013 23:33:12 -0400
In-Reply-To: <20130809001540.GB7427@lizard.mcd01528.sjc.wayport.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com

On 08/09/2013 08:15 AM, Anton Vorontsov wrote:
> On Wed, Jul 31, 2013 at 02:25:25PM +0800, Haijun Zhang wrote:
>> Add function to support get voltage from device-tree.
>> If there are voltage-range specified in device-tree node, this function
>> will parse it and return the avail voltage mask.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
>> changes for v2:
>> 	- Update the parameters of function
>>
>>   drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mmc/core.h |  1 +
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 49a5bca..ce9c957 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/fault-inject.h>
>>   #include <linux/random.h>
>>   #include <linux/slab.h>
>> +#include <linux/of.h>
>>   
>>   #include <linux/mmc/card.h>
>>   #include <linux/mmc/host.h>
>> @@ -1196,6 +1197,51 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
>>   }
>>   EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
>>   
>> +#ifdef CONFIG_OF
>> +
>> +/*
> This is not kernel-doc formatted comment for the function.. it should
> start with /**...
>
>> + * mmc_of_parse_voltage - return mask of supported voltages
>> + * @np: The device node need to be parsed.
>> + *
>> + * 1. Return zero: voltage-ranges unspecified in device-tree.
>> + * 2. Return negative errno: voltage-range is invalid.
> This doesn't seem right... the function returns the unsigned mask... You
> can change the prototype of this func to something like this:
>
> int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
>
> So the function will fill the mask and return 0 on success, and will
> return negtive errno on errors.
Thanks, Anton.
I'll correct the return prototype of the function.
In case voltage unspecified in device node is not an error in my 
platform. So i hope to reserve the zero as unspecified case and give an 
prompt, an available value in case success, negative errno in case 
error. It's easy to figure out the root cause.

>> + * 3. Return ocr_mask: a mask of voltages that parse from device-tree
>> + * node can be provided to MMC/SD/SDIO devices.
>> + */
>> +
> No need for this empty line...
>
>> +u32 mmc_of_parse_voltage(struct device_node *np)
>> +{
>> +	const u32 *voltage_ranges;
>> +	int num_ranges, i;
>> +	u32 ocr_mask = 0;
>> +
>> +	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
>> +	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>> +	if (!voltage_ranges || !num_ranges) {
>> +		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
>> +		return 0;
>> +	}
>> +
>> +	for (i = 0; i < num_ranges; i++) {
>> +		const int j = i * 2;
>> +		u32 mask;
>> +
>> +		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
>> +				be32_to_cpu(voltage_ranges[j + 1]));
> You lost some [pretty] formatting to line up the two arguments. :)
I'll correct these. Thanks.
>> +		if (!mask) {
>> +			pr_err("%s: voltage-range #%d is invalid\n",
>> +				np->full_name, i);
>> +			return -EINVAL;
>> +		}
>> +		ocr_mask |= mask;
>> +	}
>> +
>> +	return ocr_mask;
>> +}
>> +EXPORT_SYMBOL(mmc_of_parse_voltage);
>> +
>> +#endif /* CONFIG_OF */
>> +
>>   #ifdef CONFIG_REGULATOR
>>   
>>   /**
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 443243b..e3f8fe3 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -209,5 +209,6 @@ static inline void mmc_claim_host(struct mmc_host *host)
>>   }
>>   
>>   extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>> +extern u32 mmc_of_parse_voltage(struct device_node *np);
> You need to add a 'struct device_node;' forward-declaration, otherwise
> non-OF code might fail to compile...
I'll move of.h from core.c to core.h
>
> Thanks,
>
> Anton
>


-- 
Thanks & Regards

Haijun


