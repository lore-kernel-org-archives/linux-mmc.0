From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V2] mmc: dwmmc: Add quirk for broken Hardware Config
Date: Mon, 23 Jul 2012 17:35:27 +0530
Message-ID: <1343045127-20227-2-git-send-email-girish.shivananjappa@linaro.org>
References: <1343045127-20227-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56260 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2GWMFt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jul 2012 08:05:49 -0400
Received: by gglu4 with SMTP id u4so5330650ggl.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jul 2012 05:05:48 -0700 (PDT)
In-Reply-To: <1343045127-20227-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, will.newton@imgtec.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, shashidharh@vayavyalabs.com, thomas.abraham@linaro.org, jh80.chung@samsung.com, svenkatr@ti.com, Girish K S <girish.shivananjappa@linaro.org>

In some Soc'S that integrate Designware mmc host controllers, the
HCON register is broken. The hardware configuration is not
updated. One specific usecase is the IDMAC. In Exysons5 SoC
there exist a internal DMA, but the HCON register's DMA_INTERFACE
field is not set to indicate its existance.

This quirk can be used in such case to force the existance broken
HCON field.

changes in v2:
	-moved the implementation to quirk framework as per venkat's
	 review comment.
changes in v1:
	-modified the caps2 field access per controller index.Reported
	 by Jaehoon Chung <jh80.chung@samsung.com>.
	-replaced the pointer to device with the pointer to platform
	 device in struct dw_mci.
	-updated driver data for all 4 mmc controllers of exynos5 SoC.
	-added non device-tree support for ctrl_id access.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   10 +++-
 drivers/mmc/host/dw_mmc.c       |  151 ++++++++++++++++++++++++---------------
 drivers/mmc/host/dw_mmc.h       |    1 +
 include/linux/mmc/dw_mmc.h      |    4 +-
 4 files changed, 107 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 900f412..7d31e90 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -35,9 +35,17 @@ static unsigned long exynos5250_dwmmc_caps[4] = {
 	MMC_CAP_CMD23,
 };
 
+static unsigned long exynos5250_dwmmc_quirks[4] = {
+	DW_MCI_QUIRK_NO_HCON_DMA_INFO,
+	DW_MCI_QUIRK_NO_HCON_DMA_INFO,
+	DW_MCI_QUIRK_NO_HCON_DMA_INFO,
+	DW_MCI_QUIRK_NO_HCON_DMA_INFO,
+};
+
 static struct dw_mci_drv_data exynos5250_drv_data = {
 	.ctrl_type	= DW_MCI_TYPE_EXYNOS5250,
 	.caps		= exynos5250_dwmmc_caps,
+	.quirks		= exynos5250_dwmmc_quirks,
 };
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
@@ -74,7 +82,7 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	host->dev = &pdev->dev;
+	host->pdev = pdev;
 	host->irq_flags = 0;
 	host->pdata = pdev->dev.platform_data;
 	ret = -ENOMEM;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 000da16..b32e200 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -283,8 +283,10 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
+	struct device *dev = &host->pdev->dev;
+
 	host->cmd = cmd;
-	dev_vdbg(host->dev,
+	dev_vdbg(dev,
 		 "start command: ARGR=0x%08x CMDR=0x%08x\n",
 		 cmd->arg, cmd_flags);
 
@@ -323,10 +325,11 @@ static int dw_mci_get_dma_dir(struct mmc_data *data)
 static void dw_mci_dma_cleanup(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;
+	struct device *dev = &host->pdev->dev;
 
 	if (data)
 		if (!data->host_cookie)
-			dma_unmap_sg(host->dev,
+			dma_unmap_sg(dev,
 				     data->sg,
 				     data->sg_len,
 				     dw_mci_get_dma_dir(data));
@@ -351,8 +354,9 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
 static void dw_mci_idmac_complete_dma(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;
+	struct device *dev = &host->pdev->dev;
 
-	dev_vdbg(host->dev, "DMA complete\n");
+	dev_vdbg(dev, "DMA complete\n");
 
 	host->dma_ops->cleanup(host);
 
@@ -420,10 +424,27 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 	mci_writel(host, PLDMND, 1);
 }
 
+static int dw_get_platform_device_id(struct dw_mci *host)
+{
+	int ctrl_id;
+	struct device *dev = &host->pdev->dev;
+
+	if (dev->of_node)
+		ctrl_id = of_alias_get_id(dev->of_node, "mshc");
+	else
+		ctrl_id = host->pdev->id;
+
+	if (ctrl_id < 0)
+		ctrl_id = 0;
+
+	return ctrl_id;
+}
+
 static int dw_mci_idmac_init(struct dw_mci *host)
 {
 	struct idmac_desc *p;
 	int i, dma_support;
+	struct device *dev = &host->pdev->dev;
 
 	/* Number of descriptors in the ring buffer */
 	host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
@@ -431,14 +452,20 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	/* Check if Hardware Configuration Register has support for DMA */
 	dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
 
-	if (!dma_support || dma_support > 2) {
-		dev_err(&host->dev,
+	/*
+	 * In Some of the Soc's the HCON Register is broken. Even though the
+	 * Soc's has a internal DMA the HCON register's DMA field doesnt
+	 * show it. So additional quirk is added for such Soc's
+	 */
+	if ((!dma_support || dma_support > 2) &&
+	    !(host->quirks & DW_MCI_QUIRK_NO_HCON_DMA_INFO)) {
+		dev_err(dev,
 			"Host Controller does not support IDMA Tx.\n");
 		host->dma_ops = NULL;
 		return -ENODEV;
 	}
 
-	dev_info(&host->dev, "Using internal DMA controller.\n");
+	dev_info(dev, "Using internal DMA controller.\n");
 
 	/* Forward link the descriptor list */
 	for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
@@ -474,6 +501,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 {
 	struct scatterlist *sg;
 	unsigned int i, sg_len;
+	struct device *dev = &host->pdev->dev;
 
 	if (!next && data->host_cookie)
 		return data->host_cookie;
@@ -494,7 +522,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 			return -EINVAL;
 	}
 
-	sg_len = dma_map_sg(host->dev,
+	sg_len = dma_map_sg(dev,
 			    data->sg,
 			    data->sg_len,
 			    dw_mci_get_dma_dir(data));
@@ -532,12 +560,13 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
+	struct device *dev = &slot->host->pdev->dev;
 
 	if (!slot->host->use_dma || !data)
 		return;
 
 	if (data->host_cookie)
-		dma_unmap_sg(slot->host->dev,
+		dma_unmap_sg(dev,
 			     data->sg,
 			     data->sg_len,
 			     dw_mci_get_dma_dir(data));
@@ -548,6 +577,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 {
 	int sg_len;
 	u32 temp;
+	struct device *dev = &host->pdev->dev;
 
 	host->using_dma = 0;
 
@@ -563,7 +593,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 
 	host->using_dma = 1;
 
-	dev_vdbg(host->dev,
+	dev_vdbg(dev,
 		 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
 		 (unsigned long)host->sg_cpu, (unsigned long)host->sg_dma,
 		 sg_len);
@@ -928,6 +958,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot;
 	struct mmc_host	*prev_mmc = host->cur_slot->mmc;
+	struct device *dev = &host->pdev->dev;
 
 	WARN_ON(host->cmd || host->data);
 
@@ -937,12 +968,12 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 		slot = list_entry(host->queue.next,
 				  struct dw_mci_slot, queue_node);
 		list_del(&slot->queue_node);
-		dev_vdbg(host->dev, "list not empty: %s is next\n",
+		dev_vdbg(dev, "list not empty: %s is next\n",
 			 mmc_hostname(slot->mmc));
 		host->state = STATE_SENDING_CMD;
 		dw_mci_start_request(host, slot);
 	} else {
-		dev_vdbg(host->dev, "list empty\n");
+		dev_vdbg(dev, "list empty\n");
 		host->state = STATE_IDLE;
 	}
 
@@ -1081,7 +1112,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 					data->bytes_xfered = 0;
 					data->error = -ETIMEDOUT;
 				} else {
-					dev_err(host->dev,
+					dev_err(&host->pdev->dev,
 						"data FIFO error "
 						"(status=%08x)\n",
 						status);
@@ -1829,7 +1860,8 @@ static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
 
 static int dw_mci_of_setup_bus(struct dw_mci *host, u8 slot, u32 bus_wd)
 {
-	struct device_node *np = dw_mci_of_find_slot_node(host->dev, slot);
+	struct device *dev = &host->pdev->dev;
+	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
 	int idx, gpio, ret;
 
 	if (!np)
@@ -1838,13 +1870,13 @@ static int dw_mci_of_setup_bus(struct dw_mci *host, u8 slot, u32 bus_wd)
 	for (idx = 0; idx < NUM_PINS(bus_wd); idx++) {
 		gpio = of_get_gpio(np, idx);
 		if (!gpio_is_valid(gpio)) {
-			dev_err(host->dev, "invalid gpio: %d\n", gpio);
+			dev_err(dev, "invalid gpio: %d\n", gpio);
 			return -EINVAL;
 		}
 
-		ret = devm_gpio_request(host->dev, gpio, "dw-mci-bus");
+		ret = devm_gpio_request(dev, gpio, "dw-mci-bus");
 		if (ret) {
-			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
+			dev_err(dev, "gpio [%d] request failed\n", gpio);
 			return -EBUSY;
 		}
 	}
@@ -1852,11 +1884,11 @@ static int dw_mci_of_setup_bus(struct dw_mci *host, u8 slot, u32 bus_wd)
 	host->slot[slot]->wp_gpio = -1;
 	gpio = of_get_named_gpio(np, "wp-gpios", 0);
 	if (!gpio_is_valid(gpio)) {
-		dev_info(host->dev, "wp gpio not available");
+		dev_info(dev, "wp gpio not available");
 	} else {
-		ret = devm_gpio_request(host->dev, gpio, "dw-mci-wp");
+		ret = devm_gpio_request(dev, gpio, "dw-mci-wp");
 		if (ret)
-			dev_info(host->dev, "gpio [%d] request failed\n",
+			dev_info(dev, "gpio [%d] request failed\n",
 						gpio);
 		else
 			host->slot[slot]->wp_gpio = gpio;
@@ -1865,11 +1897,11 @@ static int dw_mci_of_setup_bus(struct dw_mci *host, u8 slot, u32 bus_wd)
 	host->slot[slot]->cd_gpio = -1;
 	gpio = of_get_named_gpio(np, "cd-gpios", 0);
 	if (!gpio_is_valid(gpio)) {
-		dev_info(host->dev, "cd gpio not available");
+		dev_info(dev, "cd gpio not available");
 	} else {
-		ret = devm_gpio_request(host->dev, gpio, "dw-mci-cd");
+		ret = devm_gpio_request(dev, gpio, "dw-mci-cd");
 		if (ret)
-			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
+			dev_err(dev, "gpio [%d] request failed\n", gpio);
 		else
 			host->slot[slot]->cd_gpio = gpio;
 	}
@@ -1893,8 +1925,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
 	int ctrl_id, ret;
+	struct device *dev = &host->pdev->dev;
 
-	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
+	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), dev);
 	if (!mmc)
 		return -ENOMEM;
 
@@ -1923,11 +1956,8 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
-	if (host->dev->of_node) {
-		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-		if (ctrl_id < 0)
-			ctrl_id = 0;
-	}
+	ctrl_id = dw_get_platform_device_id(host);
+
 	if (host->drv_data->caps)
 		mmc->caps |= host->drv_data->caps[ctrl_id];
 
@@ -1937,9 +1967,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->get_bus_wd) {
 		if (host->pdata->get_bus_wd(slot->id) >= 4)
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
-	} else if (host->dev->of_node) {
+	} else if (dev->of_node) {
 		unsigned int bus_width;
-		bus_width = dw_mci_of_get_bus_wd(host->dev, slot->id);
+		bus_width = dw_mci_of_get_bus_wd(dev, slot->id);
 		switch (bus_width) {
 		case 8:
 			mmc->caps |= MMC_CAP_8_BIT_DATA;
@@ -2030,11 +2060,12 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 
 static void dw_mci_init_dma(struct dw_mci *host)
 {
+	struct device *dev = &host->pdev->dev;
 	/* Alloc memory for sg translation */
-	host->sg_cpu = dma_alloc_coherent(host->dev, PAGE_SIZE,
+	host->sg_cpu = dma_alloc_coherent(dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
 	if (!host->sg_cpu) {
-		dev_err(host->dev, "%s: could not alloc DMA memory\n",
+		dev_err(dev, "%s: could not alloc DMA memory\n",
 			__func__);
 		goto no_dma;
 	}
@@ -2050,12 +2081,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	if (host->dma_ops->init && host->dma_ops->start &&
 	    host->dma_ops->stop && host->dma_ops->cleanup) {
 		if (host->dma_ops->init(host)) {
-			dev_err(host->dev, "%s: Unable to initialize "
+			dev_err(dev, "%s: Unable to initialize "
 				"DMA Controller.\n", __func__);
 			goto no_dma;
 		}
 	} else {
-		dev_err(host->dev, "DMA initialization not found.\n");
+		dev_err(dev, "DMA initialization not found.\n");
 		goto no_dma;
 	}
 
@@ -2063,7 +2094,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	return;
 
 no_dma:
-	dev_info(host->dev, "Using PIO mode.\n");
+	dev_info(dev, "Using PIO mode.\n");
 	host->use_dma = 0;
 	return;
 }
@@ -2109,7 +2140,7 @@ static struct dw_mci_of_quirks {
 static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 {
 	struct dw_mci_board *pdata;
-	struct device *dev = host->dev;
+	struct device *dev = &host->pdev->dev;
 	struct device_node *np = dev->of_node;
 	u32 timing[3];
 	int idx, cnt;
@@ -2166,33 +2197,34 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 int dw_mci_probe(struct dw_mci *host)
 {
-	int width, i, ret = 0;
+	int width, i, ctrl_id, ret = 0;
 	u32 fifo_size;
 	int init_slots = 0;
+	struct device *dev = &host->pdev->dev;
 
 	if (!host->pdata) {
 		host->pdata = dw_mci_parse_dt(host);
 		if (IS_ERR(host->pdata)) {
-			dev_err(host->dev, "platform data not available\n");
+			dev_err(dev, "platform data not available\n");
 			return -EINVAL;
 		}
 	}
 
 	if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
-		dev_err(host->dev,
+		dev_err(dev,
 			"Platform data must supply select_slot function\n");
 		return -ENODEV;
 	}
 
-	host->biu_clk = clk_get(host->dev, "biu");
+	host->biu_clk = clk_get(dev, "biu");
 	if (IS_ERR(host->biu_clk))
-		dev_dbg(host->dev, "biu clock not available\n");
+		dev_dbg(dev, "biu clock not available\n");
 	else
 		clk_prepare_enable(host->biu_clk);
 
-	host->ciu_clk = clk_get(host->dev, "ciu");
+	host->ciu_clk = clk_get(dev, "ciu");
 	if (IS_ERR(host->ciu_clk))
-		dev_dbg(host->dev, "ciu clock not available\n");
+		dev_dbg(dev, "ciu clock not available\n");
 	else
 		clk_prepare_enable(host->ciu_clk);
 
@@ -2202,7 +2234,7 @@ int dw_mci_probe(struct dw_mci *host)
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 
 	if (!host->bus_hz) {
-		dev_err(host->dev,
+		dev_err(dev,
 			"Platform data must supply bus speed\n");
 		ret = -ENODEV;
 		goto err_clk;
@@ -2210,6 +2242,11 @@ int dw_mci_probe(struct dw_mci *host)
 
 	host->quirks = host->pdata->quirks;
 
+	ctrl_id = dw_get_platform_device_id(host);
+
+	if (host->drv_data->quirks)
+		host->quirks |= host->drv_data->quirks[ctrl_id];
+
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
@@ -2243,7 +2280,7 @@ int dw_mci_probe(struct dw_mci *host)
 	}
 
 	/* Reset all blocks */
-	if (!mci_wait_reset(host->dev, host))
+	if (!mci_wait_reset(dev, host))
 		return -ENODEV;
 
 	host->dma_ops = host->pdata->dma_ops;
@@ -2300,15 +2337,15 @@ int dw_mci_probe(struct dw_mci *host)
 	for (i = 0; i < host->num_slots; i++) {
 		ret = dw_mci_init_slot(host, i);
 		if (ret)
-			dev_dbg(host->dev, "slot %d init failed\n", i);
+			dev_dbg(dev, "slot %d init failed\n", i);
 		else
 			init_slots++;
 	}
 
 	if (init_slots) {
-		dev_info(host->dev, "%d slots initialized\n", init_slots);
+		dev_info(dev, "%d slots initialized\n", init_slots);
 	} else {
-		dev_dbg(host->dev, "attempted to initialize %d slots, "
+		dev_dbg(dev, "attempted to initialize %d slots, "
 					"but failed on all\n", host->num_slots);
 		goto err_init_slot;
 	}
@@ -2318,7 +2355,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * Need to check the version-id and set data-offset for DATA register.
 	 */
 	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
-	dev_info(host->dev, "Version ID is %04x\n", host->verid);
+	dev_info(dev, "Version ID is %04x\n", host->verid);
 
 	if (host->verid < DW_MMC_240A)
 		host->data_offset = DATA_OFFSET;
@@ -2335,12 +2372,12 @@ int dw_mci_probe(struct dw_mci *host)
 		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
 
-	dev_info(host->dev, "DW MMC controller at irq %d, "
+	dev_info(dev, "DW MMC controller at irq %d, "
 		 "%d bit host data width, "
 		 "%u deep fifo\n",
 		 host->irq, width, fifo_size);
 	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
-		dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
+		dev_info(dev, "Internal DMAC interrupt fix enabled.\n");
 
 	return 0;
 
@@ -2353,7 +2390,7 @@ err_workqueue:
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-	dma_free_coherent(host->dev, PAGE_SIZE,
+	dma_free_coherent(dev, PAGE_SIZE,
 			  host->sg_cpu, host->sg_dma);
 
 	if (host->vmmc) {
@@ -2377,23 +2414,23 @@ EXPORT_SYMBOL(dw_mci_probe);
 void dw_mci_remove(struct dw_mci *host)
 {
 	int i;
+	struct device *dev = &host->pdev->dev;
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
 	for (i = 0; i < host->num_slots; i++) {
-		dev_dbg(host->dev, "remove slot %d\n", i);
+		dev_dbg(dev, "remove slot %d\n", i);
 		if (host->slot[i])
 			dw_mci_cleanup_slot(host->slot[i], i);
 	}
-
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);
 
 	free_irq(host->irq, host);
 	destroy_workqueue(host->card_workqueue);
-	dma_free_coherent(host->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+	dma_free_coherent(dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
@@ -2451,7 +2488,7 @@ int dw_mci_resume(struct dw_mci *host)
 	if (host->vmmc)
 		regulator_enable(host->vmmc);
 
-	if (!mci_wait_reset(host->dev, host)) {
+	if (!mci_wait_reset(&host->pdev->dev, host)) {
 		ret = -ENODEV;
 		return ret;
 	}
@@ -2483,7 +2520,7 @@ EXPORT_SYMBOL(dw_mci_resume);
 
 static int __init dw_mci_init(void)
 {
-	printk(KERN_INFO "Synopsys Designware Multimedia Card Interface Driver");
+	pr_info("Synopsys Designware Multimedia Card Interface Driver");
 	return 0;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6c17282..a3d684b 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -203,6 +203,7 @@ extern int dw_mci_resume(struct dw_mci *host);
 struct dw_mci_drv_data {
 	unsigned long		ctrl_type;
 	unsigned long		*caps;
+	unsigned long		*quirks;
 };
 
 #endif /* _DW_MMC_H_ */
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 32c778f..03c409b 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -161,7 +161,7 @@ struct dw_mci {
 	u32			fifoth_val;
 	u16			verid;
 	u16			data_offset;
-	struct device		*dev;
+	struct platform_device	*pdev;
 	struct dw_mci_board	*pdata;
 	struct dw_mci_drv_data	*drv_data;
 	struct clk		*biu_clk;
@@ -215,6 +215,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
 /* Write Protect detection not available */
 #define DW_MCI_QUIRK_NO_WRITE_PROTECT		BIT(4)
+/* HCON Register's IDMAC information broken */
+#define DW_MCI_QUIRK_NO_HCON_DMA_INFO		BIT(5)
 
 struct dma_pdata;
 
-- 
1.7.4.1

