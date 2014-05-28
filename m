From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Remove redundant runtime_idle callback
Date: Wed, 28 May 2014 20:56:55 +0900
Message-ID: <5385CF07.8020304@samsung.com>
References: <1401270245-20163-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57296 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbaE1L45 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 07:56:57 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6A004GP96V4OB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 May 2014 20:56:55 +0900 (KST)
In-reply-to: <1401270245-20163-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 05/28/2014 06:44 PM, Ulf Hansson wrote:
> The runtime PM core handles a runtime_idle callback set to NULL as one
> returning 0. So, let's just set it to NULL instead.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/bus.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index d2dbf02..8a1f124 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -180,7 +180,6 @@ static int mmc_bus_resume(struct device *dev)
>  #endif
>  
>  #ifdef CONFIG_PM_RUNTIME
> -
>  static int mmc_runtime_suspend(struct device *dev)
>  {
>  	struct mmc_card *card = mmc_dev_to_card(dev);
> @@ -196,17 +195,10 @@ static int mmc_runtime_resume(struct device *dev)
>  
>  	return host->bus_ops->runtime_resume(host);
>  }
> -
> -static int mmc_runtime_idle(struct device *dev)
> -{
> -	return 0;
> -}
> -
>  #endif /* !CONFIG_PM_RUNTIME */
>  
>  static const struct dev_pm_ops mmc_bus_pm_ops = {
> -	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume,
> -			mmc_runtime_idle)
> +	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume, NULL)
>  	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
>  };
>  
> 

