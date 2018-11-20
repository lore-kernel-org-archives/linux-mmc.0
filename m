From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-omap: Remove redundant structure
 assignments
Date: Tue, 20 Nov 2018 10:31:35 +0530
Message-ID: <e337e772-5581-c225-e1c1-58fa6d285988@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-5-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org



On 19/11/18 4:46 PM, Faiz Abbas wrote:
> The sdhci_execute_tuning() function has assignment of
> private pointers multiple times. Remove the redundant assignment.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/mmc/host/sdhci-omap.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index bf268b38ddc8..b3cb39d0db6f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -295,10 +295,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   	int ret = 0;
>   	u32 reg;
>   
> -	pltfm_host = sdhci_priv(host);
> -	omap_host = sdhci_pltfm_priv(pltfm_host);
> -	dev = omap_host->dev;
> -
>   	/* clock tuning is not needed for upto 52MHz */
>   	if (ios->clock <= 52000000)
>   		return 0;
> 
