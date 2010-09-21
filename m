From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: fix incorrect spinlock usage after merge
Date: Tue, 21 Sep 2010 04:15:49 +0100
Message-ID: <20100921031547.GA7073@void.printf.net>
References: <1284987822-17955-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45410 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab0IUDP4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Sep 2010 23:15:56 -0400
Content-Disposition: inline
In-Reply-To: <1284987822-17955-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, akpm@linux-foundation.org, w.sang@pengutronix.de

Hi Ben,

On Mon, Sep 20, 2010 at 03:03:42PM +0200, Marek Szyprowski wrote:
> In the commit f522886e202a34a2191dd5d471b3c4d46410a9a0 a merge conflict
> in the sdhci-s3c driver been fixed. However the fix used incorrect
> spinlock operation - it cause a race with sdhci interrupt service. The
> correct way to solve it is to use spin_lock_irqsave/irqrestore() calls.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 71ad416..735d431 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -241,8 +241,10 @@ static struct sdhci_ops sdhci_s3c_ops = {
>  static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(dev);
> +	unsigned long flags;
> +
>  	if (host) {
> -		spin_lock(&host->lock);
> +		spin_lock_irqsave(&host->lock, flags);
>  		if (state) {
>  			dev_dbg(&dev->dev, "card inserted.\n");
>  			host->flags &= ~SDHCI_DEVICE_DEAD;
> @@ -253,7 +255,7 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>  			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  		}
>  		tasklet_schedule(&host->card_tasklet);
> -		spin_unlock(&host->lock);
> +		spin_unlock_irqrestore(&host->lock, flags);
>  	}
>  }
>  

Could I have your ACK on this before I send it to Linus, please?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
