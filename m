From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 7/7] mmc: host: dw_mmc: fix fifo ordering in big endian
Date: Wed, 25 Mar 2015 11:23:30 +0000
Message-ID: <1427282610-10350-8-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282610-10350-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:52192 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbCYLXo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Mar 2015 07:23:44 -0400
In-Reply-To: <1427282610-10350-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@lists.codethink.co.uk, marc.dunford@codethink.co.uk, sam.bishop@codethink.co.uk, Dinh Nguyen <dinguyen@opensource.altera.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Linux MMC <linux-mmc@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

The dw_mmc driver changes to make the IO accesors endian agnostic did not
take into account the fifo accesses do not need to be swapped. To fix this
add a mmci_fifo_read/write wrapper to allow these to be passed through the
IO without being swapped.

Since these are now specific functions, it would be easier just to store
the pointer to the fifo registers in the host block instead of the offset
to them. So change the host->data_offset to host->fifo_reg (which also
means we catch all the places this is read or written).

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux MMC <linux-mmc@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  | 59 +++++++++++++++++++---------------------------
 drivers/mmc/host/dw_mmc.h  | 14 +++++++++++
 include/linux/mmc/dw_mmc.h |  4 ++--
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 12e681c..98f0c92 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1685,8 +1685,7 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
 		buf += len;
 		cnt -= len;
 		if (host->part_buf_count == 2) {
-			mci_writew(host, DATA(host->data_offset),
-					host->part_buf16);
+			mci_fifo_writew(host->fifo_reg, host->part_buf16);
 			host->part_buf_count = 0;
 		}
 	}
@@ -1703,15 +1702,14 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
 			cnt -= len;
 			/* push data from aligned buffer into fifo */
 			for (i = 0; i < items; ++i)
-				mci_writew(host, DATA(host->data_offset),
-						aligned_buf[i]);
+				mci_fifo_writew(host->fifo_reg, aligned_buf[i]);
 		}
 	} else
 #endif
 	{
 		u16 *pdata = buf;
 		for (; cnt >= 2; cnt -= 2)
-			mci_writew(host, DATA(host->data_offset), *pdata++);
+			mci_fifo_writew(host->fifo_reg, *pdata++);
 		buf = pdata;
 	}
 	/* put anything remaining in the part_buf */
@@ -1720,8 +1718,7 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
 		 /* Push data if we have reached the expected data length */
 		if ((data->bytes_xfered + init_cnt) ==
 		    (data->blksz * data->blocks))
-			mci_writew(host, DATA(host->data_offset),
-				   host->part_buf16);
+			mci_fifo_writew(host->fifo_reg, host->part_buf16);
 	}
 }
 
@@ -1736,8 +1733,7 @@ static void dw_mci_pull_data16(struct dw_mci *host, void *buf, int cnt)
 			int items = len >> 1;
 			int i;
 			for (i = 0; i < items; ++i)
-				aligned_buf[i] = mci_readw(host,
-						DATA(host->data_offset));
+				aligned_buf[i] = mci_fifo_readw(host->fifo_reg);
 			/* memcpy from aligned buffer into output buffer */
 			memcpy(buf, aligned_buf, len);
 			buf += len;
@@ -1748,11 +1744,11 @@ static void dw_mci_pull_data16(struct dw_mci *host, void *buf, int cnt)
 	{
 		u16 *pdata = buf;
 		for (; cnt >= 2; cnt -= 2)
-			*pdata++ = mci_readw(host, DATA(host->data_offset));
+			*pdata++ = mci_fifo_readw(host->fifo_reg);
 		buf = pdata;
 	}
 	if (cnt) {
-		host->part_buf16 = mci_readw(host, DATA(host->data_offset));
+		host->part_buf16 = mci_fifo_readw(host->fifo_reg);
 		dw_mci_pull_final_bytes(host, buf, cnt);
 	}
 }
@@ -1768,8 +1764,7 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
 		buf += len;
 		cnt -= len;
 		if (host->part_buf_count == 4) {
-			mci_writel(host, DATA(host->data_offset),
-					host->part_buf32);
+			mci_fifo_writel(host->fifo_reg,	host->part_buf32);
 			host->part_buf_count = 0;
 		}
 	}
@@ -1786,15 +1781,14 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
 			cnt -= len;
 			/* push data from aligned buffer into fifo */
 			for (i = 0; i < items; ++i)
-				mci_writel(host, DATA(host->data_offset),
-						aligned_buf[i]);
+				mci_fifo_writel(host->fifo_reg,	aligned_buf[i]);
 		}
 	} else
 #endif
 	{
 		u32 *pdata = buf;
 		for (; cnt >= 4; cnt -= 4)
-			mci_writel(host, DATA(host->data_offset), *pdata++);
+			mci_fifo_writel(host->fifo_reg, *pdata++);
 		buf = pdata;
 	}
 	/* put anything remaining in the part_buf */
@@ -1803,8 +1797,7 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
 		 /* Push data if we have reached the expected data length */
 		if ((data->bytes_xfered + init_cnt) ==
 		    (data->blksz * data->blocks))
-			mci_writel(host, DATA(host->data_offset),
-				   host->part_buf32);
+			mci_fifo_writel(host->fifo_reg, host->part_buf32);
 	}
 }
 
@@ -1819,8 +1812,7 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
 			int items = len >> 2;
 			int i;
 			for (i = 0; i < items; ++i)
-				aligned_buf[i] = mci_readl(host,
-						DATA(host->data_offset));
+				aligned_buf[i] = mci_fifo_readl(host->fifo_reg);
 			/* memcpy from aligned buffer into output buffer */
 			memcpy(buf, aligned_buf, len);
 			buf += len;
@@ -1831,11 +1823,11 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
 	{
 		u32 *pdata = buf;
 		for (; cnt >= 4; cnt -= 4)
-			*pdata++ = mci_readl(host, DATA(host->data_offset));
+			*pdata++ = mci_fifo_readl(host->fifo_reg);
 		buf = pdata;
 	}
 	if (cnt) {
-		host->part_buf32 = mci_readl(host, DATA(host->data_offset));
+		host->part_buf32 = mci_fifo_readl(host->fifo_reg);
 		dw_mci_pull_final_bytes(host, buf, cnt);
 	}
 }
@@ -1852,8 +1844,7 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 		cnt -= len;
 
 		if (host->part_buf_count == 8) {
-			mci_writeq(host, DATA(host->data_offset),
-					host->part_buf);
+			mci_fifo_writeq(host->fifo_reg,	host->part_buf);
 			host->part_buf_count = 0;
 		}
 	}
@@ -1870,15 +1861,14 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 			cnt -= len;
 			/* push data from aligned buffer into fifo */
 			for (i = 0; i < items; ++i)
-				mci_writeq(host, DATA(host->data_offset),
-						aligned_buf[i]);
+				mci_fifo_writeq(host->fifo_reg,	aligned_buf[i]);
 		}
 	} else
 #endif
 	{
 		u64 *pdata = buf;
 		for (; cnt >= 8; cnt -= 8)
-			mci_writeq(host, DATA(host->data_offset), *pdata++);
+			mci_fifo_writeq(host->fifo_reg, *pdata++);
 		buf = pdata;
 	}
 	/* put anything remaining in the part_buf */
@@ -1887,8 +1877,7 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 		/* Push data if we have reached the expected data length */
 		if ((data->bytes_xfered + init_cnt) ==
 		    (data->blksz * data->blocks))
-			mci_writeq(host, DATA(host->data_offset),
-				   host->part_buf);
+			mci_fifo_writeq(host->fifo_reg, host->part_buf);
 	}
 }
 
@@ -1903,8 +1892,8 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 			int items = len >> 3;
 			int i;
 			for (i = 0; i < items; ++i)
-				aligned_buf[i] = mci_readq(host,
-						DATA(host->data_offset));
+				aligned_buf[i] = mci_fifo_readq(host->fifo_reg);
+
 			/* memcpy from aligned buffer into output buffer */
 			memcpy(buf, aligned_buf, len);
 			buf += len;
@@ -1915,11 +1904,11 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	{
 		u64 *pdata = buf;
 		for (; cnt >= 8; cnt -= 8)
-			*pdata++ = mci_readq(host, DATA(host->data_offset));
+			*pdata++ = mci_fifo_readq(host->fifo_reg);
 		buf = pdata;
 	}
 	if (cnt) {
-		host->part_buf = mci_readq(host, DATA(host->data_offset));
+		host->part_buf = mci_fifo_readq(host->fifo_reg);
 		dw_mci_pull_final_bytes(host, buf, cnt);
 	}
 }
@@ -2731,9 +2720,9 @@ int dw_mci_probe(struct dw_mci *host)
 	dev_info(host->dev, "Version ID is %04x\n", host->verid);
 
 	if (host->verid < DW_MMC_240A)
-		host->data_offset = DATA_OFFSET;
+		host->fifo_reg = host->regs + DATA_OFFSET;
 	else
-		host->data_offset = DATA_240A_OFFSET;
+		host->fifo_reg = host->regs + DATA_240A_OFFSET;
 
 	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
 	ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 46efdc5..2eebe48 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -169,6 +169,16 @@
 #define SDMMC_CTRL_ALL_RESET_FLAGS \
 	(SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET)
 
+/* FIFO register access macros. These should not change the data endian-ness
+ * as they are written to memory to be dealt with by the upper layers */
+#define mci_fifo_readw(__reg)	__raw_readw(__reg)
+#define mci_fifo_readl(__reg)	__raw_readl(__reg)
+#define mci_fifo_readq(__reg)	__raw_readq(__reg)
+
+#define mci_fifo_writew(__value, __reg)	__raw_writew(__reg, __value)
+#define mci_fifo_writel(__value, __reg)	__raw_writel(__reg, __value)
+#define mci_fifo_writeq(__value, __reg)	__raw_writeq(__reg, __value)
+
 /* Register access macros */
 #define mci_readl(dev, reg)			\
 	readl_relaxed((dev)->regs + SDMMC_##reg)
@@ -200,6 +210,10 @@
 	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg))
 #define mci_writeq(dev, reg, value)			\
 	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
+
+#define __raw_writeq(__value, __reg) \
+	(*(volatile u64 __force *)(__reg)= (__value))
+#define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
 #endif
 
 extern int dw_mci_probe(struct dw_mci *host);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 471fb31..49addec 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -44,6 +44,7 @@ struct mmc_data;
  * struct dw_mci - MMC controller state shared between all slots
  * @lock: Spinlock protecting the queue and associated data.
  * @regs: Pointer to MMIO registers.
+ * @fifo_reg: Pointer to MMIO registers for data FIFO
  * @sg: Scatterlist entry currently being processed by PIO code, if any.
  * @sg_miter: PIO mapping scatterlist iterator.
  * @cur_slot: The slot which is currently using the controller.
@@ -79,7 +80,6 @@ struct mmc_data;
  * @current_speed: Configured rate of the controller.
  * @num_slots: Number of slots available.
  * @verid: Denote Version ID.
- * @data_offset: Set the offset of DATA register according to VERID.
  * @dev: Device associated with the MMC controller.
  * @pdata: Platform data associated with the MMC controller.
  * @drv_data: Driver specific data for identified variant of the controller
@@ -132,6 +132,7 @@ struct dw_mci {
 	spinlock_t		lock;
 	spinlock_t		irq_lock;
 	void __iomem		*regs;
+	void __iomem		*fifo_reg;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
@@ -172,7 +173,6 @@ struct dw_mci {
 	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
-	u16			data_offset;
 	struct device		*dev;
 	struct dw_mci_board	*pdata;
 	const struct dw_mci_drv_data	*drv_data;
-- 
2.1.4

