From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-s3c: revert "fix missing clock for gpio card-detect"
Date: Thu, 29 Aug 2013 21:22:29 -0400
Message-ID: <871u5cx99m.fsf@octavius.laptop.org>
References: <51FBBD7D.2020203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44752 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab3H3BWe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Aug 2013 21:22:34 -0400
In-Reply-To: <51FBBD7D.2020203@samsung.com> (Jaehoon Chung's message of "Fri,
	02 Aug 2013 23:09:01 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>

Hi,

On Fri, Aug 02 2013, Jaehoon Chung wrote:
> Fixed the warning message.(clk_disable/enable didn't pair)
> [..]
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changelog v2:
> 	- Added acked/tested by Heiko (on s3c2416)
>
>  drivers/mmc/host/sdhci-s3c.c |    9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 6debda9..f974778 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -373,27 +373,18 @@ static struct sdhci_ops sdhci_s3c_ops = {
>  static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(dev);
> -#ifdef CONFIG_PM_RUNTIME
> -	struct sdhci_s3c *sc = sdhci_priv(host);
> -#endif
>  	unsigned long flags;
>  
>  	if (host) {
>  		spin_lock_irqsave(&host->lock, flags);
>  		if (state) {
>  			dev_dbg(&dev->dev, "card inserted.\n");
> -#ifdef CONFIG_PM_RUNTIME
> -			clk_prepare_enable(sc->clk_io);
> -#endif
>  			host->flags &= ~SDHCI_DEVICE_DEAD;
>  			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  		} else {
>  			dev_dbg(&dev->dev, "card removed.\n");
>  			host->flags |= SDHCI_DEVICE_DEAD;
>  			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> -#ifdef CONFIG_PM_RUNTIME
> -			clk_disable_unprepare(sc->clk_io);
> -#endif
>  		}
>  		tasklet_schedule(&host->card_tasklet);
>  		spin_unlock_irqrestore(&host->lock, flags);

Jaehoon/Heiko, it looks this patch was itself a bug fix -- can we
not find a way to support cd-gpios and runtime PM at the same time?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
