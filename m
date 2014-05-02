From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap: Use DIV_ROUND_UP instead of open coded
Date: Fri, 2 May 2014 08:39:15 -0700
Message-ID: <20140502153915.GA3014@atomide.com>
References: <1398596216.21067.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14234 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbaEBPjX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 May 2014 11:39:23 -0400
Content-Disposition: inline
In-Reply-To: <1398596216.21067.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

* Axel Lin <axel.lin@ingics.com> [140427 03:58]:
> This also makes the intention more clear.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Added Jarkko Nikula to cc.

Tony

> ---
>  drivers/mmc/host/omap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 5c2e58b..711981e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -177,7 +177,7 @@ static void mmc_omap_fclk_offdelay(struct mmc_omap_slot *slot)
>  	unsigned long tick_ns;
>  
>  	if (slot != NULL && slot->host->fclk_enabled && slot->fclk_freq > 0) {
> -		tick_ns = (1000000000 + slot->fclk_freq - 1) / slot->fclk_freq;
> +		tick_ns = DIV_ROUND_UP(1000000000, slot->fclk_freq);
>  		ndelay(8 * tick_ns);
>  	}
>  }
> @@ -435,7 +435,7 @@ static void mmc_omap_send_stop_work(struct work_struct *work)
>  	struct mmc_data *data = host->stop_data;
>  	unsigned long tick_ns;
>  
> -	tick_ns = (1000000000 + slot->fclk_freq - 1)/slot->fclk_freq;
> +	tick_ns = DIV_ROUND_UP(1000000000, slot->fclk_freq);
>  	ndelay(8*tick_ns);
>  
>  	mmc_omap_start_command(host, data->stop);
> @@ -477,7 +477,7 @@ mmc_omap_send_abort(struct mmc_omap_host *host, int maxloops)
>  	u16 stat = 0;
>  
>  	/* Sending abort takes 80 clocks. Have some extra and round up */
> -	timeout = (120*1000000 + slot->fclk_freq - 1)/slot->fclk_freq;
> +	timeout = DIV_ROUND_UP(120 * 1000000, slot->fclk_freq);
>  	restarts = 0;
>  	while (restarts < maxloops) {
>  		OMAP_MMC_WRITE(host, STAT, 0xFFFF);
> @@ -677,8 +677,8 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
>  	if (n > host->buffer_bytes_left)
>  		n = host->buffer_bytes_left;
>  
> -	nwords = n / 2;
> -	nwords += n & 1; /* handle odd number of bytes to transfer */
> +	/* Round up to handle odd number of bytes to transfer */
> +	nwords = DIV_ROUND_UP(n, 2);
>  
>  	host->buffer_bytes_left -= n;
>  	host->total_bytes_left -= n;
> -- 
> 1.8.3.2
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
