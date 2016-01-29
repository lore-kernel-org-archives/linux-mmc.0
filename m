From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 11/25] mmc: sdhci: avoid walking SG list for writes
Date: Fri, 29 Jan 2016 09:44:42 +0000
Message-ID: <E1aP5be-0001pb-8I@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44235 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbcA2Jo7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:44:59 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

If we are writing data to the card, there is no point in walking the
scatterlist to find out if there are any unaligned entries; this is a
needless waste of CPU cycles.  Avoid this by checking for a non-read
tranfer first.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 774b0cf05f9d..9b56bb5546bf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -559,37 +559,39 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	void *align;
 	char *buffer;
 	unsigned long flags;
-	bool has_unaligned;
 
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
 	else
 		direction = DMA_TO_DEVICE;
 
-	/* Do a quick scan of the SG list for any unaligned mappings */
-	has_unaligned = false;
-	for_each_sg(data->sg, sg, host->sg_count, i)
-		if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
-			has_unaligned = true;
-			break;
-		}
+	if (data->flags & MMC_DATA_READ) {
+		bool has_unaligned = false;
 
-	if (has_unaligned && data->flags & MMC_DATA_READ) {
-		dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
-			data->sg_len, direction);
+		/* Do a quick scan of the SG list for any unaligned mappings */
+		for_each_sg(data->sg, sg, host->sg_count, i)
+			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
+				has_unaligned = true;
+				break;
+			}
 
-		align = host->align_buffer;
+		if (has_unaligned) {
+			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
+				data->sg_len, direction);
 
-		for_each_sg(data->sg, sg, host->sg_count, i) {
-			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
-				size = SDHCI_ADMA2_ALIGN -
-				       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
+			align = host->align_buffer;
 
-				buffer = sdhci_kmap_atomic(sg, &flags);
-				memcpy(buffer, align, size);
-				sdhci_kunmap_atomic(buffer, &flags);
+			for_each_sg(data->sg, sg, host->sg_count, i) {
+				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
+					size = SDHCI_ADMA2_ALIGN -
+					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
 
-				align += SDHCI_ADMA2_ALIGN;
+					buffer = sdhci_kmap_atomic(sg, &flags);
+					memcpy(buffer, align, size);
+					sdhci_kunmap_atomic(buffer, &flags);
+
+					align += SDHCI_ADMA2_ALIGN;
+				}
 			}
 		}
 	}
-- 
2.1.0

