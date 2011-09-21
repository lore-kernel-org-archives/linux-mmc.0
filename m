From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: HS200 mode support for eMMC 4.5
Date: Wed, 21 Sep 2011 14:26:40 -0400
Message-ID: <m2obyd3g67.fsf@bob.laptop.org>
References: <1316181604-31378-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1316181604-31378-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Fri, 16 Sep 2011 19:30:04 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On Fri, Sep 16 2011, Girish K S wrote:
> This patch adds the support of the HS200 bus speed for
> eMMC 4.5 devices.
> The eMMC 4.5 devices have support for 200MHz bus speed.
> The mmc core and host modules have been touched to add support
> for this module.
> It is necessary to know the card type in the sdhci.c file to
> add support for eMMC tuning function. So card.h file is included
> to import the card data structure.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/core/bus.c   |    3 +-
>  drivers/mmc/core/mmc.c   |  116 ++++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci.c |   18 ++++++-
>  include/linux/mmc/card.h |    3 +
>  include/linux/mmc/host.h |    8 +++
>  include/linux/mmc/mmc.h  |    9 +++-
>  6 files changed, 143 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 393d817..a0aa7ab 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
>  			type);
>  	} else {
> -		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
> +		printk(KERN_INFO "%s: new %s%s%s%s card at address %04x\n",
>  			mmc_hostname(card->host),
>  			mmc_sd_card_uhs(card) ? "ultra high speed " :
>  			(mmc_card_highspeed(card) ? "high speed " : ""),
> +			(mmc_card_hs200(card) ? "HS200 " : ""),
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
>  			type, card->rca);
>  	}
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9cbc113..c50ca42 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -283,6 +283,66 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	}
>  	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
>  	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
> +	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_52 |
> +	     EXT_CSD_CARD_TYPE_26:
> +		card->ext_csd.hs_max_dtr = 200000000;
> +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
> +		break;
> +	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_8V |
> +		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> +		card->ext_csd.hs_max_dtr = 200000000;
> +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
> +		break;

Please try shortening this switch-case by avoiding duplicating sections
that repeat the same action, and having the case fall-through instead.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
