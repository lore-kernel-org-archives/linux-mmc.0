From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: sdhci: Test cd-gpio instead of SDHCI presence when
 probing
Date: Mon, 17 Sep 2012 11:09:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1209171107130.1689@axis700.grange>
References: <m3y5k9yxfz.fsf@pullcord.laptop.org> <Pine.LNX.4.64.1209170834170.1689@axis700.grange>
 <m3a9wpyqnc.fsf_-_@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61513 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab2IQJJl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 05:09:41 -0400
In-Reply-To: <m3a9wpyqnc.fsf_-_@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Mon, 17 Sep 2012, Chris Ball wrote:

> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Previously to this patch, an SDHCI platform that uses a GPIO for
> card detection instead of the internal SDHCI_CARD_PRESENT bit on
> the presence register would fail to bring up a new card because
> logic in sdhci_request() fails the request if that bit is 0.
> 
> Some drivers worked around this in various ways: esdhc-imx defines
> an IO accessor to fake the presence bit being true, s3c turns on
> polling (which stops the SDHCI driver from checking the bit) after
> a card's inserted.  But none of this should be necessary; the real
> fix is to check whether we're using a GPIO and avoid relying on
> the presence bit if so, as this patch implements.
> 

Well, ok, thanks for attributing this patch to me:-) I guess then my Sob 
should go in the first, as you'll be forwarding the patch upstream? But 
feel free to swap them if you disagree

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d98b199..0e15c79 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -28,6 +28,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/slot-gpio.h>
>  
>  #include "sdhci.h"
>  
> @@ -1293,6 +1294,13 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>  				SDHCI_CARD_PRESENT;
>  
> +	/* If we're using a cd-gpio, testing the presence bit might fail. */
> +	if (!present) {
> +		int ret = mmc_gpio_get_cd(host->mmc);
> +		if (ret > 0)
> +			present = true;
> +	}
> +
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		host->mrq->cmd->error = -ENOMEDIUM;
>  		tasklet_schedule(&host->finish_tasklet);
> -- 
> 1.7.11.2
> 
> 
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
