From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Give a good reset after we give power
Date: Wed, 25 Feb 2015 19:35:56 +0900
Message-ID: <54EDA58C.7050605@samsung.com>
References: <1424458639-23330-1-git-send-email-dianders@chromium.org>
 <1424458639-23330-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50436 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbbBYKf6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 05:35:58 -0500
In-reply-to: <1424458639-23330-2-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Dear, Doug.

Looks good to me. Thanks!

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 02/21/2015 03:57 AM, Doug Anderson wrote:
> We should give dw_mmc a good reset after we apply power.  On some
> boards vqmmc may actually be connected to the IP block in the SoC so
> it's good to reset after power comes in.
> 
> Without this we sometimes see failures enumerating cards on rk3288.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 43fcae1..6a712ae 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1119,13 +1119,23 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		mci_writel(slot->host, PWREN, regs);
>  		break;
>  	case MMC_POWER_ON:
> -		if (!IS_ERR(mmc->supply.vqmmc) && !slot->host->vqmmc_enabled) {
> -			ret = regulator_enable(mmc->supply.vqmmc);
> -			if (ret < 0)
> -				dev_err(slot->host->dev,
> -					"failed to enable vqmmc regulator\n");
> -			else
> +		if (!slot->host->vqmmc_enabled) {
> +			if (!IS_ERR(mmc->supply.vqmmc)) {
> +				ret = regulator_enable(mmc->supply.vqmmc);
> +				if (ret < 0)
> +					dev_err(slot->host->dev,
> +						"failed to enable vqmmc\n");
> +				else
> +					slot->host->vqmmc_enabled = true;
> +
> +			} else {
> +				/* Keep track so we don't reset again */
>  				slot->host->vqmmc_enabled = true;
> +			}
> +
> +			/* Reset our state machine after powering on */
> +			dw_mci_ctrl_reset(slot->host,
> +					  SDMMC_CTRL_ALL_RESET_FLAGS);
>  		}
>  
>  		/* Adjust clock / bus width after power is up */
> @@ -1139,10 +1149,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		if (!IS_ERR(mmc->supply.vmmc))
>  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>  
> -		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled) {
> +		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
>  			regulator_disable(mmc->supply.vqmmc);
> -			slot->host->vqmmc_enabled = false;
> -		}
> +		slot->host->vqmmc_enabled = false;
>  
>  		regs = mci_readl(slot->host, PWREN);
>  		regs &= ~(1 << slot->id);
> 

