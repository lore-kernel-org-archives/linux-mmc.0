From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec
	3.0
Date: Tue, 17 Aug 2010 12:42:58 +0100
Message-ID: <20100817114258.GB1733@console-pimps.org>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com> <4C696233.6000408@csr.com> <20100816182710.GA6338@console-pimps.org> <4C698956.101@csr.com> <20100816192748.GC6263@console-pimps.org> <AANLkTinxtxAMVe+LY_W_JU558XuG_+ea3HNU8Xr0thja@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:57635 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678Ab0HQLm7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 07:42:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinxtxAMVe+LY_W_JU558XuG_+ea3HNU8Xr0thja@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: David Vrabel <david.vrabel@csr.com>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Tue, Aug 17, 2010 at 07:08:57AM -0400, zhangfei gao wrote:
> 
> Thanks for your carefully review, my mistake.
> update the patch to distinguish spec 2.0 and 3.0, help review again.
> 
> From 9701da8440b847d8e061107fa6d25bd77698e577 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 6 Aug 2010 07:10:01 +0800
> Subject: [PATCH] sdhci: support 10-bit divided clock Mode
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Micha? Miros?aw <mirqus@gmail.com>
> Cc: David Vrabel <david.vrabel@csr.com>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   22 +++++++++++++++++-----
>  drivers/mmc/host/sdhci.h |    5 +++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 913555e..7ed6f1c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1001,13 +1001,25 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	if (clock == 0)
>  		goto out;
> 
> -	for (div = 1;div < 256;div *= 2) {
> -		if ((host->max_clk / div) <= clock)
> -			break;
> +	if (host->version >= SDHCI_SPEC_300) {
> +		if(host->max_clk <= clock)
> +			div = 1;
> +		else {
> +			for (div = 2; div < 2046; div += 2) {
> +				if ((host->max_clk / div) <= clock)
> +					break;
> +			}
> +		}
> +	} else {
> +		for (div = 1;div < 256;div *= 2) {
> +			if ((host->max_clk / div) <= clock)
> +				break;
> +		}
>  	}
>  	div >>= 1;
> 
> -	clk = div << SDHCI_DIVIDER_SHIFT;
> +	clk = (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> +	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) <<
> SDHCI_DIVIDER_HI_SHIFT;
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> 
> @@ -1707,7 +1719,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	host->version = (host->version & SDHCI_SPEC_VER_MASK)
>  				>> SDHCI_SPEC_VER_SHIFT;
> -	if (host->version > SDHCI_SPEC_200) {
> +	if (host->version > SDHCI_SPEC_300) {
>  		printk(KERN_ERR "%s: Unknown controller version (%d). "
>  			"You may experience problems.\n", mmc_hostname(mmc),
>  			host->version);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 036cfae..50860dc 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -86,6 +86,10 @@
> 
>  #define SDHCI_CLOCK_CONTROL	0x2C
>  #define  SDHCI_DIVIDER_SHIFT	8
> +#define  SDHCI_DIVIDER_HI_SHIFT	6
> +#define  SDHCI_DIV_MASK	0xFF
> +#define  SDHCI_DIV_MASK_LEN	8
> +#define  SDHCI_DIV_HI_MASK	0x300
>  #define  SDHCI_CLOCK_CARD_EN	0x0004
>  #define  SDHCI_CLOCK_INT_STABLE	0x0002
>  #define  SDHCI_CLOCK_INT_EN	0x0001
> @@ -178,6 +182,7 @@
>  #define  SDHCI_SPEC_VER_SHIFT	0
>  #define   SDHCI_SPEC_100	0
>  #define   SDHCI_SPEC_200	1
> +#define   SDHCI_SPEC_300	2
> 
>  struct sdhci_ops;
> 
> -- 
> 1.7.0.4

> From 9701da8440b847d8e061107fa6d25bd77698e577 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 6 Aug 2010 07:10:01 +0800
> Subject: [PATCH] sdhci: support 10-bit divided clock Mode
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Micha?? Miros??aw <mirqus@gmail.com>
> Cc: David Vrabel <david.vrabel@csr.com>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   22 +++++++++++++++++-----
>  drivers/mmc/host/sdhci.h |    5 +++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 913555e..7ed6f1c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1001,13 +1001,25 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if (clock == 0)
>  		goto out;
>  
> -	for (div = 1;div < 256;div *= 2) {
> -		if ((host->max_clk / div) <= clock)
> -			break;
> +	if (host->version >= SDHCI_SPEC_300) {
> +		if(host->max_clk <= clock)
> +			div = 1;
> +		else {
> +			for (div = 2; div < 2046; div += 2) {
> +				if ((host->max_clk / div) <= clock)
> +					break;
> +			}
> +		}
> +	} else {
> +		for (div = 1;div < 256;div *= 2) {
> +			if ((host->max_clk / div) <= clock)
> +				break;
> +		}
>  	}
>  	div >>= 1;
>  
> -	clk = div << SDHCI_DIVIDER_SHIFT;
> +	clk = (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> +	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) << SDHCI_DIVIDER_HI_SHIFT;
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> @@ -1707,7 +1719,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	host->version = (host->version & SDHCI_SPEC_VER_MASK)
>  				>> SDHCI_SPEC_VER_SHIFT;
> -	if (host->version > SDHCI_SPEC_200) {
> +	if (host->version > SDHCI_SPEC_300) {
>  		printk(KERN_ERR "%s: Unknown controller version (%d). "
>  			"You may experience problems.\n", mmc_hostname(mmc),
>  			host->version);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 036cfae..50860dc 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -86,6 +86,10 @@
>  
>  #define SDHCI_CLOCK_CONTROL	0x2C
>  #define  SDHCI_DIVIDER_SHIFT	8
> +#define  SDHCI_DIVIDER_HI_SHIFT	6
> +#define  SDHCI_DIV_MASK	0xFF
> +#define  SDHCI_DIV_MASK_LEN	8
> +#define  SDHCI_DIV_HI_MASK	0x300
>  #define  SDHCI_CLOCK_CARD_EN	0x0004
>  #define  SDHCI_CLOCK_INT_STABLE	0x0002
>  #define  SDHCI_CLOCK_INT_EN	0x0001
> @@ -178,6 +182,7 @@
>  #define  SDHCI_SPEC_VER_SHIFT	0
>  #define   SDHCI_SPEC_100	0
>  #define   SDHCI_SPEC_200	1
> +#define   SDHCI_SPEC_300	2
>  
>  struct sdhci_ops;
>  
> -- 
> 1.7.0.4
>

Reviewed-by: Matt Fleming <matt@console-pimps.org>
