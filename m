From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 6/6] mmc: omap_hsmmc: split omap-dma header file
Date: Thu, 15 May 2014 19:08:52 +0530
Message-ID: <5374C36C.1020404@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com> <1399654013-28262-7-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54640 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbaEONjH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 May 2014 09:39:07 -0400
In-Reply-To: <1399654013-28262-7-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

On Friday 09 May 2014 10:16 PM, Balaji T K wrote:
> moving dmaengine consumer specific function to omap-dmaengine.h
> to Resolve build failure seen with sh-allmodconfig:
>      include/linux/omap-dma.h:171:8: error: expected identifier before numeric constant
>      make[4]: *** [drivers/mmc/host/omap_hsmmc.o] Error 1
>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Hi Russell, Tony,

Since this patches touches omap dma header file,
can you provide your comments / ack if it looks ok ?

> ---
>   drivers/mmc/host/omap_hsmmc.c  |    2 +-
>   include/linux/omap-dma.h       |   19 +------------------
>   include/linux/omap-dmaengine.h |   21 +++++++++++++++++++++
>   3 files changed, 23 insertions(+), 19 deletions(-)
>   create mode 100644 include/linux/omap-dmaengine.h
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index cba71d6..6b7b755 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -31,7 +31,7 @@
>   #include <linux/of.h>
>   #include <linux/of_gpio.h>
>   #include <linux/of_device.h>
> -#include <linux/omap-dma.h>
> +#include <linux/omap-dmaengine.h>
>   #include <linux/mmc/host.h>
>   #include <linux/mmc/core.h>
>   #include <linux/mmc/mmc.h>
> diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
> index 41a13e7..999f52d 100644
> --- a/include/linux/omap-dma.h
> +++ b/include/linux/omap-dma.h
> @@ -1,23 +1,6 @@
> -/*
> - * OMAP DMA Engine support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
>   #ifndef __LINUX_OMAP_DMA_H
>   #define __LINUX_OMAP_DMA_H
> -
> -struct dma_chan;
> -
> -#if defined(CONFIG_DMA_OMAP) || defined(CONFIG_DMA_OMAP_MODULE)
> -bool omap_dma_filter_fn(struct dma_chan *, void *);
> -#else
> -static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
> -{
> -	return false;
> -}
> -#endif
> +#include <linux/omap-dmaengine.h>
>
>   /*
>    *  Legacy OMAP DMA handling defines and functions
> diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
> new file mode 100644
> index 0000000..2b0b6aa
> --- /dev/null
> +++ b/include/linux/omap-dmaengine.h
> @@ -0,0 +1,21 @@
> +/*
> + * OMAP DMA Engine support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __LINUX_OMAP_DMAENGINE_H
> +#define __LINUX_OMAP_DMAENGINE_H
> +
> +struct dma_chan;
> +
> +#if defined(CONFIG_DMA_OMAP) || defined(CONFIG_DMA_OMAP_MODULE)
> +bool omap_dma_filter_fn(struct dma_chan *, void *);
> +#else
> +static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
> +{
> +	return false;
> +}
> +#endif
> +#endif /* __LINUX_OMAP_DMAENGINE_H */
>

