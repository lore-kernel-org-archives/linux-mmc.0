From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH v2 1/1] mmc: bus: print bus speed mode of UHS-I card
Date: Fri, 30 Mar 2012 16:51:36 +0800
Message-ID: <20120330085135.GA13563@ladygaga>
References: <1333089618-20627-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1333089618-20627-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, arindam.nath@amd.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 30, 2012 at 12:10:18PM +0530, Subhash Jadavani wrote:
> When UHS-I card is detected also print the bus speed mode
> in which UHS-I card will be running.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>

Acked-by: Aaron Lu <aaron.lu@amd.com>

-Aaron

> ---
>  drivers/mmc/core/bus.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 5d011a3..3f60606 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -267,6 +267,15 @@ int mmc_add_card(struct mmc_card *card)
>  {
>  	int ret;
>  	const char *type;
> +	const char *uhs_bus_speed_mode = "";
> +	static const char *const uhs_speeds[] = {
> +		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
> +		[UHS_SDR25_BUS_SPEED] = "SDR25 ",
> +		[UHS_SDR50_BUS_SPEED] = "SDR50 ",
> +		[UHS_SDR104_BUS_SPEED] = "SDR104 ",
> +		[UHS_DDR50_BUS_SPEED] = "DDR50 ",
> +	};
> +
>  
>  	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), card->rca);
>  
> @@ -296,6 +305,10 @@ int mmc_add_card(struct mmc_card *card)
>  		break;
>  	}
>  
> +	if (mmc_sd_card_uhs(card) &&
> +		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
> +		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
> +
>  	if (mmc_host_is_spi(card->host)) {
>  		pr_info("%s: new %s%s%s card on SPI\n",
>  			mmc_hostname(card->host),
> @@ -303,13 +316,13 @@ int mmc_add_card(struct mmc_card *card)
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
>  			type);
>  	} else {
> -		pr_info("%s: new %s%s%s%s card at address %04x\n",
> +		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
>  			mmc_hostname(card->host),
>  			mmc_card_uhs(card) ? "ultra high speed " :
>  			(mmc_card_highspeed(card) ? "high speed " : ""),
>  			(mmc_card_hs200(card) ? "HS200 " : ""),
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
> -			type, card->rca);
> +			uhs_bus_speed_mode, type, card->rca);
>  	}
>  
>  #ifdef CONFIG_DEBUG_FS
> -- 
> 1.7.1.1
> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
