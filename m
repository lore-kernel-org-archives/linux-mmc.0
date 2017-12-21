From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/12] mmc: sdhci_omap: Fix sdhci-omap quirks
Date: Thu, 21 Dec 2017 11:12:53 +0200
Message-ID: <a153d6b2-bca0-485b-cff0-2a6c7875b177@intel.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-8-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214130941.26666-8-kishon-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
> Remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk as gpio card detection
> is supported in sdhci-omap.

SDHCI_QUIRK_BROKEN_CARD_DETECTION is for native card detection not gpio card
detection.

> 
> Add SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk as setting preset values loads
> incorrect CLKD values (for UHS modes).
> 
> Remove SDHCI_QUIRK2_NO_1_8_V quirk as sdhci-omap now supports UHS modes.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-omap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 594e41200d8a..6dee275b2e57 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -755,13 +755,12 @@ static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
>  }
>  
>  static const struct sdhci_pltfm_data sdhci_omap_pdata = {
> -	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> -		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
> -	.quirks2 = SDHCI_QUIRK2_NO_1_8_V |
> -		   SDHCI_QUIRK2_ACMD23_BROKEN |
> +	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
> +		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  		   SDHCI_QUIRK2_RSP_136_HAS_CRC,
>  	.ops = &sdhci_omap_ops,
>  };
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
