From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 8/9] mmc: core: Allow CMD13 polling when switch to HS400
 mode
Date: Fri, 18 Nov 2016 14:02:21 +0200
Message-ID: <5b69bb3b-ede3-753c-e261-89e51ca0e43d@intel.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752302AbcKRMHV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Nov 2016 07:07:21 -0500
In-Reply-To: <1479293481-20186-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>

On 16/11/16 12:51, Ulf Hansson wrote:
> In cases when the mmc host doesn't support HW busy detection, polling for
> busy by using CMD13 is beneficial. The reasons have already been explained
> in earlier change logs.
> 
> Moreover, when polling with CMD13 during bus timing changes, we should
> retry instead of fail when we get CRC errors.
> 
> Switching from HS200 to HS400 and reverse includes several steps, where
> each step changes the bus speed timing. Let's improve the behaviour during
> these sequences, by allowing CMD13 polling for each of the step. Let's also
> make sure the CMD13 polling becomes retried, while receiving a CRC error.

I don't know we need to try to get polling for HS400.  The support of HS400
suggests a relatively sophisticated host controller which really should
support busy waiting as well.

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc.c | 87 +++++++++++++++-----------------------------------
>  1 file changed, 26 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0b26383..24b9e72 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1094,8 +1094,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>  static int mmc_select_hs400(struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
> -	unsigned int max_dtr;
> -	int err = 0;
> +	int err;
>  	u8 val;
>  
>  	/*
> @@ -1105,34 +1104,26 @@ static int mmc_select_hs400(struct mmc_card *card)
>  	      host->ios.bus_width == MMC_BUS_WIDTH_8))
>  		return 0;
>  
> -	/* Switch card to HS mode */
> -	val = EXT_CSD_TIMING_HS;
> -	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -			   EXT_CSD_HS_TIMING, val,
> -			   card->ext_csd.generic_cmd6_time, 0,
> -			   true, false, true);
> +	/*
> +	 * Switch card to HS mode.
> +	 * First reduce to the HS frequency as CMD13 are sent to poll for busy
> +	 * and/or to validate the switch status.
> +	 */
> +	mmc_set_clock(host, card->ext_csd.hs_max_dtr);

That was moved by commit 649c6059d2371fef886a8f967e21416204723d63
("mmc: mmc: Fix HS switch failure in mmc_select_hs400()") i.e. if you put it
back I would expect the gru board problem to reappear.

> +	err = mmc_select_hs(card);
>  	if (err) {
>  		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
>  			mmc_hostname(host), err);
>  		return err;
>  	}
>  
> -	/* Set host controller to HS timing */
> -	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> -
> -	/* Reduce frequency to HS frequency */
> -	max_dtr = card->ext_csd.hs_max_dtr;
> -	mmc_set_clock(host, max_dtr);
> -
> -	err = mmc_switch_status(card);
> -	if (err)
> -		goto out_err;
> -
> -	/* Switch card to DDR */
> -	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -			 EXT_CSD_BUS_WIDTH,
> -			 EXT_CSD_DDR_BUS_WIDTH_8,
> -			 card->ext_csd.generic_cmd6_time);
> +	/* Switch card to HS DDR */
> +	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			   EXT_CSD_BUS_WIDTH,
> +			   EXT_CSD_DDR_BUS_WIDTH_8,
> +			   card->ext_csd.generic_cmd6_time,
> +			   MMC_TIMING_MMC_DDR52,
> +			   true, true, true);
>  	if (err) {
>  		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
>  			mmc_hostname(host), err);
> @@ -1144,28 +1135,17 @@ static int mmc_select_hs400(struct mmc_card *card)
>  	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			   EXT_CSD_HS_TIMING, val,
> -			   card->ext_csd.generic_cmd6_time, 0,
> -			   true, false, true);
> +			   card->ext_csd.generic_cmd6_time,
> +			   MMC_TIMING_MMC_HS400,
> +			   true, true, true);

This is not exactly right.  Tuning has been done at the HS400 operating
frequency.  That is why we set the bus speed before sending any more
commands. i.e. mmc_switch_status(card) is below mmc_set_bus_speed(card)

>  	if (err) {
>  		pr_err("%s: switch to hs400 failed, err:%d\n",
>  			 mmc_hostname(host), err);
>  		return err;
>  	}
>  
> -	/* Set host controller to HS400 timing and frequency */
> -	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>  	mmc_set_bus_speed(card);
> -
> -	err = mmc_switch_status(card);
> -	if (err)
> -		goto out_err;
> -
>  	return 0;
> -
> -out_err:
> -	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
> -	       __func__, err);
> -	return err;
>  }
>  
>  int mmc_hs200_to_hs400(struct mmc_card *card)
> @@ -1187,27 +1167,17 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>  	/* Switch HS400 to HS DDR */
>  	val = EXT_CSD_TIMING_HS;
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> -			   val, card->ext_csd.generic_cmd6_time, 0,
> -			   true, false, true);
> -	if (err)
> -		goto out_err;
> -
> -	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> -
> -	err = mmc_switch_status(card);
> +			   val, card->ext_csd.generic_cmd6_time,
> +			   MMC_TIMING_MMC_DDR52,
> +			   true, true, true);
>  	if (err)
>  		goto out_err;
>  
>  	/* Switch HS DDR to HS */
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
>  			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
> -			   0, true, false, true);
> -	if (err)
> -		goto out_err;
> -
> -	mmc_set_timing(host, MMC_TIMING_MMC_HS);
> -
> -	err = mmc_switch_status(card);
> +			   MMC_TIMING_MMC_HS,
> +			   true, true, true);
>  	if (err)
>  		goto out_err;
>  
> @@ -1215,14 +1185,9 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>  	val = EXT_CSD_TIMING_HS200 |
>  	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> -			   val, card->ext_csd.generic_cmd6_time, 0,
> -			   true, false, true);
> -	if (err)
> -		goto out_err;
> -
> -	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> -
> -	err = mmc_switch_status(card);
> +			   val, card->ext_csd.generic_cmd6_time,
> +			   MMC_TIMING_MMC_HS200,
> +			   true, true, true);
>  	if (err)
>  		goto out_err;
>  
> 

