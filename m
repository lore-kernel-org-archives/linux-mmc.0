From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 11/24] mmc: sdhci: factor out common DMA cleanup in
 sdhci_finish_data()
Date: Mon, 21 Dec 2015 11:41:18 +0000
Message-ID: <E1aAyq6-00016x-2Q@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39726 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbLULlp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:41:45 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

sdhci_finish_data() has two paths which result in identical DMA cleanup.
One is when SDHCI_USE_ADMA is clear, and the other is just before when
SDHCI_USE_ADMA is set, and is performed within sdhci_adma_table_post().

Simplify the code by removing the 'else' and eliminating the duplicate
inside sdhci_adma_table_post().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 90ad6fd8bb65..d315273d1184 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -549,19 +549,12 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 static void sdhci_adma_table_post(struct sdhci_host *host,
 	struct mmc_data *data)
 {
-	int direction;
-
 	struct scatterlist *sg;
 	int i, size;
 	void *align;
 	char *buffer;
 	unsigned long flags;
 
-	if (data->flags & MMC_DATA_READ)
-		direction = DMA_FROM_DEVICE;
-	else
-		direction = DMA_TO_DEVICE;
-
 	if (data->flags & MMC_DATA_READ) {
 		bool has_unaligned = false;
 
@@ -574,7 +567,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 		if (has_unaligned) {
 			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
-				data->sg_len, direction);
+					    data->sg_len, DMA_FROM_DEVICE);
 
 			align = host->align_buffer;
 
@@ -592,12 +585,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 			}
 		}
 	}
-
-	if (data->host_cookie == COOKIE_MAPPED) {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-			data->sg_len, direction);
-		data->host_cookie = COOKIE_UNMAPPED;
-	}
 }
 
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
@@ -908,14 +895,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		if (host->flags & SDHCI_USE_ADMA)
 			sdhci_adma_table_post(host, data);
-		else {
-			if (data->host_cookie == COOKIE_MAPPED) {
-				dma_unmap_sg(mmc_dev(host->mmc),
-					data->sg, data->sg_len,
-					(data->flags & MMC_DATA_READ) ?
-					DMA_FROM_DEVICE : DMA_TO_DEVICE);
-				data->host_cookie = COOKIE_UNMAPPED;
-			}
+
+		if (data->host_cookie == COOKIE_MAPPED) {
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				     (data->flags & MMC_DATA_READ) ?
+				     DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			data->host_cookie = COOKIE_UNMAPPED;
 		}
 	}
 
-- 
2.1.0

