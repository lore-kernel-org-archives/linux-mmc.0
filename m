From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC v2 2/2] mmc: sdhci: Ignore capability register when it comes
 to speeds and use DT binding instead when sdhci-cap-speed-modes-broken is
 set.
Date: Mon, 24 Oct 2016 10:34:46 +0300
Message-ID: <d4547457-036a-dbb7-ddb8-b839e04949b7@intel.com>
References: <1477085715-30213-1-git-send-email-zach.brown@ni.com>
 <1477085715-30213-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10893 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932235AbcJXHjj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 03:39:39 -0400
In-Reply-To: <1477085715-30213-3-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>, ulf.hansson@linaro.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 22/10/16 00:35, Zach Brown wrote:
> When the sdhci-cap-speed-modes-broken DT property is set, the driver
> will ignore the bits of the capability registers that correspond to
> speed modes.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  drivers/mmc/host/sdhci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1e25b01..59c62d3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -22,6 +22,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>  
>  #include <linux/leds.h>
>  
> @@ -3013,10 +3014,19 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>  
>  	host->caps = caps ? *caps : sdhci_readl(host, SDHCI_CAPABILITIES);
>  
> +	if (of_property_read_bool(mmc_dev(host->mmc)->of_node,
> +				  "sdhci-cap-speed-modes-broken"))

It rather begs the question: if you are going to do something sdhci
specific, why not just read the whole of the caps register from DT?

> +		host->caps &= ~SDHCI_CAN_DO_HISPD;
> +
>  	if (host->version < SDHCI_SPEC_300)
>  		return;
>  
>  	host->caps1 = caps1 ? *caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +
> +	if (of_property_read_bool(mmc_dev(host->mmc)->of_node,
> +				  "sdhci-cap-speed-modes-broken"))

Why read it twice?

> +		host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
> +				 SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_HS400);
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>  
> 

