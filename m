From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] MMC: OMAP: HSMMC: Remove unused iclk
Date: Wed, 22 Jun 2011 18:27:37 +0200
Message-ID: <4E0217F9.9070105@ti.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1308752314-32079-4-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Hilman, Kevin" <khilman@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 6/22/2011 4:18 PM, Krishnamoorthy, Balaji T wrote:
> After runtime conversion to handle clk,
> iclk node is not used
> However fclk node is still used to get clock rate.
>
> Signed-off-by: Balaji T K<balajitk@ti.com>
> ---
>   drivers/mmc/host/omap_hsmmc.c |   10 ----------
>   1 files changed, 0 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 5b81d8b..afcca36 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -145,7 +145,6 @@ struct omap_hsmmc_host {
>   	struct	mmc_command	*cmd;
>   	struct	mmc_data	*data;
>   	struct	clk		*fclk;
> -	struct	clk		*iclk;
>   	struct	clk		*dbclk;
>   	/*
>   	 * vcc == configured supply
> @@ -1855,17 +1854,10 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>
>   	spin_lock_init(&host->irq_lock);
>
> -	host->iclk = clk_get(&pdev->dev, "ick");
> -	if (IS_ERR(host->iclk)) {
> -		ret = PTR_ERR(host->iclk);
> -		host->iclk = NULL;
> -		goto err1;
> -	}
>   	host->fclk = clk_get(&pdev->dev, "fck");
>   	if (IS_ERR(host->fclk)) {
>   		ret = PTR_ERR(host->fclk);
>   		host->fclk = NULL;
> -		clk_put(host->iclk);
>   		goto err1;
>   	}
>
> @@ -2025,7 +2017,6 @@ err_irq:
>   	pm_runtime_mark_last_busy(host->dev);
>   	pm_runtime_put_autosuspend(host->dev);
>   	clk_put(host->fclk);

Since you just have to use the clk_get_rate, you can remove as well all 
the clock related functions for the fck node: clk_put / clk_enable...

> -	clk_put(host->iclk);
>   	if (host->got_dbclk) {
>   		clk_disable(host->dbclk);
>   		clk_put(host->dbclk);
> @@ -2062,7 +2053,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>   		pm_runtime_forbid(host->dev);
>   		pm_runtime_disable(host->dev);
>   		clk_put(host->fclk);

Here as well.

Regards,
Benoit
