From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 17/19] mmc: mmci: add stm32 sdmmc idma support
Date: Tue, 12 Jun 2018 15:14:38 +0200
Message-ID: <1528809280-31116-18-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds support of Internal DMA (IDMA) for
STM32 sdmmc variant. Direct memory access (DMA) is used to provide
high-speed transfer between the SDMMC FIFO and the memory.
The SDMMC internal DMA (IDMA) provides one channel to be used either
for transmit or receive.

The IDMA provides 2 modes:
- Single buffered channel: the data at the memory side is accessed
  in a linear matter starting from the base address IDMABASE with
  DATALENGTH. So, max segment number must be defined to one and
  max segment size to max datalength.
- Linked list channel: the data at the memory side is subsequently
  accessed from linked buffers, located at base address IDMABASE.
  The size of the memory buffers is defined by IDMABSIZE. The first
  linked list item is defined at IDMABAR address, and next item in
  IDMALAR. In this mode sdmmc variant could transfer several
  memory segments (not contiguous) in the same request.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h     |   5 ++
 drivers/mmc/host/mmci_dma.c | 197 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci_dma.h |   2 +
 3 files changed, 204 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index c2ad724..e36ea18 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -343,6 +343,8 @@ struct mmci_host;
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @mmci_dma: Pointer to platform-specific DMA callbacks.
  * @reset: true if variant has need reset signal.
+ * @dma_lli: true if variant has dma link list feature.
+ * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
  * @validate_data: if hardware block has specific constraint on validate data
  * @set_clk_ios: if clock procedure of variant is specific
  * @set_pwr_ios: if power procedure of variant is specific
@@ -391,6 +393,8 @@ struct variant_data {
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
 	bool			reset;
+	bool			dma_lli;
+	u32			stm32_idmabsize_mask;
 	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
@@ -445,5 +449,6 @@ struct mmci_host {
 };
 
 extern struct mmci_dma_ops dmaengine;
+extern struct mmci_dma_ops sdmmc_idma;
 
 void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl);
diff --git a/drivers/mmc/host/mmci_dma.c b/drivers/mmc/host/mmci_dma.c
index dd7dae5..27b55c2 100644
--- a/drivers/mmc/host/mmci_dma.c
+++ b/drivers/mmc/host/mmci_dma.c
@@ -581,3 +581,200 @@ struct mmci_dma_ops dmaengine = {
 #else
 struct mmci_dma_ops dmaengine = {};
 #endif
+
+#define SDMMC_LLI_BUF_LEN	PAGE_SIZE
+#define SDMMC_IDMA_BURST	BIT(MMCI_STM32_IDMABNDT_SHIFT)
+
+struct sdmmc_lli_desc {
+	u32 idmalar;
+	u32 idmabase;
+	u32 idmasize;
+};
+
+struct sdmmc_next {
+	s32 cookie;
+};
+
+struct sdmmc_priv {
+	dma_addr_t sg_dma;
+	void *sg_cpu;
+	struct sdmmc_next next_data;
+};
+
+static int __sdmmc_idma_prep_data(struct mmci_host *host, struct mmc_data *data)
+{
+	int n_elem;
+
+	n_elem = dma_map_sg(mmc_dev(host->mmc),
+			    data->sg,
+			    data->sg_len,
+			    mmc_get_dma_dir(data));
+
+	if (!n_elem) {
+		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int sdmmc_idma_validate_data(struct mmci_host *host,
+			     struct mmc_data *data)
+{
+	struct sdmmc_priv *idma = host->dma_priv;
+	struct sdmmc_next *nd = &idma->next_data;
+	struct scatterlist *sg;
+	int ret, i;
+
+	/* Check if next job is not already prepared. */
+	if (data->host_cookie != nd->cookie) {
+		ret = __sdmmc_idma_prep_data(host, data);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * idma has constraints on idmabase & idmasize for each element
+	 * excepted the last element which has no constraint on idmasize
+	 */
+	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
+		if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32)) ||
+		    !IS_ALIGNED(sg_dma_len(data->sg), SDMMC_IDMA_BURST)) {
+			dev_err(mmc_dev(host->mmc),
+				"unaligned scatterlist: ofst:%x length:%d\n",
+				data->sg->offset, data->sg->length);
+			return -EINVAL;
+		}
+	}
+
+	if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32))) {
+		dev_err(mmc_dev(host->mmc),
+			"unaligned last scatterlist: ofst:%x length:%d\n",
+			data->sg->offset, data->sg->length);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void sdmmc_idma_pre_req(struct mmci_host *host, struct mmc_data *data)
+{
+	struct sdmmc_priv *idma = host->dma_priv;
+	struct sdmmc_next *nd = &idma->next_data;
+
+	if (!__sdmmc_idma_prep_data(host, data))
+		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+}
+
+static void sdmmc_idma_post_req(struct mmci_host *host, struct mmc_data *data,
+				int err)
+{
+	if (!data || !data->host_cookie)
+		return;
+
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		     mmc_get_dma_dir(data));
+
+	data->host_cookie = 0;
+}
+
+static int sdmmc_idma_setup(struct mmci_host *host)
+{
+	struct sdmmc_priv *idma;
+
+	idma = devm_kzalloc(mmc_dev(host->mmc), sizeof(*idma), GFP_KERNEL);
+	if (!idma)
+		return -ENOMEM;
+
+	host->dma_priv = idma;
+
+	if (host->variant->dma_lli) {
+		idma->sg_cpu = dmam_alloc_coherent(mmc_dev(host->mmc),
+						   SDMMC_LLI_BUF_LEN,
+						   &idma->sg_dma, GFP_KERNEL);
+		if (!idma->sg_cpu) {
+			dev_err(mmc_dev(host->mmc),
+				"Failed to alloc IDMA descriptor\n");
+			return -ENOMEM;
+		}
+		host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
+			sizeof(struct sdmmc_lli_desc);
+		host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
+	} else {
+		host->mmc->max_segs = 1;
+		host->mmc->max_seg_size = host->mmc->max_req_size;
+	}
+
+	/* initialize pre request cookie */
+	idma->next_data.cookie = 1;
+
+	return 0;
+}
+
+static int sdmmc_idma_start(struct mmci_host *host, unsigned int datactrl)
+
+{
+	struct sdmmc_priv *idma = host->dma_priv;
+	struct sdmmc_lli_desc *desc = (struct sdmmc_lli_desc *)idma->sg_cpu;
+	struct mmc_data *data = host->data;
+	struct scatterlist *sg;
+	int i;
+
+	if (!host->variant->dma_lli || data->sg_len == 1) {
+		writel_relaxed(sg_dma_address(data->sg),
+			       host->base + MMCI_STM32_IDMABASE0R);
+		writel_relaxed(MMCI_STM32_IDMAEN,
+			       host->base + MMCI_STM32_IDMACTRLR);
+		goto out;
+	}
+
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		desc[i].idmalar = (i + 1) * sizeof(struct sdmmc_lli_desc);
+		desc[i].idmalar |= MMCI_STM32_ULA | MMCI_STM32_ULS
+			| MMCI_STM32_ABR;
+		desc[i].idmabase = sg_dma_address(sg);
+		desc[i].idmasize = sg_dma_len(sg);
+	}
+
+	/* notice the end of link list */
+	desc[data->sg_len - 1].idmalar &= ~MMCI_STM32_ULA;
+
+	dma_wmb();
+	writel_relaxed(idma->sg_dma, host->base + MMCI_STM32_IDMABAR);
+	writel_relaxed(desc[0].idmalar, host->base + MMCI_STM32_IDMALAR);
+	writel_relaxed(desc[0].idmabase, host->base + MMCI_STM32_IDMABASE0R);
+	writel_relaxed(desc[0].idmasize, host->base + MMCI_STM32_IDMABSIZER);
+	writel_relaxed(MMCI_STM32_IDMAEN | MMCI_STM32_IDMALLIEN,
+		       host->base + MMCI_STM32_IDMACTRLR);
+
+	/* mask & datactrl */
+out:
+	mmci_write_datactrlreg(host, datactrl);
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+
+	return 0;
+}
+
+static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+}
+
+static void sdmmc_idma_get_next_data(struct mmci_host *host,
+				     struct mmc_data *data)
+{
+	struct sdmmc_priv *idma = host->dma_priv;
+	struct sdmmc_next *next = &idma->next_data;
+
+	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
+}
+
+struct mmci_dma_ops sdmmc_idma = {
+	.setup = sdmmc_idma_setup,
+	.pre_req = sdmmc_idma_pre_req,
+	.start = sdmmc_idma_start,
+	.finalize = sdmmc_idma_finalize,
+	.post_req = sdmmc_idma_post_req,
+	.get_next_data = sdmmc_idma_get_next_data,
+};
diff --git a/drivers/mmc/host/mmci_dma.h b/drivers/mmc/host/mmci_dma.h
index 33e4e8a..cbfda89 100644
--- a/drivers/mmc/host/mmci_dma.h
+++ b/drivers/mmc/host/mmci_dma.h
@@ -28,4 +28,6 @@ void mmci_dma_post_req(struct mmci_host *host,
 void mmci_dma_error(struct mmci_host *host);
 void mmci_dma_get_next_data(struct mmci_host *host, struct mmc_data *data);
 
+int sdmmc_idma_validate_data(struct mmci_host *host,
+			     struct mmc_data *data);
 #endif /* __MMC_DMA_H__ */
-- 
2.7.4
