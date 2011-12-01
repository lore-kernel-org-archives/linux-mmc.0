From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mmcif: fix clock gating on platforms, implementing a .down_pwr() method
Date: Thu, 01 Dec 2011 12:48:51 -0500
Message-ID: <87d3c8mbcs.fsf@laptop.org>
References: <Pine.LNX.4.64.1111161009060.1100@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38364 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab1LARsp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 12:48:45 -0500
In-Reply-To: <Pine.LNX.4.64.1111161009060.1100@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 16 Nov 2011 10:10:41 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Nov 16 2011, Guennadi Liakhovetski wrote:
> Do not power down the card in .set_ios(), unless MMC_POWER_OFF is 
> requested. This fixes the MMCIF interface functionality on ecovec boards.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mmc/host/sh_mmcif.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 557886b..c021482 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -895,7 +895,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		if (host->power) {
>  			pm_runtime_put(&host->pd->dev);
>  			host->power = false;
> -			if (p->down_pwr)
> +			if (p->down_pwr && ios->power_mode == MMC_POWER_OFF)
>  				p->down_pwr(host->pd);
>  		}
>  		host->state = STATE_IDLE;

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
