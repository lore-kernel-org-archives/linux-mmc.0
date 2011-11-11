From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc mxcmmc: fix falling back to PIO
Date: Fri, 11 Nov 2011 11:13:10 -0500
Message-ID: <871utewsbt.fsf@laptop.org>
References: <1321025285-22821-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59339 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757986Ab1KKQNL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 11:13:11 -0500
In-Reply-To: <1321025285-22821-1-git-send-email-s.hauer@pengutronix.de>
	(Sascha Hauer's message of "Fri, 11 Nov 2011 16:28:05 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Sascha,

On Fri, Nov 11 2011, Sascha Hauer wrote:
> When we can't configure the dma channel we want to fall
> back to PIO. We do this by setting host->do_dma to zero.
> This does not work as do_dma is used to see whether dma
> can be used for the current transfer. Instead, we have
> to set host->dma to NULL.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/mxcmmc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 14aa213..b87143d 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -731,6 +731,7 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  				"failed to config DMA channel. Falling back to PIO\n");
>  			dma_release_channel(host->dma);
>  			host->do_dma = 0;
> +			host->dma = NULL;
>  		}
>  	}

Thanks, pushed to mmc-next for 3.2 with a stable@ tag added.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
