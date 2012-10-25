From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] mmc: omap_hsmmc: remove warning message for
 debounce clock
Date: Thu, 25 Oct 2012 09:12:32 -0700
Message-ID: <20121025161231.GO11928@atomide.com>
References: <1351180715-26761-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351180715-26761-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, svenkatr@ti.com
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [121025 09:00]:
> MMC debounce clock is applicable only for omap2430, warning message gets
> printed when enable fails for debounce clock. Remove the get debounce clock
> failure message as it is noisy for other platforms.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>

This would be good to get in during the -rc cycle if possible to remove
the bogus warnings on non-2430 omaps. But since it's been there for a
long time, we can wait too if needed.

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 54bfd0c..9a4ef4d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1816,7 +1816,6 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>  	 * MMC can still work without debounce clock.
>  	 */
>  	if (IS_ERR(host->dbclk)) {
> -		dev_warn(mmc_dev(host->mmc), "Failed to get debounce clk\n");
>  		host->dbclk = NULL;
>  	} else if (clk_prepare_enable(host->dbclk) != 0) {
>  		dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
