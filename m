From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 12/25] mmc: sdhci: factor out common DMA cleanup in
 sdhci_finish_data()
Date: Fri, 29 Jan 2016 09:44:47 +0000
Message-ID: <E1aP5bj-0001ph-Bw@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44241 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbcA2JpF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:45:05 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

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
index 9b56bb5546bf..49692b7b4016 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -552,19 +552,12 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
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
 
@@ -577,7 +570,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 		if (has_unaligned) {
 			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
-				data->sg_len, direction);
+					    data->sg_len, DMA_FROM_DEVICE);
 
 			align = host->align_buffer;
 
@@ -595,12 +588,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
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
@@ -909,14 +896,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
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

