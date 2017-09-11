From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: tegra: Mark 64 bit dma broken on Tegra186
Date: Mon, 11 Sep 2017 08:47:34 +0300
Message-ID: <17ddf6e8-0f3f-09ab-220a-ae97d8a07c5a@intel.com>
References: <1504900113-8983-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14886 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbdIKFyN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 Sep 2017 01:54:13 -0400
In-Reply-To: <1504900113-8983-1-git-send-email-vdumpa@nvidia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krishna Reddy <vdumpa@nvidia.com>, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/09/17 22:48, Krishna Reddy wrote:
> SDHCI controllers on Tegra186 support 40 bit addressing.
> IOVA addresses are 48-bit wide on Tegra186.
> SDHCI host common code sets dma mask as either 32-bit or 64-bit.
> To avoid access issues when SMMU is enabled, disable 64-bit dma.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 0cd6fa80db66..b877c13184c2 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -422,7 +422,15 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   /* SDHCI controllers on Tegra186 support 40-bit addressing.
> +		    * IOVA addresses are 48-bit wide on Tegra186.
> +		    * With 64-bit dma mask used for SDHCI, accesses can
> +		    * be broken. Disable 64-bit dma, which would fall back
> +		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
> +		    * But it is not supported as of now.
> +		    */
> +		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
>  	.ops  = &tegra114_sdhci_ops,
>  };
>  
> 

