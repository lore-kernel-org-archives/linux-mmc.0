From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Enable MMC_CAP2_CACHE_CTRL as default
Date: Thu, 19 Dec 2013 23:43:41 +0900
Message-ID: <002b01cefcc8$b6168130$22438390$%jun@samsung.com>
References: <1387364961-15464-1-git-send-email-ulf.hansson@linaro.org>
 <1387364961-15464-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12360 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3LSOno (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 09:43:44 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY200DUB68UOG10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 Dec 2013 23:43:43 +0900 (KST)
In-reply-to: <1387364961-15464-2-git-send-email-ulf.hansson@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>

On Wed, December 18, 2013 Ulf Hansson wrote: 
> There are no reason to why the use of a non-volatile internal eMMC
> cache should be controlled by a host cap. Instead let's just enable it
> if the eMMC card supports it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

When cache feature was introduced for the first time, there was stability issue in some devices.
So host should have decided whether to select that feature.
Now, your change makes sense. But just check minor one below.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

> ---
>  drivers/mmc/core/core.c  |    3 ---
>  drivers/mmc/core/mmc.c   |    3 +--
>  include/linux/mmc/host.h |    1 -
>  3 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index df591a9..66ec347 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2585,9 +2585,6 @@ int mmc_flush_cache(struct mmc_card *card)
>  	struct mmc_host *host = card->host;
Also, 'host' can be removed.  No use.

Thanks,
Seungwon Jeon

>  	int err = 0;
> 
> -	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
> -		return err;
> -
>  	if (mmc_card_mmc(card) &&
>  			(card->ext_csd.cache_size > 0) &&
>  			(card->ext_csd.cache_ctrl & 1)) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ef1cc73..7ab3e9c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1287,8 +1287,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	 * If cache size is higher than 0, this indicates
>  	 * the existence of cache and it can be turned on.
>  	 */
> -	if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
> -			card->ext_csd.cache_size > 0) {
> +	if (card->ext_csd.cache_size > 0) {
>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				EXT_CSD_CACHE_CTRL, 1,
>  				card->ext_csd.generic_cmd6_time);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f539bc7..8383e3f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -264,7 +264,6 @@ struct mmc_host {
>  	u32			caps2;		/* More host capabilities */
> 
>  #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
> -#define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
>  #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
>  #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
>  #define MMC_CAP2_NO_SLEEP_CMD	(1 << 4)	/* Don't allow sleep command */
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

