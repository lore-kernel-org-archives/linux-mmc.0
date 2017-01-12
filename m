From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: remove default broken-cd for ARM
Date: Thu, 12 Jan 2017 09:15:21 +0200
Message-ID: <c04b729e-45ee-6ffd-a52c-bf117f4b3c42@intel.com>
References: <1482745244-24114-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3568 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbdALHUd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Jan 2017 02:20:33 -0500
In-Reply-To: <1482745244-24114-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On 26/12/16 11:40, Yangbo Lu wrote:
> Initially all QorIQ platforms were PowerPC architecture and they didn't
> support card detection except several platforms. The driver added the
> quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION as default and this made broken-cd
> property in dts node didn't work. Now QorIQ platform turns to ARM
> architecture and most of them could support card detection. However it's
> a large number of dts trees that need to be fixed with broken-cd if we
> remove the default SDHCI_QUIRK_BROKEN_CARD_DETECTION in driver. And the
> users don't want to see this. So this patch is to remove this default
> quirk just for ARM and keep it for PowerPC.(Note, QorIQ PowerPC platform
> only has big-endian eSDHC while QorIQ ARM platform has big-endian or
> little-endian eSDHC) This makes broken-cd property work again for ARM.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 9a6eb44..364f6b8 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -569,16 +569,19 @@ static const struct sdhci_ops sdhci_esdhc_le_ops = {
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata = {
> -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> -		| SDHCI_QUIRK_NO_CARD_NO_RESET
> -		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks = ESDHC_DEFAULT_QUIRKS |
> +#ifdef CONFIG_PPC
> +		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +#endif
> +		  SDHCI_QUIRK_NO_CARD_NO_RESET |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops = &sdhci_esdhc_be_ops,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_esdhc_le_pdata = {
> -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> -		| SDHCI_QUIRK_NO_CARD_NO_RESET
> -		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks = ESDHC_DEFAULT_QUIRKS |
> +		  SDHCI_QUIRK_NO_CARD_NO_RESET |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops = &sdhci_esdhc_le_ops,
>  };
>  
> @@ -643,8 +646,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
>  	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
>  	    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,t1040-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
> +	    of_device_is_compatible(np, "fsl,t1040-esdhc"))
>  		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  
>  	if (of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
> 

