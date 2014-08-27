From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Pass back errors from mmc_of_parse()
Date: Wed, 27 Aug 2014 13:13:11 +0900
Message-ID: <53FD5AD7.1010402@samsung.com>
References: <1408990744-1093-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17355 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaH0ENO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Aug 2014 00:13:14 -0400
In-reply-to: <1408990744-1093-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, olof@lixom.net, Sonny Rao <sonnyrao@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 08/26/2014 03:19 AM, Doug Anderson wrote:
> It's possible that mmc_of_parse() could return errors (possibly in
> some future version it might return -EPROBE_DEFER even).  Let's pass
> those errors back.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7f227e9..9ef4df0 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2131,7 +2131,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (host->pdata->caps2)
>  		mmc->caps2 = host->pdata->caps2;
>  
> -	mmc_of_parse(mmc);
> +	ret = mmc_of_parse(mmc);
> +	if (ret)
> +		goto err_host_allocated;
>  
>  	if (host->pdata->blk_settings) {
>  		mmc->max_segs = host->pdata->blk_settings->max_segs;
> @@ -2163,7 +2165,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  
>  	ret = mmc_add_host(mmc);
>  	if (ret)
> -		goto err_setup_bus;
> +		goto err_host_allocated;
>  
>  #if defined(CONFIG_DEBUG_FS)
>  	dw_mci_init_debugfs(slot);
> @@ -2174,9 +2176,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  
>  	return 0;
>  
> -err_setup_bus:
> +err_host_allocated:
>  	mmc_free_host(mmc);
> -	return -EINVAL;
> +	return ret;
>  }
>  
>  static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
> 

