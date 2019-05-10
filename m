From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Fri, 10 May 2019 08:58:32 +0300
Message-ID: <0662a705-1991-e854-21a4-4ff6b5533f13@intel.com>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
 <20190510034228.32211-4-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510034228.32211-4-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 10/05/19 6:42 AM, Faiz Abbas wrote:
> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
> fields are exchanged. Fix this. This didn't have any affect on the
> driver because this was a NOP and it was taking the correct value from
> the bootloader.
> 
> Cc: stable <stable@vger.kernel.org>

Except that it doesn't apply to stable because of patch 1.  Maybe make this
the first patch.

> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 3ff949925127..d0b20780dd0f 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -227,8 +227,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
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
