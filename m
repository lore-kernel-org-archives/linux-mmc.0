From: Chris Ball <cjb@laptop.org>
Subject: Re: [patch] sdhci: correct f_min in sd 3.0
Date: Tue, 28 Sep 2010 04:13:57 +0100
Message-ID: <20100928031357.GA7389@void.printf.net>
References: <AANLkTimp+4V9zvQtOqHoVmpH-+Vmb+0Sr1MzM-cNHAiC@mail.gmail.com> <20100924032401.GA10294@void.printf.net> <AANLkTikeu8pBLSuHQwrrREBRS=NNe9qeRP11oob31SNf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49305 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023Ab0I1DN7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 23:13:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikeu8pBLSuHQwrrREBRS=NNe9qeRP11oob31SNf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

Hi Zhangfei,

On Sat, Sep 25, 2010 at 12:23:33AM -0400, zhangfei gao wrote:
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 20 Sep 2010 15:15:18 -0400
> Subject: [PATCH] sdhci: correct f_min in sd 3.0
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    8 +++++---
>  drivers/mmc/host/sdhci.h |    3 +++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5928b0a..829e78a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1007,14 +1007,14 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  		if (host->max_clk <= clock)
>  			div = 1;
>  		else {
> -			for (div = 2; div < 2046; div += 2) {
> +			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
>  				if ((host->max_clk / div) <= clock)
>  					break;
>  			}
>  		}
>  	} else {
>  		/* Version 2.00 divisors must be a power of 2. */
> -		for (div = 1; div < 256; div *= 2) {
> +		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
>  			if ((host->max_clk / div) <= clock)
>  				break;
>  		}
> @@ -1836,8 +1836,10 @@ int sdhci_add_host(struct sdhci_host *host)
>  	mmc->ops = &sdhci_ops;
>  	if (host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);
> +	else if (host->version >= SDHCI_SPEC_300)
> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>  	else
> -		mmc->f_min = host->max_clk / 256;
> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>  	mmc->f_max = host->max_clk;
>  	mmc->caps |= MMC_CAP_SDIO_IRQ;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index ae28a31..d35fb3d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -185,6 +185,9 @@
>  #define   SDHCI_SPEC_200	1
>  #define   SDHCI_SPEC_300	2
>  
> +#define	SDHCI_MAX_DIV_SPEC_200	256
> +#define	SDHCI_MAX_DIV_SPEC_300	2046
> +
>  struct sdhci_ops;
>  
>  struct sdhci_host {

Thanks very much, I've applied this to mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
