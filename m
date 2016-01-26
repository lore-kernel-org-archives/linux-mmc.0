From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 24/25] mmc: sdhci: consolidate the DMA/ADMA size/address
 quicks
Date: Tue, 26 Jan 2016 13:41:14 +0000
Message-ID: <E1aO3ru-0005k4-RX@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36903 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965242AbcAZNlT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:41:19 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Rather than scanning the scatterlist multiple times for each quirk,
scan it once, checking for each possible quirk.  This should be
cheaper due to the length and offset members commonly sharing the
same cache line than scanning the scatterlist multiple times.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 12d53009a6f8..92ceceb47b74 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -731,22 +731,35 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
 					DBG("Reverting to PIO because of transfer size (%d)\n",
@@ -754,35 +767,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
 					DBG("Reverting to PIO because of bad alignment\n");
 					host->flags &= ~SDHCI_REQ_USE_DMA;
-- 
2.1.0

