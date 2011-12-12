From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 3/5] mmc: mmci: Add constraints on alignment for SDIO
Date: Mon, 12 Dec 2011 16:36:05 +0100
Message-ID: <1323704167-10247-4-git-send-email-ulf.hansson@stericsson.com>
References: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:48515 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303Ab1LLPgm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 10:36:42 -0500
In-Reply-To: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

From: Per Forlin <per.forlin@stericsson.com>

Buffers must be 4-byte aligned due to restrictions that the
PL18x FIFO accesses must be done in a 4-byte aligned manner.

Moreover DPSM_DMAREQCTL must be enabled for SDIO to support
writes for non 32-byte aligned sg element lengths. In PIO
mode any buffer length can be handled as long as the buffer
address is 4-byte aligned.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   51 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |    7 ++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b949e07..9ea2f13 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -45,6 +45,7 @@ static unsigned int fmax = 515633;
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
+ * @dma_sdio_req_ctrl: enable value for DMAREQCTL register for SDIO write
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -60,6 +61,7 @@ static unsigned int fmax = 515633;
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
+	unsigned int		dma_sdio_req_ctrl;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
@@ -102,6 +104,7 @@ static struct variant_data variant_ux500 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.dma_sdio_req_ctrl	= MCI_ST_DPSM_DMAREQCTL,
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
@@ -114,6 +117,7 @@ static struct variant_data variant_ux500v2 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.dma_sdio_req_ctrl	= MCI_ST_DPSM_DMAREQCTL,
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
@@ -123,6 +127,30 @@ static struct variant_data variant_ux500v2 = {
 };
 
 /*
+ * Validate mmc prerequisites
+ */
+static int mmci_validate_data(struct mmci_host *host,
+			      struct mmc_data *data)
+{
+	if (!data)
+		return 0;
+
+	if (!is_power_of_2(data->blksz)) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported block size (%d bytes)\n", data->blksz);
+		return -EINVAL;
+	}
+
+	if (data->sg->offset & 3) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported alignment (0x%x)\n", data->sg->offset);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
  * This must be called with host->lock held
  */
 static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
@@ -432,8 +460,12 @@ static int mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	if (!chan)
 		return -EINVAL;
 
-	/* If less than or equal to the fifo size, don't bother with DMA */
-	if (data->blksz * data->blocks <= variant->fifosize)
+	/*
+	 * If less than or equal to the fifo size, don't bother with DMA.
+	 * SDIO transfers may not be 4-byte aligned, fall back to PIO.
+	 */
+	if (data->blksz * data->blocks <= variant->fifosize ||
+	    (data->blksz * data->blocks) & 3)
 		return -EINVAL;
 
 	device = chan->device;
@@ -468,6 +500,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	int ret;
 	struct mmc_data *data = host->data;
+	struct variant_data *variant = host->variant;
 
 	ret = mmci_dma_prep_data(host, host->data, NULL);
 	if (ret)
@@ -482,6 +515,11 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 	datactrl |= MCI_DPSM_DMAENABLE;
 
+	/* Some hardware versions need special flags for SDIO DMA write. */
+	if (variant->sdio && host->mmc->card && mmc_card_sdio(host->mmc->card)
+	    && (data->flags & MMC_DATA_WRITE))
+		datactrl |= variant->dma_sdio_req_ctrl;
+
 	/* Trigger the DMA transfer */
 	writel(datactrl, host->base + MMCIDATACTRL);
 
@@ -526,6 +564,9 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (!data)
 		return;
 
+	if (mmci_validate_data(host, mrq->data))
+		return;
+
 	if (data->host_cookie) {
 		data->host_cookie = 0;
 		return;
@@ -1019,10 +1060,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(host->mrq != NULL);
 
-	if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
-		dev_err(mmc_dev(mmc), "unsupported block size (%d bytes)\n",
-			mrq->data->blksz);
-		mrq->cmd->error = -EINVAL;
+	mrq->cmd->error = mmci_validate_data(host, mrq->data);
+	if (mrq->cmd->error) {
 		mmc_request_done(mmc, mrq);
 		return;
 	}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d437ccf..095c01c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -60,6 +60,13 @@
 #define MCI_ST_DPSM_RWMOD	(1 << 10)
 #define MCI_ST_DPSM_SDIOEN	(1 << 11)
 /* Control register extensions in the ST Micro Ux500 versions */
+/*
+ * DMA request control is required for write
+ * if transfer size is not 32-byte aligned.
+ * DMA request control is also needed if the total
+ * transfer size is 32-byte aligned but any of the
+ * sg element lengths are not 32-byte aligned.
+ */
 #define MCI_ST_DPSM_DMAREQCTL	(1 << 12)
 #define MCI_ST_DPSM_DBOOTMODEEN	(1 << 13)
 #define MCI_ST_DPSM_BUSYMODE	(1 << 14)
-- 
1.7.5.4

