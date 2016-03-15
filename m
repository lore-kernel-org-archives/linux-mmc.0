From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/5] mmc: davinci: don't use dma platform resources
Date: Tue, 15 Mar 2016 10:54:04 +0200
Message-ID: <56E7CDAC.1090907@ti.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-5-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------060109060607040409010707"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933944AbcCOIzx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2016 04:55:53 -0400
In-Reply-To: <1457996081-21975-5-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, nsekhar@ti.com
Cc: ulf.hansson@linaro.org, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--------------060109060607040409010707
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit

On 03/15/16 00:54, David Lechner wrote:
> The davinci arch now has dma_slave_map tables for dma resources, so it is
> no longer necessary to pass dma resources through the platform device.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes: Remove platform_get_resource completly instead of just ignoring it.
> 
> 
>  drivers/mmc/host/davinci_mmc.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 8d10a92..dc96401 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -202,7 +202,6 @@ struct mmc_davinci_host {
>  	u32 buffer_bytes_left;
>  	u32 bytes_left;
>  
> -	u32 rxdma, txdma;
>  	struct dma_chan *dma_tx;
>  	struct dma_chan *dma_rx;
>  	bool use_dma;
> @@ -520,16 +519,14 @@ static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
>  	dma_cap_set(DMA_SLAVE, mask);
>  
>  	host->dma_tx =
> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
> -				&host->txdma, mmc_dev(host->mmc), "tx");
> +		dma_request_slave_channel(mmc_dev(host->mmc), "tx");

you would need to use dma_request_chan() to be able to rely on the legacy
channel mapping.
I have staged commits for converting all daVinci and OMAP drivers, I'll attach
the patch I have for davinci-mmc for reference.
When we convert to use the dma_request_chan() we can handle deferred probing
also...



>  	if (!host->dma_tx) {
>  		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
>  		return -ENODEV;
>  	}
>  
>  	host->dma_rx =
> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
> -				&host->rxdma, mmc_dev(host->mmc), "rx");
> +		dma_request_slave_channel(mmc_dev(host->mmc), "rx");
>  	if (!host->dma_rx) {
>  		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
>  		r = -ENODEV;
> @@ -1251,18 +1248,6 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>  	host = mmc_priv(mmc);
>  	host->mmc = mmc;	/* Important */
>  
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (!r)
> -		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
> -	else
> -		host->rxdma = r->start;
> -
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (!r)
> -		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
> -	else
> -		host->txdma = r->start;
> -
>  	host->mem_res = mem;
>  	host->base = devm_ioremap(&pdev->dev, mem->start, mem_size);
>  	if (!host->base)
> 


-- 
Péter

--------------060109060607040409010707
Content-Type: text/x-patch;
	name="0001-mmc-davinci_mmc-Use-dma_request_chan-to-requesting-D.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-mmc-davinci_mmc-Use-dma_request_chan-to-requesting-D.pa";
	filename*1="tch"

>From c349c76720ffa6e203eff3865de2da8e4c0b415c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 21 Dec 2015 12:47:07 +0200
Subject: [PATCH] mmc: davinci_mmc: Use dma_request_chan() to requesting DMA
 channel

With the new dma_request_chan() the client driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the driver can now support deferred probing
against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/davinci_mmc.c | 52 ++++++++++++------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 693144e7427b..9edc37d207d2 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -32,12 +32,10 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/edma.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <linux/platform_data/edma.h>
 #include <linux/platform_data/mmc-davinci.h>
 
 /*
@@ -513,35 +511,20 @@ davinci_release_dma_channels(struct mmc_davinci_host *host)
 
 static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 {
-	int r;
-	dma_cap_mask_t mask;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->dma_tx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->txdma, mmc_dev(host->mmc), "tx");
-	if (!host->dma_tx) {
+	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
+	if (IS_ERR(host->dma_tx)) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
-		return -ENODEV;
+		return PTR_ERR(host->dma_tx);
 	}
 
-	host->dma_rx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->rxdma, mmc_dev(host->mmc), "rx");
-	if (!host->dma_rx) {
+	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
+	if (IS_ERR(host->dma_rx)) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
-		r = -ENODEV;
-		goto free_master_write;
+		dma_release_channel(host->dma_tx);
+		return PTR_ERR(host->dma_rx);
 	}
 
 	return 0;
-
-free_master_write:
-	dma_release_channel(host->dma_tx);
-
-	return r;
 }
 
 /*----------------------------------------------------------------------*/
@@ -1253,18 +1236,6 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
-	else
-		host->rxdma = r->start;
-
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
-	else
-		host->txdma = r->start;
-
 	host->mem_res = mem;
 	host->base = ioremap(mem->start, mem_size);
 	if (!host->base)
@@ -1291,8 +1262,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host->mmc_irq = irq;
 	host->sdio_irq = platform_get_irq(pdev, 1);
 
-	if (host->use_dma && davinci_acquire_dma_channels(host) != 0)
-		host->use_dma = 0;
+	if (host->use_dma) {
+		ret = davinci_acquire_dma_channels(host);
+		if (ret == -EPROBE_DEFER)
+			goto out;
+		else if (ret)
+			host->use_dma = 0;
+	}
 
 	/* REVISIT:  someday, support IRQ-driven card detection.  */
 	mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 
2.7.3


--------------060109060607040409010707--
