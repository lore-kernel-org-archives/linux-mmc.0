From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 1/3] mmc: dw_mmc: remove the quirks flags
Date: Tue, 21 Jun 2016 14:35:37 +0900
Message-ID: <1466487339-13211-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33198 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbcFUFqo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 01:46:44 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9302Q7YWVHZ4B0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Jun 2016 14:35:41 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the quirks flag. (DW_MCI_QUIRK_BROKEN_DTO)
For removing this, enabled the dto_timer by defaults.
It doesn't see any I/O performance degression.
In future, dwmmc controller should not use the quirks flag.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changelog V2:
	- Added Shawn's Reviewed-by tag

 drivers/mmc/host/dw_mmc-rockchip.c |  3 ---
 drivers/mmc/host/dw_mmc.c          | 16 +++++-----------
 include/linux/mmc/dw_mmc.h         |  9 ---------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 358b0dc..d3cf1f1 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -285,9 +285,6 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	/* It is slot 8 on Rockchip SoCs */
 	host->sdio_id0 = 8;
 
-	/* It needs this quirk on all Rockchip SoCs */
-	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO;
-
 	if (of_device_is_compatible(host->dev->of_node,
 				    "rockchip,rk3288-dw-mshc"))
 		host->bus_hz /= RK3288_CLKGEN_DIV;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87f8529..5cf143b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1802,8 +1802,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				 * If all data-related interrupts don't come
 				 * within the given time in reading data state.
 				 */
-				if ((host->quirks & DW_MCI_QUIRK_BROKEN_DTO) &&
-				    (host->dir_status == DW_MCI_RECV_STATUS))
+				if (host->dir_status == DW_MCI_RECV_STATUS)
 					dw_mci_set_drto(host);
 				break;
 			}
@@ -1845,8 +1844,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				 * interrupt doesn't come within the given time.
 				 * in reading data state.
 				 */
-				if ((host->quirks & DW_MCI_QUIRK_BROKEN_DTO) &&
-				    (host->dir_status == DW_MCI_RECV_STATUS))
+				if (host->dir_status == DW_MCI_RECV_STATUS)
 					dw_mci_set_drto(host);
 				break;
 			}
@@ -2412,8 +2410,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
-			if (host->quirks & DW_MCI_QUIRK_BROKEN_DTO)
-				del_timer(&host->dto_timer);
+			del_timer(&host->dto_timer);
 
 			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
 			if (!host->data_status)
@@ -3004,11 +3001,8 @@ int dw_mci_probe(struct dw_mci *host)
 	setup_timer(&host->cmd11_timer,
 		    dw_mci_cmd11_timer, (unsigned long)host);
 
-	host->quirks = host->pdata->quirks;
-
-	if (host->quirks & DW_MCI_QUIRK_BROKEN_DTO)
-		setup_timer(&host->dto_timer,
-			    dw_mci_dto_timer, (unsigned long)host);
+	setup_timer(&host->dto_timer,
+		    dw_mci_dto_timer, (unsigned long)host);
 
 	spin_lock_init(&host->lock);
 	spin_lock_init(&host->irq_lock);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index f7ed271..83b0edfc 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -112,7 +112,6 @@ struct dw_mci_dma_slave {
  * @part_buf: Simple buffer for partial fifo reads/writes.
  * @push_data: Pointer to FIFO push function.
  * @pull_data: Pointer to FIFO pull function.
- * @quirks: Set of quirks that apply to specific versions of the IP.
  * @vqmmc_enabled: Status of vqmmc, should be true or false.
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
@@ -218,9 +217,6 @@ struct dw_mci {
 	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
 	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
 
-	/* Workaround flags */
-	u32			quirks;
-
 	bool			vqmmc_enabled;
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
@@ -242,17 +238,12 @@ struct dw_mci_dma_ops {
 	void (*exit)(struct dw_mci *host);
 };
 
-/* IP Quirks/flags. */
-/* Timer for broken data transfer over scheme */
-#define DW_MCI_QUIRK_BROKEN_DTO			BIT(0)
-
 struct dma_pdata;
 
 /* Board platform data */
 struct dw_mci_board {
 	u32 num_slots;
 
-	u32 quirks; /* Workaround / Quirk flags */
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-- 
1.9.1

