From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 1/1] mmc: Support of PCI mode for the dw_mmc driver This Patch adds the support for the scenario where the Synopsys Designware IP is present on the PCI bus.The patch adds the minimal modifications necessary for the driver to work on PCI platform. The Driver has also been tested for on the PCI platform with single Card Slot.
Date: Wed, 28 Sep 2011 20:32:19 +0530
Message-ID: <1317222139-5552-1-git-send-email-shashidharh@vayavyalabs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53469 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1I1PCf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 11:02:35 -0400
Received: by yxl31 with SMTP id 31so6454393yxl.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 08:02:35 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shawn Guo <shawn.guo@li>
Cc: linux-mmc@vger.kernel.org, Shashidhar Hiremath <shashidharh@vayavyalabs.com>


Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 drivers/mmc/host/Kconfig   |   11 ++++
 drivers/mmc/host/dw_mmc.c  |  126 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h  |   12 ++++
 include/linux/mmc/dw_mmc.h |    4 ++
 4 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c87096..84d8908 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -526,6 +526,17 @@ config MMC_DW
 	  block, this provides host support for SD and MMC interfaces, in both
 	  PIO and external DMA modes.
 
+config MMC_DW_PCI
+	bool "MMC_DW Support On PCI bus"
+	depends on MMC_DW && PCI
+	help
+	  This selects the PCI for the Synopsys Designware Mobile Storage IP.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
+
 config MMC_DW_IDMAC
 	bool "Internal DMAC interface"
 	depends on MMC_DW
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0f714..74f28a5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -21,7 +21,11 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#ifdef CONFIG_MMC_DW_PCI
+#include <linux/pci.h>
+#else
 #include <linux/platform_device.h>
+#endif
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -101,6 +105,18 @@ struct dw_mci_slot {
 	int			last_detect_state;
 };
 
+#ifdef CONFIG_MMC_DW_PCI
+static struct pci_device_id dw_mci_id  = {  PCI_DEVICE(DEVICE_ID, VENDOR_ID) };
+
+struct dw_mci_board pci_board_data = {
+	.num_slots			= 1,
+	.caps				= DW_MCI_CAPABILITIES,
+	.bus_hz				= 33 * 1000 * 1000,
+	.detect_delay_ms		= 200,
+	.fifo_depth			= 32,
+};
+#endif
+
 static struct workqueue_struct *dw_mci_card_workqueue;
 
 #if defined(CONFIG_DEBUG_FS)
@@ -682,6 +698,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	u32 regs;
+#ifdef CONFIG_MMC_DW_PCI
+	u32 card_detect;
+#endif
 
 	/* set default 1 bit mode */
 	slot->ctype = SDMMC_CTYPE_1BIT;
@@ -716,7 +735,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
+#ifdef CONFIG_MMC_DW_PCI
+		/* Enable Power to the card that has been detected */
+		card_detect = mci_readl(slot->host, CDETECT);
+		mci_writel(slot->host, PWREN, ((~card_detect) & 0x1));
+		break;
+	case MMC_POWER_OFF:
+		mci_writel(slot->host, PWREN, 0);
 		break;
+#endif
 	default:
 		break;
 	}
@@ -1775,7 +1802,12 @@ static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
 	return false;
 }
 
+#ifdef CONFIG_MMC_DW_PCI
+static int __devinit dw_mci_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *entries)
+#else
 static int dw_mci_probe(struct platform_device *pdev)
+#endif
 {
 	struct dw_mci *host;
 	struct resource	*regs;
@@ -1783,6 +1815,16 @@ static int dw_mci_probe(struct platform_device *pdev)
 	int irq, ret, i, width;
 	u32 fifo_size;
 
+#ifdef CONFIG_MMC_DW_PCI
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+	if (pci_request_regions(pdev, "dw_mmc")) {
+		ret = -ENODEV;
+		goto err_freehost;
+	}
+	irq = pdev->irq;
+#else
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENXIO;
@@ -1790,19 +1832,26 @@ static int dw_mci_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+#endif
 
 	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
 	if (!host)
 		return -ENOMEM;
 
 	host->pdev = pdev;
+#ifdef CONFIG_MMC_DW_PCI
+	host->pdata = pdata = &pci_board_data;
+#else
 	host->pdata = pdata = pdev->dev.platform_data;
+#endif
+#ifndef CONFIG_MMC_DW_PCI
 	if (!pdata || !pdata->init) {
 		dev_err(&pdev->dev,
 			"Platform data must supply init function\n");
 		ret = -ENODEV;
 		goto err_freehost;
 	}
+#endif
 
 	if (!pdata->select_slot && pdata->num_slots > 1) {
 		dev_err(&pdev->dev,
@@ -1825,9 +1874,17 @@ static int dw_mci_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&host->queue);
 
 	ret = -ENOMEM;
+#ifdef CONFIG_MMC_DW_PCI
+	host->regs = pci_iomap(pdev, PCI_BAR_NO, COMPLETE_BAR);
+	if (!host->regs) {
+		ret = -EIO;
+		goto err_free_res;
+	}
+#else
 	host->regs = ioremap(regs->start, resource_size(regs));
 	if (!host->regs)
 		goto err_freehost;
+#endif
 
 	host->dma_ops = pdata->dma_ops;
 	dw_mci_init_dma(host);
@@ -1903,11 +1960,19 @@ static int dw_mci_probe(struct platform_device *pdev)
 		goto err_dmaunmap;
 	INIT_WORK(&host->card_work, dw_mci_work_routine_card);
 
+#ifdef CONFIG_MMC_DW_PCI
+	ret = request_irq(irq, dw_mci_interrupt, IRQF_SHARED, "dw-mci", host);
+#else
 	ret = request_irq(irq, dw_mci_interrupt, 0, "dw-mci", host);
+#endif
 	if (ret)
 		goto err_workqueue;
 
+#ifdef CONFIG_MMC_DW_PCI
+	pci_set_drvdata(pdev, host);
+#else
 	platform_set_drvdata(pdev, host);
+#endif
 
 	if (host->pdata->num_slots)
 		host->num_slots = host->pdata->num_slots;
@@ -1966,21 +2031,38 @@ err_dmaunmap:
 		regulator_put(host->vmmc);
 	}
 
+#ifdef CONFIG_MMC_DW_PCI
+err_free_res:
+	pci_release_regions(pdev);
+#endif
 
 err_freehost:
 	kfree(host);
 	return ret;
 }
 
+#ifdef CONFIG_MMC_DW_PCI
+static void __devexit dw_mci_remove(struct pci_dev *pdev)
+#else
 static int __exit dw_mci_remove(struct platform_device *pdev)
+#endif
 {
+
+#ifdef CONFIG_MMC_DW_PCI
+	struct dw_mci *host = pci_get_drvdata(pdev);
+#else
 	struct dw_mci *host = platform_get_drvdata(pdev);
+#endif
 	int i;
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
+#ifdef CONFIG_MMC_DW_PCI
+	pci_set_drvdata(pdev, NULL);
+#else
 	platform_set_drvdata(pdev, NULL);
+#endif
 
 	for (i = 0; i < host->num_slots; i++) {
 		dev_dbg(&pdev->dev, "remove slot %d\n", i);
@@ -1992,7 +2074,11 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);
 
+#ifdef CONFIG_MMC_DW_PCI
+	free_irq(pdev->irq, host);
+#else
 	free_irq(platform_get_irq(pdev, 0), host);
+#endif
 	destroy_workqueue(dw_mci_card_workqueue);
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 
@@ -2006,18 +2092,31 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
 
 	iounmap(host->regs);
 
+#ifdef CONFIG_MMC_DW_PCI
+	pci_release_regions(pdev);
+#endif
 	kfree(host);
+#ifndef CONFIG_MMC_DW_PCI
 	return 0;
+#endif
 }
 
 #ifdef CONFIG_PM
 /*
  * TODO: we should probably disable the clock to the card in the suspend path.
  */
+#ifdef CONFIG_MMC_DW_PCI
+static int dw_mci_suspend(struct pci_dev *pdev, pm_message_t mesg)
+#else
 static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
+#endif
 {
 	int i, ret;
+#ifdef CONFIG_MMC_DW_PCI
+	struct dw_mci *host = pci_get_drvdata(pdev);
+#else
 	struct dw_mci *host = platform_get_drvdata(pdev);
+#endif
 
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
@@ -2040,10 +2139,18 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return 0;
 }
 
+#ifdef CONFIG_MMC_DW_PCI
+static int dw_mci_resume(struct pci_dev *pdev)
+#else
 static int dw_mci_resume(struct platform_device *pdev)
+#endif
 {
 	int i, ret;
+#ifdef CONFIG_MMC_DW_PCI
+	struct dw_mci *host = pci_get_drvdata(pdev);
+#else
 	struct dw_mci *host = platform_get_drvdata(pdev);
+#endif
 
 	if (host->vmmc)
 		regulator_enable(host->vmmc);
@@ -2081,6 +2188,16 @@ static int dw_mci_resume(struct platform_device *pdev)
 #define dw_mci_resume	NULL
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_MMC_DW_PCI
+static struct pci_driver dw_mci_driver = {
+	.name		= "dw_mmc",
+	.id_table	= &dw_mci_id,
+	.probe		= dw_mci_probe,
+	.remove		= dw_mci_remove,
+	.suspend	= dw_mci_suspend,
+	.resume		= dw_mci_resume,
+};
+#else
 static struct platform_driver dw_mci_driver = {
 	.remove		= __exit_p(dw_mci_remove),
 	.suspend	= dw_mci_suspend,
@@ -2089,15 +2206,24 @@ static struct platform_driver dw_mci_driver = {
 		.name		= "dw_mmc",
 	},
 };
+#endif
 
 static int __init dw_mci_init(void)
 {
+#ifdef CONFIG_MMC_DW_PCI
+	return pci_register_driver(&dw_mci_driver);
+#else
 	return platform_driver_probe(&dw_mci_driver, dw_mci_probe);
+#endif
 }
 
 static void __exit dw_mci_exit(void)
 {
+#ifdef CONFIG_MMC_DW_PCI
+	pci_unregister_driver(&dw_mci_driver);
+#else
 	platform_driver_unregister(&dw_mci_driver);
+#endif
 }
 
 module_init(dw_mci_init);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 027d377..3b1e459 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -164,4 +164,16 @@
 	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
 #endif
 
+/* PCI Specific macros */
+#ifdef CONFIG_MMC_DW_PCI
+#define PCI_BAR_NO 2
+#define COMPLETE_BAR 0
+/* Dummy Device Id and Vendor Id */
+#define VENDOR_ID 0x700
+#define DEVICE_ID 0x1107
+/* Defining the Capabilities */
+#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED |\
+			 MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA | MMC_CAP_SDIO_IRQ)
+#endif
+
 #endif /* _DW_MMC_H_ */
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6b46819..87af5a6 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -147,7 +147,11 @@ struct dw_mci {
 	u32			current_speed;
 	u32			num_slots;
 	u32			fifoth_val;
+#ifdef CONFIG_MMC_DW_PCI
+	struct pci_dev		*pdev;
+#else
 	struct platform_device	*pdev;
+#endif
 	struct dw_mci_board	*pdata;
 	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
 
-- 
1.7.2.3

