From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] sdhci: Enable high speed support for MMC cards
Date: Fri, 17 Sep 2010 23:14:04 +0100
Message-ID: <20100917221404.GA19979@void.printf.net>
References: <20100827191945.GI20407@void.printf.net> <AANLkTinmaio2PAcnwP7+U8P4O1-T3HiLYz_ej3zGAV5Y@mail.gmail.com> <m362yu4sef.fsf@pullcord.laptop.org> <AANLkTikswH2GdmXvRBWoeJcbrAn+JbzLTOA9fkPyV=fB@mail.gmail.com> <20100830155644.GA13076@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50147 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875Ab0IQWOH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Sep 2010 18:14:07 -0400
Content-Disposition: inline
In-Reply-To: <20100830155644.GA13076@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Kyungmin Park <kmpark@infradead.org>, "George G. Davis" <gdavis@mvista.com>, Zhangfei Gao <zgao6@marvell.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Aug 30, 2010 at 04:56:44PM +0100, Chris Ball wrote:
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Mon, 16 Aug 2010 21:15:32 -0400
> Subject: [PATCH] sdhci: Enable high-speed support for MMC cards
> 
> Support MMC_CAP_MMC_HIGHSPEED.
> 
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> Acked-by: Matt Fleming <matt@console-pimps.org>
> Acked-by: Kyungmin Park <kmpark@infradead.org>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 401527d..87ab234 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1824,7 +1824,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
>  
>  	if (caps & SDHCI_CAN_DO_HISPD)
> -		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
> -- 
> 1.7.0.1

Pushed to mmc-next, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
