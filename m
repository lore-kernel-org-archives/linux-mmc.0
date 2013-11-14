From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 05/17] mmc: tmio: don't overwrite caps2
Date: Thu, 14 Nov 2013 14:36:32 +0100
Message-ID: <10903520.3arDgICZF8@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87habfz3kd.wl%kuninori.morimoto.gx@renesas.com> <87d2m3z3ex.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87d2m3z3ex.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 14 November 2013 02:24:58 Kuninori Morimoto wrote:
> 02cb3221d5bb351ad9f7469453dcca7594a0fabf
> (mmc: tmio: support caps2 flags) added caps2 support
> on tmio, but it overwrites mmc_of_parse() settings.
> This patch fixes it up
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/mmc/host/tmio_mmc_pio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c
> b/drivers/mmc/host/tmio_mmc_pio.c index 99f6d29..1f5f2ba 100644
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
-- 
Regards,

Laurent Pinchart

