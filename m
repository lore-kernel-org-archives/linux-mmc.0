From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Don't disable vmmc if keeping power in suspend
Date: Mon, 12 Aug 2013 19:33:38 +0900
Message-ID: <000001ce9747$680a9800$381fc800$%jun@samsung.com>
References: <1375846138-15839-1-git-send-email-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53662 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab3HLKdk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 06:33:40 -0400
In-reply-to: <1375846138-15839-1-git-send-email-dbasehore@chromium.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Derek Basehore' <dbasehore@chromium.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Wed, August 07, 2013, Derek Basehore
> If we keep power for suspend on a host for dw_mmc, don't disable vmmc-supply
> regulator when suspending the host.

I have a trivial comment.
It would be better to add some macro for checking MMC_PM_KEEP_POWER.
And I just wonder how the problem is silent. Origin code has stood up somewhat long.
Did you see?

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ee5f167..bf82d7c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2474,7 +2474,7 @@ int dw_mci_suspend(struct dw_mci *host)
>  		}
>  	}
> 
> -	if (host->vmmc)
> +	if (host->vmmc && !(host->pdata->pm_caps & MMC_PM_KEEP_POWER))
>  		regulator_disable(host->vmmc);
> 
>  	return 0;
> @@ -2485,7 +2485,7 @@ int dw_mci_resume(struct dw_mci *host)
>  {
>  	int i, ret;
> 
> -	if (host->vmmc) {
> +	if (host->vmmc && !(host->pdata->pm_caps & MMC_PM_KEEP_POWER)) {
>  		ret = regulator_enable(host->vmmc);
>  		if (ret) {
>  			dev_err(host->dev,
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

