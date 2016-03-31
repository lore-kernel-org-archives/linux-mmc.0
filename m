From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 4/4] mmc: dw_mmc: remove setup_clock callback
Date: Thu, 31 Mar 2016 15:38:41 +0900
Message-ID: <56FCC5F1.4040203@samsung.com>
References: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
 <1453944679-16981-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47655 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbcCaGin (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2016 02:38:43 -0400
In-reply-to: <1453944679-16981-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/28/2016 10:31 AM, Shawn Lin wrote:
> Now, no dw_mmc variant drivers use this callback, let's
> remove it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 9 ---------
>  drivers/mmc/host/dw_mmc.h | 1 -
>  2 files changed, 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1d27a2b..ee13374 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3003,15 +3003,6 @@ int dw_mci_probe(struct dw_mci *host)
>  		}
>  	}
>  
> -	if (drv_data && drv_data->setup_clock) {
> -		ret = drv_data->setup_clock(host);
> -		if (ret) {
> -			dev_err(host->dev,
> -				"implementation specific clock setup failed\n");
> -			goto err_clk_ciu;
> -		}
> -	}
> -
>  	setup_timer(&host->cmd11_timer,
>  		    dw_mci_cmd11_timer, (unsigned long)host);
>  
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 1a9492e..bfc2a4d 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -286,7 +286,6 @@ struct dw_mci_slot {
>  struct dw_mci_drv_data {
>  	unsigned long	*caps;
>  	int		(*init)(struct dw_mci *host, bool setup_clk);
> -	int		(*setup_clock)(struct dw_mci *host);

Could you remove the description for setup_clock?

  * @init: early implementation specific initialization.
- * @setup_clock: implementation specific clock configuration.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.

Best Regards,
Jaehoon Chung

>  	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
>  	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>  	int		(*parse_dt)(struct dw_mci *host);
> 

