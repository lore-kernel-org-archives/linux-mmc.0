From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Tue, 02 Jul 2013 19:58:17 +0900
Message-ID: <51D2B249.4000901@samsung.com>
References: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52435 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3GBK6P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 06:58:15 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MPB004B42GOTQO0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 02 Jul 2013 19:58:13 +0900 (KST)
In-reply-to: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@wwwdotorg.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 07/02/2013 07:53 PM, Ulf Hansson wrote:
> Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
> Oops in the shutdown sequence for SDIO.
> 
> The drv pointer, does not exist for SDIO since the probing of the SDIO
> card from the mmc_bus perspective is expected to fail by returning
> -ENODEV.
> 
> This patch adds the proper check for the pointer before calling it.
> 
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Reported-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/bus.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 4c0decf..d4b99bb 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -129,7 +129,8 @@ static void mmc_bus_shutdown(struct device *dev)
>  	struct mmc_host *host = card->host;
>  	int ret;
>  
> -	drv->shutdown(card);
> +	if (dev->driver && drv->shutdown)
> +		drv->shutdown(card);
>  
>  	if (host->bus_ops->shutdown) {
>  		ret = host->bus_ops->shutdown(host);
> 

