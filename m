From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: print out controller name for register debug
Date: Thu, 23 Sep 2010 00:08:06 +0100
Message-ID: <20100922230805.GA6659@void.printf.net>
References: <4BA72971.1070804@nokia.com> <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com> <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com> <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com> <4C984B01.2000005@nokia.com> <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com> <1CE3965A-95E9-41A7-8333-432778AAC336@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39898 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab0IVXIK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 19:08:10 -0400
Content-Disposition: inline
In-Reply-To: <1CE3965A-95E9-41A7-8333-432778AAC336@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

Hi Philip,

On Wed, Sep 22, 2010 at 03:25:13PM -0700, Philip Rakity wrote:
> Subject: [PATCH] sdhci: print out controller name for register debug
> 
> In a multi-controller environment it is helpful to know which controller
> has problems.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e2b1f32..6b8ca32 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -47,7 +47,8 @@ static void sdhci_finish_command(struct sdhci_host *);
>  
>  static void sdhci_dumpregs(struct sdhci_host *host)
>  {
> -	printk(KERN_DEBUG DRIVER_NAME ": ============== REGISTER DUMP ==============\n");
> +	printk(KERN_DEBUG DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
> +		mmc_hostname(host->mmc));
>  
>  	printk(KERN_DEBUG DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
>  		sdhci_readl(host, SDHCI_DMA_ADDRESS),

Thanks, pushed to mmc-next; I'm surprised no-one noticed this before. :)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
