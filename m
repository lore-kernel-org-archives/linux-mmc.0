From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [MMC] omap: Remove BUG_ON for disabled interrupts
Date: Mon, 31 May 2010 16:37:48 +0300
Message-ID: <20100531133748.GG30216@atomide.com>
References: <1275186443-8242-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57888 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab0EaNho (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2010 09:37:44 -0400
Content-Disposition: inline
In-Reply-To: <1275186443-8242-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, akpm@linux-foundation.org

* Cory Maccarrone <darkstar6262@gmail.com> [100530 05:22]:
> This change removes a BUG_ON for when interrupts are disabled
> during an MMC request.  During boot, interrupts can be disabled
> when a request is made, causing this bug to be triggered.  In reality,
> there's no reason this should halt the kernel, as the driver has proved
> reliable in spite of disabled interrupts, and additionally, there's
> nothing in this code that would require interrupts to be enabled.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  drivers/mmc/host/omap.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 2b28168..d98ddcf 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1157,7 +1157,6 @@ static void mmc_omap_start_request(struct mmc_omap_host *host,
>  	mmc_omap_start_command(host, req->cmd);
>  	if (host->dma_in_use)
>  		omap_start_dma(host->dma_ch);
> -	BUG_ON(irqs_disabled());
>  }
>  
>  static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)

This looks safe to me.

Acked-by: Tony Lindgren <tony@atomide.com>
