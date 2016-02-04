From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix num_slots setting
Date: Thu, 04 Feb 2016 15:10:17 +0900
Message-ID: <56B2EB49.6010505@samsung.com>
References: <1454393485-4770-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47829 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504AbcBDGKT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2016 01:10:19 -0500
In-reply-to: <1454393485-4770-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

On 02/02/2016 03:11 PM, Shawn Lin wrote:
> This patch make num_slots to 1 if pdata->num_slot is not
> defined. Meanwhile, we need to make sure num_slots should
> not larger that the supported slots

Thanks! I will apply this.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - remove default num-slots setting from dw_mci_parse_dt
> 
>  drivers/mmc/host/dw_mmc.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7128351..9696b77 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2864,12 +2864,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* find out number of slots supported */
> -	if (of_property_read_u32(dev->of_node, "num-slots",
> -				&pdata->num_slots)) {
> -		dev_info(dev,
> -			 "num-slots property not found, assuming 1 slot is available\n");
> -		pdata->num_slots = 1;
> -	}
> +	of_property_read_u32(np, "num-slots", &pdata->num_slots);
>  
>  	/* get quirks */
>  	for (idx = 0; idx < ARRAY_SIZE(of_quirks); idx++)
> @@ -2949,12 +2944,6 @@ int dw_mci_probe(struct dw_mci *host)
>  		}
>  	}
>  
> -	if (host->pdata->num_slots < 1) {
> -		dev_err(host->dev,
> -			"Platform data must supply num_slots.\n");
> -		return -ENODEV;
> -	}
> -
>  	host->biu_clk = devm_clk_get(host->dev, "biu");
>  	if (IS_ERR(host->biu_clk)) {
>  		dev_dbg(host->dev, "biu clock not available\n");
> @@ -3111,7 +3100,15 @@ int dw_mci_probe(struct dw_mci *host)
>  	if (host->pdata->num_slots)
>  		host->num_slots = host->pdata->num_slots;
>  	else
> -		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
> +		host->num_slots = 1;
> +
> +	if (host->num_slots < 1 ||
> +	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON))) {
> +		dev_err(host->dev,
> +			"Platform data must supply correct num_slots.\n");
> +		ret = -ENODEV;
> +		goto err_clk_ciu;
> +	}
>  
>  	/*
>  	 * Enable interrupts for command done, data over, data empty,
> 

