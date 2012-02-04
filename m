From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix Low speed mmc card detection failure
Date: Sat, 04 Feb 2012 17:33:54 -0500
Message-ID: <m2r4ya9qjx.fsf@bob.laptop.org>
References: <1326943579-30952-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43914 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2BDWeC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 17:34:02 -0500
In-Reply-To: <1326943579-30952-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Thu, 19 Jan 2012 08:56:19 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi,

On Wed, Jan 18 2012, Girish K S wrote:
> This patch fixes the failure of low speed mmc card detection
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/core/mmc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index dc03291..2bc586b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1020,7 +1020,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  			err = mmc_select_hs200(card);
>  		else if	(host->caps & MMC_CAP_MMC_HIGHSPEED)
>  			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -					 EXT_CSD_HS_TIMING, 1, 0);
> +					 EXT_CSD_HS_TIMING, 1,
> +					 card->ext_csd.generic_cmd6_time);
>  
>  		if (err && err != -EBADMSG)
>  			goto free_card;
> @@ -1130,7 +1131,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	 * Activate wide bus and DDR (if supported).
>  	 */
>  	if (!mmc_card_hs200(card) &&
> -	    (card->csd.mmca_vsn >= CSD_SPEC_VER_3) &&
> +	    (card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
>  	    (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
>  		static unsigned ext_csd_bits[][2] = {
>  			{ EXT_CSD_BUS_WIDTH_8, EXT_CSD_DDR_BUS_WIDTH_8 },

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
