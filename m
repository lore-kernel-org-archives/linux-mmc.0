From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] Revert "mmc: sdhci: Fix incorrect switch to HS mode"
Date: Thu, 28 Nov 2019 13:33:29 +0200
Message-ID: <3f3cd789-55a7-dee8-593c-6eb208877dd6@intel.com>
References: <20191128110422.25917-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128110422.25917-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, alcooperx@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 28/11/19 1:04 PM, Faiz Abbas wrote:
> This reverts commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37.
> 
> This commit aims to treat SD High speed and SDR25 as the same while
> setting UHS Timings in HOST_CONTROL2 which leads to failures with some
> SD cards in AM65x. Revert this commit.
> 
> The issue this commit was trying to fix can be implemented in a platform
> specific callback instead of common sdhci code.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3140fe2e5dba..296d955ede59 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1882,9 +1882,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>  	else if (timing == MMC_TIMING_UHS_SDR12)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -	else if (timing == MMC_TIMING_SD_HS ||
> -		 timing == MMC_TIMING_MMC_HS ||
> -		 timing == MMC_TIMING_UHS_SDR25)
> +	else if (timing == MMC_TIMING_UHS_SDR25)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>  	else if (timing == MMC_TIMING_UHS_SDR50)
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> 
