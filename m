From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: don't overwrite caps2
Date: Tue, 26 Nov 2013 17:21:48 -0500
Message-ID: <877gbug5xf.fsf@octavius.laptop.org>
References: <87mwkz8p4k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33915 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab3KZWV7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 17:21:59 -0500
In-Reply-To: <87mwkz8p4k.wl%kuninori.morimoto.gx@renesas.com> (Kuninori
	Morimoto's message of "Wed, 20 Nov 2013 00:16:14 -0800 (PST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Nov 20 2013, Kuninori Morimoto wrote:
> 02cb3221d5bb351ad9f7469453dcca7594a0fabf
> (mmc: tmio: support caps2 flags) added caps2 support
> on tmio, but it overwrites mmc_of_parse() settings.
> This patch fixes it up
>
> Acked-by: Laurent <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>>> Chris
>
> This was part of "SDHI support for r8a7790" patch-set,
> but was separated
>
>  drivers/mmc/host/tmio_mmc_pio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 99f6d29..1f5f2ba 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1021,7 +1021,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>  
>  	mmc->ops = &tmio_mmc_ops;
>  	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
> -	mmc->caps2 = pdata->capabilities2;
> +	mmc->caps2 |= pdata->capabilities2;
>  	mmc->max_segs = 32;
>  	mmc->max_blk_size = 512;
>  	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
