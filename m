From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: HSMMC cmd line reset change
Date: Fri, 17 Sep 2010 08:48:03 -0700
Message-ID: <20100917154803.GB29610@atomide.com>
References: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57696 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab0IQPsK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2010 11:48:10 -0400
Content-Disposition: inline
In-Reply-To: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

* Madhusudhan Chikkature <madhu.cr@ti.com> [100915 16:50]:
> OMAP4: HSMMC cmd line reset change
> 
> The cmd line reset logic is changed in OMAP4 ES2. The new procedure
> is to monitor a 0->1 transition and then 1->0 transition.The earlier
> logic would fail on ES2 chips because the loop could exit even before
> the reset is actually complete.
> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4526d27..750ba7d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -976,12 +976,19 @@ static inline void omap_hsmmc_reset_controller_fsm(struct
> omap_hsmmc_host *host,
>  						   unsigned long bit)
>  {
>  	unsigned long i = 0;
> +	unsigned long j = 0;
>  	unsigned long limit = (loops_per_jiffy *
>  				msecs_to_jiffies(MMC_TIMEOUT_MS));
> 
>  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
>  			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
> 
> +	if (cpu_is_omap44xx() && bit == SRC) {
> +		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
> +				&& (j++ < limit))
> +			cpu_relax();
> +	}
> +
>  	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
>  		(i++ < limit))
>  		cpu_relax();

Please don't use cpu_is_omapxxxx tests in the drivers, drivers
should be generic.

Instead, just pass a feature flag in the platform_data for this
feature like HSMMC_REVERSE_RESET_LOGIC or similar.

Even better, look at the mmc silicon revision number and set this
flag automatically during the driver init if possible.

Regards,

Tony
