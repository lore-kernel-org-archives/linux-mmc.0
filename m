From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 5/9] mmc: cavium: Add support for Octeon cn7890
Date: Mon,  6 Feb 2017 14:39:48 +0100
Message-ID: <20170206133953.8390-6-jglauber@cavium.com>
References: <20170206133953.8390-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170206133953.8390-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

The MMC unit on Octeon cn7890 differs in that it has multiple
interrupts. Requires a lock for the interrupt handler. DMA addresses
have a dedicated 64 bit register now, so use that when available.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 drivers/mmc/host/cavium-mmc.c          | 16 ++++++-
 drivers/mmc/host/cavium-mmc.h          |  6 +++
 drivers/mmc/host/cavium-pltfm-octeon.c | 79 +++++++++++++++++++++++++++-------
 3 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
index e9e6f76..f1fe291 100644
--- a/drivers/mmc/host/cavium-mmc.c
+++ b/drivers/mmc/host/cavium-mmc.c
@@ -385,8 +385,14 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	union mio_emm_rsp_sts rsp_sts;
 	union mio_emm_int emm_int;
 	struct mmc_request *req;
+	unsigned long flags = 0;
 	bool host_done;
 
+	if (host->need_irq_handler_lock)
+		spin_lock_irqsave(&host->irq_handler_lock, flags);
+	else
+		__acquire(&host->irq_handler_lock);
+
 	/* Clear interrupt bits (write 1 clears ). */
 	emm_int.val = readq(host->base + MIO_EMM_INT);
 	writeq(emm_int.val, host->base + MIO_EMM_INT);
@@ -444,6 +450,10 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	if (host_done)
 		host->release_bus(host);
 out:
+	if (host->need_irq_handler_lock)
+		spin_unlock_irqrestore(&host->irq_handler_lock, flags);
+	else
+		__release(&host->irq_handler_lock);
 	return IRQ_RETVAL(emm_int.val != 0);
 }
 
@@ -471,11 +481,15 @@ static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
 	dma_cfg.s.size = (sg_dma_len(&data->sg[0]) / 8) - 1;
 
 	addr = sg_dma_address(&data->sg[0]);
-	dma_cfg.s.adr = addr;
+	if (!host->big_dma_addr)
+		dma_cfg.s.adr = addr;
 	writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
 
 	pr_debug("[%s] sg_dma_len: %u  total sg_elem: %d\n",
 		 (dma_cfg.s.rw) ? "W" : "R", sg_dma_len(&data->sg[0]), count);
+
+	if (host->big_dma_addr)
+		writeq(addr, host->dma_base + MIO_EMM_DMA_ADR);
 	return addr;
 }
 
diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
index f350212..5f41be9 100644
--- a/drivers/mmc/host/cavium-mmc.h
+++ b/drivers/mmc/host/cavium-mmc.h
@@ -49,6 +49,12 @@ struct cvm_mmc_host {
 	struct sg_mapping_iter smi;
 	bool dma_active;
 
+	bool has_ciu3;
+	bool big_dma_addr;
+	bool need_irq_handler_lock;
+	spinlock_t irq_handler_lock;
+	struct semaphore mmc_serializer;
+
 	struct gpio_desc *global_pwr_gpiod;
 
 	struct cvm_mmc_slot *slot[CAVIUM_MAX_MMC];
diff --git a/drivers/mmc/host/cavium-pltfm-octeon.c b/drivers/mmc/host/cavium-pltfm-octeon.c
index 4fbc67e..ad82a13 100644
--- a/drivers/mmc/host/cavium-pltfm-octeon.c
+++ b/drivers/mmc/host/cavium-pltfm-octeon.c
@@ -23,20 +23,28 @@ extern void l2c_unlock_mem_region(u64 start, u64 len);
 
 static void octeon_mmc_acquire_bus(struct cvm_mmc_host *host)
 {
-	/* Switch the MMC controller onto the bus. */
-	down(&octeon_bootbus_sem);
-	writeq(0, (void __iomem *)CVMX_MIO_BOOT_CTL);
+	if (!host->has_ciu3) {
+		/* Switch the MMC controller onto the bus. */
+		down(&octeon_bootbus_sem);
+		writeq(0, (void __iomem *)CVMX_MIO_BOOT_CTL);
+	} else {
+		down(&host->mmc_serializer);
+	}
 }
 
 static void octeon_mmc_release_bus(struct cvm_mmc_host *host)
 {
-	up(&octeon_bootbus_sem);
+	if (!host->has_ciu3)
+		up(&octeon_bootbus_sem);
+	else
+		up(&host->mmc_serializer);
 }
 
 static void octeon_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
 {
 	writeq(val, host->base + MIO_EMM_INT);
-	writeq(val, host->base + MIO_EMM_INT_EN);
+	if (!host->dma_active || (host->dma_active && !host->has_ciu3))
+		writeq(val, host->base + MIO_EMM_INT_EN);
 }
 
 static void octeon_mmc_dmar_fixup(struct cvm_mmc_host *host,
@@ -75,6 +83,9 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
+	spin_lock_init(&host->irq_handler_lock);
+	sema_init(&host->mmc_serializer, 1);
+
 	host->dev = &pdev->dev;
 	host->acquire_bus = octeon_mmc_acquire_bus;
 	host->release_bus = octeon_mmc_release_bus;
@@ -87,12 +98,34 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 
 	host->sys_freq = octeon_get_io_clock_rate();
 
-	/* First one is EMM second DMA */
-	for (i = 0; i < 2; i++) {
-		mmc_irq[i] = platform_get_irq(pdev, i);
-		if (mmc_irq[i] < 0)
-			return mmc_irq[i];
+	if (of_device_is_compatible(node, "cavium,octeon-7890-mmc")) {
+		host->big_dma_addr = true;
+		host->need_irq_handler_lock = true;
+		host->has_ciu3 = true;
+		/*
+		 * First seven are the EMM_INT bits 0..6, then two for
+		 * the EMM_DMA_INT bits
+		 */
+		for (i = 0; i < 9; i++) {
+			mmc_irq[i] = platform_get_irq(pdev, i);
+			if (mmc_irq[i] < 0)
+				return mmc_irq[i];
+
+			/* work around legacy u-boot device trees */
+			irq_set_irq_type(mmc_irq[i], IRQ_TYPE_EDGE_RISING);
+		}
+	} else {
+		host->big_dma_addr = false;
+		host->need_irq_handler_lock = false;
+		host->has_ciu3 = false;
+		/* First one is EMM second DMA */
+		for (i = 0; i < 2; i++) {
+			mmc_irq[i] = platform_get_irq(pdev, i);
+			if (mmc_irq[i] < 0)
+				return mmc_irq[i];
+		}
 	}
+
 	host->last_slot = -1;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -122,12 +155,26 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	val = readq(host->base + MIO_EMM_INT);
 	writeq(val, host->base + MIO_EMM_INT);
 
-	ret = devm_request_irq(&pdev->dev, mmc_irq[0],
-			       cvm_mmc_interrupt, 0, KBUILD_MODNAME, host);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
-			mmc_irq[0]);
-		return ret;
+	if (host->has_ciu3) {
+		/* Only CMD_DONE, DMA_DONE, CMD_ERR, DMA_ERR */
+		for (i = 1; i <= 4; i++) {
+			ret = devm_request_irq(&pdev->dev, mmc_irq[i],
+					       cvm_mmc_interrupt,
+					       0, KBUILD_MODNAME, host);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+					mmc_irq[i]);
+				return ret;
+			}
+		}
+	} else {
+		ret = devm_request_irq(&pdev->dev, mmc_irq[0],
+				       cvm_mmc_interrupt, 0, KBUILD_MODNAME, host);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+				mmc_irq[0]);
+			return ret;
+		}
 	}
 
 	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev, "power",
-- 
2.9.0.rc0.21.g7777322
