From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RFC] mmc: omap_hsmmc: Fix the warning
Date: Tue, 07 Aug 2012 22:52:47 -0400
Message-ID: <87pq72xfgg.fsf@octavius.laptop.org>
References: <1343119640-24516-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36834 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab2HHCwv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 22:52:51 -0400
In-Reply-To: <1343119640-24516-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 24 Jul 2012 14:17:20 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

Hi,

On Tue, Jul 24 2012, Shubhrajyoti D wrote:
> The commit 9c17d08 [mmc: omap_hsmmc: ensure probe returns error upon
> resource failure] introduced the below warning.
>
>   CC      drivers/of/of_net.o
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
> drivers/mmc/host/omap_hsmmc.c:1936: warning: statement with no effect
>
> Fix the same by assigning the error value to ret.
>
> Cc: Kevin Hilman <khilman@ti.com>
> Reported-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index be8631d..3a09f93 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1933,7 +1933,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>  	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
>  	if (!host->tx_chan) {
>  		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> -		ret -ENXIO;
> +		ret = -ENXIO;
>  		goto err_irq;
>  	}

I think you must be confused -- this warning isn't present in mainline, and
the line in commit 9c17d08 is already correct:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=9c17d08ca183b92c9cfab6537069914a5e0e7e81

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a9227a7..bc28627 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1931,6 +1931,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
 	if (!res) {
 		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
+		ret = -ENXIO;
 		goto err_irq;
 	}
 	host->dma_line_tx = res->start;
@@ -1938,6 +1939,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
 		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
+		ret = -ENXIO;
 		goto err_irq;
 	}
 	host->dma_line_rx = res->start;

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
