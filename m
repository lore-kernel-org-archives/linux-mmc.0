From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] OMAP HSMMC: fix a racing case between kmmcd and 	omap_hsmmc_suspend
Date: Mon, 21 Jun 2010 15:27:55 +0300
Message-ID: <4C1F5ACB.8090407@nokia.com>
References: <AANLkTilPeWe7ygUv0npuAhn-MnJhoPdnAu9C7S85OQUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57876 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab0FUM2f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2010 08:28:35 -0400
In-Reply-To: <AANLkTilPeWe7ygUv0npuAhn-MnJhoPdnAu9C7S85OQUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ethan Du <ethan.too@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>

Ethan Du wrote:
> If suspend called when kmmcd is doing host->ops->disable,
> as kmmcd already increased host->en_dis_recurs to 1, the mmc_host_enable
> in suspend function will return directly without increase the nesting_cnt,
> which will cause the followed register access carried out to the disabled host.
> 
> mmc_suspend_host will enable host itself. No need to enable host before it.
> Also works on kmmcd will get flushed in mmc_suspend_host, enable host after
> it will be safe. So make the mmc_host_enable after it.
> 
> Signed-off-by: Ethan <ethan.too@gmail.com>

Looks good to me

Acked-by: Adrian Hunter <adrian.hunter@nokia.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b032828..fc74263 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2291,8 +2291,8 @@ static int omap_hsmmc_suspend(struct device *dev)
>                         }
>                 }
>                 cancel_work_sync(&host->mmc_carddetect_work);
> -               mmc_host_enable(host->mmc);
>                 ret = mmc_suspend_host(host->mmc);
> +               mmc_host_enable(host->mmc);
>                 if (ret == 0) {
>                         omap_hsmmc_disable_irq(host);
>                         OMAP_HSMMC_WRITE(host->base, HCTL,
> --
> 1.5.6.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

