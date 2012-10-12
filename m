From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant
Date: Fri, 12 Oct 2012 16:02:02 +0200
Message-ID: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:35906 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932651Ab2JLODA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 10:03:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Per Forlin <per.forlin@stericsson.com>

From: Ulf Hansson <ulf.hansson@linaro.org>

For the ux500v2 variant non power of two block sizes are supported.
This will make it possible to decrease data overhead for SDIO
transfers. Although we need to put some constraints to the alignment
of the buffers when enabling this feature.

Buffers must be 4 bytes aligned due to restrictions that the PL18x
FIFO accesses must be done in a 4 byte aligned manner. Moreover we
need to enable DMA_REQCTL for SDIO to support write of non 32 bytes
aligned sg element lengths. In PIO mode any buffer length can be
handled as long as the buffer address is 4 byte aligned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
 drivers/mmc/host/mmci.c |   56 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/mmci.h |    7 ++++++
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..ca6d128 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -48,6 +48,7 @@ static unsigned int fmax = 515633;
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
+ * @dma_sdio_req_ctrl: enable value for DMAREQCTL register for SDIO write
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -58,10 +59,12 @@ static unsigned int fmax = 515633;
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
+ * @non_power_of_2_blksize: true if block sizes can be other than power of two
  */
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
+	unsigned int		dma_sdio_req_ctrl;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
@@ -70,6 +73,7 @@ struct variant_data {
 	bool			blksz_datactrl16;
 	u32			pwrreg_powerup;
 	bool			signal_direction;
+	bool			non_power_of_2_blksize;
 };
 
 static struct variant_data variant_arm = {
@@ -112,6 +116,7 @@ static struct variant_data variant_ux500 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.dma_sdio_req_ctrl	= MCI_ST_DPSM_DMAREQCTL,
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
@@ -124,15 +129,42 @@ static struct variant_data variant_ux500v2 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.dma_sdio_req_ctrl	= MCI_ST_DPSM_DMAREQCTL,
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
 	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.non_power_of_2_blksize	= true,
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
+	if (!host->variant->non_power_of_2_blksize &&
+	    !is_power_of_2(data->blksz)) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported block size (%d bytes)\n", data->blksz);
+		return -EINVAL;
+	}
+
+	if (data->sg->offset & 3) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported alginment (0x%x)\n", data->sg->offset);
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
@@ -446,8 +478,12 @@ static int mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	if (!chan)
 		return -EINVAL;
 
-	/* If less than or equal to the fifo size, don't bother with DMA */
-	if (data->blksz * data->blocks <= variant->fifosize)
+	/*
+	 * If less than or equal to the fifo size, don't bother with DMA
+	 * SDIO transfers may not be 4 bytes aligned, fall back to PIO
+	 */
+	if (data->blksz * data->blocks <= variant->fifosize ||
+	    (data->blksz * data->blocks) & 3)
 		return -EINVAL;
 
 	device = chan->device;
@@ -482,6 +518,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	int ret;
 	struct mmc_data *data = host->data;
+	struct variant_data *variant = host->variant;
 
 	ret = mmci_dma_prep_data(host, host->data, NULL);
 	if (ret)
@@ -496,6 +533,11 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 	datactrl |= MCI_DPSM_DMAENABLE;
 
+	/* Some hardware versions need special flags for SDIO DMA write */
+	if (variant->sdio && host->mmc->card && mmc_card_sdio(host->mmc->card)
+	    && (data->flags & MMC_DATA_WRITE))
+		datactrl |= variant->dma_sdio_req_ctrl;
+
 	/* Trigger the DMA transfer */
 	writel(datactrl, host->base + MMCIDATACTRL);
 
@@ -540,6 +582,9 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (!data)
 		return;
 
+	if (mmci_validate_data(host, mrq->data))
+		return;
+
 	if (data->host_cookie) {
 		data->host_cookie = 0;
 		return;
@@ -642,7 +687,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	writel(host->size, base + MMCIDATALENGTH);
 
 	blksz_bits = ffs(data->blksz) - 1;
-	BUG_ON(1 << blksz_bits != data->blksz);
 
 	if (variant->blksz_datactrl16)
 		datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
@@ -1048,10 +1092,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
index d437ccf..c2b3332 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -60,6 +60,13 @@
 #define MCI_ST_DPSM_RWMOD	(1 << 10)
 #define MCI_ST_DPSM_SDIOEN	(1 << 11)
 /* Control register extensions in the ST Micro Ux500 versions */
+/*
+ * DMA request control is required for write
+ * if transfer size is not 32 byte aligned.
+ * DMA request control is also needed if the total
+ * transfer size is 32 byte aligned but any of the
+ * sg element lengths are not aligned with 32 byte.
+ */
 #define MCI_ST_DPSM_DMAREQCTL	(1 << 12)
 #define MCI_ST_DPSM_DBOOTMODEEN	(1 << 13)
 #define MCI_ST_DPSM_BUSYMODE	(1 << 14)
-- 
1.7.10

