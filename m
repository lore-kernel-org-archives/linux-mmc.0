From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Fri, 26 Apr 2019 09:00:35 +0300
Message-ID: <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425155727.20010-3-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 25/04/19 6:57 PM, Faiz Abbas wrote:
> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
> fields are exchanged. Fix this.

Could you also comment on whether this has any known effect on the driver.

> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 866a9082705f..613b151a73c5 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -205,8 +205,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>  		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>  
> -	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
> -			   SLOTTYPE_MASK);
> +	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
> +			   ctl_cfg_2);
>  
>  	return sdhci_add_host(host);
>  }
> 
