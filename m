From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 6/8] mmc: omap: Remove always set use_dma flag from struct mmc_omap_host
Date: Sat, 16 Nov 2013 17:53:12 +0200
Message-ID: <1384617194-22126-6-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
 <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:47025 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3KPPxl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Nov 2013 10:53:41 -0500
In-Reply-To: <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Because use_dma is set only in mmc_omap_probe and unset nowhere there is no
need to carry that flag in struct mmc_omap_host for mmc_omap_prepare_data
function.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index c20c625..c975051 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -162,7 +162,6 @@ struct mmc_omap_host {
 	u32			total_bytes_left;
 
 	unsigned		features;
-	unsigned		use_dma:1;
 	unsigned		brs_received:1, dma_done:1;
 	unsigned		dma_in_use:1;
 	spinlock_t		dma_lock;
@@ -954,7 +953,7 @@ static void
 mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 {
 	struct mmc_data *data = req->data;
-	int i, use_dma, block_size;
+	int i, use_dma = 1, block_size;
 	unsigned sg_len;
 
 	host->data = data;
@@ -979,13 +978,10 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
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
 
@@ -1379,7 +1375,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	host->id = pdev->id;
 	host->irq = irq;
-	host->use_dma = 1;
 	host->phys_base = res->start;
 	host->iclk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(host->iclk))
-- 
1.8.4.2

