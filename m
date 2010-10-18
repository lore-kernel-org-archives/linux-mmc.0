From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Mon, 18 Oct 2010 17:13:55 +0100
Message-ID: <20101018161355.GA21088@void.printf.net>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de> <1287138064-21385-6-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42658 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab0JRQN4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Oct 2010 12:13:56 -0400
Content-Disposition: inline
In-Reply-To: <1287138064-21385-6-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>

Hi Wolfram,

On Fri, Oct 15, 2010 at 12:21:03PM +0200, Wolfram Sang wrote:
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index c8623de..277fcb9 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -18,23 +18,7 @@
>  #include <linux/mmc/host.h>
>  #include "sdhci-of.h"
>  #include "sdhci.h"
> -
> -/*
> - * Ops and quirks for the Freescale eSDHC controller.
> - */
> -
> -#define ESDHC_DMA_SYSCTL	0x40c
> -#define ESDHC_DMA_SNOOP		0x00000040
> -
> -#define ESDHC_SYSTEM_CONTROL	0x2c
> -#define ESDHC_CLOCK_MASK	0x0000fff0
> -#define ESDHC_PREDIV_SHIFT	8
> -#define ESDHC_DIVIDER_SHIFT	4
> -#define ESDHC_CLOCK_PEREN	0x00000004
> -#define ESDHC_CLOCK_HCKEN	0x00000002
> -#define ESDHC_CLOCK_IPGEN	0x00000001
> -
> -#define ESDHC_HOST_CONTROL_RES	0x05
> +#include "sdhci-esdhc.c"

Stephen reports a -next build failure after this patch.  Presumably this
should be sdhci-esdhc.h?  It's confusing that no-one else hit this.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
