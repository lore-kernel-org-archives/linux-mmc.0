From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/7] mmc: omap_hsmmc: use devm_regulator API
Date: Fri, 20 Dec 2013 10:38:54 -0800
Message-ID: <20131220183837.GB26054@atomide.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1387560955-6547-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387560955-6547-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [131220 09:37]:
> Use devm_regulator API, while at it use
> devm_regulator_get_optional for optional vmmc_aux supply
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index dbd32ad..1eb4350 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -316,7 +316,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  	struct regulator *reg;
>  	int ocr_value = 0;
>  
> -	reg = regulator_get(host->dev, "vmmc");
> +	reg = devm_regulator_get(host->dev, "vmmc");
>  	if (IS_ERR(reg)) {
>  		dev_err(host->dev, "vmmc regulator missing\n");
>  		return PTR_ERR(reg);
> @@ -336,7 +336,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  		}
>  
>  		/* Allow an aux regulator */
> -		reg = regulator_get(host->dev, "vmmc_aux");
> +		reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
>  		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
>  
>  		/* For eMMC do not power off when not in sleep state */
> @@ -366,8 +366,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  
>  static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
>  {
> -	regulator_put(host->vcc);
> -	regulator_put(host->vcc_aux);
>  	mmc_slot(host).set_power = NULL;
>  }
>  
> -- 
> 1.7.5.4
> 
