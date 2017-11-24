From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 12/22] mmc: tmio,renesas_sdhi: move struct tmio_mmc_dma to renesas_sdhi.h
Date: Sat, 25 Nov 2017 01:24:47 +0900
Message-ID: <1511540697-27387-13-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

struct tmio_mmc_dma looks like TMIO core data, but in fact, Renesas
private data.  Move it to renesas_sdhi.h (probably, it is better to
rename it to renesas_sdhi_dma, or squash it into struct renesas_sdhi).

I also moved struct renesas_sdhi and host_to_priv() to that header
because they are necessary to convert the tmio_mmc_host pointer into
the renesas_sdhi pointer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/renesas_sdhi.h               | 19 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_core.c          | 14 --------------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  6 ++++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 16 ++++++++++------
 drivers/mmc/host/tmio_mmc.h                   |  7 -------
 5 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index b9dfea5..9a507b3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -35,6 +35,25 @@ struct renesas_sdhi_of_data {
 	unsigned short max_segs;
 };
 
+struct tmio_mmc_dma {
+	enum dma_slave_buswidth dma_buswidth;
+	bool (*filter)(struct dma_chan *chan, void *arg);
+	void (*enable)(struct tmio_mmc_host *host, bool enable);
+};
+
+struct renesas_sdhi {
+	struct clk *clk;
+	struct clk *clk_cd;
+	struct tmio_mmc_data mmc_data;
+	struct tmio_mmc_dma dma_priv;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default, *pins_uhs;
+	void __iomem *scc_ctl;
+};
+
+#define host_to_priv(host) \
+	container_of((host)->pdata, struct renesas_sdhi, mmc_data)
+
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops);
 int renesas_sdhi_remove(struct platform_device *pdev);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 267e2e0..34fd194 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -46,19 +46,6 @@
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
 
-#define host_to_priv(host) \
-	container_of((host)->pdata, struct renesas_sdhi, mmc_data)
-
-struct renesas_sdhi {
-	struct clk *clk;
-	struct clk *clk_cd;
-	struct tmio_mmc_data mmc_data;
-	struct tmio_mmc_dma dma_priv;
-	struct pinctrl *pinctrl;
-	struct pinctrl_state *pins_default, *pins_uhs;
-	void __iomem *scc_ctl;
-};
-
 static void renesas_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 {
 	u32 val;
@@ -539,7 +526,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->bus_shift = of_data->bus_shift;
 	}
 
-	host->dma		= dma_priv;
 	host->write16_hook	= renesas_sdhi_write16_hook;
 	host->clk_enable	= renesas_sdhi_clk_enable;
 	host->clk_update	= renesas_sdhi_clk_update;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 41cbe84..691a99f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -103,6 +103,8 @@ renesas_sdhi_internal_dmac_dm_write(struct tmio_mmc_host *host,
 static void
 renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
+
 	if (!host->chan_tx || !host->chan_rx)
 		return;
 
@@ -110,8 +112,8 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool enable)
 		renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO1,
 						    INFO1_CLEAR);
 
-	if (host->dma->enable)
-		host->dma->enable(host, enable);
+	if (priv->dma_priv.enable)
+		priv->dma_priv.enable(host, enable);
 }
 
 static void
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index e210644..aeb3838 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -117,11 +117,13 @@ MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
 					     bool enable)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
+
 	if (!host->chan_tx || !host->chan_rx)
 		return;
 
-	if (host->dma->enable)
-		host->dma->enable(host, enable);
+	if (priv->dma_priv.enable)
+		priv->dma_priv.enable(host, enable);
 }
 
 static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
@@ -359,6 +361,8 @@ static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
 static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 					      struct tmio_mmc_data *pdata)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
+
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->pdev->dev.of_node &&
 	    (!pdata->chan_priv_tx || !pdata->chan_priv_rx))
@@ -378,7 +382,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 		dma_cap_set(DMA_SLAVE, mask);
 
 		host->chan_tx = dma_request_slave_channel_compat(mask,
-					host->dma->filter, pdata->chan_priv_tx,
+					priv->dma_priv.filter, pdata->chan_priv_tx,
 					&host->pdev->dev, "tx");
 		dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n", __func__,
 			host->chan_tx);
@@ -389,7 +393,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start +
 			(CTL_SD_DATA_PORT << host->bus_shift);
-		cfg.dst_addr_width = host->dma->dma_buswidth;
+		cfg.dst_addr_width = priv->dma_priv.dma_buswidth;
 		if (!cfg.dst_addr_width)
 			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.src_addr = 0;
@@ -398,7 +402,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			goto ecfgtx;
 
 		host->chan_rx = dma_request_slave_channel_compat(mask,
-					host->dma->filter, pdata->chan_priv_rx,
+					priv->dma_priv.filter, pdata->chan_priv_rx,
 					&host->pdev->dev, "rx");
 		dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n", __func__,
 			host->chan_rx);
@@ -408,7 +412,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
-		cfg.src_addr_width = host->dma->dma_buswidth;
+		cfg.src_addr_width = priv->dma_priv.dma_buswidth;
 		if (!cfg.src_addr_width)
 			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.dst_addr = 0;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 37409c5..dc470d3 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -112,12 +112,6 @@
 struct tmio_mmc_data;
 struct tmio_mmc_host;
 
-struct tmio_mmc_dma {
-	enum dma_slave_buswidth dma_buswidth;
-	bool (*filter)(struct dma_chan *chan, void *arg);
-	void (*enable)(struct tmio_mmc_host *host, bool enable);
-};
-
 struct tmio_mmc_dma_ops {
 	void (*start)(struct tmio_mmc_host *host, struct mmc_data *data);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
@@ -149,7 +143,6 @@ struct tmio_mmc_host {
 
 	struct platform_device *pdev;
 	struct tmio_mmc_data *pdata;
-	struct tmio_mmc_dma	*dma;
 
 	/* DMA support */
 	bool			force_pio;
-- 
2.7.4
