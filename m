From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
Date: Mon, 22 Jul 2013 12:40:47 -0500
Message-ID: <1374514847.15592.7@snotra>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
	<1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:11234
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147Ab3GVRlA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Jul 2013 13:41:00 -0400
In-Reply-To: <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Mon Jul 22 02:53:56 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

On 07/22/2013 02:53:56 AM, Haijun Zhang wrote:
> Add voltage-range support in esdhc of T4, So we can choose
> to read voltages from dts file as one optional.
> If we can get a valid voltage-range from device node, we use
> this voltage as the final voltage support. Else we still read
> from capacity or from other provider.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 31  
> +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c          |  3 +++
>  include/linux/mmc/sdhci.h         |  1 +
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c  
> b/drivers/mmc/host/sdhci-of-esdhc.c
> index 15039e2..8b4b27a 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -262,6 +262,35 @@ static int esdhc_pltfm_bus_width(struct  
> sdhci_host *host, int width)
>  	return 0;
>  }
> 
> +static void esdhc_get_voltage(struct sdhci_host *host,
> +			struct platform_device *pdev)
> +{
> +	const u32 *voltage_ranges;
> +	int num_ranges, i;
> +	struct device_node *np;
> +	np = pdev->dev.of_node;
> +
> +	voltage_ranges = of_get_property(np, "voltage-ranges",  
> &num_ranges);
> +	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> +	if (!voltage_ranges || !num_ranges) {
> +		dev_info(&pdev->dev, "OF: voltage-ranges  
> unspecified\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < num_ranges; i++) {
> +		const int j = i * 2;
> +		u32 mask;
> +		mask =  
> mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> +				be32_to_cpu(voltage_ranges[j + 1]));
> +		if (!mask) {
> +			dev_info(&pdev->dev,
> +				"OF: false voltage-ranges specified\n");
> +			return;
> +		}
> +		host->ocr_mask |= mask;
> +	}
> +}

Don't duplicate this code.  Move it somewhere common and share it.

Why did you remove the range index from the error string, and why did  
you change it from dev_err to dev_info?

-Scott
