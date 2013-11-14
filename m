From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/8] mmc: omap: Fix I2C dependency and make driver
 usable with device tree
Date: Thu, 14 Nov 2013 11:05:33 +0000
Message-ID: <20131114110533.GD16396@e106331-lin.cambridge.arm.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54307 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab3KNLF7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2013 06:05:59 -0500
Content-Disposition: inline
In-Reply-To: <1384396537-3486-4-git-send-email-tony@atomide.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Nov 14, 2013 at 02:35:32AM +0000, Tony Lindgren wrote:
> Some features can be configured by the companion I2C chips,
> which may not be available at the probe time. Fix the issue
> by returning -EPROBE_DEFER when the MMC controller slots
> are not configured.
> 
> While at it, let's also add minimal device tree support so
> omap24xx platforms can use this driver without legacy mode
> since we claim to support device tree for mach-omap2 based
> systems.
> 
> Although adding the minimal device tree support is not strictly
> a fix, it does remove one of the last blockers for dropping a
> bunch of legacy platform data for mach-omap2.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.
> 
> ---
>  drivers/mmc/host/omap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index ed56868..43c66ad 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -22,6 +22,7 @@
>  #include <linux/delay.h>
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
> +#include <linux/of.h>
>  #include <linux/omap-dma.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> @@ -1330,7 +1331,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
>  	}
>  	if (pdata->nr_slots == 0) {
>  		dev_err(&pdev->dev, "no slots\n");
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1553,6 +1554,12 @@ static int mmc_omap_resume(struct platform_device *pdev)
>  #define mmc_omap_resume		NULL
>  #endif
>  
> +#if IS_BUILTIN(CONFIG_OF)
> +static const struct of_device_id mmc_omap_match[] = {
> +	{ .compatible = "ti,omap2420-mmc", },

Missing binding document.

Thanks,
Mark.
