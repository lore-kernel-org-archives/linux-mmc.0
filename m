From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] sdio: Fix crash in mmc_attach_sdio() error path
Date: Tue, 1 Dec 2009 15:53:25 +0000
Message-ID: <20091201155325.GB21413@console-pimps.org>
References: <20091201151300.A34C29D404F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:33173 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZLAPvk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 10:51:40 -0500
Content-Disposition: inline
In-Reply-To: <20091201151300.A34C29D404F@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, Dec 01, 2009 at 03:13:00PM +0000, Daniel Drake wrote:
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index cdb845b..fa07d4f 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -516,7 +516,8 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>  	 * The number of functions on the card is encoded inside
>  	 * the ocr.
>  	 */
> -	card->sdio_funcs = funcs = (ocr & 0x70000000) >> 28;
> +	funcs = (ocr & 0x70000000) >> 28;
> +	card->sdio_funcs = 0;
>  
>  	/*
>  	 * If needed, disconnect card detection pull-up resistor.
> @@ -528,10 +529,11 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>  	/*
>  	 * Initialize (but don't add) all present functions.
>  	 */
> -	for (i = 0;i < funcs;i++) {
> +	for (i = 0;i < funcs;i++, card->sdio_funcs++) {
>  		err = sdio_init_func(host->card, i + 1);
>  		if (err)
>  			goto remove;
> +		card->sdio_funcs = i + 1;
>  	}

I don't understand what you're trying to do here. The card->sdio_funcs++
should take care of incrementing the sdio_funcs count properly. When the
loop terminates both "i" and "card->sdio_funcs" will be equal to
"funcs", unless we jump to the remove label. Unless I've missed
something?

Isn't this hunk below fixing a slightly different bug? Admittedly, it
could cause a crash, but I think it warrants a separate patch and
changelog.

I assumed you would be sending a patch just for this bug below and not
for the one above (which I is why I submitted one). I wasn't very clear
about that though ;-)

> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index d37464e..9e060c8 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -248,12 +248,15 @@ int sdio_add_func(struct sdio_func *func)
>  /*
>   * Unregister a SDIO function with the driver model, and
>   * (eventually) free it.
> + * This function can be called through error paths where sdio_add_func() was
> + * never executed (because a failure occurred at an earlier point).
>   */
>  void sdio_remove_func(struct sdio_func *func)
>  {
> -	if (sdio_func_present(func))
> -		device_del(&func->dev);
> +	if (!sdio_func_present(func))
> +		return;
>  
> +	device_del(&func->dev);
>  	put_device(&func->dev);
>  }
>  
> -- 
> 1.6.2.5
> 
