From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/17] mmc: host: omap_hsmmc: use devm_regulator_get_optional()
 for vmmc
Date: Wed, 29 Jul 2015 15:09:09 +0300
Message-ID: <55B8C265.1050801@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com> <1438168187-1614-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438168187-1614-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, afenkart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 07/29/2015 02:09 PM, Kishon Vijay Abraham I wrote:
> Since vmmc can be optional for some platforms, use
> devm_regulator_get_optional() for vmmc. Now return error only
> in the case of -EPROBE_DEFER and for all other cases set
> host->vcc to NULL.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/mmc/host/omap_hsmmc.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4d12032..b673e59 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -344,11 +344,13 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>   	struct regulator *reg;
>   	int ocr_value = 0;
>   
> -	reg = devm_regulator_get(host->dev, "vmmc");
> +	reg = devm_regulator_get_optional(host->dev, "vmmc");
>   	if (IS_ERR(reg)) {
> -		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
> +		if (PTR_ERR(reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		host->vcc = NULL;
> +		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
>   			PTR_ERR(reg));
> -		return PTR_ERR(reg);

I think, It could be unsafe to just drop this return.
regulator_get_optional may return:
1 valid pointer on regulator : success;
2 ERR_PTR(-ENODEV)           : regulator is not assigned, can proceed.
3 ERR_PTR(-EPROBE_DEFER)     : regulator is assigned, but not ready yet, retry.
4 ERR_PTR(<other error codes>: regulator is assigned, but can't be retrieved, failure, can't proceed

So, It's allowed to continue with host->vcc = NULL; only in case [2], while
in case [4] probe should fail.

>   	} else {
>   		host->vcc = reg;
>   		ocr_value = mmc_regulator_get_ocrmask(reg);
> 


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
