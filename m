From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4: hsmmc: Fix improper card detection while booting
Date: Tue, 16 Nov 2010 10:08:33 -0800
Message-ID: <20101116180833.GX9264@atomide.com>
References: <6576.10.24.255.17.1289812139.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6576.10.24.255.17.1289812139.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* kishore kadiyala <kishore.kadiyala@ti.com> [101115 00:59]:
> While booting OMAP4 ES2.0 boards, cards on MMC1 and MMC2 controllers
> are not getting detected some times.
> 
> During reset of command/data line, wrong pointer to base address
> was passed while read operation to SYSCTL register, thus impacting
> the updated reset logic.
> Passing correct base address fixes the issue.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Acked-by: Felipie Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Chris Ball   <cjb@laptop.org>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>

Good find:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 82a1079..5d46021 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1002,7 +1002,7 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host
> *host,
>  	 * Monitor a 0->1 transition first
>  	 */
>  	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
> -		while ((!(OMAP_HSMMC_READ(host, SYSCTL) & bit))
> +		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>  					&& (i++ < limit))
>  			cpu_relax();
>  	}
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
