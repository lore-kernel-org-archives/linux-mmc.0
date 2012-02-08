From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Wed, 08 Feb 2012 10:07:19 -0500
Message-ID: <m21uq52wk8.fsf@bob.laptop.org>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49875 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2BHPHb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Feb 2012 10:07:31 -0500
In-Reply-To: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	(r66093@freescale.com's message of "Wed, 8 Feb 2012 16:05:56 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

Hi,

On Wed, Feb 08 2012, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> SD card read was failing (data crc error)on some cards at
> maximum possible frequency on P1010(CCB frequency set to 400MHz).
> Some clock deviations are also observed at this frequency.
> Hence reduced the mmc clock freq.
>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks, just one comment below:

> ---
> changes for v2:
> 	- change the property to compatible for quirks
> changes for v3:
> 	- fix one compile error
> changes for v4:
> 	- use hooks to suspend/resume the special platform
> changes for v5:
> 	- add the Acked-by
> changes for v6:
> 	- move the workaround codes to special platform from header file
> changes for v7:
> 	- don't use quirks to check the platform support
>
>  drivers/mmc/host/sdhci-of-esdhc.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
>  drivers/mmc/host/sdhci-of-esdhc.c |   24 ++++++++++++++++++++++--
>  1 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 2ef52f4..acac541 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1,7 +1,7 @@
>  /*
>   * Freescale eSDHC controller driver.
>   *
> - * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.
> + * Copyright (c) 2007, 2010, 2012 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   *
>   * Authors: Xiaobo Xie <X.Xie@freescale.com>
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> @@ -114,6 +115,25 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
>  	return pltfm_host->clock / 256 / 16;
>  }
>  
> +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	/* Workaround to reduce the clock frequency for p1010 esdhc */
> +	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
> +		if (clock == 0) {
> +			host->clock = clock;
> +			return;
> +		}

Is this if (clock == 0) necessary?  You'll be calling esdhc_set_clock()
immediately afterwards, and it performs the same test.

> +
> +		if (clock > 20000000)
> +			clock -= 5000000;
> +		if (clock > 40000000)
> +			clock -= 5000000;
> +	}
> +
> +	/* Set the clock */
> +	esdhc_set_clock(host, clock);
> +}
> +
>  #ifdef CONFIG_PM
>  static u32 esdhc_proctl;
>  static void esdhc_of_suspend(struct sdhci_host *host)
> @@ -135,7 +155,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.write_l = sdhci_be32bs_writel,
>  	.write_w = esdhc_writew,
>  	.write_b = esdhc_writeb,
> -	.set_clock = esdhc_set_clock,
> +	.set_clock = esdhc_of_set_clock,
>  	.enable_dma = esdhc_of_enable_dma,
>  	.get_max_clock = esdhc_of_get_max_clock,
>  	.get_min_clock = esdhc_of_get_min_clock,

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
