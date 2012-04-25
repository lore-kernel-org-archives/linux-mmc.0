From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v2 2/2] mmc: core: fix the signaling 1.8V for HS200
Date: Wed, 25 Apr 2012 15:19:50 +0530
Message-ID: <000601cd22c8$c418b6d0$4c4a2470$@codeaurora.org>
References: <004c01cd22b3$8cd76870$a6863950$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:64675 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057Ab2DYJtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 05:49:55 -0400
In-Reply-To: <004c01cd22b3$8cd76870$a6863950$%jun@samsung.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

Regards,
Subhash

> -----Original Message-----
> From: Seungwon Jeon [mailto:tgih.jun@samsung.com]
> Sent: Wednesday, April 25, 2012 12:48 PM
> To: linux-mmc@vger.kernel.org
> Cc: 'Chris Ball'; 'Subhash Jadavani'; 'Girish K S'
> Subject: [PATCH v2 2/2] mmc: core: fix the signaling 1.8V for HS200
> 
> Currently only 1.2V is treated for HS200 mode. If the host has only 1.8V I/O
> capability not 1.2V, mmc_set_signal_voltage can't be called for 1.8V HS200.
> EXT_CSD_CARD_TYPE_SDR_1_8V needs to be considered.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 0477769..2a9b7b1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -728,7 +728,7 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
>   */
>  static int mmc_select_hs200(struct mmc_card *card)  {
> -	int idx, err = 0;
> +	int idx, err = -EINVAL;
>  	struct mmc_host *host;
>  	static unsigned ext_csd_bits[] = {
>  		EXT_CSD_BUS_WIDTH_4,
> @@ -744,10 +744,12 @@ static int mmc_select_hs200(struct mmc_card
> *card)
>  	host = card->host;
> 
>  	if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
> -	    host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
> -		if (mmc_set_signal_voltage(host,
> MMC_SIGNAL_VOLTAGE_120, 0))
> -			err = mmc_set_signal_voltage(host,
> -
> MMC_SIGNAL_VOLTAGE_180, 0);
> +			host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
> +		err = mmc_set_signal_voltage(host,
> MMC_SIGNAL_VOLTAGE_120, 0);
> +
> +	if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V
> &&
> +			host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
> +		err = mmc_set_signal_voltage(host,
> MMC_SIGNAL_VOLTAGE_180, 0);
> 
>  	/* If fails try again during next card power cycle */
>  	if (err)
> --
> 1.7.0.4
> 


