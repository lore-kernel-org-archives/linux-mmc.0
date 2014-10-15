From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Change signal voltage error to dev_dbg()
Date: Wed, 15 Oct 2014 10:40:09 +0900
Message-ID: <543DD079.4090306@samsung.com>
References: <1413000976-2038-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:64452 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbaJOBkW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 21:40:22 -0400
In-reply-to: <1413000976-2038-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Addy Ke <addy.ke@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 10/11/2014 01:16 PM, Doug Anderson wrote:
> In (28f92b5 mmc: core: Try other signal levels during power up) we can
> see that there are times when it's valid to try several signal
> voltages.  Don't print an ugly error in the logs when that happens.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 69f0cc6..c4afbdd 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1075,7 +1075,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>  		ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
>  
>  		if (ret) {
> -			dev_err(&mmc->class_dev,
> +			dev_dbg(&mmc->class_dev,
>  					 "Regulator set error %d: %d - %d\n",
>  					 ret, min_uv, max_uv);
>  			return ret;
> 

