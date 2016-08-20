From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/2] mmc: core: fall back host->f_init if failing to
 init mmc card after resume
Date: Sat, 20 Aug 2016 11:02:00 +0800
Message-ID: <6a9e58af-d4fd-3426-220b-fc5022cf366d@rock-chips.com>
References: <1468979860-28712-1-git-send-email-shawn.lin@rock-chips.com>
 <1468979860-28712-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:41025 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcHTDCJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2016 23:02:09 -0400
In-Reply-To: <1468979860-28712-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Ulf,

Any idea to share with this patch? :)

On 2016/7/20 9:57, Shawn Lin wrote:
> We observed the failure of initializing card after resume
> accidentally. It's hard to reproduce but we did get report from
> the suspend/resume test of our RK3399 mp test farm . Unfortunately,
> we still fail to figure out what was going wrong at that time.
> Also we can't achieve it by retrying the host->f_init without falling
> back it. But this patch will solve the problem as we could add some log
> there and see that we resume the mmc card successfully after falling
> back the host->f_init. There is no obvious side effect found, so it seems
> this patch will improve the stability.
>
> [   93.405085] mmc1: unexpected status 0x800900 after switch
> [   93.408474] mmc1: switch to bus width 1 failed
> [   93.408482] mmc1: mmc_select_hs200 failed, error -110
> [   93.408492] mmc1: error -110 during resume (card was removed?)
> [   93.408705] PM: resume of devices complete after 213.453 msecs
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v2:
> - remove mmc_power_off
> - take f_min into consideration
>
>  drivers/mmc/core/mmc.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 403b97b..a2891c1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1945,6 +1945,7 @@ static int mmc_suspend(struct mmc_host *host)
>  static int _mmc_resume(struct mmc_host *host)
>  {
>  	int err = 0;
> +	int i;
>
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
> @@ -1954,8 +1955,22 @@ static int _mmc_resume(struct mmc_host *host)
>  	if (!mmc_card_suspended(host->card))
>  		goto out;
>
> -	mmc_power_up(host, host->card->ocr);
> -	err = mmc_init_card(host, host->card->ocr, host->card);
> +	/*
> +	 * Let's try to fallback the host->f_init
> +	 * if failing to init mmc card after resume.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> +		if (host->f_init < max(freqs[i], host->f_min))
> +			continue;
> +		else
> +			host->f_init = max(freqs[i], host->f_min);
> +
> +		mmc_power_up(host, host->card->ocr);
> +		err = mmc_init_card(host, host->card->ocr, host->card);
> +		if (!err)
> +			break;
> +	}
> +
>  	mmc_card_clr_suspended(host->card);
>
>  out:
>


-- 
Best Regards
Shawn Lin

