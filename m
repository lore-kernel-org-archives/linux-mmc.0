From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: remove waiting time when clkgate_delay is set
Date: Fri, 02 Mar 2012 16:12:19 -0500
Message-ID: <m2aa3yn1vw.fsf@bob.laptop.org>
References: <1330494769-7558-1-git-send-email-chanho61.park@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44892 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758267Ab2CBVM0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Mar 2012 16:12:26 -0500
In-Reply-To: <1330494769-7558-1-git-send-email-chanho61.park@samsung.com>
	(Chanho Park's message of "Wed, 29 Feb 2012 14:52:49 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chanho Park <chanho61.park@samsung.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi,

On Wed, Feb 29 2012, Chanho Park wrote:
> Since recent commit("mmc: core: Use delayed work in clock gating
> framework":597dd9d79cfbbb1), we always wait "unnecessary" default
> clock delay(8 cycles). Actually, we don't need it if clkgate_delay
> (unit:ms) is set because we already wait sufficient time to change
> the clock due to delayed_workqueue.
> This patch removes duplicated waiting time when clkgate_delay is set.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/host.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index c3704e2..d710ce0 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -109,8 +109,11 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>  	 */
>  	if (!host->clk_requests) {
>  		spin_unlock_irqrestore(&host->clk_lock, flags);
> -		tick_ns = DIV_ROUND_UP(1000000000, freq);
> -		ndelay(host->clk_delay * tick_ns);
> +		/* wait only when clk_gate_delay is 0*/
> +		if (!host->clkgate_delay) {
> +			tick_ns = DIV_ROUND_UP(1000000000, freq);
> +			ndelay(host->clk_delay * tick_ns);
> +		}
>  	} else {
>  		/* New users appeared while waiting for this work */
>  		spin_unlock_irqrestore(&host->clk_lock, flags);

Have you seen Guennadi's patch?

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=63871af54a0f0053de6534afe8da101b988b86b6

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
