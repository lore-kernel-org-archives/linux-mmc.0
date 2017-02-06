From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 7/9] mmc: cavium: Add scatter-gather DMA support
Date: Mon,  6 Feb 2017 14:39:50 +0100
Message-ID: <20170206133953.8390-8-jglauber@cavium.com>
References: <20170206133953.8390-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170206133953.8390-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add Support for the scatter-gather DMA available in the
ThunderX MMC units. Up to 16 DMA requests can be processed
together.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 drivers/mmc/host/cavium-mmc.c          | 105 ++++++++++++++++++++++++++++++++-
 drivers/mmc/host/cavium-mmc.h          |  58 ++++++++++++++++++
 drivers/mmc/host/cavium-pci-thunderx.c |   3 +
 3 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
index f1fe291..3d3c9c7 100644
--- a/drivers/mmc/host/cavium-mmc.c
+++ b/drivers/mmc/host/cavium-mmc.c
@@ -351,9 +351,31 @@ static int finish_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 	return 1;
 }
 
+static int finish_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
+{
+	union mio_emm_dma_fifo_cfg fifo_cfg;
+
+	/* Check if there are any pending requests left */
+	fifo_cfg.val = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG);
+	if (fifo_cfg.s.count)
+		dev_err(host->dev, "%u requests still pending\n",
+			fifo_cfg.s.count);
+
+	data->bytes_xfered = data->blocks * data->blksz;
+	data->error = 0;
+
+	/* Clear and disable FIFO */
+	writeq(BIT_ULL(16), host->dma_base + MIO_EMM_DMA_FIFO_CFG);
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
 
 static bool bad_status(union mio_emm_rsp_sts *rsp_sts)
@@ -493,9 +515,83 @@ static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 	return addr;
 }
 
+/*
+ * Queue complete sg list into the FIFO.
+ * Returns 0 on error, 1 otherwise.
+ */
+static u64 prepare_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
+{
+	union mio_emm_dma_fifo_cmd fifo_cmd;
+	struct scatterlist *sg;
+	int count, i;
+	u64 addr;
+
+	count = dma_map_sg(host->dev, data->sg, data->sg_len,
+			   get_dma_dir(data));
+	if (!count)
+		return 0;
+	if (count > 16)
+		goto error;
+
+	/* Enable FIFO by removing CLR bit */
+	writeq(0, host->dma_base + MIO_EMM_DMA_FIFO_CFG);
+
+	for_each_sg(data->sg, sg, count, i) {
+		/* Program DMA address */
+		addr = sg_dma_address(sg);
+		if (addr & 7)
+			goto error;
+		writeq(addr, host->dma_base + MIO_EMM_DMA_FIFO_ADR);
+
+		/*
+		 * If we have scatter-gather support we also have an extra
+		 * register for the DMA addr, so no need to check
+		 * host->big_dma_addr here.
+		 */
+		fifo_cmd.val = 0;
+		fifo_cmd.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+
+		/* enable interrupts on the last element */
+		if (i + 1 == count)
+			fifo_cmd.s.intdis = 0;
+		else
+			fifo_cmd.s.intdis = 1;
+
+#ifdef __LITTLE_ENDIAN
+		fifo_cmd.s.endian = 1;
+#endif
+		fifo_cmd.s.size = sg_dma_len(sg) / 8 - 1;
+		/*
+		 * The write copies the address and the command to the FIFO
+		 * and increments the FIFO's COUNT field.
+		 */
+		writeq(fifo_cmd.val, host->dma_base + MIO_EMM_DMA_FIFO_CMD);
+		pr_debug("[%s] sg_dma_len: %u  sg_elem: %d/%d\n",
+			 (fifo_cmd.s.rw) ? "W" : "R", sg_dma_len(sg), i, count);
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
+	writeq(BIT_ULL(16), host->dma_base + MIO_EMM_DMA_FIFO_CFG);
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
 
 static void prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -998,7 +1094,10 @@ int cvm_mmc_slot_probe(struct device *dev, struct cvm_mmc_host *host)
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
index 64a837c..04898b8 100644
--- a/drivers/mmc/host/cavium-mmc.h
+++ b/drivers/mmc/host/cavium-mmc.h
@@ -22,6 +22,10 @@
 #define MIO_EMM_DMA_CFG		0x00
 #define MIO_EMM_DMA_ADR		0x08
 
+#define MIO_EMM_DMA_FIFO_CFG	0x00
+#define MIO_EMM_DMA_FIFO_ADR	0x00
+#define MIO_EMM_DMA_FIFO_CMD	0x00
+
 #define MIO_EMM_CFG		0x00
 #define MIO_EMM_SWITCH		0x48
 #define MIO_EMM_DMA		0x50
@@ -40,6 +44,9 @@
 
 #elif CONFIG_MMC_CAVIUM_THUNDERX
 
+#define MIO_EMM_DMA_FIFO_CFG	0x160
+#define MIO_EMM_DMA_FIFO_ADR	0x170
+#define MIO_EMM_DMA_FIFO_CMD	0x178
 #define MIO_EMM_DMA_CFG		0x180
 #define MIO_EMM_DMA_ADR		0x188
 #define MIO_EMM_DMA_INT		0x190
@@ -81,6 +88,7 @@ struct cvm_mmc_host {
 	struct mmc_request *current_req;
 	struct sg_mapping_iter smi;
 	bool dma_active;
+	bool use_sg;
 
 	bool has_ciu3;
 	bool big_dma_addr;
@@ -135,6 +143,56 @@ struct cvm_mmc_cr_mods {
 
 /* Bitfield definitions */
 
+union mio_emm_dma_fifo_cfg {
+	u64 val;
+	struct mio_emm_dma_fifo_cfg_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		u64 :48;
+		u64 clr:1;
+		u64 :3;
+		u64 int_lvl:4;
+		u64 :3;
+		u64 count:5;
+#else
+		u64 count:5;
+		u64 :3;
+		u64 int_lvl:4;
+		u64 :3;
+		u64 clr:1;
+		u64 :48;
+#endif
+	} s;
+};
+
+union mio_emm_dma_fifo_cmd {
+	u64 val;
+	struct mio_emm_dma_fifo_cmd_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		u64 :1;
+		u64 rw:1;
+		u64 :1;
+		u64 intdis:1;
+		u64 swap32:1;
+		u64 swap16:1;
+		u64 swap8:1;
+		u64 endian:1;
+		u64 size:20;
+		u64 :36;
+#else
+		u64 :36;
+		u64 size:20;
+		u64 endian:1;
+		u64 swap8:1;
+		u64 swap16:1;
+		u64 swap32:1;
+		u64 intdis:1;
+		u64 :1;
+		u64 rw:1;
+		u64 :1;
+#endif
+	} s;
+};
+
 union mio_emm_cmd {
 	u64 val;
 	struct mio_emm_cmd_s {
diff --git a/drivers/mmc/host/cavium-pci-thunderx.c b/drivers/mmc/host/cavium-pci-thunderx.c
index 5052c4e..579e063 100644
--- a/drivers/mmc/host/cavium-pci-thunderx.c
+++ b/drivers/mmc/host/cavium-pci-thunderx.c
@@ -109,6 +109,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	host->release_bus = thunder_mmc_release_bus;
 	host->int_enable = thunder_mmc_int_enable;
 
+	host->use_sg = true;
 	host->big_dma_addr = true;
 	host->need_irq_handler_lock = true;
 	host->last_slot = -1;
@@ -123,6 +124,8 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	 */
 	writeq(127, host->base + MIO_EMM_INT_EN);
 	writeq(3, host->base + MIO_EMM_DMA_INT_ENA_W1C);
+	/* Clear DMA FIFO */
+	writeq(BIT_ULL(16), host->base + MIO_EMM_DMA_FIFO_CFG);
 
 	ret = thunder_mmc_register_interrupts(host, pdev);
 	if (ret)
-- 
2.9.0.rc0.21.g7777322
