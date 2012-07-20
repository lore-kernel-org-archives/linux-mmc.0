From: merez@codeaurora.org
Subject: Re: [RESEND PATCH v10] mmc: support BKOPS feature for eMMC
Date: Fri, 20 Jul 2012 04:58:23 -0700 (PDT)
Message-ID: <0af2721026286ee4d196ead20848664e.squirrel@www.codeaurora.org>
References: <500823C5.4010503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:19772 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab2GTL6X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jul 2012 07:58:23 -0400
In-Reply-To: <500823C5.4010503@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>


On Thu, July 19, 2012 8:12 am, Jaehoon Chung wrote:
> +void mmc_start_bkops(struct mmc_card *card, bool from_exception)
> +{
> +        int err;
> +        int timeout;
> +        bool use_busy_signal;
> +
> +        BUG_ON(!card);
> +
> +        if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card) ||
> +                !(card->host->caps2 & MMC_CAP2_BKOPS))
> +                return;
To my opinion, the host cannot decide not to support BKOPs if it is
enabled by the card. In such a case, the card will expect the host to
start the BKOPs and may get into performance degradation.
I think the MMC_CAP2_BKOPS should be removed.
Does everyone agree or do I miss something?

> @@ -489,6 +568,53 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct
> mmc_command *cmd, int retries
>  EXPORT_SYMBOL(mmc_wait_for_cmd);
>
>  /**
> + *	mmc_stop_bkops - stop ongoing BKOPS
> + *	@card: MMC card to check BKOPS
> + *
> + *	Send HPI command to stop ongoing background operations,
> + *	to allow rapid servicing of foreground operations,e.g. read/
> + *	writes. Wait until the card comes out of the programming state
> + *	to avoid errors in servicing read/write requests.
> + */
> +int mmc_stop_bkops(struct mmc_card *card)
> +{
> +	int err = 0;
> +
> +	BUG_ON(!card);
> +	err = mmc_interrupt_hpi(card);
> +
> +	/*
> +	 * if err is EINVAL, it's status that can't issue HPI.
> +	 * it should complete the BKOPS.
> +	 */
> +	if (!err || (err == -EINVAL)) {
> +		mmc_card_clr_doing_bkops(card);
> +		err = 0;
> +	}
I don't understand the comment regarding the case where err equals
-EINVAL. Can you please explain it?

> @@ -392,13 +393,25 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>                    (index << 16) |
>                    (value << 8) |
>                    set;
> -        cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +        cmd.flags = MMC_CMD_AC;
> +        if (use_busy_signal)
> +                cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> +        else
> +                cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
> +
> +
>          cmd.cmd_timeout_ms = timeout_ms;
>
>          err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>          if (err)
>                  return err;
>
> +        /*
> +         * No need to check card status in case of BKOPS LEVEL1 switch
> +         */

Change the comment to be general (don't mention BKOPs level 1), something
like:
No need to check card status in case of unblocking command.
Also, 1 line comment should be /* comment */

Thanks,
Maya

-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

