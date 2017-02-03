From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 7/9] mmc: meson-gx: reduce bounce buffer size
Date: Fri, 03 Feb 2017 10:18:41 -0800
Message-ID: <7hvasruohq.fsf@baylibre.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
        <90d34a64-bd3e-dcf2-4c36-5ef4e2ac8666@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33076 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdBCSSn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 13:18:43 -0500
Received: by mail-pf0-f176.google.com with SMTP id y143so7574543pfb.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 10:18:43 -0800 (PST)
In-Reply-To: <90d34a64-bd3e-dcf2-4c36-5ef4e2ac8666@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Feb 2017 07:49:18 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> A bounce buffer of 512K isn't needed as the max request size is
> 511 * 512 byte.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

> ---
> v2:
> - no changes
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 883263c5..48ce4ba4 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -785,7 +785,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
>  
>  	/* data bounce buffer */
> -	host->bounce_buf_size = SZ_512K;
> +	host->bounce_buf_size = mmc->max_req_size;
>  	host->bounce_buf =
>  		dma_alloc_coherent(host->dev, host->bounce_buf_size,
>  				   &host->bounce_dma_addr, GFP_KERNEL);
