From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs: fix build regression from mismerge
Date: Tue, 09 Oct 2012 11:51:29 -0400
Message-ID: <877gqzabjy.fsf@octavius.laptop.org>
References: <201210091537.23659.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52447 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756235Ab2JIPvo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Oct 2012 11:51:44 -0400
In-Reply-To: <201210091537.23659.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 9 Oct 2012 15:37:23 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Attila Kinali <attila@kinali.ch>, Lauri Hintsala <lauri.hintsala@bluegiga.com>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi,

On Tue, Oct 09 2012, Arnd Bergmann wrote:
> From all I can tell, the patches
>
> fc108d24 "mmc: mxs-mmc: fix deadlock caused by recursion loop"
> 829c1bf4 "mmc: spi: Pull out parts shared between MMC and SPI"
>
> came in through separate branches and cause this build error when
> combined.
>
> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
> drivers/mmc/host/mxs-mmc.c:527:78: error: 'struct mxs_mmc_host' has no member named 'base'
> drivers/mmc/host/mxs-mmc.c:527:95: error: 'struct mxs_mmc_host' has no member named 'devid'
>
> This does the obvious missing change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Attila Kinali <attila@kinali.ch>
> Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
>

I'll send Marek's change to Linus once the main MMC merge has been pulled.
Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
