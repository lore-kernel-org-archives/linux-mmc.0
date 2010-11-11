From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix rmmod race for card-detection polling hosts
Date: Thu, 11 Nov 2010 23:45:01 +0000
Message-ID: <20101111234501.GA18472@void.printf.net>
References: <Pine.LNX.4.64.1011111730170.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46142 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab0KKXpD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 18:45:03 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011111730170.15747@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi,

On Thu, Nov 11, 2010 at 05:32:25PM +0100, Guennadi Liakhovetski wrote:
> MMC hosts, using polling for card detection by defining the MMC_CAP_NEEDS_POLL
> flag, have a race on rmmod, where the delayed work is cancelled without
> waiting for completed polling. To prevent this a _sync version of the work
> cancellation has to be used.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Chris, if this bug is old enough, this should also go to stable 
> eventually.
> 
>  drivers/mmc/core/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8f86d70..31ae07a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1559,7 +1559,7 @@ void mmc_stop_host(struct mmc_host *host)
>  
>  	if (host->caps & MMC_CAP_DISABLE)
>  		cancel_delayed_work(&host->disable);
> -	cancel_delayed_work(&host->detect);
> +	cancel_delayed_work_sync(&host->detect);
>  	mmc_flush_scheduled_work();
>  
>  	/* clear pm flags now and let card drivers set them as needed */

Thanks very much, pushed to for-linus/mmc-next with a Cc: to stable@,
and queued for .37.  The bug is old -- the cancel_delayed_work() call
was introduced in .31, and before that we weren't cancelling it at all.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
