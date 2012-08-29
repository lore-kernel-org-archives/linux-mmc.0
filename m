From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v5 8/9] mmc: dw_mmc: add support for implementation specific
 callbacks
Date: Wed, 29 Aug 2012 16:18:14 +0530
Message-ID: <1346237295-7116-9-git-send-email-thomas.abraham@linaro.org>
References: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

The core dw-mshc controller driver can let platform specific implementations
of the dw-mshc controller to control the hardware as required by such
implementations. This is acheived by invoking implementation specific (optional)
callbacks. Define the list of callbacks supported the add invocation points
for the same.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   12 ++++++++++--
 drivers/mmc/host/dw_mmc-pltfm.h |    3 ++-
 drivers/mmc/host/dw_mmc.c       |   38 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h       |   22 ++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h      |    4 ++++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index e17da91..c960ca7 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -23,7 +23,8 @@
 
 #include "dw_mmc.h"
 
-int dw_mci_pltfm_register(struct platform_device *pdev)
+int dw_mci_pltfm_register(struct platform_device *pdev,
+				struct dw_mci_drv_data *drv_data)
 {
 	struct dw_mci *host;
 	struct resource	*regs;
@@ -41,6 +42,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev)
 	if (host->irq < 0)
 		return host->irq;
 
+	host->drv_data = drv_data;
 	host->dev = &pdev->dev;
 	host->irq_flags = 0;
 	host->pdata = pdev->dev.platform_data;
@@ -48,6 +50,12 @@ int dw_mci_pltfm_register(struct platform_device *pdev)
 	if (!host->regs)
 		return -ENOMEM;
 
+	if (host->drv_data->init) {
+		ret = host->drv_data->init(host);
+		if (ret)
+			return ret;
+	}
+
 	platform_set_drvdata(pdev, host);
 	ret = dw_mci_probe(host);
 	return ret;
@@ -56,7 +64,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
 static int __devinit dw_mci_pltfm_probe(struct platform_device *pdev)
 {
-	return dw_mci_pltfm_register(pdev);
+	return dw_mci_pltfm_register(pdev, NULL);
 }
 
 static int __devexit dw_mci_pltfm_remove(struct platform_device *pdev)
diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
index 6c065d9..301f245 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -12,7 +12,8 @@
 #ifndef _DW_MMC_PLTFM_H_
 #define _DW_MMC_PLTFM_H_
 
-extern int dw_mci_pltfm_register(struct platform_device *pdev);
+extern int dw_mci_pltfm_register(struct platform_device *pdev,
+				struct dw_mci_drv_data *drv_data);
 extern int __devexit dw_mci_pltfm_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops dw_mci_pltfm_pmops;
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1308619..8dd698b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -231,6 +231,7 @@ static void dw_mci_set_timeout(struct dw_mci *host)
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct mmc_data	*data;
+	struct dw_mci_slot *slot = mmc_priv(mmc);
 	u32 cmdr;
 	cmd->error = -EINPROGRESS;
 
@@ -260,6 +261,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmdr |= SDMMC_CMD_DAT_WR;
 	}
 
+	if (slot->host->drv_data->prepare_command)
+		slot->host->drv_data->prepare_command(slot->host, &cmdr);
+
 	return cmdr;
 }
 
@@ -815,6 +819,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		slot->clock = ios->clock;
 	}
 
+	if (slot->host->drv_data->set_ios)
+		slot->host->drv_data->set_ios(slot->host, ios);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
@@ -1820,6 +1827,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
+	int ctrl_id, ret;
 	u8 bus_width;
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
@@ -1851,6 +1859,16 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
+	if (host->dev->of_node) {
+		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
+		if (ctrl_id < 0)
+			ctrl_id = 0;
+	} else {
+		ctrl_id = to_platform_device(host->dev)->id;
+	}
+	if (host->drv_data && host->drv_data->caps)
+		mmc->caps |= host->drv_data->caps[ctrl_id];
+
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
@@ -1861,6 +1879,14 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	else
 		bus_width = 1;
 
+	if (host->drv_data->setup_bus) {
+		struct device_node *slot_np;
+		slot_np = dw_mci_of_find_slot_node(host->dev, slot->id);
+		ret = host->drv_data->setup_bus(host, slot_np, bus_width);
+		if (ret)
+			goto err_setup_bus;
+	}
+
 	switch (bus_width) {
 	case 8:
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
@@ -1927,6 +1953,10 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	queue_work(host->card_workqueue, &host->card_work);
 
 	return 0;
+
+err_setup_bus:
+	mmc_free_host(mmc);
+	return -EINVAL;
 }
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
@@ -2021,7 +2051,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	struct dw_mci_board *pdata;
 	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
-	int idx;
+	int idx, ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
@@ -2048,6 +2078,12 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
 
+	if (host->drv_data->parse_dt) {
+		ret = host->drv_data->parse_dt(host);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return pdata;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 15c27e1..a9f045a 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -182,4 +182,26 @@ extern int dw_mci_suspend(struct dw_mci *host);
 extern int dw_mci_resume(struct dw_mci *host);
 #endif
 
+/**
+ * dw_mci driver data - dw-mshc implementation specific driver data.
+ * @caps: mmc subsystem specified capabilities of the controller(s).
+ * @init: early implementation specific initialization.
+ * @prepare_command: handle CMD register extensions.
+ * @set_ios: handle bus specific extensions.
+ * @parse_dt: parse implementation specific device tree properties.
+ * @setup_bus: initialize io-interface
+ *
+ * Provide controller implementation specific extensions. The usage of this
+ * data structure is fully optional and usage of each member in this structure
+ * is optional as well.
+ */
+struct dw_mci_drv_data {
+	unsigned long	*caps;
+	int		(*init)(struct dw_mci *host);
+	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
+	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
+	int		(*parse_dt)(struct dw_mci *host);
+	int		(*setup_bus)(struct dw_mci *host,
+				struct device_node *slot_np, u8 bus_width);
+};
 #endif /* _DW_MMC_H_ */
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index b72e4aa..6cb043e 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -78,6 +78,8 @@ struct mmc_data;
  * @data_offset: Set the offset of DATA register according to VERID.
  * @dev: Device associated with the MMC controller.
  * @pdata: Platform data associated with the MMC controller.
+ * @drv_data: Driver specific data for identified variant of the controller
+ * @priv: Implementation defined private data.
  * @biu_clk: Pointer to bus interface unit clock instance.
  * @ciu_clk: Pointer to card interface unit clock instance.
  * @slot: Slots sharing this MMC controller.
@@ -160,6 +162,8 @@ struct dw_mci {
 	u16			data_offset;
 	struct device		*dev;
 	struct dw_mci_board	*pdata;
+	struct dw_mci_drv_data	*drv_data;
+	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
 	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
-- 
1.6.6.rc2
