From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: RE: [PATCH 3/8] mmc: core: remove BUG_ONs from mmc
Date: Wed, 2 Nov 2016 09:40:35 +0000
Message-ID: <4a277797476345c7a4db8f1fa12bca08@bgmail103.nvidia.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com>
 <1478071533-12775-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5897 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbcKBJkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2016 05:40:41 -0400
In-Reply-To: <1478071533-12775-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Shawn Lin
> Sent: Wednesday, November 02, 2016 12:56 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org; Shawn Lin <shawn.lin@rock-chips.com>
> Subject: [PATCH 3/8] mmc: core: remove BUG_ONs from mmc
> 
> BUG_ONs doesn't help anything except for stop the system from running. If it
> occurs, it implies we should deploy proper error handling for that. So this patch is
> gonna discard these meaningless BUG_ONs and deploy error handling if needed.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/core/mmc.c     | 14 --------------
>  drivers/mmc/core/mmc_ops.c | 17 -----------------
>  2 files changed, 31 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> e811bd9..4763a35 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1464,7 +1464,6 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>  	u32 cid[4];
>  	u32 rocr;
> 
> -	BUG_ON(!host);

Instead of just removing BUG_ON, it would be worth adding null check and
return from here graciously as you mentioned in patch commit message,
without which next instruction below may crash if host == NULL.

Similar is the case with other removals below.

>  	WARN_ON(!host->claimed);
> 
>  	/* Set correct bus mode for MMC before attempting init */ @@ -1854,9
> +1853,6 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int
> notify_type)
>   */
>  static void mmc_remove(struct mmc_host *host)  {
> -	BUG_ON(!host);
> -	BUG_ON(!host->card);
> -
>  	mmc_remove_card(host->card);
>  	host->card = NULL;
>  }
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
