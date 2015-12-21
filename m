From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 22/24] mmc: sdhci: prepare DMA address/size quirk handling
 consolidation
Date: Mon, 21 Dec 2015 11:42:14 +0000
Message-ID: <E1aAyr0-000186-Fg@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39736 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbLULmU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:42:20 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Prepare to consolidate the DMA address/size quirk handling into one
single loop.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 65b230ea179e..474d96943560 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -730,21 +730,22 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
 					DBG("Reverting to PIO because of "
 						"transfer size (%d)\n",
 						sg->length);
@@ -760,10 +761,11 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
@@ -771,15 +773,15 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
 					DBG("Reverting to PIO because of "
 						"bad alignment\n");
 					host->flags &= ~SDHCI_REQ_USE_DMA;
-- 
2.1.0

