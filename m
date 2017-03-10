From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v12 7/9] mmc: cavium: Add scatter-gather DMA support
Date: Fri, 10 Mar 2017 14:25:05 +0100
Message-ID: <20170310132507.32025-8-jglauber@cavium.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310132507.32025-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add Support for the scatter-gather DMA available in the
ThunderX MMC units. Up to 16 DMA requests can be processed
together.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium-mmc.c          | 104 ++++++++++++++++++++++++++++++++-
 drivers/mmc/host/cavium-mmc.h          |  16 +++++
 drivers/mmc/host/cavium-pci-thunderx.c |   3 +
 3 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
index c57abed..fb6e1c1 100644
--- a/drivers/mmc/host/cavium-mmc.c
+++ b/drivers/mmc/host/cavium-mmc.c
@@ -377,9 +377,32 @@ static int finish_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 	return 1;
 }
 
+static int finish_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
+{
+	u64 fifo_cfg;
+	int count;
+
+	/* Check if there are any pending requests left */
+	fifo_cfg = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG(host));
+	count = FIELD_GET(MIO_EMM_DMA_FIFO_CFG_COUNT, fifo_cfg);
+	if (count)
+		dev_err(host->dev, "%u requests still pending\n", count);
+
+	data->bytes_xfered = data->blocks * data->blksz;
+	data->error = 0;
+
+	/* Clear and disable FIFO */
+	writeq(BIT_ULL(16), host->dma_base + MIO_EMM_DMA_FIFO_CFG(host));
+	dma_unmap_sg(host->dev, data->sg, data->sg_len, get_dma_dir(data));
+	return 1;
+}
+
 static int finish_dma(struct cvm_mmc_host *host, struct mmc_data *data)
 {
-	return finish_dma_single(host, data);
+	if (host->use_sg && data->sg_len > 1)
+		return finish_dma_sg(host, data);
+	else
+		return finish_dma_single(host, data);
 }
 
 static int check_status(u64 rsp_sts)
@@ -522,9 +545,81 @@ static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 	return addr;
 }
 
+/*
+ * Queue complete sg list into the FIFO.
+ * Returns 0 on error, 1 otherwise.
+ */
+static u64 prepare_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
+{
+	struct scatterlist *sg;
+	u64 fifo_cmd, addr;
+	int count, i, rw;
+
+	count = dma_map_sg(host->dev, data->sg, data->sg_len,
+			   get_dma_dir(data));
+	if (!count)
+		return 0;
+	if (count > 16)
+		goto error;
+
+	/* Enable FIFO by removing CLR bit */
+	writeq(0, host->dma_base + MIO_EMM_DMA_FIFO_CFG(host));
+
+	for_each_sg(data->sg, sg, count, i) {
+		/* Program DMA address */
+		addr = sg_dma_address(sg);
+		if (addr & 7)
+			goto error;
+		writeq(addr, host->dma_base + MIO_EMM_DMA_FIFO_ADR(host));
+
+		/*
+		 * If we have scatter-gather support we also have an extra
+		 * register for the DMA addr, so no need to check
+		 * host->big_dma_addr here.
+		 */
+		rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+		fifo_cmd = FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_RW, rw);
+
+		/* enable interrupts on the last element */
+		fifo_cmd |= FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_INTDIS,
+				       (i + 1 == count) ? 0 : 1);
+
+#ifdef __LITTLE_ENDIAN
+		fifo_cmd |= FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_ENDIAN, 1);
+#endif
+		fifo_cmd |= FIELD_PREP(MIO_EMM_DMA_FIFO_CMD_SIZE,
+				       sg_dma_len(sg) / 8 - 1);
+		/*
+		 * The write copies the address and the command to the FIFO
+		 * and increments the FIFO's COUNT field.
+		 */
+		writeq(fifo_cmd, host->dma_base + MIO_EMM_DMA_FIFO_CMD(host));
+		pr_debug("[%s] sg_dma_len: %u  sg_elem: %d/%d\n",
+			 (rw) ? "W" : "R", sg_dma_len(sg), i, count);
+	}
+
+	/*
+	 * In difference to prepare_dma_single we don't return the
+	 * address here, as it would not make sense for scatter-gather.
+	 * The dma fixup is only required on models that don't support
+	 * scatter-gather, so that is not a problem.
+	 */
+	return 1;
+
+error:
+	WARN_ON_ONCE(1);
+	dma_unmap_sg(host->dev, data->sg, data->sg_len, get_dma_dir(data));
+	/* Disable FIFO */
+	writeq(BIT_ULL(16), host->dma_base + MIO_EMM_DMA_FIFO_CFG(host));
+	return 0;
+}
+
 static u64 prepare_dma(struct cvm_mmc_host *host, struct mmc_data *data)
 {
-	return prepare_dma_single(host, data);
+	if (host->use_sg && data->sg_len > 1)
+		return prepare_dma_sg(host, data);
+	else
+		return prepare_dma_single(host, data);
 }
 
 static u64 prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -965,7 +1060,10 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD;
 
-	mmc->max_segs = 1;
+	if (host->use_sg)
+		mmc->max_segs = 16;
+	else
+		mmc->max_segs = 1;
 
 	/* DMA size field can address up to 8 MB */
 	mmc->max_seg_size = 8 * 1024 * 1024;
diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
index fb82aee..5893f3a 100644
--- a/drivers/mmc/host/cavium-mmc.h
+++ b/drivers/mmc/host/cavium-mmc.h
@@ -22,6 +22,9 @@
 #define CAVIUM_MAX_MMC		4
 
 /* DMA register addresses */
+#define MIO_EMM_DMA_FIFO_CFG(x)	(0x00 + x->reg_off_dma)
+#define MIO_EMM_DMA_FIFO_ADR(x)	(0x10 + x->reg_off_dma)
+#define MIO_EMM_DMA_FIFO_CMD(x)	(0x18 + x->reg_off_dma)
 #define MIO_EMM_DMA_CFG(x)	(0x20 + x->reg_off_dma)
 #define MIO_EMM_DMA_ADR(x)	(0x28 + x->reg_off_dma)
 #define MIO_EMM_DMA_INT(x)	(0x30 + x->reg_off_dma)
@@ -63,6 +66,7 @@ struct cvm_mmc_host {
 	struct mmc_request *current_req;
 	struct sg_mapping_iter smi;
 	bool dma_active;
+	bool use_sg;
 
 	bool has_ciu3;
 	bool big_dma_addr;
@@ -110,6 +114,18 @@ struct cvm_mmc_cr_mods {
 };
 
 /* Bitfield definitions */
+#define MIO_EMM_DMA_FIFO_CFG_CLR	BIT_ULL(16)
+#define MIO_EMM_DMA_FIFO_CFG_INT_LVL	GENMASK_ULL(12, 8)
+#define MIO_EMM_DMA_FIFO_CFG_COUNT	GENMASK_ULL(4, 0)
+
+#define MIO_EMM_DMA_FIFO_CMD_RW		BIT_ULL(62)
+#define MIO_EMM_DMA_FIFO_CMD_INTDIS	BIT_ULL(60)
+#define MIO_EMM_DMA_FIFO_CMD_SWAP32	BIT_ULL(59)
+#define MIO_EMM_DMA_FIFO_CMD_SWAP16	BIT_ULL(58)
+#define MIO_EMM_DMA_FIFO_CMD_SWAP8	BIT_ULL(57)
+#define MIO_EMM_DMA_FIFO_CMD_ENDIAN	BIT_ULL(56)
+#define MIO_EMM_DMA_FIFO_CMD_SIZE	GENMASK_ULL(55, 36)
+
 #define MIO_EMM_CMD_SKIP_BUSY		BIT_ULL(62)
 #define MIO_EMM_CMD_BUS_ID		GENMASK_ULL(61, 60)
 #define MIO_EMM_CMD_VAL			BIT_ULL(59)
diff --git a/drivers/mmc/host/cavium-pci-thunderx.c b/drivers/mmc/host/cavium-pci-thunderx.c
index 6ad36b4..5b93a7b 100644
--- a/drivers/mmc/host/cavium-pci-thunderx.c
+++ b/drivers/mmc/host/cavium-pci-thunderx.c
@@ -104,6 +104,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	host->release_bus = thunder_mmc_release_bus;
 	host->int_enable = thunder_mmc_int_enable;
 
+	host->use_sg = true;
 	host->big_dma_addr = true;
 	host->need_irq_handler_lock = true;
 	host->last_slot = -1;
@@ -118,6 +119,8 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	 */
 	writeq(127, host->base + MIO_EMM_INT_EN(host));
 	writeq(3, host->base + MIO_EMM_DMA_INT_ENA_W1C(host));
+	/* Clear DMA FIFO */
+	writeq(BIT_ULL(16), host->base + MIO_EMM_DMA_FIFO_CFG(host));
 
 	ret = thunder_mmc_register_interrupts(host, pdev);
 	if (ret)
-- 
2.9.0.rc0.21.g7777322
