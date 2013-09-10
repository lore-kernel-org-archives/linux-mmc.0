From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] mmc: core: remove the mmc_sd_card_uhs()
Date: Tue, 10 Sep 2013 15:01:16 +0900
Message-ID: <522EB5AC.8070108@samsung.com>
References: <522EB1B3.6020402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54551 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab3IJGAx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Sep 2013 02:00:53 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW00EIMBDFOKR0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 Sep 2013 15:00:52 +0900 (KST)
In-reply-to: <522EB1B3.6020402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>, jackey.shen@amd.com

I found this patch has already posted at mailing.

http://permalink.gmane.org/gmane.linux.kernel.mmc/20474

On 09/10/2013 02:44 PM, Jaehoon Chung wrote:
> mmc_sd_card_uhs() didn't has difference with mmc_card_uhs().
> And mmc_sd_card_set_uhs() didn't use anywhere.
> 
> I'm not sure why mmc_sd_card_uhs() used.
> If need to check whether card is sd or not, then we can use the mmc_card_sd().
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/core/bus.c            |    2 +-
>  drivers/mmc/host/rtsx_pci_sdmmc.c |    2 +-
>  include/linux/mmc/card.h          |    2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 704bf66..cdca8a7 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -340,7 +340,7 @@ int mmc_add_card(struct mmc_card *card)
>  		break;
>  	}
>  
> -	if (mmc_sd_card_uhs(card) &&
> +	if (mmc_card_uhs(card) &&
>  		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
>  		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
>  
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 82a35b9..b6964a1 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -359,7 +359,7 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
>  	struct mmc_host *mmc = host->mmc;
>  	struct mmc_card *card = mmc->card;
>  	struct mmc_data *data = mrq->data;
> -	int uhs = mmc_sd_card_uhs(card);
> +	int uhs = mmc_card_uhs(card);
>  	int read = (data->flags & MMC_DATA_READ) ? 1 : 0;
>  	u8 cfg2, trans_mode;
>  	int err;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 842de3e..f42cdbd 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -420,7 +420,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
>  #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
>  #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
> -#define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>  #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
>  #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
> @@ -432,7 +431,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>  #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
>  #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
> -#define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
>  #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>  #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
> 

