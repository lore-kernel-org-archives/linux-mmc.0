From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix regression: set default clock gating delay to 0
Date: Fri, 02 Mar 2012 15:55:08 -0500
Message-ID: <m2ipimn2oj.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1202231119030.25586@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48605 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab2CBUzW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Mar 2012 15:55:22 -0500
In-Reply-To: <Pine.LNX.4.64.1202231119030.25586@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 23 Feb 2012 11:22:29 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Sujit Reddy Thumma <sthumma@codeaurora.org>

Hi,

On Thu, Feb 23 2012, Guennadi Liakhovetski wrote:
> A recent commit "mmc: core: Use delayed work in clock gating framework"
> introduced a default 200ms delay before clock gating actually takes place.
> This means, that every time an MMC interface becomes idle it first stays
> on for 200ms before gating its clock. This leads to increased power
> consumption and is therefore a clear regression. This patch restores the
> original behaviour by setting the default delay to 0. Users,
> prioritising throughput over power efficiency can still modify the delay
> via sysfs.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> As discussed in this thread
>
> http://thread.gmane.org/gmane.linux.kernel.mmc/12307
>
> this is one of the ways to fix the regression. Please, push for 3.3.
>
>  drivers/mmc/core/host.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 30055f2..c3704e2 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -238,10 +238,10 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
>  	/* Hold MCI clock for 8 cycles by default */
>  	host->clk_delay = 8;
>  	/*
> -	 * Default clock gating delay is 200ms.
> +	 * Default clock gating delay is 0ms to avoid wasting power.
>  	 * This value can be tuned by writing into sysfs entry.
>  	 */
> -	host->clkgate_delay = 200;
> +	host->clkgate_delay = 0;
>  	host->clk_gated = false;
>  	INIT_DELAYED_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
>  	spin_lock_init(&host->clk_lock);

Thanks, will push this to 3.3 this week.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
