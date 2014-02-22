From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 6/7] mmc: omap: Remove always set use_dma flag from struct mmc_omap_host
Date: Sat, 22 Feb 2014 18:01:42 +0200
Message-ID: <1393084903-7194-7-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49634 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbaBVQR6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Feb 2014 11:17:58 -0500
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Because use_dma is set only in mmc_omap_probe and unset nowhere there is no
need to carry that flag in struct mmc_omap_host for mmc_omap_prepare_data
function.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index e4c7a0380a63..42175cd90435 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -152,7 +152,6 @@ struct mmc_omap_host {
 	u32			total_bytes_left;
 
 	unsigned		features;
-	unsigned		use_dma:1;
 	unsigned		brs_received:1, dma_done:1;
 	unsigned		dma_in_use:1;
 	spinlock_t		dma_lock;
@@ -944,7 +943,7 @@ static void
 mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 {
 	struct mmc_data *data = req->data;
-	int i, use_dma, block_size;
+	int i, use_dma = 1, block_size;
 	unsigned sg_len;
 
 	host->data = data;
@@ -969,13 +968,10 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 	sg_len = (data->blocks == 1) ? 1 : data->sg_len;
 
 	/* Only do DMA for entire blocks */
-	use_dma = host->use_dma;
-	if (use_dma) {
-		for (i = 0; i < sg_len; i++) {
-			if ((data->sg[i].length % block_size) != 0) {
-				use_dma = 0;
-				break;
-			}
+	for (i = 0; i < sg_len; i++) {
+		if ((data->sg[i].length % block_size) != 0) {
+			use_dma = 0;
+			break;
 		}
 	}
 
@@ -1369,7 +1365,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	host->id = pdev->id;
 	host->irq = irq;
-	host->use_dma = 1;
 	host->phys_base = res->start;
 	host->iclk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(host->iclk))
-- 
1.8.5.3

