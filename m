From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: core: Use mmc_flush_cache() during mmc suspend
Date: Thu, 19 Dec 2013 23:46:17 +0900
Message-ID: <002c01cefcc9$131cbe80$39563b80$%jun@samsung.com>
References: <1387364961-15464-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56520 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3LSOqU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 09:46:20 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY200FUI6D6N510@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 Dec 2013 23:46:18 +0900 (KST)
In-reply-to: <1387364961-15464-1-git-send-email-ulf.hansson@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>

On Wed, December 18, 2013 Ulf Hansson wrote:
> Earlier we disabled the cache during suspend, which meant a flush was
> internally at the eMMC performed as well.
> 
> To simplify code we can make use of the mmc_flush_cache(), during mmc
> suspend, which makes the mmc_cache_ctrl() redundant so then we can
> remove it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> ---
>  drivers/mmc/core/core.c  |   38 --------------------------------------
>  drivers/mmc/core/mmc.c   |    2 +-
>  include/linux/mmc/host.h |    2 --
>  3 files changed, 1 insertion(+), 41 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 098374b..df591a9 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2602,44 +2602,6 @@ int mmc_flush_cache(struct mmc_card *card)
>  }
>  EXPORT_SYMBOL(mmc_flush_cache);
> 
> -/*
> - * Turn the cache ON/OFF.
> - * Turning the cache OFF shall trigger flushing of the data
> - * to the non-volatile storage.
> - * This function should be called with host claimed
> - */
> -int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
> -{
> -	struct mmc_card *card = host->card;
> -	unsigned int timeout;
> -	int err = 0;
> -
> -	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
> -			mmc_card_is_removable(host))
> -		return err;
> -
> -	if (card && mmc_card_mmc(card) &&
> -			(card->ext_csd.cache_size > 0)) {
> -		enable = !!enable;
> -
> -		if (card->ext_csd.cache_ctrl ^ enable) {
> -			timeout = enable ? card->ext_csd.generic_cmd6_time : 0;
> -			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -					EXT_CSD_CACHE_CTRL, enable, timeout);
> -			if (err)
> -				pr_err("%s: cache %s error %d\n",
> -						mmc_hostname(card->host),
> -						enable ? "on" : "off",
> -						err);
> -			else
> -				card->ext_csd.cache_ctrl = enable;
> -		}
> -	}
> -
> -	return err;
> -}
> -EXPORT_SYMBOL(mmc_cache_ctrl);
> -
>  #ifdef CONFIG_PM
> 
>  /* Do the card removal on suspend if card is assumed removeable
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 98e9eb0..ef1cc73 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1484,7 +1484,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>  			goto out;
>  	}
> 
> -	err = mmc_cache_ctrl(host, 0);
> +	err = mmc_flush_cache(host->card);
>  	if (err)
>  		goto out;
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 99f5709..f539bc7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -388,8 +388,6 @@ int mmc_power_restore_host(struct mmc_host *host);
>  void mmc_detect_change(struct mmc_host *, unsigned long delay);
>  void mmc_request_done(struct mmc_host *, struct mmc_request *);
> 
> -int mmc_cache_ctrl(struct mmc_host *, u8);
> -
>  static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>  {
>  	host->ops->enable_sdio_irq(host, 0);
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

