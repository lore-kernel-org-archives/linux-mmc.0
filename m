From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: check the "present" variable before
 checking flags
Date: Mon, 28 Nov 2016 10:42:35 +0900
Message-ID: <dea7cace-2493-6e4b-27ac-575d9ad98d08@samsung.com>
References: <CGME20161124110445epcas5p17a1437a2c6b7b3c228b06e23893fedbe@epcas5p1.samsung.com>
 <20161124110442.22058-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49809 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbcK1Bmi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 20:42:38 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHB00Z5YWQZVI80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Nov 2016 10:42:35 +0900 (KST)
In-reply-to: <20161124110442.22058-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

On 11/24/2016 08:04 PM, Jaehoon Chung wrote:
> Before checking flags, it has to check "present" variable.
> Otherwise, flags should be cleared everytime.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied on my dwmmc repository.

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d400afc..c6cc618 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1536,7 +1536,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  	spin_lock_bh(&host->lock);
>  	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
>  		dev_dbg(&mmc->class_dev, "card is present\n");
> -	else if (!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
> +	else if (!present &&
> +			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
>  		dev_dbg(&mmc->class_dev, "card is not present\n");
>  	spin_unlock_bh(&host->lock);
>  
> 

