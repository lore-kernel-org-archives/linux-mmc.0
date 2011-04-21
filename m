From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: tmio: fix a recent regression: restore .set_ios(MMC_POWER_UP) handling
Date: Thu, 21 Apr 2011 11:35:40 -0400
Message-ID: <m37hanaa7n.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1104210903250.6893@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56056 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab1DUPbt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 11:31:49 -0400
In-Reply-To: <Pine.LNX.4.64.1104210903250.6893@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 21 Apr 2011 09:09:59 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>, Paul Parsons <lost.distance@yahoo.com>

Hi,

On Thu, Apr 21 2011, Guennadi Liakhovetski wrote:
> The aggressive clock gating for TMIO MMC patch has broken switching
> interface power on, using MFD or platform callbacks. Restore the
> ios->power_mode == MMC_POWER_UP && ios->clock == 0 case handling.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> This one should go in 2.6.39
>
>  drivers/mmc/host/tmio_mmc_pio.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 6e3271d..f4fac9f 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -772,15 +772,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		tmio_mmc_set_clock(host, ios->clock);
>  
>  	/* Power sequence - OFF -> UP -> ON */
> -	if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
> +	if (ios->power_mode == MMC_POWER_UP) {
> +		/* power up SD bus */
> +		if (host->set_pwr)
> +			host->set_pwr(host->pdev, 1);
> +	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
>  		/* power down SD bus */
>  		if (ios->power_mode == MMC_POWER_OFF && host->set_pwr)
>  			host->set_pwr(host->pdev, 0);
>  		tmio_mmc_clk_stop(host);
> -	} else if (ios->power_mode == MMC_POWER_UP) {
> -		/* power up SD bus */
> -		if (host->set_pwr)
> -			host->set_pwr(host->pdev, 1);
>  	} else {
>  		/* start bus clock */
>  		tmio_mmc_clk_start(host);

Thanks, pushed to mmc-next for .39.

Paul Parsons (CC'd) submitted a similar patch to fix the same regression.
Paul, please could you check that Guennadi's patch fixes your problem?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
