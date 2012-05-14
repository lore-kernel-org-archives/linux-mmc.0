From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH v3 2/2] mmc4.5: host: poweroff notify rework
Date: Mon, 14 May 2012 09:20:37 +0200
Message-ID: <4FB0B245.7000206@stericsson.com>
References: <1336398084-23203-1-git-send-email-girish.shivananjappa@linaro.org> <1336398084-23203-2-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:59965 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569Ab2ENHUs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 03:20:48 -0400
In-Reply-To: <1336398084-23203-2-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "saugata.das@linaro.org" <saugata.das@linaro.org>

Hi Girish,

In patch 1/2 you break the compilation of these host drivers. In this 
patch 2/2 you fix it again. I would prefer you include these fixes in 
the same patch instead of splitting them into two pieces.

Kind regards
Ulf Hansson

On 05/07/2012 03:41 PM, Girish K S wrote:
> This patch changes the structure member name to maintain consistency
> of name for the poweroff notify feature
>
> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
> ---
>   drivers/mmc/host/dw_mmc.c |    4 ++--
>   drivers/mmc/host/sdhci.c  |    4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ab3fc46..09ac734 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1791,9 +1791,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>   		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>
>   	if (mmc->caps2&  MMC_CAP2_POWEROFF_NOTIFY)
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
> +		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_SHORT;
>   	else
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
> +		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_NONE;
>
>   	if (host->pdata->blk_settings) {
>   		mmc->max_segs = host->pdata->blk_settings->max_segs;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e626732..958e5fe 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2817,9 +2817,9 @@ int sdhci_add_host(struct sdhci_host *host)
>   	 * set notify to short power off notify timeout value.
>   	 */
>   	if (mmc->caps2&  MMC_CAP2_POWEROFF_NOTIFY)
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
> +		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_SHORT;
>   	else
> -		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
> +		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_NONE;
>
>   	/* Initial value for re-tuning timer count */
>   	host->tuning_count = (caps[1]&  SDHCI_RETUNING_TIMER_COUNT_MASK)>>

