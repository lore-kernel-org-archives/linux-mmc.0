From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 23/24] mmc: sdhci: consolidate the DMA/ADMA size/address
 quicks
Date: Mon, 21 Dec 2015 11:42:19 +0000
Message-ID: <E1aAyr5-00018D-K2@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39742 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbLULm2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:42:28 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Rather than scanning the scatterlist multiple times for each quirk,
scan it once, checking for each possible quirk.  This should be
cheaper due to the length and offset members commonly sharing the
same cache line than scanning the scatterlist multiple times.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 474d96943560..ce1259f2add3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -728,22 +728,35 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/*
 	 * FIXME: This doesn't account for merging when mapping the
 	 * scatterlist.
+	 *
+	 * The assumption here being that alignment and lengths are
+	 * the same after DMA mapping to device address space.
 	 */
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		struct scatterlist *sg;
-		unsigned int length_mask;
+		unsigned int length_mask, offset_mask;
 		int i;
 
 		length_mask = 0;
+		offset_mask = 0;
 		if (host->flags & SDHCI_USE_ADMA) {
-			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE)
+			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE) {
 				length_mask = 3;
+				/*
+				 * As we use up to 3 byte chunks to work
+				 * around alignment problems, we need to
+				 * check the offset as well.
+				 */
+				offset_mask = 3;
+			}
 		} else {
 			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_SIZE)
 				length_mask = 3;
+			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR)
+				offset_mask = 3;
 		}
 
-		if (unlikely(length_mask)) {
+		if (unlikely(length_mask | offset_mask)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
 				if (sg->length & length_mask) {
 					DBG("Reverting to PIO because of "
@@ -752,35 +765,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					host->flags &= ~SDHCI_REQ_USE_DMA;
 					break;
 				}
-			}
-		}
-	}
-
-	/*
-	 * The assumption here being that alignment is the same after
-	 * translation to device address space.
-	 */
-	if (host->flags & SDHCI_REQ_USE_DMA) {
-		struct scatterlist *sg;
-		unsigned int offset_mask;
-		int i;
-
-		offset_mask = 0;
-		if (host->flags & SDHCI_USE_ADMA) {
-			/*
-			 * As we use 3 byte chunks to work around
-			 * alignment problems, we need to check this
-			 * quirk.
-			 */
-			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE)
-				offset_mask = 3;
-		} else {
-			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR)
-				offset_mask = 3;
-		}
-
-		if (unlikely(offset_mask)) {
-			for_each_sg(data->sg, sg, data->sg_len, i) {
 				if (sg->offset & offset_mask) {
 					DBG("Reverting to PIO because of "
 						"bad alignment\n");
-- 
2.1.0

