From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Fix merge issue causing build error
Date: Sun, 7 Oct 2012 11:12:27 +0800
Message-ID: <20121007031224.GK20231@S2101-09.ap.freescale.net>
References: <1349124763-10840-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65247 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab2JGDMb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Oct 2012 23:12:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3047760pbb.19
        for <linux-mmc@vger.kernel.org>; Sat, 06 Oct 2012 20:12:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349124763-10840-1-git-send-email-marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Copy Chris who should be able to help send this fix for 3.7-rc.

Shawn

On Mon, Oct 01, 2012 at 10:52:43PM +0200, Marek Vasut wrote:
> The following error appeared due to trivial merge problem:
> 
> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
> drivers/mmc/host/mxs-mmc.c:527:3: error: 'struct mxs_mmc_host' has no member named 'base'
> drivers/mmc/host/mxs-mmc.c:527:3: error: 'struct mxs_mmc_host' has no member named 'devid'
> make[3]: *** [drivers/mmc/host/mxs-mmc.o] Error 1
> 
> This patches corrects the issue.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/mxs-mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index bb4c2bf..80d1e6d 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>  		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>  		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> -		       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);
> +		       ssp->base + HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_SET);
>  	} else {
>  		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>  		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> -- 
> 1.7.10.4
> 
