From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH] mmc: omap: remove clock rate hard coding
Date: Wed, 21 Dec 2011 03:22:10 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C304F5B6@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A8062A41@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A8062A41@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 20, 2011 at 15:12, S, Venkatraman wrote:
> From: Balaji TK <balajitk@ti.com>
> 
> MMC master clock rate can vary for each instance of the MMC controller
> on the device. Use clk_get_rate instead to get the value.
> 
>   Signed-off-by: Balaji TK  <balajitk@ti.com>
>   Reviewed-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d5fe43d..5b35c7e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -120,7 +120,6 @@
>  
>  #define MMC_AUTOSUSPEND_DELAY	100
>  #define MMC_TIMEOUT_MS		20
> -#define OMAP_MMC_MASTER_CLOCK	96000000
>  #define OMAP_MMC_MIN_CLOCK	400000
>  #define OMAP_MMC_MAX_CLOCK	52000000
>  #define DRIVER_NAME		"omap_hsmmc"
> @@ -598,12 +597,12 @@ static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
>  }
>  
>  /* Calculate divisor for the given clock frequency */
> -static u16 calc_divisor(struct mmc_ios *ios)
> +static u16 calc_divisor(struct omap_hsmmc_host *host, struct mmc_ios *ios)
>  {
>  	u16 dsor = 0;
>  
>  	if (ios->clock) {
> -		dsor = DIV_ROUND_UP(OMAP_MMC_MASTER_CLOCK, ios->clock);
> +		dsor = DIV_ROUND_UP(clk_get_rate(host->fclk), ios->clock);
>  		if (dsor > 250)
>  			dsor = 250;
>  	}
> @@ -623,7 +622,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>  
>  	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
>  	regval = regval & ~(CLKD_MASK | DTO_MASK);
> -	regval = regval | (calc_divisor(ios) << 6) | (DTO << 16);
> +	regval = regval | (calc_divisor(host, ios) << 6) | (DTO << 16);
>  	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
>  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
>  		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Tested on AM335x platform.

Tested-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>

Regards, 
Gururaja
