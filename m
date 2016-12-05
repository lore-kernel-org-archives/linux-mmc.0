From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V2 1/1] mmc: mmc: Relax checking for switch errors after
 HS200 switch
Date: Mon, 5 Dec 2016 11:28:54 +0800
Message-ID: <d9186009-adfc-690b-c51a-5460ce65cf83@rock-chips.com>
References: <1480677395-14169-1-git-send-email-adrian.hunter@intel.com>
 <1480677395-14169-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:54672 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcLED3K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2016 22:29:10 -0500
In-Reply-To: <1480677395-14169-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>

On 2016/12/2 19:16, Adrian Hunter wrote:
> The JEDEC specification indicates CMD13 can be used after a HS200 switch
> to check for errors. However in practice some boards experience CRC errors
> in the CMD13 response. Consequently, for HS200, CRC errors are not a
> reliable way to know the switch failed. If there really is a problem, we
> would expect tuning will fail and the result ends up the same. So change
> the error condition to ignore CRC errors in that case.
>

This makes sense to me, especially for arasan,sdhci-5.1. As it actually
needs to update the sd_clk rate to PHY before sending commands when
finishing to switch timing. It leads to a dilemma that we should really
update the sd_clk to PHY *only after* we actually finish switching
timing. But how we need to know we finish switching to e.g HS200? If
not using .card_busy, we have to send CMD13 but as I mentioned we need
to update sd_clk first, otherwise we expected a CRC there in theory.

Which comes first?
updating sd_clk to PHY for it to latch the successful result of CMD13
to know we are in HS200 now but updating sd_clk indicates that we
already know we are in HS200? :)

Although it indeed could work using current code by theoretically it
shouldn't. CMD13 shouldn't be used to indicate the status of bus
switching at all from my point.

This patchs improve it much,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c     | 15 +++++++++++++--
>  drivers/mmc/core/mmc_ops.c |  9 ++++++++-
>  drivers/mmc/core/mmc_ops.h |  1 +
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 033e00abe93f..b61b52f9da3d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1240,7 +1240,12 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
> -	err = mmc_switch_status(card);
> +	/*
> +	 * For HS200, CRC errors are not a reliable way to know the switch
> +	 * failed. If there really is a problem, we would expect tuning will
> +	 * fail and the result ends up the same.
> +	 */
> +	err = __mmc_switch_status(card, false);
>  	if (err)
>  		goto out_err;
>
> @@ -1403,7 +1408,13 @@ static int mmc_select_hs200(struct mmc_card *card)
>  		old_timing = host->ios.timing;
>  		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
> -		err = mmc_switch_status(card);
> +		/*
> +		 * For HS200, CRC errors are not a reliable way to know the
> +		 * switch failed. If there really is a problem, we would expect
> +		 * tuning will fail and the result ends up the same.
> +		 */
> +		err = __mmc_switch_status(card, false);
> +
>  		/*
>  		 * mmc_select_timing() assumes timing has not changed if
>  		 * it is a switch error.
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index cb7006feb5c4..81ce63bb0773 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -431,18 +431,25 @@ static int mmc_switch_status_error(struct mmc_host *host, u32 status)
>  }
>
>  /* Caller must hold re-tuning */
> -int mmc_switch_status(struct mmc_card *card)
> +int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
>  {
>  	u32 status;
>  	int err;
>
>  	err = mmc_send_status(card, &status);
> +	if (!crc_err_fatal && err == -EILSEQ)
> +		return 0;
>  	if (err)
>  		return err;
>
>  	return mmc_switch_status_error(card->host, status);
>  }
>
> +int mmc_switch_status(struct mmc_card *card)
> +{
> +	return __mmc_switch_status(card, true);
> +}
> +
>  static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>  			bool send_status, bool retry_crc_err)
>  {
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 761cb69c46af..abd525ed74be 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -28,6 +28,7 @@
>  int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
>  int mmc_can_ext_csd(struct mmc_card *card);
>  int mmc_switch_status(struct mmc_card *card);
> +int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  		unsigned int timeout_ms, unsigned char timing,
>  		bool use_busy_signal, bool send_status,	bool retry_crc_err);
>


-- 
Best Regards
Shawn Lin

