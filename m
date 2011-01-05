From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: Support Mobile Storage controller Interface
Date: Wed, 05 Jan 2011 11:21:03 +0900
Message-ID: <4D23D58F.9090608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12280 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab1AECeK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 21:34:10 -0500
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LEJ00BPA2JAKWE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Jan 2011 11:21:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LEJ00LSY2JA70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Jan 2011 11:21:10 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Philip Rakity <prakity@marvell.com>, afleming@gmail.com, Andrew Morton <akpm@linux-foundation.org>

This patch is Mobile Storage Controller interface.
This controller is similar to SDHCI.(This patch is based on sdhci.c)
I tried to use mobile storage with sdhci-controller, but bit controlling is too many different
So need Mobile Storage controller.

I tested only 8-bit buswidth. It's working well...i think performance didn't ensure yet.
It should be add DDR feature. 

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/Kconfig  |   12 +
 drivers/mmc/host/Makefile |    1 +
 drivers/mmc/host/mshci.c  | 1499 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mshci.h  |  364 +++++++++++
 4 files changed, 1876 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/mshci.c
 create mode 100644 drivers/mmc/host/mshci.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..59a6057 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -24,6 +24,18 @@ config MMC_PXA
 
 	  If unsure, say N.
 
+config MMC_MSHCI
+	tristate "Mobile Storage Host Controller Interface support"
+	depends on HAS_DMA
+	help
+	  This selects the Mobile Storage Host Controller Interface.
+	  If support SD/MMC card.
+
+	  If you have a controller with this interface, say Y or M here. You
+	  also need to enable an appropriate bus interface.
+
+	  If unsure, say N.
+
 config MMC_SDHCI
 	tristate "Secure Digital Host Controller Interface support"
 	depends on HAS_DMA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 7b645ff..2cf4be0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MMC_AT91)		+= at91_mci.o
 obj-$(CONFIG_MMC_ATMELMCI)	+= atmel-mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 obj-$(CONFIG_MMC_MSM)		+= msm_sdcc.o
+obj-$(CONFIG_MMC_MSHCI)		+= mshci.o
 obj-$(CONFIG_MMC_MVSDIO)	+= mvsdio.o
 obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
 obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
diff --git a/drivers/mmc/host/mshci.c b/drivers/mmc/host/mshci.c
new file mode 100644
index 0000000..57cc040
--- /dev/null
+++ b/drivers/mmc/host/mshci.c
@@ -0,0 +1,1499 @@
+/*
+ *  linux/drivers/mmc/host/mshci.c - Mobile Storage Host Controller Interface driver
+ *
+ *  Copyright (C) 2011 Samsung Electronics, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/leds.h>
+
+#include <linux/mmc/host.h>
+
+#include "mshci.h"
+
+#define DRIVER_NAME "mshci"
+
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
+static unsigned int debug_quirks;
+
+static void mshci_prepare_data(struct mshci_host *, struct mmc_data *);
+static void mshci_finish_data(struct mshci_host *);
+
+static void mshci_send_command(struct mshci_host *, struct mmc_command *);
+static void mshci_finish_command(struct mshci_host *);
+
+
+static void mshci_dumpregs(struct mshci_host *host)
+{
+	/* ToDo */
+}
+
+
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+static void mshci_clear_set_irqs(struct mshci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = mshci_readl(host, MSHCI_INTMSK);
+	ier &= ~clear;
+	ier |= set;
+	mshci_writel(host, ier, MSHCI_INTMSK);
+}
+
+static void mshci_unmask_irqs(struct mshci_host *host, u32 irqs)
+{
+	mshci_clear_set_irqs(host, 0, irqs);
+}
+
+static void mshci_mask_irqs(struct mshci_host *host, u32 irqs)
+{
+	mshci_clear_set_irqs(host, irqs, 0);
+}
+
+static void mshci_set_card_detection(struct mshci_host *host, bool enable)
+{
+	u32 irqs = INTMSK_CDETECT;
+
+	if (enable)
+		mshci_unmask_irqs(host, irqs);
+	else
+		mshci_mask_irqs(host, irqs);
+}
+
+static void mshci_enable_card_detection(struct mshci_host *host)
+{
+	mshci_set_card_detection(host, true);
+}
+
+static void mshci_disable_card_detection(struct mshci_host *host)
+{
+	mshci_set_card_detection(host, false);
+}
+
+static void mshci_reset(struct mshci_host *host, u8 mask)
+{
+	u32 timeout = 100;
+	u32 ier;
+
+	ier = mshci_readl(host, MSHCI_CTRL);
+	ier |= mask;
+
+	mshci_writel(host, ier, MSHCI_CTRL);
+	while (mshci_readl(host, MSHCI_CTRL) & DMA_RESET) {
+		if (timeout == 0) {
+			printk(KERN_ERR "%s: Reset never completed.\n",
+				mmc_hostname(host->mmc));
+			mshci_dumpregs(host);
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+}
+
+static void mshci_init(struct mshci_host *host)
+{
+	mshci_reset(host, RESET_ALL);
+
+	/* clear interrupt status */
+	mshci_writel(host, INTMSK_ALL, MSHCI_RINTSTS);
+
+	mshci_clear_set_irqs(host, INTMSK_ALL,
+		INTMSK_CDETECT | INTMSK_RE |
+		INTMSK_CDONE | INTMSK_DTO | INTMSK_TXDR | INTMSK_RXDR |
+		INTMSK_RCRC | INTMSK_DCRC | INTMSK_RTO | INTMSK_DRTO |
+		INTMSK_HTO | INTMSK_FRUN | INTMSK_HLE | INTMSK_SBE |
+		INTMSK_EBE);
+}
+
+static void mshci_reinit(struct mshci_host *host)
+{
+	mshci_init(host);
+	mshci_enable_card_detection(host);
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Core functions                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void mshci_read_block_pio(struct mshci_host *host)
+{
+	unsigned long flags;
+	size_t fifo_cnt, len;
+	u32 uninitialized_var(scratch);
+	u8 *buf;
+
+	DBG("PIO reading\n");
+
+	fifo_cnt = (mshci_readl(host, MSHCI_STATUS)&FIFO_COUNT) >> 17;
+	fifo_cnt *= FIFO_WIDTH;
+
+	if (fifo_cnt == 128)
+		fifo_cnt = 512;
+
+	local_irq_save(flags);
+
+	while (fifo_cnt) {
+		if (!sg_miter_next(&host->sg_miter))
+			BUG();
+
+		len = min(host->sg_miter.length, fifo_cnt);
+
+		fifo_cnt -= len;
+		host->sg_miter.consumed = len;
+
+		buf = host->sg_miter.addr;
+
+		while (len) {
+			scratch = mshci_readl(host, MSHCI_FIFODAT);
+
+			*buf = scratch & 0xFF;
+
+			*((u32 *)buf) = scratch;
+			buf += 4;
+			len -= 4;
+		}
+	}
+
+	sg_miter_stop(&host->sg_miter);
+
+	local_irq_restore(flags);
+}
+
+static void mshci_write_block_pio(struct mshci_host *host)
+{
+	unsigned long flags;
+	size_t fifo_cnt, len, chunk;
+	u32 scratch;
+	u8 *buf;
+
+	DBG("PIO writing\n");
+
+	fifo_cnt = 64;
+
+	fifo_cnt *= FIFO_WIDTH;
+	chunk = 0;
+	scratch = 0;
+
+	local_irq_save(flags);
+
+	while (fifo_cnt) {
+		if (!sg_miter_next(&host->sg_miter)) {
+			/*
+			 * Even though transfer is complete,
+			 * TXDR interrupt occurs again.
+			 * So, it has to check that it has really
+			 * no next sg buffer or just DTO interrupt
+			 * has not occured yet.
+			 */
+			if ((host->data->blocks * host->data->blksz) ==
+					host->data_transfered)
+				break; /* transfer done but DTO not yet */
+			BUG();
+		}
+		len = min(host->sg_miter.length, fifo_cnt);
+
+		fifo_cnt -= len;
+		host->sg_miter.consumed = len;
+		host->data_transfered += len;
+
+		buf = (host->sg_miter.addr);
+
+		while (len) {
+			scratch |= (u32)*buf << (chunk * 8);
+
+			buf++;
+			chunk++;
+			len--;
+
+			if ((chunk == 4) || ((len == 0) && (fifo_cnt == 0))) {
+				mshci_writel(host, scratch, MSHCI_FIFODAT);
+				chunk = 0;
+				scratch = 0;
+			}
+		}
+	}
+
+	sg_miter_stop(&host->sg_miter);
+
+	local_irq_restore(flags);
+}
+
+static void mshci_transfer_pio(struct mshci_host *host)
+{
+	BUG_ON(!host->data);
+
+	if (host->blocks == 0)
+		return;
+
+	if (host->data->flags & MMC_DATA_READ)
+		mshci_read_block_pio(host);
+	else
+		mshci_write_block_pio(host);
+
+	DBG("PIO transfer complete.\n");
+}
+
+static void mshci_set_mdma_desc(u8 *desc_vir, u8 *desc_phy,
+				u32 des0, u32 des1, u32 des2)
+{
+	((struct mshci_idmac *)(desc_vir))->des[0] = des0;
+	((struct mshci_idmac *)(desc_vir))->des[1] = des1;
+	((struct mshci_idmac *)(desc_vir))->des[2] = des2;
+	((struct mshci_idmac *)(desc_vir))->des[3] = (u32)desc_phy +
+					sizeof(struct mshci_idmac);
+}
+
+static int mshci_mdma_table_pre(struct mshci_host *host,
+	struct mmc_data *data)
+{
+	int direction;
+
+	u8 *desc_vir, *desc_phy;
+	dma_addr_t addr;
+	int len;
+
+	struct scatterlist *sg;
+	int i;
+	u32 des_flag;
+	u32 size_idmac = sizeof(struct mshci_idmac);
+
+	if (data->flags & MMC_DATA_READ)
+		direction = DMA_FROM_DEVICE;
+	else
+		direction = DMA_TO_DEVICE;
+
+	host->sg_count = dma_map_sg(mmc_dev(host->mmc),
+		data->sg, data->sg_len, direction);
+	if (host->sg_count == 0)
+		goto fail;
+
+	desc_vir = host->idma_desc;
+
+	/* to know phy address */
+	host->idma_addr = dma_map_single(mmc_dev(host->mmc),
+		host->idma_desc, 128 * size_idmac, DMA_TO_DEVICE);
+	if (dma_mapping_error(mmc_dev(host->mmc), host->idma_addr))
+		goto unmap_entries;
+	BUG_ON(host->idma_addr & 0x3);
+
+	desc_phy = (u8 *)host->idma_addr;
+
+	for_each_sg(data->sg, sg, host->sg_count, i) {
+		addr = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		/* tran, valid */
+		des_flag = (MSHCI_IDMAC_OWN|MSHCI_IDMAC_CH);
+		des_flag |= (i == 0) ? MSHCI_IDMAC_FS : 0;
+
+		mshci_set_mdma_desc(desc_vir, desc_phy, des_flag, len, addr);
+		desc_vir += size_idmac;
+		desc_phy += size_idmac;
+
+		/*
+		 * If this triggers then we have a calculation bug
+		 * somewhere. :/
+		 */
+		WARN_ON((desc_vir - host->idma_desc) > 128 * size_idmac);
+	}
+
+	/*
+	* Add a terminating flag.
+	 */
+	((struct mshci_idmac *)(desc_vir-size_idmac))->des[0] |= MSHCI_IDMAC_LD;
+
+	/* it has to dma map again to resync vir data to phy data  */
+	host->idma_addr = dma_map_single(mmc_dev(host->mmc),
+		host->idma_desc, 128 * size_idmac, DMA_TO_DEVICE);
+	if (dma_mapping_error(mmc_dev(host->mmc), host->idma_addr))
+		goto unmap_entries;
+	BUG_ON(host->idma_addr & 0x3);
+
+	return 0;
+
+unmap_entries:
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+		data->sg_len, direction);
+fail:
+	return -EINVAL;
+}
+
+static void mshci_idma_table_post(struct mshci_host *host,
+	struct mmc_data *data)
+{
+	int direction;
+
+	if (data->flags & MMC_DATA_READ)
+		direction = DMA_FROM_DEVICE;
+	else
+		direction = DMA_TO_DEVICE;
+
+	dma_unmap_single(mmc_dev(host->mmc), host->idma_addr,
+		(128 * 2 + 1) * 4, DMA_TO_DEVICE);
+
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+		data->sg_len, direction);
+}
+
+static u32 mshci_calc_timeout(struct mshci_host *host, struct mmc_data *data)
+{
+	return 0xffffffff; /* this value SHOULD be optimized */
+}
+
+static void mshci_set_transfer_irqs(struct mshci_host *host)
+{
+	u32 dma_irqs = INTMSK_DMA;
+	u32 pio_irqs = INTMSK_TXDR | INTMSK_RXDR;
+
+	if (host->flags & MSHCI_REQ_USE_DMA) {
+		/* Next codes are the W/A for DDR */
+		if (mshci_readl(host, MSHCI_UHS_REG) && (1 << 16))
+			dma_irqs |= INTMSK_DCRC;
+		/* clear interrupts for PIO */
+		mshci_clear_set_irqs(host, dma_irqs, 0);
+	} else {
+		/* Next codes are the W/A for DDR */
+		if (mshci_readl(host, MSHCI_UHS_REG) && (1 << 16))
+			mshci_clear_set_irqs(host, INTMSK_DCRC, pio_irqs);
+		else
+			mshci_clear_set_irqs(host, 0, pio_irqs);
+	}
+}
+
+static void mshci_prepare_data(struct mshci_host *host, struct mmc_data *data)
+{
+	u32 count;
+	u32 ret;
+
+	WARN_ON(host->data);
+
+	if (data == NULL)
+		return;
+
+	BUG_ON(data->blksz * data->blocks > (host->mmc->max_req_size *
+					host->mmc->max_segs));
+	BUG_ON(data->blksz > host->mmc->max_blk_size);
+	BUG_ON(data->blocks > 400000);
+
+	host->data = data;
+	host->data_early = 0;
+
+	count = mshci_calc_timeout(host, data);
+	mshci_writel(host, count, MSHCI_TMOUT);
+
+	mshci_reset(host, FIFO_RESET);
+
+	if (host->flags & (MSHCI_USE_IDMA))
+		host->flags |= MSHCI_REQ_USE_DMA;
+
+	/*
+	 * FIXME: This doesn't account for merging when mapping the
+	 * scatterlist.
+	 */
+	if (host->flags & MSHCI_REQ_USE_DMA) {
+		/*
+		 * mshc's IDMAC can't transfer data that is not aligned
+		 * or has length not divided by 4 byte.
+		 **/
+		int i;
+		struct scatterlist *sg;
+
+			for_each_sg(data->sg, sg, data->sg_len, i) {
+				if (sg->length & 0x3) {
+					DBG("Reverting to PIO because of "
+						"transfer size (%d)\n",
+						sg->length);
+					host->flags &= ~MSHCI_REQ_USE_DMA;
+					break;
+			} else if (sg->offset & 0x3) {
+				DBG("Reverting to PIO because of "
+					"bad alignment\n");
+				host->flags &= ~MSHCI_REQ_USE_DMA;
+				break;
+			}
+		}
+	}
+
+	if (host->flags & MSHCI_REQ_USE_DMA) {
+		ret = mshci_mdma_table_pre(host, data);
+		if (ret) {
+			/*
+			 * This only happens when someone fed
+			 * us an invalid request.
+			 */
+			WARN_ON(1);
+			host->flags &= ~MSHCI_REQ_USE_DMA;
+		} else {
+			mshci_writel(host, host->idma_addr,
+				MSHCI_DBADDR);
+		}
+	}
+
+	if (host->flags & MSHCI_REQ_USE_DMA) {
+		/* enable DMA, IDMA interrupts and IDMAC */
+		mshci_writel(host, (mshci_readl(host, MSHCI_CTRL) |
+					ENABLE_IDMAC|DMA_ENABLE), MSHCI_CTRL);
+		mshci_writel(host, (mshci_readl(host, MSHCI_BMOD) |
+					(BMOD_IDMAC_ENABLE|BMOD_IDMAC_FB)),
+					MSHCI_BMOD);
+		mshci_writel(host, INTMSK_IDMAC_ERROR, MSHCI_IDINTEN);
+	}
+
+	if (!(host->flags & MSHCI_REQ_USE_DMA)) {
+		int flags;
+
+		flags = SG_MITER_ATOMIC;
+		if (host->data->flags & MMC_DATA_READ)
+			flags |= SG_MITER_TO_SG;
+		else
+			flags |= SG_MITER_FROM_SG;
+
+		sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
+		host->blocks = data->blocks;
+
+		printk(KERN_ERR "it starts transfer on PIO\n");
+	}
+	/* set transfered data as 0. this value only uses for PIO write */
+	host->data_transfered = 0;
+	mshci_set_transfer_irqs(host);
+
+	mshci_writel(host, data->blksz, MSHCI_BLKSIZ);
+	mshci_writel(host, (data->blocks * data->blksz), MSHCI_BYTCNT);
+}
+
+static u32 mshci_set_transfer_mode(struct mshci_host *host,
+	struct mmc_data *data)
+{
+	u32 ret = 0;
+
+	if (data == NULL)
+		return ret;
+
+	WARN_ON(!host->data);
+
+	/* this cmd has data to transmit */
+	ret |= CMD_DATA_EXP_BIT;
+
+	if (data->flags & MMC_DATA_WRITE)
+		ret |= CMD_RW_BIT;
+	if (data->flags & MMC_DATA_STREAM)
+		ret |= CMD_TRANSMODE_BIT;
+
+	return ret;
+}
+
+static void mshci_finish_data(struct mshci_host *host)
+{
+	struct mmc_data *data;
+
+	BUG_ON(!host->data);
+
+	data = host->data;
+	host->data = NULL;
+
+	if (host->flags & MSHCI_REQ_USE_DMA) {
+		mshci_idma_table_post(host, data);
+		/* disable IDMAC and DMA interrupt */
+		mshci_writel(host, (mshci_readl(host, MSHCI_CTRL) &
+				~(DMA_ENABLE|ENABLE_IDMAC)), MSHCI_CTRL);
+		/* mask all interrupt source of IDMAC */
+		mshci_writel(host, 0x0, MSHCI_IDINTEN);
+	}
+
+	if (data->error) {
+		mshci_reset(host, DMA_RESET);
+		data->bytes_xfered = 0;
+	} else
+		data->bytes_xfered = data->blksz * data->blocks;
+
+	if (data->stop)
+		mshci_send_command(host, data->stop);
+	else
+		tasklet_schedule(&host->finish_tasklet);
+}
+
+static void mshci_clock_onoff(struct mshci_host *host, bool val)
+{
+	u32 loop_count = 0x100000;
+
+	if (val)
+		mshci_writel(host, CLK_ENABLE, MSHCI_CLKENA);
+	else
+		mshci_writel(host, CLK_DISABLE, MSHCI_CLKENA);
+
+	mshci_writel(host, 0, MSHCI_CMD);
+	mshci_writel(host, CMD_ONLY_CLK, MSHCI_CMD);
+
+	do {
+		if (!(mshci_readl(host, MSHCI_CMD) & CMD_STRT_BIT))
+			break;
+		loop_count--;
+	} while (loop_count);
+
+	if (loop_count == 0) {
+		printk(KERN_ERR "%s: Clock %s has been failed.\n "
+				, mmc_hostname(host->mmc), val ? "ON" : "OFF");
+	}
+}
+
+static void mshci_send_command(struct mshci_host *host, struct mmc_command *cmd)
+{
+	int flags, ret;
+
+	WARN_ON(host->cmd);
+
+	/* disable interrupt before issuing cmd to the card. */
+	mshci_writel(host, (mshci_readl(host, MSHCI_CTRL) & ~INT_ENABLE),
+					MSHCI_CTRL);
+
+	mod_timer(&host->timer, jiffies + 10 * HZ);
+
+	host->cmd = cmd;
+
+	mshci_prepare_data(host, cmd->data);
+
+	mshci_writel(host, cmd->arg, MSHCI_CMDARG);
+
+	flags = mshci_set_transfer_mode(host, cmd->data);
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		printk(KERN_ERR "%s: Unsupported response type!\n",
+			mmc_hostname(host->mmc));
+		cmd->error = -EINVAL;
+		tasklet_schedule(&host->finish_tasklet);
+		return;
+	}
+
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		flags |= CMD_RESP_EXP_BIT;
+		if (cmd->flags & MMC_RSP_136)
+			flags |= CMD_RESP_LENGTH_BIT;
+	}
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= CMD_CHECK_CRC_BIT;
+	flags |= (cmd->opcode | CMD_STRT_BIT | CMD_WAIT_PRV_DAT_BIT);
+
+	ret = mshci_readl(host, MSHCI_CMD);
+	if (ret & CMD_STRT_BIT)
+		printk(KERN_ERR "CMD busy. current cmd %d. last cmd reg 0x%x\n",
+			cmd->opcode, ret);
+
+	mshci_writel(host, flags, MSHCI_CMD);
+
+	/* enable interrupt upon it sends a command to the card. */
+	mshci_writel(host, (mshci_readl(host, MSHCI_CTRL) | INT_ENABLE),
+					MSHCI_CTRL);
+}
+
+static void mshci_finish_command(struct mshci_host *host)
+{
+	int i;
+
+	BUG_ON(host->cmd == NULL);
+
+	if (host->cmd->flags & MMC_RSP_PRESENT) {
+		if (host->cmd->flags & MMC_RSP_136) {
+			/*
+			 * response data are overturned.
+			 */
+			for (i = 0; i < 4; i++) {
+				host->cmd->resp[i] = mshci_readl(host,
+						MSHCI_RESP0 + (3-i)*4);
+			}
+		} else {
+			host->cmd->resp[0] = mshci_readl(host, MSHCI_RESP0);
+		}
+	}
+
+	host->cmd->error = 0;
+
+	/* if data interrupt occurs earlier than command interrupt */
+	if (host->data && host->data_early)
+		mshci_finish_data(host);
+
+	if (!host->cmd->data)
+		tasklet_schedule(&host->finish_tasklet);
+
+	host->cmd = NULL;
+}
+
+static void mshci_set_clock(struct mshci_host *host, unsigned int clock)
+{
+	int div;
+	u32 loop_count;
+
+	if (clock == host->clock)
+		return;
+
+	/* befor changing clock. clock needs to be off. */
+	mshci_clock_onoff(host, CLK_DISABLE);
+
+	if (clock == 0)
+		goto out;
+
+	if (clock >= host->max_clk) {
+		div = 0;
+	} else {
+		for (div = 1; div < 255; div++) {
+			if ((host->max_clk / (div<<1)) <= clock)
+				break;
+		}
+	}
+
+	mshci_writel(host, div, MSHCI_CLKDIV);
+
+	mshci_writel(host, 0, MSHCI_CMD);
+	mshci_writel(host, CMD_ONLY_CLK, MSHCI_CMD);
+	loop_count = 0x10000;
+
+	do {
+		if (!(mshci_readl(host, MSHCI_CMD) & CMD_STRT_BIT))
+			break;
+		loop_count--;
+	} while (loop_count);
+
+	if (loop_count == 0) {
+		printk(KERN_ERR "%s: Changing clock has been failed.\n "
+				, mmc_hostname(host->mmc));
+	}
+	mshci_writel(host, mshci_readl(host, MSHCI_CMD)&(~CMD_SEND_CLK_ONLY),
+					MSHCI_CMD);
+
+	mshci_clock_onoff(host, CLK_ENABLE);
+
+out:
+	host->clock = clock;
+}
+
+static void mshci_set_power(struct mshci_host *host, unsigned short power)
+{
+	u8 pwr;
+
+	if (power == (unsigned short)-1)
+		pwr = 0;
+
+	if (host->pwr == pwr)
+		return;
+
+	host->pwr = pwr;
+
+	if (pwr == 0)
+		mshci_writel(host, 0x0, MSHCI_PWREN);
+	else
+		mshci_writel(host, 0x1, MSHCI_PWREN);
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static void mshci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mshci_host *host;
+	bool present;
+	unsigned long flags;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	WARN_ON(host->mrq != NULL);
+
+	host->mrq = mrq;
+
+	present = !(mshci_readl(host, MSHCI_CDETECT) & CARD_PRESENT);
+
+	if (host->quirks && MSHCI_QUIRK_BROKEN_CARD_DETECTION)
+		present = true;
+
+	if (!present || host->flags & MSHCI_DEVICE_DEAD) {
+		host->mrq->cmd->error = -ENOMEDIUM;
+		tasklet_schedule(&host->finish_tasklet);
+	} else {
+		mshci_send_command(host, mrq->cmd);
+	}
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void mshci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mshci_host *host;
+	unsigned long flags;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->flags & MSHCI_DEVICE_DEAD)
+		goto out;
+
+	if (ios->power_mode == MMC_POWER_OFF)
+		mshci_reinit(host);
+
+	if (host->ops->set_ios)
+		host->ops->set_ios(host, ios);
+
+	mshci_set_clock(host, ios->clock);
+
+	if (ios->power_mode == MMC_POWER_OFF)
+		mshci_set_power(host, -1);
+	else
+		mshci_set_power(host, ios->vdd);
+
+	if (ios->bus_width == MMC_BUS_WIDTH_8)
+		mshci_writel(host, (0x1<<16), MSHCI_CTYPE);
+	else if (ios->bus_width == MMC_BUS_WIDTH_4)
+		mshci_writel(host, (0x1<<0), MSHCI_CTYPE);
+	else
+		mshci_writel(host, (0x0<<0), MSHCI_CTYPE);
+out:
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static int mshci_get_ro(struct mmc_host *mmc)
+{
+	struct mshci_host *host;
+	unsigned long flags;
+	int wrtprt;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->quirks & MSHCI_QUIRK_ALWAYS_WRITABLE)
+		wrtprt = 0;
+	else if (host->quirks & MSHCI_QUIRK_NO_WP_BIT)
+		wrtprt = host->ops->get_ro(mmc) ? 0 : WRTPRT_ON;
+	else if (host->flags & MSHCI_DEVICE_DEAD)
+		wrtprt = 0;
+	else
+		wrtprt = mshci_readl(host, MSHCI_WRTPRT);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return wrtprt & WRTPRT_ON;
+}
+
+static void mshci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mshci_host *host;
+	unsigned long flags;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->flags & MSHCI_DEVICE_DEAD)
+		goto out;
+
+	if (enable)
+		mshci_unmask_irqs(host, SDIO_INT_ENABLE);
+	else
+		mshci_mask_irqs(host, SDIO_INT_ENABLE);
+out:
+	mmiowb();
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static struct mmc_host_ops mshci_ops = {
+	.request	= mshci_request,
+	.set_ios	= mshci_set_ios,
+	.get_ro		= mshci_get_ro,
+	.enable_sdio_irq = mshci_enable_sdio_irq,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Tasklets                                                                  *
+ *                                                                           *
+\*****************************************************************************/
+
+static void mshci_tasklet_card(unsigned long param)
+{
+	struct mshci_host *host;
+	unsigned long flags;
+
+	host = (struct mshci_host *)param;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!mshci_readl(host, MSHCI_CDETECT) & CARD_PRESENT) {
+		if (host->mrq) {
+			printk(KERN_ERR "%s: Card removed during transfer!\n",
+				mmc_hostname(host->mmc));
+			printk(KERN_ERR "%s: Resetting controller.\n",
+				mmc_hostname(host->mmc));
+
+			host->mrq->cmd->error = -ENOMEDIUM;
+			tasklet_schedule(&host->finish_tasklet);
+		}
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	mmc_detect_change(host->mmc, msecs_to_jiffies(100));
+}
+
+static void mshci_tasklet_finish(unsigned long param)
+{
+	struct mshci_host *host;
+	unsigned long flags;
+	struct mmc_request *mrq;
+
+	host = (struct mshci_host *)param;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	del_timer(&host->timer);
+
+	mrq = host->mrq;
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (!(host->flags & MSHCI_DEVICE_DEAD) &&
+		(mrq->cmd->error ||
+		 (mrq->data && (mrq->data->error ||
+		  (mrq->data->stop && mrq->data->stop->error))))) {
+
+		/* Spec says we should do both at the same time, but Ricoh
+		   controllers do not like that. */
+		mshci_reset(host, FIFO_RESET);
+	}
+
+	host->mrq = NULL;
+	host->cmd = NULL;
+	host->data = NULL;
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	mmc_request_done(host->mmc, mrq);
+}
+
+static void mshci_timeout_timer(unsigned long data)
+{
+	struct mshci_host *host;
+	unsigned long flags;
+
+	host = (struct mshci_host *)data;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->mrq) {
+		printk(KERN_ERR "%s: Timeout waiting for hardware "
+			"interrupt.\n", mmc_hostname(host->mmc));
+		mshci_dumpregs(host);
+
+		if (host->data) {
+			host->data->error = -ETIMEDOUT;
+			mshci_finish_data(host);
+		} else {
+			if (host->cmd)
+				host->cmd->error = -ETIMEDOUT;
+			else
+				host->mrq->cmd->error = -ETIMEDOUT;
+
+			tasklet_schedule(&host->finish_tasklet);
+		}
+	}
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+static void mshci_cmd_irq(struct mshci_host *host, u32 intmask)
+{
+	BUG_ON(intmask == 0);
+
+	if (!host->cmd) {
+		printk(KERN_ERR "%s: Got command interrupt 0x%08x even "
+			"though no command operation was in progress.\n",
+			mmc_hostname(host->mmc), (unsigned)intmask);
+		mshci_dumpregs(host);
+		return;
+	}
+
+	if (intmask & INTMSK_RTO)
+		host->cmd->error = -ETIMEDOUT;
+	else if (intmask & (INTMSK_RCRC | INTMSK_RE))
+		host->cmd->error = -EILSEQ;
+
+	if (host->cmd->error) {
+		tasklet_schedule(&host->finish_tasklet);
+		return;
+	}
+
+	if (intmask & INTMSK_CDONE)
+		mshci_finish_command(host);
+}
+
+static void mshci_data_irq(struct mshci_host *host, u32 intmask, u8 intr_src)
+{
+	BUG_ON(intmask == 0);
+
+	if (!host->data) {
+		/*
+		 * The "data complete" interrupt is also used to
+		 * indicate that a busy state has ended. See comment
+		 * above in mshci_cmd_irq().
+		 */
+		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
+			if (intmask & INTMSK_DTO) {
+				mshci_finish_command(host);
+				return;
+			}
+		}
+
+		printk(KERN_ERR "%s: Got data interrupt 0x%08x from %s "
+			"even though no data operation was in progress.\n",
+			mmc_hostname(host->mmc), (unsigned)intmask,
+			intr_src ? "MINT" : "IDMAC");
+		mshci_dumpregs(host);
+
+		return;
+	}
+	if (intr_src == INT_SRC_MINT) {
+		if (intmask & INTMSK_DATA_TIMEOUT)
+			host->data->error = -ETIMEDOUT;
+		else if (intmask & INTMSK_DATA_CRC)
+			host->data->error = -EILSEQ;
+		else if (intmask & INTMSK_FRUN) {
+			printk(KERN_ERR "%s: FIFO underrun/overrun error\n",
+					mmc_hostname(host->mmc));
+			host->data->error = -EIO;
+		}
+	} else {
+		if (intmask & (IDSTS_FBE | IDSTS_CES | IDSTS_DU)) {
+			printk(KERN_ERR "%s: Fatal Bus error on DMA\n",
+					mmc_hostname(host->mmc));
+			host->data->error = -EIO;
+		}
+	}
+
+	if (host->data->error)
+		mshci_finish_data(host);
+	else {
+		if (!(host->flags & MSHCI_REQ_USE_DMA) &&
+				(((host->data->flags & MMC_DATA_READ) &&
+				(intmask & (INTMSK_RXDR | INTMSK_DTO))) ||
+				((host->data->flags & MMC_DATA_WRITE) &&
+					(intmask & (INTMSK_TXDR)))))
+			mshci_transfer_pio(host);
+
+		if (intmask & INTMSK_DTO) {
+			if (host->cmd) {
+				/*
+				 * Data managed to finish before the
+				 * command completed. Make sure we do
+				 * things in the proper order.
+				 */
+				host->data_early = 1;
+			} else {
+				mshci_finish_data(host);
+			}
+		}
+	}
+}
+
+static irqreturn_t mshci_irq(int irq, void *dev_id)
+{
+	irqreturn_t result;
+	struct mshci_host *host = dev_id;
+	u32 intmask;
+	int cardint = 0;
+	int timeout = 100;
+
+	spin_lock(&host->lock);
+
+	intmask = mshci_readl(host, MSHCI_MINTSTS);
+
+	if (!intmask || intmask == 0xffffffff) {
+		/* check if there is a interrupt for IDMAC  */
+		intmask = mshci_readl(host, MSHCI_IDSTS);
+		if (intmask) {
+			mshci_writel(host, intmask, MSHCI_IDSTS);
+			mshci_data_irq(host, intmask, INT_SRC_IDMAC);
+			result = IRQ_HANDLED;
+			goto out;
+		}
+		result = IRQ_NONE;
+		goto out;
+	}
+	DBG("*** %s got interrupt: 0x%08x\n",
+		mmc_hostname(host->mmc), intmask);
+
+	mshci_writel(host, intmask, MSHCI_RINTSTS);
+
+	if (intmask & (INTMSK_CDETECT))
+		tasklet_schedule(&host->card_tasklet);
+
+	intmask &= ~INTMSK_CDETECT;
+
+	if (intmask & CMD_STATUS) {
+		if (!(intmask & INTMSK_CDONE) && (intmask & INTMSK_RTO)) {
+			/*
+			 * when a error about command timeout occurs,
+			 * cmd done intr comes together.
+			 * cmd done intr comes later than error intr.
+			 * so, it has to wait for cmd done intr.
+			 */
+			while (--timeout &&
+				(!(mshci_readl(host, MSHCI_MINTSTS)
+				  & INTMSK_CDONE))) {
+				if (!timeout)
+					printk(KERN_ERR"*** %s time out for\
+						CDONE intr\n",
+						mmc_hostname(host->mmc));
+				else
+					mshci_writel(host, INTMSK_CDONE,
+						MSHCI_RINTSTS);
+			}
+			mshci_cmd_irq(host, intmask & CMD_STATUS);
+		} else {
+			mshci_cmd_irq(host, intmask & CMD_STATUS);
+		}
+	}
+
+	if (intmask & DATA_STATUS) {
+		if (!(intmask & INTMSK_DTO) && (intmask & INTMSK_DRTO)) {
+			/*
+			 * when a error about data timout occurs,
+			 * DTO intr comes together.
+			 * DTO intr comes later than error intr.
+			 * so, it has to wait for DTO intr.
+			 */
+			while (--timeout &&
+				(!(mshci_readl(host, MSHCI_MINTSTS)
+				  & INTMSK_DTO))) {
+				if (!timeout)
+					printk(KERN_ERR"*** %s time out for\
+						CDONE intr\n",
+						mmc_hostname(host->mmc));
+				else
+					mshci_writel(host, INTMSK_DTO,
+						MSHCI_RINTSTS);
+			}
+			mshci_data_irq(host, intmask &
+					DATA_STATUS, INT_SRC_MINT);
+		} else {
+			mshci_data_irq(host, intmask &
+					DATA_STATUS, INT_SRC_MINT);
+		}
+	}
+
+	intmask &= ~(CMD_STATUS | DATA_STATUS);
+
+	if (intmask & SDIO_INT_ENABLE)
+		cardint = 1;
+
+	intmask &= ~SDIO_INT_ENABLE;
+
+	if (intmask) {
+		printk(KERN_ERR "%s: Unexpected interrupt 0x%08x.\n",
+			mmc_hostname(host->mmc), intmask);
+		mshci_dumpregs(host);
+	}
+
+	result = IRQ_HANDLED;
+
+	mmiowb();
+out:
+	spin_unlock(&host->lock);
+
+	/*
+	 * We have to delay this as it calls back into the driver.
+	 */
+	if (cardint)
+		mmc_signal_sdio_irq(host->mmc);
+
+	return result;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Suspend/resume                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+#ifdef CONFIG_PM
+
+int mshci_suspend_host(struct mshci_host *host, pm_message_t state)
+{
+	int ret;
+
+	mshci_disable_card_detection(host);
+
+	ret = mmc_suspend_host(host->mmc);
+	if (ret)
+		return ret;
+
+	free_irq(host->irq, host);
+
+	if (host->vmmc)
+		ret = regulator_disable(host->vmmc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshci_suspend_host);
+
+int mshci_resume_host(struct mshci_host *host)
+{
+	int ret;
+
+	if (host->vmmc) {
+		ret = regulator_enable(host->vmmc);
+		if (ret)
+			return ret;
+	}
+
+	if (host->flags & (MSHCI_USE_IDMA)) {
+		if (host->ops->enable_dma)
+			host->ops->enable_dma(host);
+	}
+
+	ret = request_irq(host->irq, mshci_irq, IRQF_SHARED,
+			  mmc_hostname(host->mmc), host);
+	if (ret)
+		return ret;
+
+	mshci_init(host);
+	mmiowb();
+
+	ret = mmc_resume_host(host->mmc);
+	mshci_enable_card_detection(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshci_resume_host);
+
+#endif /* CONFIG_PM */
+
+/*****************************************************************************\
+ *                                                                           *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+struct mshci_host *mshci_alloc_host(struct device *dev,
+	size_t priv_size)
+{
+	struct mmc_host *mmc;
+	struct mshci_host *host;
+
+	WARN_ON(dev == NULL);
+
+	mmc = mmc_alloc_host(sizeof(struct mshci_host) + priv_size, dev);
+	if (!mmc)
+		return ERR_PTR(-ENOMEM);
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+
+	return host;
+}
+EXPORT_SYMBOL_GPL(mshci_alloc_host);
+
+static void mshci_fifo_init(struct mshci_host *host)
+{
+	int fifo_val, fifo_depth, fifo_threshold;
+
+	fifo_val = mshci_readl(host, MSHCI_FIFOTH);
+	fifo_depth = ((fifo_val & RX_WMARK) >> 16) + 1;
+	fifo_threshold = fifo_depth / 2;
+	host->fifo_threshold = fifo_threshold;
+	host->fifo_depth = fifo_threshold * 2;
+
+	printk(KERN_INFO "%s: FIFO WMARK FOR RX 0x%x WX 0x%x.\n",
+		mmc_hostname(host->mmc), fifo_depth,
+		((fifo_val & TX_WMARK)>>16)+1);
+
+	fifo_val &= ~(RX_WMARK | TX_WMARK | MSIZE_MASK);
+
+	fifo_val |= (fifo_threshold | (fifo_threshold<<16));
+	fifo_val |= MSIZE_8;
+
+	mshci_writel(host, fifo_val, MSHCI_FIFOTH);
+}
+
+int mshci_add_host(struct mshci_host *host)
+{
+	struct mmc_host *mmc;
+	int ret, count;
+
+	WARN_ON(host == NULL);
+	if (host == NULL)
+		return -EINVAL;
+
+	mmc = host->mmc;
+
+	if (debug_quirks)
+		host->quirks = debug_quirks;
+
+	mshci_reset(host, RESET_ALL);
+
+	host->version = mshci_readl(host, MSHCI_VERID);
+
+	/* there are no reasons not to use DMA */
+	host->flags |= MSHCI_USE_IDMA;
+
+	if (host->flags & MSHCI_USE_IDMA) {
+		/* We need to allocate descriptors for all sg entries
+		 * 128 transfer for each of those entries. */
+		host->idma_desc = kmalloc((128 * 2 + 1) * 4, GFP_KERNEL);
+		if (!host->idma_desc) {
+			kfree(host->idma_desc);
+			printk(KERN_WARNING "%s: Unable to allocate IDMA "
+				"buffers. Falling back to standard DMA.\n",
+				mmc_hostname(mmc));
+			host->flags &= ~MSHCI_USE_IDMA;
+		}
+	}
+
+	/*
+	 * If we use DMA, then it's up to the caller to set the DMA
+	 * mask, but PIO does not need the hw shim so we set a new
+	 * mask here in that case.
+	 */
+	if (!(host->flags & (MSHCI_USE_IDMA))) {
+		host->dma_mask = DMA_BIT_MASK(64);
+		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
+	}
+
+	printk("%s: Version ID 0x%x.\n",
+		mmc_hostname(host->mmc), host->version);
+
+	host->max_clk = 0;
+
+	if (host->max_clk == 0) {
+		if (!host->ops->get_max_clock) {
+			printk(KERN_ERR
+			       "%s: Hardware doesn't specify base clock "
+			       "frequency.\n", mmc_hostname(mmc));
+			return -ENODEV;
+		}
+		host->max_clk = host->ops->get_max_clock(host);
+	}
+
+	/*
+	 * Set host parameters.
+	 */
+	if (host->ops->get_ro)
+		mshci_ops.get_ro = host->ops->get_ro;
+
+	mmc->ops = &mshci_ops;
+	mmc->f_min = host->max_clk / 512;
+	mmc->f_max = host->max_clk;
+
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_4_BIT_DATA;
+
+	mmc->ocr_avail |= MMC_VDD_32_33|MMC_VDD_33_34 |
+		MMC_VDD_29_30 | MMC_VDD_30_31;
+
+	spin_lock_init(&host->lock);
+
+	mmc->max_segs = 128;
+
+	/* Maximum number of sectors in one transfer */
+	mmc->max_req_size = 524288;
+
+	/*
+	 * Maximum segment size. Could be one segment with the maximum number
+	 * of bytes. When doing hardware scatter/gather, each entry cannot
+	 * be larger than 4 KiB though.
+	 */
+	if (host->flags & MSHCI_USE_IDMA)
+		mmc->max_seg_size = 0x1000;
+	else
+		mmc->max_seg_size = mmc->max_req_size;
+
+	/*
+	 * from SD spec 2.0 and MMC spec 4.2, block size has been
+	 * fixed to 512 byte
+	 */
+	mmc->max_blk_size = 512;
+
+	/*
+	 * Maximum block count.
+	 */
+	mmc->max_blk_count = 65535;
+
+	/*
+	 * Init tasklets.
+	 */
+	tasklet_init(&host->card_tasklet,
+		mshci_tasklet_card, (unsigned long)host);
+	tasklet_init(&host->finish_tasklet,
+		mshci_tasklet_finish, (unsigned long)host);
+
+	setup_timer(&host->timer, mshci_timeout_timer, (unsigned long)host);
+
+	ret = request_irq(host->irq, mshci_irq, IRQF_SHARED,
+		mmc_hostname(mmc), host);
+	if (ret)
+		goto untasklet;
+
+	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
+	if (IS_ERR(host->vmmc)) {
+		printk(KERN_INFO "%s: no vmmc regulator found\n",
+			mmc_hostname(mmc));
+		host->vmmc = NULL;
+	} else
+		regulator_enable(host->vmmc);
+
+	mshci_init(host);
+	mshci_fifo_init(host);
+
+	mshci_writel(host, (mshci_readl(host, MSHCI_CTRL) | INT_ENABLE),
+			MSHCI_CTRL);
+
+	/* set debounce filter value*/
+	mshci_writel(host, 0xffffff, MSHCI_DEBNCE);
+
+	/* clear card type. set 1bit mode */
+	mshci_writel(host, 0x0, MSHCI_CTYPE);
+
+	/* set bus mode register for IDMAC */
+	if (host->flags & MSHCI_USE_IDMA) {
+		mshci_writel(host, BMOD_IDMAC_RESET, MSHCI_BMOD);
+		count = 100;
+		while ((mshci_readl(host, MSHCI_BMOD) & BMOD_IDMAC_RESET)
+				&& --count);
+
+		mshci_writel(host, (mshci_readl(host, MSHCI_BMOD) |
+				(BMOD_IDMAC_ENABLE|BMOD_IDMAC_FB)), MSHCI_BMOD);
+	}
+#ifdef CONFIG_MMC_DEBUG
+	mshci_dumpregs(host);
+#endif
+
+	mmiowb();
+
+	mmc_add_host(mmc);
+
+	printk(KERN_INFO "%s: MSHCI controller on %s [%s] using %s\n",
+		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		(host->flags & MSHCI_USE_IDMA) ? "IDMA" : "PIO");
+
+	mshci_enable_card_detection(host);
+
+	return 0;
+
+untasklet:
+	tasklet_kill(&host->card_tasklet);
+	tasklet_kill(&host->finish_tasklet);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshci_add_host);
+
+void mshci_remove_host(struct mshci_host *host, int dead)
+{
+	unsigned long flags;
+
+	if (dead) {
+		spin_lock_irqsave(&host->lock, flags);
+
+		host->flags |= MSHCI_DEVICE_DEAD;
+
+		if (host->mrq) {
+			printk(KERN_ERR "%s: Controller removed during "
+				" transfer!\n", mmc_hostname(host->mmc));
+
+			host->mrq->cmd->error = -ENOMEDIUM;
+			tasklet_schedule(&host->finish_tasklet);
+		}
+
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+	mshci_disable_card_detection(host);
+
+	mmc_remove_host(host->mmc);
+
+	if (!dead)
+		mshci_reset(host, RESET_ALL);
+
+	free_irq(host->irq, host);
+
+	del_timer_sync(&host->timer);
+
+	tasklet_kill(&host->card_tasklet);
+	tasklet_kill(&host->finish_tasklet);
+
+	kfree(host->idma_desc);
+
+	host->idma_desc = NULL;
+	host->align_buffer = NULL;
+}
+EXPORT_SYMBOL_GPL(mshci_remove_host);
+
+void mshci_free_host(struct mshci_host *host)
+{
+	mmc_free_host(host->mmc);
+}
+EXPORT_SYMBOL_GPL(mshci_free_host);
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init mshci_drv_init(void)
+{
+	printk(KERN_INFO DRIVER_NAME
+		": Mobile Storage Host Controller Interface driver\n");
+
+	return 0;
+}
+
+static void __exit mshci_drv_exit(void)
+{
+}
+
+module_init(mshci_drv_init);
+module_exit(mshci_drv_exit);
+
+module_param(debug_quirks, uint, 0444);
+
+MODULE_AUTHOR("Jaehoon Chung <jh80.chung@samsung.com>");
+MODULE_DESCRIPTION("Mobile Storage Host Controller Interface core driver");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
diff --git a/drivers/mmc/host/mshci.h b/drivers/mmc/host/mshci.h
new file mode 100644
index 0000000..4594494
--- /dev/null
+++ b/drivers/mmc/host/mshci.h
@@ -0,0 +1,364 @@
+ /*
+ *  linux/drivers/mmc/host/mshci.h - Mobile Storage Host Controller Interface driver
+ *
+ *  Copyright (C) 2011 Samsung Electronics, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+#ifndef __MSHCI_H
+#define __MSHCI_H
+
+#include <linux/scatterlist.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define MSHCI_CTRL	0x00	/* Control Register */
+#define CTRL_RESET		(0x1<<0)
+#define FIFO_RESET		(0x1<<1)
+#define DMA_RESET		(0x1<<2)
+#define RESET_ALL		(CTRL_RESET | FIFO_RESET | DMA_RESET)
+#define INT_ENABLE		(0x1<<4)	/*Global interrupt */
+#define DMA_ENABLE		(0x1<<5)	/* DMA transfer mode */
+#define ENABLE_IDMAC		(0x1<<25)
+
+#define MSHCI_PWREN	0x04	/* Power-enable */
+#define POWER_ENABLE	(0x1<<0)
+
+#define MSHCI_CLKDIV	0x08	/* Clock divider */
+#define MSHCI_CLKSRC	0x0C	/* Clock source */
+
+#define MSHCI_CLKENA	0x10	/* Clock enable */
+#define CLK_SDMMC_MAX		(48000000) /* 96Mhz. it SHOULDBE optimized */
+#define CLK_ENABLE		(0x1<<0)
+#define CLK_DISABLE		(0x0<<0)
+
+#define MSHCI_TMOUT	0x14	/* Timeout */
+#define RSP_TIMEOUT		(0xFF<<0)
+#define DATA_TIMEOUT		(0xFFFFFF<<8)
+
+#define MSHCI_CTYPE	0x18	/* Card type */
+#define CARD_WIDTH14		(0xFFFF<<0)
+#define CARD_WIDTH8		(0xFFFF<<16)
+
+#define MSHCI_BLKSIZ	0x1C	/* Block Size */
+#define BLK_SIZ			(0xFFFF<<0)
+
+#define MSHCI_BYTCNT	0x20	/* Byte count */
+#define MSHCI_INTMSK	0x24	/* Interrupt Mask */
+#define INT_MASK		(0xFFFF<<0)
+#define SDIO_INT_MASK		(0xFFFF<<16)
+#define SDIO_INT_ENABLE		(0x1<<16)
+#define INTMSK_ALL		0xFFFFFFFF
+#define INTMSK_CDETECT		(0x1<<0)
+#define INTMSK_RE		(0x1<<1)
+#define INTMSK_CDONE		(0x1<<2)
+#define INTMSK_DTO		(0x1<<3)
+#define INTMSK_TXDR		(0x1<<4)
+#define INTMSK_RXDR		(0x1<<5)
+#define INTMSK_RCRC		(0x1<<6)
+#define INTMSK_DCRC		(0x1<<7)
+#define INTMSK_RTO		(0x1<<8)
+#define INTMSK_DRTO		(0x1<<9)
+#define INTMSK_HTO		(0x1<<10)
+#define INTMSK_FRUN		(0x1<<11)
+#define INTMSK_HLE		(0x1<<12)
+#define INTMSK_SBE		(0x1<<13)
+#define INTMSK_ACD		(0x1<<14)
+#define INTMSK_EBE		(0x1<<15)
+#define INTMSK_DMA		(INTMSK_ACD | INTMSK_RXDR | INTMSK_TXDR)
+#define INTMSK_DATA_TIMEOUT	(INTMSK_HTO | INTMSK_DRTO)
+#define INTMSK_DATA_CRC		(INTMSK_EBE | INTMSK_SBE | INTMSK_DCRC)
+
+#define INT_SRC_IDMAC		(0x0)
+#define INT_SRC_MINT		(0x1)
+
+#define MSHCI_CMDARG	0x28	/* Command Argument */
+#define MSHCI_CMD	0x2C	/* Command */
+#define CMD_RESP_EXP_BIT	(0x1<<6)
+#define CMD_RESP_LENGTH_BIT	(0x1<<7)
+#define CMD_CHECK_CRC_BIT	(0x1<<8)
+#define CMD_DATA_EXP_BIT	(0x1<<9)
+#define CMD_RW_BIT		(0x1<<10)
+#define CMD_TRANSMODE_BIT	(0x1<<11)
+#define CMD_SENT_AUTO_STOP_BIT	(0x1<<12)
+#define CMD_WAIT_PRV_DAT_BIT	(0x1<<13)
+#define CMD_ABRT_CMD_BIT	(0x1<<14)
+#define CMD_SEND_INIT_BIT	(0x1<<15)
+#define CMD_CARD_NUM_BITS	(0x1F<<16)
+#define CMD_SEND_CLK_ONLY	(0x1<<21)
+#define CMD_READ_CEATA		(0x1<<22)
+#define CMD_CCS_EXPECTED	(0x1<<23)
+#define CMD_STRT_BIT		(0x1<<31)
+#define CMD_ONLY_CLK		(CMD_STRT_BIT | CMD_SEND_CLK_ONLY | \
+					CMD_WAIT_PRV_DAT_BIT)
+
+#define MSHCI_RESP0	0x30	/* Response 0 */
+
+#define MSHCI_MINTSTS	0x40	/* Masked interrupt status */
+#define MSHCI_RINTSTS	0x44	/* Raw interrupt status */
+#define INT_STATUS	(0xFFFF<<0)
+#define SDIO_INTR	(0xFFFF<<16)
+#define DATA_ERR	(INTMSK_EBE | INTMSK_SBE | INTMSK_HLE | INTMSK_FRUN | \
+				INTMSK_EBE | INTMSK_DCRC)
+#define DATA_TOUT	(INTMSK_HTO | INTMSK_DRTO)
+#define DATA_STATUS	(DATA_ERR | DATA_TOUT | INTMSK_RXDR | \
+				INTMSK_TXDR | INTMSK_DTO)
+#define CMD_STATUS	(INTMSK_RTO | INTMSK_RCRC | INTMSK_CDONE | INTMSK_RE)
+#define CMD_ERROR       (INTMSK_RCRC | INTMSK_RTO | INTMSK_RE)
+
+#define MSHCI_STATUS	0x48	/* Status */
+#define FIFO_RXWTRMARK		(0x1<<0)
+#define FIFO_TXWTRMARK		(0x1<<1)
+#define FIFO_EMPTY		(0x1<<2)
+#define FIFO_FULL		(0x1<<3)
+#define CMD_FSMSTAT		(0xF<<4)
+#define DATA_3STATUS		(0x1<<8)
+#define DATA_BUSY		(0x1<<9)
+#define DATA_MCBUSY		(0x1<<10)
+#define RSP_INDEX		(0x3F<<11)
+#define FIFO_COUNT		(0x1FFF<<17)
+#define	DMA_ACK			(0x1<<30)
+#define	DMA_REQ			(0x1<<31)
+#define FIFO_WIDTH		(0x4)
+#define FIFO_DEPTH		(0x20)
+
+/*Command FSM status */
+#define FSM_IDLE		(0<<4)
+#define FSM_SEND_INIT_SEQ	(1<<4)
+#define FSM_TX_CMD_STARTBIT	(2<<4)
+#define FSM_TX_CMD_TXBIT	(3<<4)
+#define	FSM_TX_CMD_INDEX_ARG	(4<<4)
+#define FSM_TX_CMD_CRC7		(5<<4)
+#define FSM_TX_CMD_ENDBIT	(6<<4)
+#define	FSM_RX_RESP_STARTBIT	(7<<4)
+#define FSM_RX_RESP_IRQRESP	(8<<4)
+#define FSM_RX_RESP_TXBIT	(9<<4)
+#define FSM_RX_RESP_CMDIDX	(10<<4)
+#define FSM_RX_RESP_DATA	(11<<4)
+#define FSM_RX_RESP_CRC7	(12<<4)
+#define FSM_RX_RESP_ENDBIT	(13<<4)
+#define FSM_CMD_PATHWAITNCC	(14<<4)
+#define FSM_WAIT		(15<<4)
+
+#define MSHCI_FIFOTH	0x4C	/* FIFO threshold */
+#define TX_WMARK		(0xFFF<<0)
+#define RX_WMARK		(0xFFF<<16)
+#define MSIZE_MASK		(0x7<<28)
+
+/* DW DMA Mutiple Transaction Size */
+#define MSIZE_1			(0<<28)
+#define MSIZE_4			(1<<28)
+#define MSIZE_8			(2<<28)
+#define MSIZE_16		(3<<28)
+#define MSIZE_32		(4<<28)
+#define MSIZE_64		(5<<28)
+#define MSIZE_128		(6<<28)
+#define MSIZE_256		(7<<28)
+
+#define MSHCI_CDETECT	0x50	/* Card detect */
+#define CARD_PRESENT		(0x1<<0)
+
+#define MSHCI_WRTPRT	0x54	/* Write protect */
+#define WRTPRT_ON		(0x1<<0)
+
+#define MSHCI_GPIO	0x58	/* General Purpose IO */
+#define MSHCI_TCBCNT	0x5C	/* Transferred CIU byte count */
+#define MSHCI_TBBCNT	0x60	/* Transferred host/DMA to/from byte count */
+#define MSHCI_DEBNCE	0x64	/* Card detect debounce */
+#define MSHCI_USRID	0x68	/* User ID */
+#define MSHCI_VERID	0x6C	/* Version ID */
+
+#define MSHCI_HCON	0x70	/* Hardware Configuration */
+#define CARD_TYPE		(0x1<<0)
+#define NUM_CARDS		(0x1F<<1)
+#define H_BUS_TYPE		(0x1<<6)
+#define H_DATA_WIDTH		(0x7<<7)
+#define H_ADDR_WIDTH		(0x3F<<10)
+#define DMA_INTERFACE		(0x3<<16)
+#define	GE_DMA_DATA_WIDTH	(0x7<<18)
+#define FIFO_RAM_INSIDE		(0x1<<21)
+#define UMPLEMENT_HOLD_REG	(0x1<<22)
+#define SET_CLK_FALSE_PATH	(0x1<<23)
+#define NUM_CLK_DIVIDER		(0x3<<24)
+
+#define MSHCI_UHS_REG	0x74	/* UHS and DDR setting */
+
+#define MSHCI_BMOD      0x80    /* Bus mode register */
+#define BMOD_IDMAC_RESET        (0x1<<0)
+#define BMOD_IDMAC_FB           (0x1<<1)
+#define BMOD_IDMAC_ENABLE       (0x1<<7)
+
+#define MSHCI_PLDMND    0x84    /* Poll demand */
+#define MSHCI_DBADDR    0x88    /* Descriptor list base address */
+#define MSHCI_IDSTS     0x8C    /* Internal DMAC status */
+#define IDSTS_FSM               (0xf<<13)
+#define IDSTS_EB                (0x7<<10)
+#define IDSTS_AIS               (0x1<<9)
+#define IDSTS_NIS               (0x1<<8)
+#define IDSTS_CES               (0x1<<5)
+#define IDSTS_DU                (0x1<<4)
+#define IDSTS_FBE               (0x1<<2)
+#define IDSTS_RI                (0x1<<1)
+#define IDSTS_TI                (0x1<<0)
+
+#define MSHCI_IDINTEN   0x90    /* Internal DMAC interrupt enable */
+#define MSHCI_DSCADDR   0x94    /* Current host descriptor address */
+#define MSHCI_BUFADDR   0x98    /* Current host buffer address */
+#define MSHCI_WAKEUPCON 0xA0    /* Wakeup control register */
+#define MSHCI_CLOCKCON  0xA4    /* Clock (delay) control register */
+#define MSHCI_FIFODAT	0x100	/* FIFO data read write */
+
+struct mshci_ops;
+
+struct mshci_idmac {
+	u32	des[4];
+#define MSHCI_IDMAC_OWN         (1<<31)
+#define MSHCI_IDMAC_ER          (1<<5)
+#define MSHCI_IDMAC_CH          (1<<4)
+#define MSHCI_IDMAC_FS          (1<<3)
+#define MSHCI_IDMAC_LD          (1<<2)
+#define MSHCI_IDMAC_DIC         (1<<1)
+#define INTMSK_IDMAC_ALL        (0x337)
+#define INTMSK_IDMAC_ERROR      (0x214)
+};
+
+struct mshci_host {
+	/* Data set by hardware interface driver */
+	const char		*hw_name;	/* Hardware bus name */
+
+	unsigned int		quirks;		/* Deviations from spec. */
+/* Controller has no write-protect pin connected with SD card */
+#define MSHCI_QUIRK_NO_WP_BIT                           (1<<0)
+#define MSHCI_QUIRK_BROKEN_CARD_DETECTION               (1<<1)
+#define MSHCI_QUIRK_ALWAYS_WRITABLE                     (1<<2)
+
+	int			irq;		/* Device IRQ */
+	void __iomem		*ioaddr;	/* Mapped address */
+
+	const struct mshci_ops	*ops;		/* Low level hw interface */
+
+	struct regulator	*vmmc;		/* Power regulator */
+
+	/* Internal data */
+	struct mmc_host		*mmc;		/* MMC structure */
+	u64			dma_mask;	/* custom DMA mask */
+
+	spinlock_t		lock;		/* Mutex */
+
+	int			flags;		/* Host attributes */
+#define MSHCI_USE_IDMA		(1<<1)		/* Host is ADMA capable */
+#define MSHCI_REQ_USE_DMA	(1<<2)		/* Use DMA for this req. */
+#define MSHCI_DEVICE_DEAD	(1<<3)		/* Device unresponsive */
+
+	unsigned int		version;	/* SDHCI spec. version */
+
+	unsigned int		max_clk;	/* Max possible freq (MHz) */
+	unsigned int		timeout_clk;	/* Timeout freq (KHz) */
+
+	unsigned int		clock;		/* Current clock (MHz) */
+	u8			pwr;		/* Current voltage */
+
+	struct mmc_request	*mrq;		/* Current request */
+	struct mmc_command	*cmd;		/* Current command */
+	struct mmc_data		*data;		/* Current data request */
+	unsigned int		data_early:1;	/* Data finished before cmd */
+
+	struct sg_mapping_iter	sg_miter;	/* SG state for PIO */
+	unsigned int		blocks;		/* remaining PIO blocks */
+
+	int			sg_count;	/* Mapped sg entries */
+
+	u8			*idma_desc;	/* ADMA descriptor table */
+	u8			*align_buffer;	/* Bounce buffer */
+
+	dma_addr_t		idma_addr;	/* Mapped ADMA descr. table */
+	dma_addr_t		align_addr;	/* Mapped bounce buffer */
+
+	struct tasklet_struct	card_tasklet;	/* Tasklet structures */
+	struct tasklet_struct	finish_tasklet;
+
+	struct timer_list	timer;		/* Timer for timeouts */
+
+	u32			fifo_depth;
+	u32			fifo_threshold;
+	u32			data_transfered;
+	unsigned long		private[0] ____cacheline_aligned;
+};
+
+
+struct mshci_ops {
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+	u32		(*readl)(struct mshci_host *host, int reg);
+	u16		(*readw)(struct mshci_host *host, int reg);
+	u8		(*readb)(struct mshci_host *host, int reg);
+	void		(*writel)(struct mshci_host *host, u32 val, int reg);
+	void		(*writew)(struct mshci_host *host, u16 val, int reg);
+	void		(*writeb)(struct mshci_host *host, u8 val, int reg);
+#endif
+
+	void	(*set_clock)(struct mshci_host *host, unsigned int clock);
+
+	int		(*enable_dma)(struct mshci_host *host);
+	unsigned int	(*get_max_clock)(struct mshci_host *host);
+	unsigned int	(*get_min_clock)(struct mshci_host *host);
+	unsigned int	(*get_timeout_clock)(struct mshci_host *host);
+	void            (*set_ios)(struct mshci_host *host,
+				   struct mmc_ios *ios);
+	int             (*get_ro) (struct mmc_host *mmc);
+	void		(*init_issue_cmd)(struct mshci_host *host);
+};
+
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+
+static inline void mshci_writel(struct mshci_host *host, u32 val, int reg)
+{
+	if (unlikely(host->ops->writel))
+		host->ops->writel(host, val, reg);
+	else
+		writel(val, host->ioaddr + reg);
+}
+
+static inline u32 mshci_readl(struct mshci_host *host, int reg)
+{
+	if (unlikely(host->ops->readl))
+		return host->ops->readl(host, reg);
+	else
+		return readl(host->ioaddr + reg);
+}
+
+#else
+
+static inline void mshci_writel(struct mshci_host *host, u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+}
+
+static inline u32 mshci_readl(struct mshci_host *host, int reg)
+{
+	return readl(host->ioaddr + reg);
+}
+
+#endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
+
+extern struct mshci_host *mshci_alloc_host(struct device *dev,
+	size_t priv_size);
+extern void mshci_free_host(struct mshci_host *host);
+
+static inline void *mshci_priv(struct mshci_host *host)
+{
+	return (void *)host->private;
+}
+
+extern int mshci_add_host(struct mshci_host *host);
+extern void mshci_remove_host(struct mshci_host *host, int dead);
+
+#ifdef CONFIG_PM
+extern int mshci_suspend_host(struct mshci_host *host, pm_message_t state);
+extern int mshci_resume_host(struct mshci_host *host);
+#endif
+
+#endif /* __MSHCI_H */
-- 
1.6.0.4
