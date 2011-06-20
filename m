From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Mon, 20 Jun 2011 15:25:22 +0900
Message-ID: <20110620062517.GA7920@linux-sh.org>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au> <1308550015-15717-4-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:56193 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab1FTGZm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jun 2011 02:25:42 -0400
Content-Disposition: inline
In-Reply-To: <1308550015-15717-4-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>

On Mon, Jun 20, 2011 at 03:06:53PM +0900, Simon Horman wrote:
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index b365429..6c56453 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -27,6 +27,8 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/sh_dma.h>
>  
> +#include <asm/delay.h>
> +
>  #include "tmio_mmc.h"
>  
linux/delay.h will suffice.

> +static void sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> +{
> +	int timeout = 1000;
> +
> +	while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
> +		udelay(1);
> +
> +	if (!timeout)
> +		dev_warn(host->pdata->dev, "timeout waiting for SD bus idle\n");
> +
> +}
> +
> +static void sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
> +{
> +	if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> +		return;
> +
> +	switch (addr)
> +	{
> +	case CTL_SD_CMD:
> +	case CTL_STOP_INTERNAL_ACTION:
> +	case CTL_XFER_BLK_COUNT:
> +	case CTL_SD_CARD_CLK_CTL:
> +	case CTL_SD_XFER_LEN:
> +	case CTL_SD_MEM_CARD_OPT:
> +	case CTL_TRANSACTION_CTL:
> +	case CTL_DMA_ENABLE:
> +		sh_mobile_sdhi_wait_idle(host);
> +	}
> +}
> +
The timeout error should really be handed down.

> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 0c22df0..5912cf3 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -153,6 +153,8 @@ static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
>  
>  static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
>  {
> +	if (host->pdata->write16_hook)
> +		host->pdata->write16_hook(host, addr);
>  	writew(val, host->ctl + (addr << host->bus_shift));
>  }
>  
If it times out you are unlikely to want to proceed with the write. At
best you end up with a lost write cycle, at worst potentially a bus
lockup you can't easily recover from.
