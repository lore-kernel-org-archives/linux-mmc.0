From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 1/3 V3] mmc:core: parse voltage from device-tree
Date: Fri, 9 Aug 2013 15:42:52 -0700
Message-ID: <20130809224252.GA28851@teo>
References: <1376017863-31453-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43755 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031355Ab3HIWm4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 18:42:56 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1108896pde.24
        for <linux-mmc@vger.kernel.org>; Fri, 09 Aug 2013 15:42:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376017863-31453-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com

On Fri, Aug 09, 2013 at 11:11:01AM +0800, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the available voltage mask.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for V3:
> 	- Correct the type of return value.
> changes for v2:
> 	- Update the parameters of function
> 
>  drivers/mmc/core/core.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/core.h |  2 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 49a5bca..1b13c37 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1196,6 +1196,51 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
>  }
>  EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
>  
> +#ifdef CONFIG_OF
> +
> +/**
> + * mmc_of_parse_voltage - return mask of supported voltages
> + * @np: The device node need to be parsed.
> + *
> + * 1. Return zero: voltage-ranges unspecified in device-tree
> + * 2. Return negative errno: voltage-range is invalid.
> + * 3. Return ocr_mask: a mask of voltages that parse from device-tree
> + * node that can be provided to MMC/SD/SDIO devices.
> + */
> +int mmc_of_parse_voltage(struct device_node *np)
> +{
> +	const u32 *voltage_ranges;
> +	int num_ranges, i;
> +	int ocr_mask;
> +
> +	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> +	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> +	if (!voltage_ranges || !num_ranges) {
> +		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < num_ranges; i++) {
> +		const int j = i * 2;
> +		u32 mask;
> +
> +		mask = mmc_vddrange_to_ocrmask(
> +				be32_to_cpu(voltage_ranges[j]),
> +				be32_to_cpu(voltage_ranges[j + 1]));
> +		if (!mask) {
> +			pr_err("%s: voltage-range #%d is invalid\n",
> +				np->full_name, i);
> +			return -EINVAL;
> +		}
> +		ocr_mask |= mask;
> +	}
> +
> +	return ocr_mask;

Are you sure that (u32)(-EINVAL) is not a valid ocr_mask? In any case,
please don't do these kind of hacks... don't return mask and a errors
together.

> +}
> +EXPORT_SYMBOL(mmc_of_parse_voltage);
> +
> +#endif /* CONFIG_OF */
> +
>  #ifdef CONFIG_REGULATOR
>  
>  /**
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 443243b..117f719 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/completion.h>
> +#include <linux/of.h>
>  
>  struct request;
>  struct mmc_data;
> @@ -209,5 +210,6 @@ static inline void mmc_claim_host(struct mmc_host *host)
>  }
>  
>  extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> +extern int mmc_of_parse_voltage(struct device_node *np);

You don't really need to include the whole linux/of.h, forward-declaration
of 'struct device_node;' is enough here.

Thanks,

Anton
