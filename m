From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 5/7] mmc: host: sdhci: Remove redundant sg_count member of struct sdhci_host
Date: Mon, 22 Jul 2019 21:09:40 +0800
Message-ID: <b34528f0248ce537ec020373f96aa6d486dc6f6d.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The mmc_data structure has a member to save the mapped sg count, so
no need introduce a redundant sg_count of struct sdhci_host, remove it.
This is also a preparation patch to support ADMA3 transfer mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |   12 +++++-------
 drivers/mmc/host/sdhci.h |    2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5760b7c..9fec82f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -696,7 +696,7 @@ static void sdhci_adma_mark_end(void *desc)
 }
 
 static void sdhci_adma_table_pre(struct sdhci_host *host,
-	struct mmc_data *data, int sg_count)
+	struct mmc_data *data)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -710,14 +710,12 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	 * We currently guess that it is LE.
 	 */
 
-	host->sg_count = sg_count;
-
 	desc = host->adma_table;
 	align = host->align_buffer;
 
 	align_addr = host->align_addr;
 
-	for_each_sg(data->sg, sg, host->sg_count, i) {
+	for_each_sg(data->sg, sg, data->sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
 
@@ -788,7 +786,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		bool has_unaligned = false;
 
 		/* Do a quick scan of the SG list for any unaligned mappings */
-		for_each_sg(data->sg, sg, host->sg_count, i)
+		for_each_sg(data->sg, sg, data->sg_count, i)
 			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 				has_unaligned = true;
 				break;
@@ -800,7 +798,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 			align = host->align_buffer;
 
-			for_each_sg(data->sg, sg, host->sg_count, i) {
+			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
@@ -1094,7 +1092,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			WARN_ON(1);
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
-			sdhci_adma_table_pre(host, data, sg_cnt);
+			sdhci_adma_table_pre(host, data);
 
 			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
 			if (host->flags & SDHCI_USE_64_BIT_DMA)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 010cc29..4548d9c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -584,8 +584,6 @@ struct sdhci_host {
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
 
-	int sg_count;		/* Mapped sg entries */
-
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 	void *integr_table;	/* ADMA3 intergrate descriptor table */
-- 
1.7.9.5
