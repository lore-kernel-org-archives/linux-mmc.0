From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH RFC] mmc: sd: Fix signal voltage when there is no power
 cycle
Date: Fri, 22 Sep 2017 08:39:33 +0800
Message-ID: <58f030eb-dbfb-f96e-f665-39c9c176bb9f@rock-chips.com>
References: <1503978827-202915-1-git-send-email-shawn.lin@rock-chips.com>
 <CAAXpJNvfSWHrJiLHoxmm+ENUDsGayQROnRTL=SoHr-7dX7R9+Q@mail.gmail.com>
 <59A5E6F2.5000407@marvell.com>
 <745b195b-bdd1-e675-a36a-ca22eb41feaa@rock-chips.com>
 <59A9E5CD.3000703@marvell.com>
 <12498751-b7cc-03a4-efa5-cd0134dd57d3@rock-chips.com>
 <a367a679-28f7-898a-c043-27df8c9c9aba@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:36160 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdIVAjg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Sep 2017 20:39:36 -0400
In-Reply-To: <a367a679-28f7-898a-c043-27df8c9c9aba@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Zhoujie Wu <zjwu@marvell.com>, shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2017/9/21 15:44, Adrian Hunter wrote:
> If the card has not been power cycled, it may still be using 1.8V
> signaling. According to the SD spec., the Bus Speed Mode (function group 1)
> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
> they can be used to determine if the card has already switched to 1.8V
> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
> transfer mode.
> 
> Tested with the following cards:
>    Transcend 4GB High Speed
>    Kingston 64GB SDR104
>    Lexar by Micron HIGH-PERFORMANCE 300x 16GB DDR50
>    SanDisk Ultra 8GB DDR50
>    Transcend Ultimate 600x 16GB SDR104
>    Transcend Premium 300x 64GB SDR104
>    Lexar by Micron Professional 1000x 32GB UHS-II SDR104
>    SanDisk Extreme Pro 16GB SDR104
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Here is an alternative approach to Shawn's that uses CMD6 to identify the
> card's signal voltage.
> 
> It has the advantages that it does not depend on knowing about the regulator,
> and it works even when unbinding / re-binding the host controller.
> 

Your approach looks great!

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
>   drivers/mmc/core/core.c | 38 ++++++++++++++++++++++++--------------
>   drivers/mmc/core/core.h |  1 +
>   drivers/mmc/core/sd.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 70 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 24a73f387482..161c1d105d91 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1723,11 +1723,33 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>   
>   }
>   
> +int mmc_host_set_uhs_voltage(struct mmc_host *host)
> +{
> +	u32 clock;
> +
> +	/*
> +	 * During a signal voltage level switch, the clock must be gated
> +	 * for 5 ms according to the SD spec
> +	 */
> +	clock = host->ios.clock;
> +	host->ios.clock = 0;
> +	mmc_set_ios(host);
> +
> +	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
> +		return -EAGAIN;
> +
> +	/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
> +	mmc_delay(10);
> +	host->ios.clock = clock;
> +	mmc_set_ios(host);
> +
> +	return 0;
> +}
> +
>   int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
>   {
>   	struct mmc_command cmd = {};
>   	int err = 0;
> -	u32 clock;
>   
>   	/*
>   	 * If we cannot switch voltages, return failure so the caller
> @@ -1759,15 +1781,8 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
>   		err = -EAGAIN;
>   		goto power_cycle;
>   	}
> -	/*
> -	 * During a signal voltage level switch, the clock must be gated
> -	 * for 5 ms according to the SD spec
> -	 */
> -	clock = host->ios.clock;
> -	host->ios.clock = 0;
> -	mmc_set_ios(host);
>   
> -	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180)) {
> +	if (mmc_host_set_uhs_voltage(host)) {
>   		/*
>   		 * Voltages may not have been switched, but we've already
>   		 * sent CMD11, so a power cycle is required anyway
> @@ -1776,11 +1791,6 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
>   		goto power_cycle;
>   	}
>   
> -	/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
> -	mmc_delay(10);
> -	host->ios.clock = clock;
> -	mmc_set_ios(host);
> -
>   	/* Wait for at least 1 ms according to spec */
>   	mmc_delay(1);
>   
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 03e0f8384b1c..2b2690d0d877 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -51,6 +51,7 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
>   void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
>   u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>   int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr);
> +int mmc_host_set_uhs_voltage(struct mmc_host *host);
>   int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
>   void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>   void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 4fd1620b732d..35e1f52cb3f9 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -908,6 +908,18 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
>   	return max_dtr;
>   }
>   
> +static bool mmc_sd_card_using_v18(struct mmc_card *card)
> +{
> +	/*
> +	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
> +	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
> +	 * they can be used to determine if the card has already switched to
> +	 * 1.8V signaling.
> +	 */
> +	return card->sw_caps.sd3_bus_mode &
> +	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
> +}
> +
>   /*
>    * Handle the detection and initialisation of a card.
>    *
> @@ -921,9 +933,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>   	int err;
>   	u32 cid[4];
>   	u32 rocr = 0;
> +	bool v18_fixup_failed = false;
>   
>   	WARN_ON(!host->claimed);
> -
> +retry:
>   	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
>   	if (err)
>   		return err;
> @@ -989,6 +1002,36 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>   	if (err)
>   		goto free_card;
>   
> +	/*
> +	 * If the card has not been power cycled, it may still be using 1.8V
> +	 * signaling. Detect that situation and try to initialize a UHS-I (1.8V)
> +	 * transfer mode.
> +	 */
> +	if (!v18_fixup_failed && !mmc_host_is_spi(host) && mmc_host_uhs(host) &&
> +	    mmc_sd_card_using_v18(card) &&
> +	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
> +		/*
> +		 * Re-read switch information in case it has changed since
> +		 * oldcard was initialized.
> +		 */
> +		if (oldcard) {
> +			err = mmc_read_switch(card);
> +			if (err)
> +				goto free_card;
> +		}
> +		if (mmc_sd_card_using_v18(card)) {
> +			if (mmc_host_set_uhs_voltage(host) ||
> +			    mmc_sd_init_uhs_card(card)) {
> +				v18_fixup_failed = true;
> +				mmc_power_cycle(host, ocr);
> +				if (!oldcard)
> +					mmc_remove_card(card);
> +				goto retry;
> +			}
> +			goto done;
> +		}
> +	}
> +
>   	/* Initialization sequence for UHS-I cards */
>   	if (rocr & SD_ROCR_S18A) {
>   		err = mmc_sd_init_uhs_card(card);
> @@ -1021,7 +1064,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>   			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
>   		}
>   	}
> -
> +done:
>   	host->card = card;
>   	return 0;
>   
> 

