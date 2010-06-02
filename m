From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [MMC] omap: Remove BUG_ON for disabled interrupts
Date: Wed, 2 Jun 2010 14:05:42 -0700
Message-ID: <20100602140542.8c1073f1.akpm@linux-foundation.org>
References: <1275186443-8242-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50429 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758615Ab0FBVGT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jun 2010 17:06:19 -0400
In-Reply-To: <1275186443-8242-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, 29 May 2010 19:27:23 -0700
Cory Maccarrone <darkstar6262@gmail.com> wrote:

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

So we need to decide whether this should be backported into 2.6.34.x
and perhaps earlier.

For that decision we'll need to know the things you didn't tell us:
Which drivers are affected?  Under which setups is it triggering?  Why
aren't lots of people reporting "hey my kernel went BUG"?

