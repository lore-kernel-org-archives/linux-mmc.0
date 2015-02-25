From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make sure we only adjust the clock when
 power is on
Date: Wed, 25 Feb 2015 19:34:48 +0900
Message-ID: <54EDA548.40304@samsung.com>
References: <1424458639-23330-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50293 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbbBYKeu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 05:34:50 -0500
In-reply-to: <1424458639-23330-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Doug.

It makes sense. Looks good to me. Thanks!

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 02/21/2015 03:57 AM, Doug Anderson wrote:
> It appears that we can confuse things if we try to turn on the MMC
> clock when the power is off.  Adjust is so that we turn the clock on
> (using dw_mci_setup_bus) after power is all the way on and we turn the
> clock off before the power goes off.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4d2e3c2..43fcae1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1101,12 +1101,6 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (drv_data && drv_data->set_ios)
>  		drv_data->set_ios(slot->host, ios);
>  
> -	/* Slot specific timing and width adjustment */
> -	dw_mci_setup_bus(slot, false);
> -
> -	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
> -		slot->host->state = STATE_IDLE;
> -
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		if (!IS_ERR(mmc->supply.vmmc)) {
> @@ -1133,8 +1127,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			else
>  				slot->host->vqmmc_enabled = true;
>  		}
> +
> +		/* Adjust clock / bus width after power is up */
> +		dw_mci_setup_bus(slot, false);
> +
>  		break;
>  	case MMC_POWER_OFF:
> +		/* Turn clock off before power goes down */
> +		dw_mci_setup_bus(slot, false);
> +
>  		if (!IS_ERR(mmc->supply.vmmc))
>  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>  
> @@ -1150,6 +1151,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	default:
>  		break;
>  	}
> +
> +	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
> +		slot->host->state = STATE_IDLE;
>  }
>  
>  static int dw_mci_card_busy(struct mmc_host *mmc)
> 

