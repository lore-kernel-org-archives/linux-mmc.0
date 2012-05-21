From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] MXS-MMC: Add wp-inverted property
Date: Mon, 21 May 2012 09:39:17 +0800
Message-ID: <20120521013915.GN5427@S2101-09.ap.freescale.net>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <1337562140-5739-4-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab2EUBjH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 21:39:07 -0400
Received: by pbbrp8 with SMTP id rp8so6252181pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 20 May 2012 18:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337562140-5739-4-git-send-email-marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Copy Chris and linux-mmc, as I assume that the patch should go via mmc
tree after the merge window.

On Mon, May 21, 2012 at 03:02:20AM +0200, Marek Vasut wrote:
> The write-protect GPIO is inverted on some boards. Handle such case.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

A coupe of nits though:

The subject prefix can better be "mmc: mxs-mmc: ".

> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
>  drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> index 14d870a..0a7d2cd 100644
> --- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> @@ -13,6 +13,7 @@ Required properties:
>  
>  Optional properties:
>  - wp-gpios: Specify GPIOs for write protection
> +- wp-inverted: Set if the write protection GPIO is inverted
>  
>  Examples:
>  
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 277161d..119beb9 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -164,16 +164,23 @@ struct mxs_mmc_host {
>  	spinlock_t			lock;
>  	int				sdio_irq_en;
>  	int				wp_gpio;
> +	int				wp_inverted:1;
>  };
>  
>  static int mxs_mmc_get_ro(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
> +	int ret;
>  
>  	if (!gpio_is_valid(host->wp_gpio))
>  		return -EINVAL;
>  
> -	return gpio_get_value(host->wp_gpio);
> +	ret = gpio_get_value(host->wp_gpio);
> +
> +	if (host->wp_inverted)
> +		ret = !ret;
> +
> +	return ret;

The above lines can just be the one below?

	return (host->wp_inverted) ? !ret : ret;

>  }

-- 
Regards,
Shawn
