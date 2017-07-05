From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: mmc_ops: fix a typo for comment of mmc_start_bkops
Date: Wed, 05 Jul 2017 16:33:11 +0900
Message-ID: <617d9cef-4fee-443a-2399-ddebf865e439@samsung.com>
References: <CGME20170704023045epcas2p3d2ecc51795cd3ba785723c418176f2be@epcas2p3.samsung.com>
        <1499135403-56224-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29571 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdGEHdO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jul 2017 03:33:14 -0400
In-reply-to: <1499135403-56224-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 07/04/2017 11:30 AM, Shawn Lin wrote:
> Just a trivial fix for that found by reading the code.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 5f7c592..6dd8ecd 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -946,7 +946,7 @@ static int mmc_read_bkops_status(struct mmc_card *card)
>  /**
>   *	mmc_start_bkops - start BKOPS for supported cards
>   *	@card: MMC card to start BKOPS
> - *	@form_exception: A flag to indicate if this function was
> + *	@from_exception: A flag to indicate if this function was
>   *			 called due to an exception raised by the card
>   *
>   *	Start background operations whenever requested.
> 

