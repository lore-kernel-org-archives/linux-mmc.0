From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 9/9] mmc: core: Allow CMD13 polling when switch to HS400ES
 mode
Date: Fri, 18 Nov 2016 15:35:08 +0200
Message-ID: <851c300f-ba5e-1944-64fd-51a32f88cb89@intel.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64842 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbcKRNkI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Nov 2016 08:40:08 -0500
In-Reply-To: <1479293481-20186-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 16/11/16 12:51, Ulf Hansson wrote:
> In cases when the mmc host doesn't support HW busy detection, polling for
> busy by using CMD13 is beneficial. The reasons have already been explained
> in earlier change logs.
> 
> Moreover, when polling with CMD13 during bus timing changes, we should
> retry instead of fail when we get CRC errors.
> 
> Switching to HS400ES includes several steps, where each step changes the
> bus speed timing. Let's improve the behaviour during these sequences, by
> allowing CMD13 polling for each of the step. Let's also make sure the CMD13
> polling becomes retried, while receiving a CRC error.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc.c | 35 +++++++++++------------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 24b9e72..b6f0035 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1227,31 +1227,24 @@ static int mmc_select_hs400es(struct mmc_card *card)
>  		goto out_err;
>  
>  	/* Switch card to HS mode */
> -	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
> -			   card->ext_csd.generic_cmd6_time, 0,
> -			   true, false, true);
> +	err = mmc_select_hs(card);
>  	if (err) {
>  		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
>  			mmc_hostname(host), err);
>  		goto out_err;
>  	}
>  
> -	mmc_set_timing(host, MMC_TIMING_MMC_HS);
> -	err = mmc_switch_status(card);
> -	if (err)
> -		goto out_err;
> -
>  	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
>  
> -	/* Switch card to DDR with strobe bit */
> +	/* Switch card to HS DDR with strobe bit */
>  	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
> -	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -			 EXT_CSD_BUS_WIDTH,
> -			 val,
> -			 card->ext_csd.generic_cmd6_time);
> +	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			   EXT_CSD_BUS_WIDTH, val,
> +			   card->ext_csd.generic_cmd6_time,
> +			   MMC_TIMING_MMC_DDR52,
> +			   true, true, true);
>  	if (err) {
> -		pr_err("%s: switch to bus width for hs400es failed, err:%d\n",
> +		pr_err("%s: switch to hs ddr for hs400es failed, err:%d\n",
>  			mmc_hostname(host), err);
>  		goto out_err;
>  	}
> @@ -1261,26 +1254,20 @@ static int mmc_select_hs400es(struct mmc_card *card)
>  	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			   EXT_CSD_HS_TIMING, val,
> -			   card->ext_csd.generic_cmd6_time, 0,
> -			   true, false, true);
> +			   card->ext_csd.generic_cmd6_time,
> +			   MMC_TIMING_MMC_HS400,
> +			   true, true, true);

This could be a problem because the CMD13 is being sent to a card in HS400
enhanced strobe mode but we haven't enabled enhanced strobe on the host
controller yet.  Previously mmc_switch_status(card) was below
host->ops->hs400_enhanced_strobe().

>  	if (err) {
>  		pr_err("%s: switch to hs400es failed, err:%d\n",
>  			mmc_hostname(host), err);
>  		goto out_err;
>  	}
>  
> -	/* Set host controller to HS400 timing and frequency */
> -	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
> -
>  	/* Controller enable enhanced strobe function */
>  	host->ios.enhanced_strobe = true;
>  	if (host->ops->hs400_enhanced_strobe)
>  		host->ops->hs400_enhanced_strobe(host, &host->ios);
>  
> -	err = mmc_switch_status(card);
> -	if (err)
> -		goto out_err;
> -
>  	return 0;
>  
>  out_err:
> 

