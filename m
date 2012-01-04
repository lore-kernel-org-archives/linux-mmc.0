From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix a deadlock between system suspend and MMC block IO
Date: Wed, 04 Jan 2012 09:37:14 -0500
Message-ID: <m2lipnfs9x.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1201041527480.30506@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49416 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755562Ab2ADOhX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jan 2012 09:37:23 -0500
In-Reply-To: <Pine.LNX.4.64.1201041527480.30506@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 4 Jan 2012 15:28:45 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Jan 04 2012, Guennadi Liakhovetski wrote:
> Performing MMC block IO with simultaneous STR can lead to a deadlock: the
> mmc_pm_notify() function claims the host and then calls bus .remove()
> method, which lands in mmc_blk_remove(), which calls mmc_blk_remove_req()
> then it goes to -> mmc_cleanup_queue() -> kthread_stop(), which waits for
> the mmc-block thread to stop. If the mmc-block thread at that time is
> processing block requests, it will also try to claim the host in
> mmc_blk_issue_rq() and block there. This patch fixes the problem by
> calling .remove() before claiming the host.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mmc/core/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a2aa860..a68f085 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2476,11 +2476,11 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  		if (!host->bus_ops || host->bus_ops->suspend)
>  			break;
>  
> -		mmc_claim_host(host);
> -
> +		/* On 2 occasions above bus_ops->remove() is called unlocked */
>  		if (host->bus_ops->remove)
>  			host->bus_ops->remove(host);
>  
> +		mmc_claim_host(host);
>  		mmc_detach_bus(host);
>  		mmc_power_off(host);
>  		mmc_release_host(host);

Thanks.  The commit message explanation is very good, but the comment is
a bit cryptic.  Shall we make it longer?  I think even just:

/* Calling bus_ops->remove() with a claimed host can deadlock */

would be better.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
