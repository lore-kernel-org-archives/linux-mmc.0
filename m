From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] Powerpc eSDHC: Use u64 to calculate the timeout value to
 avoid overflow
Date: Sun, 18 Nov 2012 16:39:39 -0800
Message-ID: <20121119003938.GJ29066@lizard.sbx05977.paloaca.wayport.net>
References: <1352695528-6457-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63166 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2KSAnC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 19:43:02 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3062696pbc.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 16:43:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352695528-6457-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Mon, Nov 12, 2012 at 12:45:28PM +0800, Haijun Zhang wrote:
> As some mmc cards need large timeout value usually a few seconds,
> so data timeout nanosecond will overflow with u32 variable and
> give the wrong timeout value, so use u64 will be safe.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
>  drivers/mmc/core/core.c  |   21 ++++++++-------------
>  drivers/mmc/host/sdhci.c |    6 +++---
>  include/linux/mmc/core.h |    2 +-
>  3 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06c42cf..c241fc1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -208,10 +208,10 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  
>  	if (mrq->data) {
>  		pr_debug("%s:     blksz %d blocks %d flags %08x "
> -			"tsac %d ms nsac %d\n",
> +			"tsac %lld ms nsac %d\n",
>  			mmc_hostname(host), mrq->data->blksz,
>  			mrq->data->blocks, mrq->data->flags,
> -			mrq->data->timeout_ns / 1000000,
> +			div_u64(mrq->data->timeout_ns, 1000000),
>  			mrq->data->timeout_clks);
>  	}
>  
> @@ -659,16 +659,16 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  	if (data->flags & MMC_DATA_WRITE)
>  		mult <<= card->csd.r2w_factor;
>  
> -	data->timeout_ns = card->csd.tacc_ns * mult;
> +	data->timeout_ns = (u64)card->csd.tacc_ns * (u64)mult;

one cast would be enough.

>  	data->timeout_clks = card->csd.tacc_clks * mult;
>  
>  	/*
>  	 * SD cards also have an upper limit on the timeout.
>  	 */
>  	if (mmc_card_sd(card)) {
> -		unsigned int timeout_us, limit_us;
> +		u64 timeout_us, limit_us;
>  
> -		timeout_us = data->timeout_ns / 1000;
> +		timeout_us = div_u64(data->timeout_ns, 1000);
>  		if (mmc_host_clk_rate(card->host))
>  			timeout_us += data->timeout_clks * 1000 /
>  				(mmc_host_clk_rate(card->host) / 1000);
> @@ -1545,14 +1545,9 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
>  		/* CSD Erase Group Size uses write timeout */
>  		unsigned int mult = (10 << card->csd.r2w_factor);
>  		unsigned int timeout_clks = card->csd.tacc_clks * mult;
> -		unsigned int timeout_us;
> -
> -		/* Avoid overflow: e.g. tacc_ns=80000000 mult=1280 */
> -		if (card->csd.tacc_ns < 1000000)
> -			timeout_us = (card->csd.tacc_ns * mult) / 1000;
> -		else
> -			timeout_us = (card->csd.tacc_ns / 1000) * mult;
> +		u64 timeout_us;
>  
> +		timeout_us = (u64)(card->csd.tacc_ns / 1000) * (u64)mult;

Ditto.

Otherwise it looks good.

Thanks,
Anton.
