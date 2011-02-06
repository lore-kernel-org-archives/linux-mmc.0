From: Chris Ball <cjb@laptop.org>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 6 Feb 2011 01:50:03 +0000
Message-ID: <20110206015003.GA15576@void.printf.net>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com> <20110206003845.GA15019@void.printf.net> <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com> <20110206011514.GA15322@void.printf.net> <173274DF-475D-44FB-8C34-25728D12ADBB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44935 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab1BFBuH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Feb 2011 20:50:07 -0500
Content-Disposition: inline
In-Reply-To: <173274DF-475D-44FB-8C34-25728D12ADBB@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Albert Herranz <albert_herranz@yahoo.es>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Sat, Feb 05, 2011 at 05:35:46PM -0800, Philip Rakity wrote:
> 
> proposed solution:  I cannot verify this fix until Monday.
> =====
> 
> CMD52 is a reset for SDIO cards.  CMD0 is not sufficient when
> the card is being re-initialized.  Only send CMD52 if
> a) doing a reinitialize
> b) card is SDIO or SDIO_COMBO
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/core/core.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 30d4da4..f0ce6f6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1521,7 +1521,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>  		mmc_hostname(host), __func__, host->f_init);
>  #endif
>  	mmc_power_up(host);
> -	sdio_reset(host);
> +
> +	/* reset sdio before CMD0 when card is being reinitialized */
> +	if (host->card &&
> +		(host->card->type == MMC_TYPE_SDIO ||
> +		host->card->type == MMC_TYPE_SD_COMBO))
> +			sdio_reset(host);
>  	mmc_go_idle(host);
>  	mmc_hwungate_clock(host);
>  

Thanks.  We have macros for this, but need to add one for combo cards.
include/linux/mmc/card.h should get:

#define mmc_card_sd_combo(c)    ((c)->type == MMC_TYPE_SD_COMBO)

and then:

	/* reset sdio before CMD0 when card is being reinitialized */
	if (host->card && (mmc_card_sdio(host->card) || 
			   mmc_card_sd_combo(host->card)))
		sdio_reset(host);

(FYI your hwgate patches are applied above but aren't in mainline yet.)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
