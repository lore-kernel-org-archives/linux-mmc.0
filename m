From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: Re: [PATCH v2 1/1] mmc: sd: UHS-I bus speed should be set last in
     UHS initialization
Date: Mon, 22 Aug 2011 02:47:16 -0700 (PDT)
Message-ID: <9ee37b38ae8b93ce66b7b9daa0d08d9f.squirrel@www.codeaurora.org>
References: <1312872571-12091-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57050 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab1HVJrR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2011 05:47:17 -0400
In-Reply-To: <1312872571-12091-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: arindam.nath@amd.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>

Hi Arindam,

Can you please check if this patch looks ok or not?

Regards,
Subhash

> mmc_sd_init_uhs_card function sets the driver type, current limit
> and bus speed mode on card as well as on host controller side.
>
> Currently bus speed mode is set by sending CMD6 to card and
> immediately setting the timing mode in host controller. But
> then before initiating tuning sequence, it also tries to set
> current limit by sending CMD6 to card which results in data
> timeout errors in controller if bus speed mode is SDR50/SDR104 mode.
>
> So basically bus speed mode should be set only after current limit
> is set in the card and immediately after setting the bus speed mode,
> tuning sequence should be initiated.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
>  drivers/mmc/core/sd.c |   81
> ++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 53 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index e2dcf23..2191dda 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -459,56 +459,75 @@ static int sd_select_driver_type(struct mmc_card
> *card, u8 *status)
>  	return 0;
>  }
>
> -static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
> +static void sd_update_bus_speed_mode(struct mmc_card *card)
>  {
> -	unsigned int bus_speed = 0, timing = 0;
> -	int err;
> -
>  	/*
>  	 * If the host doesn't support any of the UHS-I modes, fallback on
>  	 * default speed.
>  	 */
>  	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> -	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50)))
> -		return 0;
> +	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))) {
> +		card->sd_bus_speed = 0;
> +		return;
> +	}
>
>  	if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
>  	    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
> -			bus_speed = UHS_SDR104_BUS_SPEED;
> -			timing = MMC_TIMING_UHS_SDR104;
> -			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
> +			card->sd_bus_speed = UHS_SDR104_BUS_SPEED;
>  	} else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
>  		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
> -			bus_speed = UHS_DDR50_BUS_SPEED;
> -			timing = MMC_TIMING_UHS_DDR50;
> -			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> +			card->sd_bus_speed = UHS_DDR50_BUS_SPEED;
>  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>  		    MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
>  		    SD_MODE_UHS_SDR50)) {
> -			bus_speed = UHS_SDR50_BUS_SPEED;
> -			timing = MMC_TIMING_UHS_SDR50;
> -			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> +			card->sd_bus_speed = UHS_SDR50_BUS_SPEED;
>  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
>  		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
> -			bus_speed = UHS_SDR25_BUS_SPEED;
> -			timing = MMC_TIMING_UHS_SDR25;
> -			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> +			card->sd_bus_speed = UHS_SDR25_BUS_SPEED;
>  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
>  		    MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
>  		    SD_MODE_UHS_SDR12)) {
> -			bus_speed = UHS_SDR12_BUS_SPEED;
> -			timing = MMC_TIMING_UHS_SDR12;
> -			card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
> +			card->sd_bus_speed = UHS_SDR12_BUS_SPEED;
> +	}
> +}
> +
> +static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
> +{
> +	int err;
> +	unsigned int timing = 0;
> +
> +	switch (card->sd_bus_speed) {
> +	case UHS_SDR104_BUS_SPEED:
> +		timing = MMC_TIMING_UHS_SDR104;
> +		card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
> +		break;
> +	case UHS_DDR50_BUS_SPEED:
> +		timing = MMC_TIMING_UHS_DDR50;
> +		card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> +		break;
> +	case UHS_SDR50_BUS_SPEED:
> +		timing = MMC_TIMING_UHS_SDR50;
> +		card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> +		break;
> +	case UHS_SDR25_BUS_SPEED:
> +		timing = MMC_TIMING_UHS_SDR25;
> +		card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> +		break;
> +	case UHS_SDR12_BUS_SPEED:
> +		timing = MMC_TIMING_UHS_SDR12;
> +		card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
> +		break;
> +	default:
> +		return 0;
>  	}
>
> -	card->sd_bus_speed = bus_speed;
> -	err = mmc_sd_switch(card, 1, 0, bus_speed, status);
> +	err = mmc_sd_switch(card, 1, 0, card->sd_bus_speed, status);
>  	if (err)
>  		return err;
>
> -	if ((status[16] & 0xF) != bus_speed)
> +	if ((status[16] & 0xF) != card->sd_bus_speed)
>  		printk(KERN_WARNING "%s: Problem setting bus speed mode!\n",
>  			mmc_hostname(card->host));
>  	else {
> @@ -608,18 +627,24 @@ static int mmc_sd_init_uhs_card(struct mmc_card
> *card)
>  		mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
>  	}
>
> +	/*
> +	 * Select the bus speed mode depending on host
> +	 * and card capability.
> +	 */
> +	sd_update_bus_speed_mode(card);
> +
>  	/* Set the driver strength for the card */
>  	err = sd_select_driver_type(card, status);
>  	if (err)
>  		goto out;
>
> -	/* Set bus speed mode of the card */
> -	err = sd_set_bus_speed_mode(card, status);
> +	/* Set current limit for the card */
> +	err = sd_set_current_limit(card, status);
>  	if (err)
>  		goto out;
>
> -	/* Set current limit for the card */
> -	err = sd_set_current_limit(card, status);
> +	/* Set bus speed mode of the card */
> +	err = sd_set_bus_speed_mode(card, status);
>  	if (err)
>  		goto out;
>
> --
> 1.7.1.1
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

