From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/4] mmc: core: Remove unnecessary check for the remove
 callback
Date: Fri, 31 May 2013 16:43:52 +0900
Message-ID: <51A854B8.3020605@samsung.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
 <1369918391-15277-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:10409 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3EaHno (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 May 2013 03:43:44 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNN00CSMK4LJNI0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 31 May 2013 16:43:37 +0900 (KST)
In-reply-to: <1369918391-15277-2-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Ulf,

According to your commit message, host->bus_ops is also always existed, isn't?

Best Regards,
Jaehoon Chung

On 05/30/2013 09:53 PM, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> For every bus_ops type the .remove callback always exist, thus there
> are no need to check the existence of it, before we decide to call it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e9a104b..d2ee282 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2483,9 +2483,7 @@ void mmc_stop_host(struct mmc_host *host)
>  	mmc_bus_get(host);
>  	if (host->bus_ops && !host->bus_dead) {
>  		/* Calling bus_ops->remove() with a claimed host can deadlock */
> -		if (host->bus_ops->remove)
> -			host->bus_ops->remove(host);
> -
> +		host->bus_ops->remove(host);
>  		mmc_claim_host(host);
>  		mmc_detach_bus(host);
>  		mmc_power_off(host);
> @@ -2638,8 +2636,7 @@ int mmc_suspend_host(struct mmc_host *host)
>  			 * bus_ops->remove() with a claimed host can
>  			 * deadlock.)
>  			 */
> -			if (host->bus_ops->remove)
> -				host->bus_ops->remove(host);
> +			host->bus_ops->remove(host);
>  			mmc_claim_host(host);
>  			mmc_detach_bus(host);
>  			mmc_power_off(host);
> @@ -2722,9 +2719,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  			break;
>  
>  		/* Calling bus_ops->remove() with a claimed host can deadlock */
> -		if (host->bus_ops->remove)
> -			host->bus_ops->remove(host);
> -
> +		host->bus_ops->remove(host);
>  		mmc_claim_host(host);
>  		mmc_detach_bus(host);
>  		mmc_power_off(host);
> 

