From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 6/8] sdhci: Turn host->lock into a mutex
Date: Sat, 24 Aug 2013 21:58:30 -0400
Message-ID: <874naev8e1.fsf@octavius.laptop.org>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
	<1373384652-21958-7-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39054 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157Ab3HYB6g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 21:58:36 -0400
In-Reply-To: <1373384652-21958-7-git-send-email-jeremie.samuel.ext@parrot.com>
	(Jeremie Samuel's message of "Tue, 9 Jul 2013 17:44:10 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: linux-mmc@vger.kernel.org, matthieu.castet@parrot.com, gregor.boirie@parrot.com, Anton Vorontsov <avorontsov@mvista.com>

Hi Jeremie, I'm sorry for a very late review.

On Tue, Jul 09 2013, Jeremie Samuel wrote:
> @@ -118,7 +119,7 @@ struct sdhci_host {
>  	enum led_brightness brightness;
>  #endif
>  
> -	spinlock_t lock;	/* Mutex */
> +	struct mutex lock;	/* Mutex */
>  
>  	int flags;		/* Host attributes */
>  #define SDHCI_USE_SDMA		(1<<0)	/* Host is SDMA capable */

I think you need to modify many of the drivers/mmc/host/sdhci-*
drivers too -- for example:

sdhci-pxav3.c:

static int sdhci_pxav3_runtime_suspend(struct device *dev)
{
        struct sdhci_host *host = dev_get_drvdata(dev);
        struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
        unsigned long flags;

        if (pltfm_host->clk) {
                spin_lock_irqsave(&host->lock, flags);
[...]


sdhci-s3c.c:

static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
{
        struct sdhci_host *host = platform_get_drvdata(dev);
#ifdef CONFIG_PM_RUNTIME
        struct sdhci_s3c *sc = sdhci_priv(host);
#endif
        unsigned long flags;

        if (host) {
                spin_lock_irqsave(&host->lock, flags);
[...]


Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
