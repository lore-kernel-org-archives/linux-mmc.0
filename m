From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: display the clock message only one time
 when card is polling
Date: Mon, 28 Nov 2016 10:42:55 +0900
Message-ID: <5c226fad-6cf9-a1dd-93cb-b13978f950ac@samsung.com>
References: <20161124110442.22058-1-jh80.chung@samsung.com>
 <CGME20161124110558epcas3p4bcab5139b810dee6a40af47fb7a534ad@epcas3p4.samsung.com>
 <20161124110442.22058-3-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47327 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbcK1Bm5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 20:42:57 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHB01SGYWRJJK80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Nov 2016 10:42:55 +0900 (KST)
In-reply-to: <20161124110442.22058-3-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

On 11/24/2016 08:04 PM, Jaehoon Chung wrote:
> When card is polling (broken-cd), there is a spamming messge related to
> clock.
> After applied this patch, display the message only one time at boot
> time. It's enough to check which clock values is used.
> Also prevent to display the spamming message.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied on my dwmmc repository.

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 13 ++++++++++++-
>  drivers/mmc/host/dw_mmc.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d508225..dd7e95d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1176,13 +1176,24 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  
>  		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
>  
> -		if (clock != slot->__clk_old || force_clkinit)
> +		if ((clock != slot->__clk_old &&
> +			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
> +			force_clkinit) {
>  			dev_info(&slot->mmc->class_dev,
>  				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
>  				 slot->id, host->bus_hz, clock,
>  				 div ? ((host->bus_hz / div) >> 1) :
>  				 host->bus_hz, div);
>  
> +			/*
> +			 * If card is polling, display the message only
> +			 * one time at boot time.
> +			 */
> +			if (slot->mmc->caps & MMC_CAP_NEEDS_POLL &&
> +					slot->mmc->f_min == clock)
> +				set_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags);
> +		}
> +
>  		/* disable clock */
>  		mci_writel(host, CLKENA, 0);
>  		mci_writel(host, CLKSRC, 0);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 4a6ae750..c594658 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -272,6 +272,7 @@ struct dw_mci_slot {
>  #define DW_MMC_CARD_NEED_INIT	1
>  #define DW_MMC_CARD_NO_LOW_PWR	2
>  #define DW_MMC_CARD_NO_USE_HOLD 3
> +#define DW_MMC_CARD_NEEDS_POLL	4
>  	int			id;
>  	int			sdio_id;
>  };
> 

