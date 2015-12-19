From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 12/17] mmc: sdhci: factor out sdhci_pre_dma_transfer() from
 sdhci_adma_table_pre()
Date: Sat, 19 Dec 2015 20:31:05 +0000
Message-ID: <E1aAO9h-0007zB-5g@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36173 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbbLSUbb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:31:31 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

In sdhci_prepare_data(), when SDHCI_REQ_USE_DMA is set, there are two
paths that prepare the data buffers for transfer.  One is when
SDHCI_USE_ADMA is set, and is located inside sdhci_adma_table_pre().
The other is when SDHCI_USE_ADMA is clear, in the else clause of the
above.

Factor out the call to sdhci_pre_dma_transfer() along with its error
checking.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 62 ++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 239581ea6856..d7cc61101a1a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -485,8 +485,8 @@ static void sdhci_adma_mark_end(void *desc)
 	dma_desc->cmd |= cpu_to_le16(ADMA2_END);
 }
 
-static int sdhci_adma_table_pre(struct sdhci_host *host,
-	struct mmc_data *data)
+static void sdhci_adma_table_pre(struct sdhci_host *host,
+	struct mmc_data *data, int sg_count)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -500,9 +500,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 	 * We currently guess that it is LE.
 	 */
 
-	host->sg_count = sdhci_pre_dma_transfer(host, data);
-	if (host->sg_count < 0)
-		return -EINVAL;
+	host->sg_count = sg_count;
 
 	desc = host->adma_table;
 	align = host->align_buffer;
@@ -566,7 +564,6 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		/* Add a terminating entry - nop, end, valid */
 		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
-	return 0;
 }
 
 static void sdhci_adma_table_post(struct sdhci_host *host,
@@ -696,7 +693,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
 	struct mmc_data *data = cmd->data;
-	int ret;
 
 	WARN_ON(host->data);
 
@@ -783,39 +779,27 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		if (host->flags & SDHCI_USE_ADMA) {
-			ret = sdhci_adma_table_pre(host, data);
-			if (ret) {
-				/*
-				 * This only happens when someone fed
-				 * us an invalid request.
-				 */
-				WARN_ON(1);
-				host->flags &= ~SDHCI_REQ_USE_DMA;
-			} else {
-				sdhci_writel(host, host->adma_addr,
-					SDHCI_ADMA_ADDRESS);
-				if (host->flags & SDHCI_USE_64_BIT_DMA)
-					sdhci_writel(host,
-						     (u64)host->adma_addr >> 32,
-						     SDHCI_ADMA_ADDRESS_HI);
-			}
-		} else {
-			int sg_cnt;
+		int sg_cnt = sdhci_pre_dma_transfer(host, data);
 
-			sg_cnt = sdhci_pre_dma_transfer(host, data);
-			if (sg_cnt <= 0) {
-				/*
-				 * This only happens when someone fed
-				 * us an invalid request.
-				 */
-				WARN_ON(1);
-				host->flags &= ~SDHCI_REQ_USE_DMA;
-			} else {
-				WARN_ON(sg_cnt != 1);
-				sdhci_writel(host, sg_dma_address(data->sg),
-					SDHCI_DMA_ADDRESS);
-			}
+		if (sg_cnt <= 0) {
+			/*
+			 * This only happens when someone fed
+			 * us an invalid request.
+			 */
+			WARN_ON(1);
+			host->flags &= ~SDHCI_REQ_USE_DMA;
+		} else if (host->flags & SDHCI_USE_ADMA) {
+			sdhci_adma_table_pre(host, data, sg_cnt);
+
+			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
+			if (host->flags & SDHCI_USE_64_BIT_DMA)
+				sdhci_writel(host,
+					     (u64)host->adma_addr >> 32,
+					     SDHCI_ADMA_ADDRESS_HI);
+		} else {
+			WARN_ON(sg_cnt != 1);
+			sdhci_writel(host, sg_dma_address(data->sg),
+				SDHCI_DMA_ADDRESS);
 		}
 	}
 
-- 
2.1.0

