From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: tmio: fixup compile error
Date: Wed, 8 Jan 2014 13:47:50 +0900
Message-ID: <20140108044748.GI15891@verge.net.au>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com>
 <87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
 <201401071440.28355.arnd@arndb.de>
 <87fvozxnnn.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fvozxnnn.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 07, 2014 at 05:33:51PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch fixup below compile error
> 
> ${LINUX}/drivers/mmc/host/tmio_mmc.c: In function 'tmio_mmc_probe':
> ${LINUX}/drivers/mmc/host/tmio_mmc.c:93:35: \
> 	error: 'res_ctl' undeclared (first use in this function)
> ${LINUX}/drivers/mmc/host/tmio_mmc.c:93:35: \
> 	note: each undeclared identifier is reported only \
> 	once for each function it appears in
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> >> Chris
> This is needed on mmc-next branch.
> 
>  drivers/mmc/host/tmio_mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 8a781e2..1900abb 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -90,7 +90,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
> -	pdata->bus_shift = resource_size(res_ctl) >> 10;
> +	pdata->bus_shift = resource_size(res) >> 10;
>  	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
>  
>  	ret = tmio_mmc_host_probe(&host, pdev, pdata);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
