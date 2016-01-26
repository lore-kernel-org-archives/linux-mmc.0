From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 13/25] mmc: sdhci: move sdhci_pre_dma_transfer()
Date: Tue, 26 Jan 2016 13:40:16 +0000
Message-ID: <E1aO3qy-0005iq-SH@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36876 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965242AbcAZNkf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:40:35 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Move sdhci_pre_dma_transfer() to avoid needing to declare this function
before use.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 52 +++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a7b0ef0196a..f260804d3d65 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -53,8 +53,6 @@ static void sdhci_finish_data(struct sdhci_host *);
 static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-static int sdhci_pre_dma_transfer(struct sdhci_host *host,
-					struct mmc_data *data);
 static int sdhci_do_get_cd(struct sdhci_host *host);
 
 #ifdef CONFIG_PM
@@ -428,6 +426,31 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
 	DBG("PIO transfer complete.\n");
 }
 
+static int sdhci_pre_dma_transfer(struct sdhci_host *host,
+				  struct mmc_data *data)
+{
+	int sg_count;
+
+	if (data->host_cookie == COOKIE_MAPPED) {
+		data->host_cookie = COOKIE_GIVEN;
+		return data->sg_count;
+	}
+
+	WARN_ON(data->host_cookie == COOKIE_GIVEN);
+
+	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				data->flags & MMC_DATA_WRITE ?
+				DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	if (sg_count == 0)
+		return -ENOSPC;
+
+	data->sg_count = sg_count;
+	data->host_cookie = COOKIE_MAPPED;
+
+	return sg_count;
+}
+
 static char *sdhci_kmap_atomic(struct scatterlist *sg, unsigned long *flags)
 {
 	local_irq_save(*flags);
@@ -2070,31 +2093,6 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	}
 }
 
-static int sdhci_pre_dma_transfer(struct sdhci_host *host,
-				       struct mmc_data *data)
-{
-	int sg_count;
-
-	if (data->host_cookie == COOKIE_MAPPED) {
-		data->host_cookie = COOKIE_GIVEN;
-		return data->sg_count;
-	}
-
-	WARN_ON(data->host_cookie == COOKIE_GIVEN);
-
-	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				data->flags & MMC_DATA_WRITE ?
-				DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-	if (sg_count == 0)
-		return -ENOSPC;
-
-	data->sg_count = sg_count;
-	data->host_cookie = COOKIE_MAPPED;
-
-	return sg_count;
-}
-
 static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 			       bool is_first_req)
 {
-- 
2.1.0

