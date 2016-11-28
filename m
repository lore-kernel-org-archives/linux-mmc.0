From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add the debug message for polling and
 non-removable
Date: Mon, 28 Nov 2016 10:42:43 +0900
Message-ID: <f7bf3080-5c23-5860-5465-a528b366f971@samsung.com>
References: <20161124110442.22058-1-jh80.chung@samsung.com>
 <CGME20161124110558epcas3p19dc9b68e904f8ea780d3182e55c2270a@epcas3p1.samsung.com>
 <20161124110442.22058-2-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51157 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbcK1Bmp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 20:42:45 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHB032H0WR82Y80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Nov 2016 10:42:44 +0900 (KST)
In-reply-to: <20161124110442.22058-2-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

On 11/24/2016 08:04 PM, Jaehoon Chung wrote:
> If card is polling or non-removable, display the more exact message.
> It's helpful to debug which detecting scheme is using.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied on my dwmmc repository.

Best Regards,
Jaehoon Chung
> ---
>  drivers/mmc/host/dw_mmc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c6cc618..d508225 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1525,9 +1525,23 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  	int gpio_cd = mmc_gpio_get_cd(mmc);
>  
>  	/* Use platform get_cd function, else try onboard card detect */
> -	if ((mmc->caps & MMC_CAP_NEEDS_POLL) || !mmc_card_is_removable(mmc))
> +	if (((mmc->caps & MMC_CAP_NEEDS_POLL)
> +				|| !mmc_card_is_removable(mmc))) {
>  		present = 1;
> -	else if (gpio_cd >= 0)
> +
> +		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
> +			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
> +				dev_info(&mmc->class_dev,
> +					"card is polling.\n");
> +			} else {
> +				dev_info(&mmc->class_dev,
> +					"card is non-removable.\n");
> +			}
> +			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +		}
> +
> +		return present;
> +	} else if (gpio_cd >= 0)
>  		present = gpio_cd;
>  	else
>  		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
> 

