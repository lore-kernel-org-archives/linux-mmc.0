From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 23/25] mmc: sdhci: prepare DMA address/size quirk handling
 consolidation
Date: Tue, 26 Jan 2016 13:41:09 +0000
Message-ID: <E1aO3rp-0005jy-GQ@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36897 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965242AbcAZNlM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:41:12 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Prepare to consolidate the DMA address/size quirk handling into one
single loop.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 30a790ee74f5..12d53009a6f8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -733,23 +733,24 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	 * scatterlist.
 	 */
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		int broken, i;
 		struct scatterlist *sg;
+		unsigned int length_mask;
+		int i;
 
-		broken = 0;
+		length_mask = 0;
 		if (host->flags & SDHCI_USE_ADMA) {
 			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE)
-				broken = 1;
+				length_mask = 3;
 		} else {
 			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_SIZE)
-				broken = 1;
+				length_mask = 3;
 		}
 
-		if (unlikely(broken)) {
+		if (unlikely(length_mask)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
-				if (sg->length & 0x3) {
+				if (sg->length & length_mask) {
 					DBG("Reverting to PIO because of transfer size (%d)\n",
-						sg->length);
+					    sg->length);
 					host->flags &= ~SDHCI_REQ_USE_DMA;
 					break;
 				}
@@ -762,10 +763,11 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	 * translation to device address space.
 	 */
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		int broken, i;
 		struct scatterlist *sg;
+		unsigned int offset_mask;
+		int i;
 
-		broken = 0;
+		offset_mask = 0;
 		if (host->flags & SDHCI_USE_ADMA) {
 			/*
 			 * As we use 3 byte chunks to work around
@@ -773,15 +775,15 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			 * quirk.
 			 */
 			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE)
-				broken = 1;
+				offset_mask = 3;
 		} else {
 			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR)
-				broken = 1;
+				offset_mask = 3;
 		}
 
-		if (unlikely(broken)) {
+		if (unlikely(offset_mask)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
-				if (sg->offset & 0x3) {
+				if (sg->offset & offset_mask) {
 					DBG("Reverting to PIO because of bad alignment\n");
 					host->flags &= ~SDHCI_REQ_USE_DMA;
 					break;
-- 
2.1.0

