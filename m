From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv3 3/4] mmc: dw_mmc: remove the "supports-highspeed"
 property.
Date: Fri, 30 May 2014 21:53:23 +0900
Message-ID: <001c01cf7c06$24809bd0$6d81d370$%jun@samsung.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
 <1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Wed, May 28, 2014, Jaehoon Chung wrote:
> Removed the parser for "supports-highspeed".
> It can be parsed with "cap-mmc-highsped" or "cap-sd-highspeed" at
> mmc_of_parse().
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Tahnks,
Seungwon Jeon

> ---
>  drivers/mmc/host/dw_mmc.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3285bdd..34b5210 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2281,9 +2281,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  			return ERR_PTR(ret);
>  	}
> 
> -	if (of_find_property(np, "supports-highspeed", NULL))
> -		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> -
>  	return pdata;
>  }
> 
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
