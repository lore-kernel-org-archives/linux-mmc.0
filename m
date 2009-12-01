From: Daniel Drake <dsd@laptop.org>
Subject: Re: crash in mmc subsystem during suspend
Date: Tue, 01 Dec 2009 12:49:26 +0000
Message-ID: <1259671766.2124.34.camel@localhost.localdomain>
References: <1258707087.2235.6.camel@localhost.localdomain>
	 <1258729858.2235.29.camel@localhost.localdomain>
	 <20091121123149.GA18478@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63925 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZLAMtZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 07:49:25 -0500
Received: by bwz27 with SMTP id 27so3378987bwz.21
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2009 04:49:30 -0800 (PST)
In-Reply-To: <20091121123149.GA18478@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org

On Sat, 2009-11-21 at 12:31 +0000, Matt Fleming wrote:
> Fancy giving this patch a try? I think it's just a case of removing too
> many funcs in the error path.

Thanks!
Yes, I agree that looks like the culprit.
I applied something very similar to your patch and the crash went away.

The one additional change I made is in sdio_bus.c :

 void sdio_remove_func(struct sdio_func *func)
 {
-       if (sdio_func_present(func))
-               device_del(&func->dev);
+       if (!sdio_func_present(func))
+               return;
 
+       device_del(&func->dev);
        put_device(&func->dev);
 }

I think this is necessary because the error path will go mmc_sdio_remove
--> sdio_remove_func
Hence sdio_remove_func() will be called when sdio_add_func() was never
called beforehand, so there is no func->dev reference to drop.

Do you agree? I'm not certain about this one.

Thanks!
Daniel


> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index cdb845b..cdec9c8 100644
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
> @@ -528,7 +529,7 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>  	/*
>  	 * Initialize (but don't add) all present functions.
>  	 */
> -	for (i = 0;i < funcs;i++) {
> +	for (i = 0;i < funcs;i++,card->sdio_funcs++) {
>  		err = sdio_init_func(host->card, i + 1);
>  		if (err)
>  			goto remove;

