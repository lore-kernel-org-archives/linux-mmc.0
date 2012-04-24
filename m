From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH 2/2] mmc: core: fix the signaling 1.8V for HS200
Date: Tue, 24 Apr 2012 13:42:33 +0530
Message-ID: <4F966071.8080309@codeaurora.org>
References: <003001cd2131$07773760$1665a620$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3600 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab2DXIMy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 04:12:54 -0400
In-Reply-To: <003001cd2131$07773760$1665a620$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Hi Seungwon,

On 4/23/2012 2:41 PM, Seungwon Jeon wrote:
> Currently only 1.2V is treated for HS200 mode. If the host has
> only 1.8V I/O capability not 1.2V, mmc_set_signal_voltage can't
> be called for 1.8V HS200. EXT_CSD_CARD_TYPE_SDR_1_8V needs to be
> considered.
Commit text looks confusing to me. In this change, you are trying to set 
the 1.8V I/O voltage only if there is an error setting the 1.2v I/O? Can 
you please clarify more?
>
> Signed-off-by: Seungwon Jeon<tgih.jun@samsung.com>
> ---
>   drivers/mmc/core/mmc.c |   12 +++++++-----
>   1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ebb9522..71eb320 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -732,7 +732,7 @@ static int mmc_select_powerclass(struct mmc_card *card,
>    */
>   static int mmc_select_hs200(struct mmc_card *card)
>   {
> -	int idx, err = 0;
> +	int idx, err = -EINVAL;
>   	struct mmc_host *host;
>   	static unsigned ext_csd_bits[] = {
>   		EXT_CSD_BUS_WIDTH_4,
> @@ -748,10 +748,12 @@ static int mmc_select_hs200(struct mmc_card *card)
>   	host = card->host;
>
>   	if (card->ext_csd.card_type&  EXT_CSD_CARD_TYPE_SDR_1_2V&&
> -	    host->caps2&  MMC_CAP2_HS200_1_2V_SDR)
> -		if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0))
> -			err = mmc_set_signal_voltage(host,
> -						     MMC_SIGNAL_VOLTAGE_180, 0);
> +			host->caps2&  MMC_CAP2_HS200_1_2V_SDR)
> +		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0);
> +
> +	if (err&&  card->ext_csd.card_type&  EXT_CSD_CARD_TYPE_SDR_1_8V&&
> +			host->caps2&  MMC_CAP2_HS200_1_8V_SDR)
> +		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 0);
>
>   	/* If fails try again during next card power cycle */
>   	if (err)

