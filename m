From: Zhang Haijun <b42677@freescale.com>
Subject: Re: [PATCH 1/3 V4] mmc:core: parse voltage from device-tree
Date: Tue, 20 Aug 2013 09:10:20 +0800
Message-ID: <5212C1FC.7070300@freescale.com>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0252.outbound.messaging.microsoft.com ([213.199.154.252]:10718
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262Ab3HTBKf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2013 21:10:35 -0400
In-Reply-To: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, galak@kernel.crashing.org

Hi, Anton and all

I had update this patchset.
Is there any change need?
If so let me know.

Thanks.

On 08/12/2013 09:39 AM, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the available voltage mask.
>
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for V4:
> 	- Add new parameter mask to return voltages.
> changes for V3:
> 	- Correct the type of return value.
>
>   drivers/mmc/core/core.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/mmc/core.h |  2 ++
>   2 files changed, 46 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 49a5bca..b9b9fb6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -27,6 +27,7 @@
>   #include <linux/fault-inject.h>
>   #include <linux/random.h>
>   #include <linux/slab.h>
> +#include <linux/of.h>
>   
>   #include <linux/mmc/card.h>
>   #include <linux/mmc/host.h>
> @@ -1196,6 +1197,49 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
>   }
>   EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
>   
> +#ifdef CONFIG_OF
> +
> +/**
> + * mmc_of_parse_voltage - return mask of supported voltages
> + * @np: The device node need to be parsed.
> + * @mask: mask of voltages available for MMC/SD/SDIO
> + *
> + * 1. Return zero on success.
> + * 2. Return negative errno: voltage-range is invalid.
> + */
> +int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
> +{
> +	const u32 *voltage_ranges;
> +	int num_ranges, i;
> +
> +	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> +	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> +	if (!voltage_ranges || !num_ranges) {
> +		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_ranges; i++) {
> +		const int j = i * 2;
> +		u32 ocr_mask;
> +
> +		ocr_mask = mmc_vddrange_to_ocrmask(
> +				be32_to_cpu(voltage_ranges[j]),
> +				be32_to_cpu(voltage_ranges[j + 1]));
> +		if (!ocr_mask) {
> +			pr_err("%s: voltage-range #%d is invalid\n",
> +				np->full_name, i);
> +			return -EINVAL;
> +		}
> +		*mask |= ocr_mask;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mmc_of_parse_voltage);
> +
> +#endif /* CONFIG_OF */
> +
>   #ifdef CONFIG_REGULATOR
>   
>   /**
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 443243b..da51bec 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -208,6 +208,8 @@ static inline void mmc_claim_host(struct mmc_host *host)
>   	__mmc_claim_host(host, NULL);
>   }
>   
> +struct device_node;
>   extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> +extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
>   
>   #endif /* LINUX_MMC_CORE_H */


