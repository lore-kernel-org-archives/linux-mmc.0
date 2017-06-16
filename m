From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v3 2/2] mmc: renesas-sdhi: improve checkpatch cleanness
Date: Fri, 16 Jun 2017 18:11:04 +0200
Message-ID: <1497629464-14459-3-git-send-email-horms+renesas@verge.net.au>
References: <1497629464-14459-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1497629464-14459-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Trivial updates to improve checkpatch cleanness.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2
* Correct one-line comment style
* Leave bus_shift size comments unchanged
---
 drivers/mmc/host/renesas_sdhi.h          |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c     | 43 ++++++++++++++++----------------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 25 +++++++++++--------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 6b4a79508c6b..ca83acc113b8 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -34,6 +34,6 @@ struct renesas_sdhi_of_data {
 };
 
 int renesas_sdhi_probe(struct platform_device *pdev,
-                       const struct tmio_mmc_dma_ops *dma_ops);
+		       const struct tmio_mmc_dma_ops *dma_ops);
 int renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f4690cba3443..a4fb07d0ea91 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -45,7 +45,8 @@
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
 
-#define host_to_priv(host) container_of((host)->pdata, struct renesas_sdhi, mmc_data)
+#define host_to_priv(host) \
+	container_of((host)->pdata, struct renesas_sdhi, mmc_data)
 
 struct renesas_sdhi {
 	struct clk *clk;
@@ -94,6 +95,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 	struct mmc_host *mmc = host->mmc;
 	struct renesas_sdhi *priv = host_to_priv(host);
 	int ret = clk_prepare_enable(priv->clk);
+
 	if (ret < 0)
 		return ret;
 
@@ -125,7 +127,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 }
 
 static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
-					      unsigned int new_clock)
+					    unsigned int new_clock)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
@@ -175,11 +177,12 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
+	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
+		 TMIO_STAT_DAT0);
 }
 
 static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
-						      struct mmc_ios *ios)
+						    struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -285,7 +288,7 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 }
 
 static void renesas_sdhi_prepare_tuning(struct tmio_mmc_host *host,
-					 unsigned long tap)
+					unsigned long tap)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
@@ -318,9 +321,9 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	tap_start = 0;
 	tap_end = 0;
 	for (i = 0; i < host->tap_num * 2; i++) {
-		if (test_bit(i, host->taps))
+		if (test_bit(i, host->taps)) {
 			ntap++;
-		else {
+		} else {
 			if (ntap > tap_cnt) {
 				tap_start = i - ntap;
 				tap_end = i - 1;
@@ -352,7 +355,6 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	return 0;
 }
 
-
 static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -414,8 +416,7 @@ static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host)
 
 static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 {
-	switch (addr)
-	{
+	switch (addr) {
 	case CTL_SD_CMD:
 	case CTL_STOP_INTERNAL_ACTION:
 	case CTL_XFER_BLK_COUNT:
@@ -432,7 +433,7 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 }
 
 static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
-					 unsigned int direction, int blk_size)
+				       unsigned int direction, int blk_size)
 {
 	/*
 	 * In Renesas controllers, when performing a
@@ -460,20 +461,23 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops)
 {
-	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data( &pdev->dev);
-	struct renesas_sdhi *priv;
-	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
+	const struct renesas_sdhi_of_data *of_data;
+	struct tmio_mmc_data *mmc_data;
+	struct tmio_mmc_dma *dma_priv;
 	struct tmio_mmc_host *host;
+	struct renesas_sdhi *priv;
 	struct resource *res;
 	int irq, ret, i;
-	struct tmio_mmc_dma *dma_priv;
+
+	of_data = of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct renesas_sdhi), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct renesas_sdhi),
+			    GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -516,7 +520,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		goto eprobe;
 	}
 
-
 	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
@@ -566,9 +569,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
 
-	/*
-	 * All SDHI have CMD12 controll bit
-	 */
+	/* All SDHI have CMD12 control bit */
 	mmc_data->flags |= TMIO_MMC_HAVE_CMD12_CTRL;
 
 	/* All SDHI have SDIO status bits which must be 1 */
@@ -614,7 +615,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			break;
 		i++;
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
-				  dev_name(&pdev->dev), host);
+				       dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 202cf4346fdf..642a0dcc8c5c 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -104,7 +104,6 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 
-
 static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
 					     bool enable)
 {
@@ -196,8 +195,8 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0)
-		desc = dmaengine_prep_slave_sg(chan, sg, ret,
-			DMA_DEV_TO_MEM, DMA_CTRL_ACK);
+		desc = dmaengine_prep_slave_sg(chan, sg, ret, DMA_DEV_TO_MEM,
+					       DMA_CTRL_ACK);
 
 	if (desc) {
 		reinit_completion(&host->dma_dataend);
@@ -265,6 +264,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 	if (!aligned) {
 		unsigned long flags;
 		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
+
 		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
 		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
 		tmio_mmc_kunmap_atomic(sg, &flags, sg_vaddr);
@@ -274,8 +274,8 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0)
-		desc = dmaengine_prep_slave_sg(chan, sg, ret,
-			DMA_MEM_TO_DEV, DMA_CTRL_ACK);
+		desc = dmaengine_prep_slave_sg(chan, sg, ret, DMA_MEM_TO_DEV,
+					       DMA_CTRL_ACK);
 
 	if (desc) {
 		reinit_completion(&host->dma_dataend);
@@ -308,7 +308,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 }
 
 static void renesas_sdhi_sys_dmac_start_dma(struct tmio_mmc_host *host,
-			       struct mmc_data *data)
+					    struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
@@ -346,7 +346,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->dma || (!host->pdev->dev.of_node &&
-		(!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
+			   (!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
 		return;
 
 	if (!host->chan_tx && !host->chan_rx) {
@@ -372,7 +372,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			return;
 
 		cfg.direction = DMA_MEM_TO_DEV;
-		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
+		cfg.dst_addr = res->start +
+			(CTL_SD_DATA_PORT << host->bus_shift);
 		cfg.dst_addr_width = host->dma->dma_buswidth;
 		if (!cfg.dst_addr_width)
 			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -428,11 +429,13 @@ static void renesas_sdhi_sys_dmac_release_dma(struct tmio_mmc_host *host)
 {
 	if (host->chan_tx) {
 		struct dma_chan *chan = host->chan_tx;
+
 		host->chan_tx = NULL;
 		dma_release_channel(chan);
 	}
 	if (host->chan_rx) {
 		struct dma_chan *chan = host->chan_rx;
+
 		host->chan_rx = NULL;
 		dma_release_channel(chan);
 	}
@@ -457,10 +460,10 @@ static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 
 static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-			pm_runtime_force_resume)
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			tmio_mmc_host_runtime_resume,
-			NULL)
+			   tmio_mmc_host_runtime_resume,
+			   NULL)
 };
 
 static struct platform_driver renesas_sys_dmac_sdhi_driver = {
-- 
2.1.4
