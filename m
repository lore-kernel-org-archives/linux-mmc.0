From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 7/9] mmc: core: Allow CMD13 polling when switch to HS200
 mode
Date: Fri, 18 Nov 2016 16:05:16 +0800
Message-ID: <847df7a0-6a00-a3ac-01f5-bdd1bffcc185@rock-chips.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:47662 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbcKRIFd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 03:05:33 -0500
In-Reply-To: <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>

Hi Ulf,

ÔÚ 2016/11/16 18:51, Ulf Hansson Ð´µÀ:
> In cases when the mmc host doesn't support HW busy detection, polling for
> busy by using CMD13 is beneficial. The reasons have already been explained
> in earlier change logs.
>
> To allow polling with CMD13, let's provide MMC_TIMING_MMC_HS200 as the
> timing parameter to __mmc_switch(), which makes sure the mmc host and the
> mmc card operates at the same bus timing during the polling.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3268fcd..0b26383 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1351,7 +1351,7 @@ static void mmc_select_driver_type(struct mmc_card *card)
>  static int mmc_select_hs200(struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
> -	unsigned int old_timing, old_signal_voltage;
> +	unsigned int old_signal_voltage;
>  	int err = -EINVAL;
>  	u8 val;
>
> @@ -1378,22 +1378,11 @@ static int mmc_select_hs200(struct mmc_card *card)
>  		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				   EXT_CSD_HS_TIMING, val,
> -				   card->ext_csd.generic_cmd6_time, 0,
> -				   true, false, true);
> -		if (err)
> -			goto err;
> -		old_timing = host->ios.timing;
> -		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> -
> -		err = mmc_switch_status(card);
> -		/*
> -		 * mmc_select_timing() assumes timing has not changed if
> -		 * it is a switch error.
> -		 */
> -		if (err == -EBADMSG)
> -			mmc_set_timing(host, old_timing);
> +				   card->ext_csd.generic_cmd6_time,
> +				   MMC_TIMING_MMC_HS200,
> +				   true, true, true);

I was finding a failure from the test last night after applying these 
patches and using HS200 only.

It seems like the controller(sdhci-of-arasan,5.1) continuously generate
response timeout for checking CMD13.. Per TRM, response timeout could
means the device didn't ack the CMD13 or the controller was failing to
latch the response..

The eMMC part number is KLMBG2JENB-B041. I will use two boards to check
if it was indeed related to these patches.

>  	}
> -err:
> +
>  	if (err) {
>  		/* fall back to the old signal voltage, if fails report error */
>  		if (__mmc_set_signal_voltage(host, old_signal_voltage))
>


-- 
Best Regards
Shawn Lin

