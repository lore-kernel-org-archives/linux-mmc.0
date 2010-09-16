From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] OMAP4: HSMMC cmd line reset change
Date: Thu, 16 Sep 2010 22:27:55 +0100
Message-ID: <20100916212754.GA24253@void.printf.net>
References: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49953 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab0IPV14 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Sep 2010 17:27:56 -0400
Content-Disposition: inline
In-Reply-To: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

Hi Madhu,

On Thu, Sep 16, 2010 at 05:28:11AM +0530, Madhusudhan Chikkature wrote:
> OMAP4: HSMMC cmd line reset change

Please don't repeat the subject line like this -- "git am" will put it
into the patch twice.  You can either leave the subject line out of the
body of the mail altogether, or put "Subject: " in front of it.

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

(This was line-wrapped, I fixed it.)

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
> -- 
> 1.7.0.4

Thanks, pushed to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
