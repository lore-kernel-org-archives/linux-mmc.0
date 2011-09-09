From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: Re: [PATCH v2] mmc: core: eMMC in Sleep mode before suspend
Date: Thu, 8 Sep 2011 23:34:11 -0700 (PDT)
Message-ID: <894c55383fbf1d731bb52d5279b08f80.squirrel@www.codeaurora.org>
References: <1315499919-804-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:26759 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab1IIGeM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 02:34:12 -0400
In-Reply-To: <1315499919-804-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, subhashj@codeaurora.org, adrian.hunter@intel.com, Balaji T K <balajitk@ti.com>

Hi Balaji,

> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
> in the mmc suspend so that Vcc (NAND core) can be cut
> to minimize power consumption.
> eMMC put into SLEEP can respond to CMD0 or H/W reset or CMD5.
> Current implemention on resume from suspend relies on CMD0 in
> mmc_init_card to get out of SLEEP mode.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Acked-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/core/mmc.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5700b1c..f73fcee 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -553,6 +553,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>  	 * need to tell some cards to go back to the idle
>  	 * state.  We wait 1ms to give cards time to
>  	 * respond.
> +	 * mmc_go_idle is needed for eMMC that are asleep
>  	 */
>  	mmc_go_idle(host);
>
> @@ -900,16 +901,20 @@ static void mmc_detect(struct mmc_host *host)
>   */
>  static int mmc_suspend(struct mmc_host *host)
>  {
> +	int err = 0;
> +
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
>
>  	mmc_claim_host(host);
> -	if (!mmc_host_is_spi(host))
> +	if (mmc_card_can_sleep(host))
> +		err = mmc_card_sleep(host);
> +	else if (!mmc_host_is_spi(host))
>  		mmc_deselect_cards(host);
>  	host->card->state &= ~MMC_STATE_HIGHSPEED;
>  	mmc_release_host(host);
>
> -	return 0;
> +	return err;
>  }

Looks good to me:
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

Thanks,
Subhash

>
>  /*
> --
> 1.7.0.4
>
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

