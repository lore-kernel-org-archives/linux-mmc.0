From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [RFC PATCH 1/1 v4 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Wed, 9 Apr 2014 20:21:03 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE641180021@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:18387
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933342AbaDIUVK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Apr 2014 16:21:10 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'cjb@laptop.org'" <cjb@laptop.org>
Cc: 'Grant Grundler' <grundler@chromium.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

Add Support to Field Firmware Update (FFU) for eMMC v5.0 and up devices.
 
  The code implemented according to  JEDEC eMMC spec - JESD84-B50.pdf
  http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc
  
This patch version (V4) provides udev (request_firmware) implementation as advised in previous patch version comments.

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig index 5562308..19ba729 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -68,3 +68,11 @@ config MMC_TEST
 
 	  This driver is only of interest to those developing or
 	  testing a host driver. Most people should say N here.
+
+config MMC_FFU
+	bool "FFU SUPPORT"
+	depends on MMC != n
+	help
+	  This is an option to run firmware update on eMMC 5.0.
+	  Field firmware updates (FFU) enables features enhancment
+	  in the field.
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile index c73b406..1e9223b 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
 
+obj-$(CONFIG_MMC_FFU)		+= ffu.o
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index 7b5424f..8311200 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -41,6 +41,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
+#include <linux/mmc/ffu.h>
 
 #include <asm/uaccess.h>
 
@@ -525,6 +526,17 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 	mmc_get_card(card);
 
+	if (cmd.opcode == MMC_FFU_DOWNLOAD_OP) {
+		err = mmc_ffu_download(card, &cmd , idata->buf,
+			idata->buf_bytes);
+		goto cmd_rel_host;
+	}
+
+	if (cmd.opcode == MMC_FFU_INSTALL_OP) {
+		err = mmc_ffu_install(card);
+		goto cmd_rel_host;
+	}
+
 	err = mmc_blk_part_switch(card, md);
 	if (err)
 		goto cmd_rel_host;
diff --git a/drivers/mmc/card/ffu.c b/drivers/mmc/card/ffu.c new file mode 100644 index 0000000..ed5f30a
--- /dev/null
+++ b/drivers/mmc/card/ffu.c
@@ -0,0 +1,605 @@
+/*
+ * *  ffu.c
+ *
+ *  Copyright 2007-2008 Pierre Ossman
+ *
+ *  Modified by SanDisk Corp., Copyright (c) 2013 SanDisk Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or 
+(at
+ * your option) any later version.
+ *
+ * This program includes bug.h, card.h, host.h, mmc.h, scatterlist.h,
+ * slab.h, ffu.h & swap.h header files
+ * The original, unmodified version of this program - the mmc_test.c
+ * file - is obtained under the GPL v2.0 license that is available via
+ * http://www.gnu.org/licenses/,
+ * or http://www.opensource.org/licenses/gpl-2.0.php
+*/
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/mmc/ffu.h>
+
+/**
+ * struct mmc_ffu_pages - pages allocated by 'alloc_pages()'.
+ * @page: first page in the allocation
+ * @order: order of the number of pages allocated  */ struct 
+mmc_ffu_pages {
+	struct page *page;
+	unsigned int order;
+};
+
+/**
+ * struct mmc_ffu_mem - allocated memory.
+ * @arr: array of allocations
+ * @cnt: number of allocations
+ */
+struct mmc_ffu_mem {
+	struct mmc_ffu_pages *arr;
+	unsigned int cnt;
+};
+
+struct mmc_ffu_area {
+	unsigned long max_sz;
+	unsigned int max_tfr;
+	unsigned int max_segs;
+	unsigned int max_seg_sz;
+	unsigned int blocks;
+	unsigned int sg_len;
+	struct mmc_ffu_mem *mem;
+	struct scatterlist *sg;
+};
+
+static void mmc_ffu_prepare_mrq(struct mmc_card *card,
+	struct mmc_request *mrq, struct scatterlist *sg, unsigned int sg_len,
+	u32 arg, unsigned int blocks, unsigned int blksz, int write) {
+	BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
+
+	if (blocks > 1) {
+		mrq->cmd->opcode = write ?
+			MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
+	} else {
+		mrq->cmd->opcode = write ? MMC_WRITE_BLOCK :
+			MMC_READ_SINGLE_BLOCK;
+	}
+
+	mrq->cmd->arg = arg;
+	if (!mmc_card_blockaddr(card))
+		mrq->cmd->arg <<= 9;
+
+	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	if (blocks == 1) {
+		mrq->stop = NULL;
+	} else {
+		mrq->stop->opcode = MMC_STOP_TRANSMISSION;
+		mrq->stop->arg = 0;
+		mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
+	mrq->data->blksz = blksz;
+	mrq->data->blocks = blocks;
+	mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
+	mrq->data->sg = sg;
+	mrq->data->sg_len = sg_len;
+
+	mmc_set_data_timeout(mrq->data, card); }
+
+/*
+ * Checks that a normal transfer didn't have any errors  */ static int 
+mmc_ffu_check_result(struct mmc_request *mrq) {
+	BUG_ON(!mrq || !mrq->cmd || !mrq->data);
+
+	if (mrq->cmd->error != 0)
+		return -EINVAL;
+
+	if (mrq->data->error != 0)
+		return -EINVAL;
+
+	if (mrq->stop != NULL && mrq->stop->error != 0)
+		return -1;
+
+	if (mrq->data->bytes_xfered != (mrq->data->blocks * mrq->data->blksz))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mmc_ffu_busy(struct mmc_command *cmd) {
+	return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
+		(R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG); }
+
+static int mmc_ffu_wait_busy(struct mmc_card *card) {
+	int ret, busy = 0;
+	struct mmc_command cmd = {0};
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	do {
+		ret = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (ret)
+			break;
+
+		if (!busy && mmc_ffu_busy(&cmd)) {
+			busy = 1;
+			if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) {
+				pr_warn("%s: Warning: Host did not "
+					"wait for busy state to end.\n",
+					mmc_hostname(card->host));
+			}
+		}
+
+	} while (mmc_ffu_busy(&cmd));
+
+	return ret;
+}
+
+/*
+ * transfer with certain parameters
+ */
+static int mmc_ffu_simple_transfer(struct mmc_card *card,
+	struct scatterlist *sg, unsigned int sg_len, u32 arg,
+	unsigned int blocks, unsigned int blksz, int write) {
+	struct mmc_request mrq = {0};
+	struct mmc_command cmd = {0};
+	struct mmc_command stop = {0};
+	struct mmc_data data = {0};
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+	mmc_ffu_prepare_mrq(card, &mrq, sg, sg_len, arg, blocks, blksz,
+		write);
+	mmc_wait_for_req(card->host, &mrq);
+
+	mmc_ffu_wait_busy(card);
+
+	return mmc_ffu_check_result(&mrq);
+}
+
+/*
+ * Map memory into a scatterlist.
+ */
+static int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, unsigned long size,
+	struct scatterlist *sglist, unsigned int max_segs,
+	unsigned int max_seg_sz, unsigned int *sg_len,
+	int min_sg_len)
+{
+	struct scatterlist *sg = NULL;
+	unsigned int i;
+	unsigned long sz = size;
+
+	sg_init_table(sglist, max_segs);
+	if (min_sg_len > max_segs)
+		min_sg_len = max_segs;
+
+	*sg_len = 0;
+	do {
+		for (i = 0; i < mem->cnt; i++) {
+			unsigned long len = PAGE_SIZE << mem->arr[i].order;
+
+			if (min_sg_len && (size / min_sg_len < len))
+				len = ALIGN(size / min_sg_len, CARD_BLOCK_SIZE);
+			if (len > sz)
+				len = sz;
+			if (len > max_seg_sz)
+				len = max_seg_sz;
+			if (sg)
+				sg = sg_next(sg);
+			else
+				sg = sglist;
+			if (!sg)
+				return -EINVAL;
+			sg_set_page(sg, mem->arr[i].page, len, 0);
+			sz -= len;
+			*sg_len += 1;
+			if (!sz)
+				break;
+		}
+	} while (sz);
+
+	if (sg)
+		sg_mark_end(sg);
+
+	return 0;
+}
+
+static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem) {
+	if (!mem)
+		return;
+	while (mem->cnt--)
+		__free_pages(mem->arr[mem->cnt].page, mem->arr[mem->cnt].order);
+	kfree(mem->arr);
+}
+
+/*
+ * Cleanup struct mmc_ffu_area.
+ */
+static int mmc_ffu_area_cleanup(struct mmc_ffu_area *area) {
+	kfree(area->sg);
+	mmc_ffu_free_mem(area->mem);
+
+	return 0;
+}
+
+/*
+ * Allocate a lot of memory, preferably max_sz but at least min_sz. In 
+case
+ * there isn't much memory do not exceed 1/16th total low mem pages. 
+Also do
+ * not exceed a maximum number of segments and try not to make segments 
+much
+ * bigger than maximum segment size.
+ */
+static struct mmc_ffu_mem *mmc_ffu_alloc_mem(unsigned long min_sz,
+	unsigned long max_sz, unsigned int max_segs, unsigned int max_seg_sz) 
+{
+	unsigned long max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
+	unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
+	unsigned long max_seg_page_cnt = DIV_ROUND_UP(max_seg_sz, PAGE_SIZE);
+	unsigned long page_cnt = 0;
+	unsigned long limit = nr_free_buffer_pages() >> 4;
+	struct mmc_ffu_mem *mem;
+
+	if (max_page_cnt > limit)
+		max_page_cnt = limit;
+	if (min_page_cnt > max_page_cnt)
+		min_page_cnt = max_page_cnt;
+
+	if (max_seg_page_cnt > max_page_cnt)
+		max_seg_page_cnt = max_page_cnt;
+
+	if (max_segs > max_page_cnt)
+		max_segs = max_page_cnt;
+
+	mem = kzalloc(sizeof(struct mmc_ffu_mem), GFP_KERNEL);
+	if (!mem)
+		return NULL;
+
+	mem->arr = kzalloc(sizeof(struct mmc_ffu_pages) * max_segs, GFP_KERNEL);
+	if (!mem->arr)
+		goto out_free;
+
+	while (max_page_cnt) {
+		struct page *page;
+		unsigned int order;
+		gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
+			__GFP_NORETRY;
+
+		order = get_order(max_seg_page_cnt << PAGE_SHIFT);
+		while (1) {
+			page = alloc_pages(flags, order);
+			if (page || !order)
+				break;
+			order -= 1;
+		}
+		if (!page) {
+			if (page_cnt < min_page_cnt)
+				goto out_free;
+			break;
+		}
+		mem->arr[mem->cnt].page = page;
+		mem->arr[mem->cnt].order = order;
+		mem->cnt += 1;
+		if (max_page_cnt <= (1UL << order))
+			break;
+		max_page_cnt -= 1UL << order;
+		page_cnt += 1UL << order;
+		if (mem->cnt >= max_segs) {
+			if (page_cnt < min_page_cnt)
+				goto out_free;
+			break;
+		}
+	}
+
+	return mem;
+
+out_free:
+	mmc_ffu_free_mem(mem);
+	return NULL;
+}
+
+/*
+ * Initialize an area for data transfers.
+ * Copy the data to the allocated pages.
+ */
+static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_card *card,
+	u8 *data, unsigned int size)
+{
+	int ret, i, length;
+
+	area->max_segs = card->host->max_segs;
+	area->max_seg_sz = card->host->max_seg_size & ~(CARD_BLOCK_SIZE - 1);
+	area->max_tfr = size;
+
+	if (area->max_tfr >> 9 > card->host->max_blk_count)
+		area->max_tfr = card->host->max_blk_count << 9;
+	if (area->max_tfr > card->host->max_req_size)
+		area->max_tfr = card->host->max_req_size;
+	if (area->max_tfr / area->max_seg_sz > area->max_segs)
+		area->max_tfr = area->max_segs * area->max_seg_sz;
+
+	/*
+	 * Try to allocate enough memory for a max. sized transfer. Less is OK
+	 * because the same memory can be mapped into the scatterlist more than
+	 * once. Also, take into account the limits imposed on scatterlist
+	 * segments by the host driver.
+	 */
+	area->mem = mmc_ffu_alloc_mem(1, area->max_tfr, area->max_segs,
+			area->max_seg_sz);
+	if (!area->mem)
+		return -ENOMEM;
+
+	/* copy data to page */
+	length = 0;
+	for (i = 0; i < area->mem->cnt; i++) {
+		 memcpy(page_address(area->mem->arr[i].page), data + length,
+			min(size - length, area->max_seg_sz));
+		length += area->max_seg_sz;
+	}
+
+	area->sg = kmalloc(sizeof(struct scatterlist) * area->max_segs,
+		GFP_KERNEL);
+	if (!area->sg) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = mmc_ffu_map_sg(area->mem, size, area->sg,
+			area->max_segs, area->max_seg_sz, &area->sg_len, 1);
+
+	if (ret != 0)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	mmc_ffu_area_cleanup(area);
+	return ret;
+}
+
+static int mmc_ffu_write(struct mmc_card *card, u8 *src, u32 arg,
+	int size)
+{
+	int rc;
+	struct mmc_ffu_area mem;
+
+	mem.sg = NULL;
+	mem.mem = NULL;
+
+	if (!src) {
+		pr_err("FFU: %s: data buffer is NULL\n",
+			mmc_hostname(card->host));
+		return -EINVAL;
+	}
+	rc = mmc_ffu_area_init(&mem, card, src, size);
+	if (rc != 0)
+		goto exit;
+
+	rc = mmc_ffu_simple_transfer(card, mem.sg, mem.sg_len, arg,
+		size / CARD_BLOCK_SIZE, CARD_BLOCK_SIZE, 1);
+
+exit:
+	mmc_ffu_area_cleanup(&mem);
+	return rc;
+}
+/* Flush all scheduled work from the MMC work queue.
+ * and initialize the MMC device */
+static int mmc_ffu_restart(struct mmc_card *card) {
+	struct mmc_host *host = card->host;
+	int err = 0;
+
+	mmc_cache_ctrl(host, 0);
+	err = mmc_power_save_host(host);
+	if (err) {
+		pr_warn("%s: going to sleep failed (%d)!!!\n",
+			__func__ , err);
+		goto exit;
+	}
+
+	err = mmc_power_restore_host(host);
+
+exit:
+
+	return err;
+}
+
+/* Host set the EXT_CSD */
+static int mmc_host_set_ffu(struct mmc_card *card, u32 ffu_enable) {
+	int err;
+
+	/* check if card is eMMC 5.0 or higher */
+	if (card->ext_csd.rev < 7)
+		return -EINVAL;
+
+	if (FFU_ENABLED(ffu_enable)) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_FW_CONFIG, MMC_FFU_ENABLE,
+			card->ext_csd.generic_cmd6_time);
+		if (err) {
+			pr_err("%s: switch to FFU failed with error %d\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
+	u8 *data, int buf_bytes)
+{
+	u8 ext_csd[CARD_BLOCK_SIZE];
+	int err;
+	int ret;
+
+	/* Read the EXT_CSD */
+	err = mmc_send_ext_csd(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* Check if FFU is supported by card */
+	if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])) {
+		err = -EINVAL;
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	err = mmc_host_set_ffu(card, ext_csd[EXT_CSD_FW_CONFIG]);
+	if (err) {
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		err = -EINVAL;
+		goto exit;
+	}
+
+	/* set device to FFU mode */
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_MODE_CONFIG,
+		MMC_FFU_MODE_SET, card->ext_csd.generic_cmd6_time);
+	if (err) {
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit_normal;
+	}
+
+	/* set CMD ARG */
+	cmd->arg = ext_csd[EXT_CSD_FFU_ARG] |
+		ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
+		ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
+		ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
+
+	err = mmc_ffu_write(card, data, cmd->arg, buf_bytes);
+
+exit_normal:
+	/* host switch back to work in normal MMC Read/Write commands */
+	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+		EXT_CSD_MODE_CONFIG, MMC_FFU_MODE_NORMAL,
+		card->ext_csd.generic_cmd6_time);
+	if (ret)
+		err = ret;
+
+exit:
+	return err;
+}
+EXPORT_SYMBOL(mmc_ffu_download);
+
+int mmc_ffu_install(struct mmc_card *card) {
+	u8 ext_csd[CARD_BLOCK_SIZE];
+	int err;
+	u32 ffu_data_len;
+	u32 timeout;
+
+	err = mmc_send_ext_csd(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* Check if FFU is supported */
+	if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE]) ||
+		FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
+		err = -EINVAL;
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	ffu_data_len = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
+		ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
+		ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
+		ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
+
+	if (!ffu_data_len) {
+		err = -EPERM;
+		return err;
+	}
+
+	/* check mode operation */
+	if (!FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES])) {
+		/* restart the eMMC */
+		err = mmc_ffu_restart(card);
+		if (err) {
+			pr_err("FFU: %s: error %d FFU install:\n",
+				mmc_hostname(card->host), err);
+		}
+	} else {
+			/* set device to FFU mode */
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_MODE_CONFIG, 0x1,
+				card->ext_csd.generic_cmd6_time);
+			if (err) {
+				pr_err("FFU: %s: error %d FFU is not supported\n",
+					mmc_hostname(card->host), err);
+				goto exit;
+			}
+
+			timeout = ext_csd[EXT_CSD_OPERATION_CODE_TIMEOUT];
+			if (timeout == 0 || timeout > 0x17) {
+				timeout = 0x17;
+				pr_warn("FFU: %s: operation code timeout is out "
+						"of range. Using maximum timeout.\n",
+					mmc_hostname(card->host));
+			}
+
+			/* timeout is at millisecond resolution */
+			timeout = (100 * (1 << timeout) / 1000) + 1;
+
+			/* set ext_csd to install mode */
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_MODE_OPERATION_CODES,
+				MMC_FFU_INSTALL_SET, timeout);
+
+			if (err) {
+				pr_err("FFU: %s: error %d setting install mode\n",
+					mmc_hostname(card->host), err);
+				goto exit;
+			}
+
+			/* read ext_csd */
+			err = mmc_send_ext_csd(card, ext_csd);
+			if (err) {
+				pr_err("FFU: %s: error %d sending ext_csd\n",
+					mmc_hostname(card->host), err);
+				goto exit;
+			}
+			/* return status */
+			err = ext_csd[EXT_CSD_FFU_STATUS];
+			if (err) {
+				pr_err("FFU: %s: error %d FFU install:\n",
+					mmc_hostname(card->host), err);
+				err = -EINVAL;
+				goto exit;
+			}
+		}
+
+exit:
+	return err;
+}
+EXPORT_SYMBOL(mmc_ffu_install);
+
diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h new file mode 100644 index 0000000..be70880
--- /dev/null
+++ b/include/linux/mmc/ffu.h
@@ -0,0 +1,63 @@
+/*
+ *
+ *  ffu.h
+ *
+ * Copyright (c) 2013 SanDisk Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or 
+(at
+ * your option) any later version.
+ *
+ * This program was created by SanDisk Corp
+ * The ffu.h file is obtained under the GPL v2.0 license that is
+ * available via http://www.gnu.org/licenses/,
+ * or http://www.opensource.org/licenses/gpl-2.0.php
+*/
+
+#if !defined(_FFU_H_)
+#define _FFU_H_
+
+#include <linux/mmc/card.h>
+
+#define CARD_BLOCK_SIZE 512
+
+/*
+ * eMMC5.0 Field Firmware Update (FFU) opcodes */ #define 
+MMC_FFU_DOWNLOAD_OP 302 #define MMC_FFU_INSTALL_OP 303
+
+#define MMC_FFU_MODE_SET 0x1
+#define MMC_FFU_MODE_NORMAL 0x0
+#define MMC_FFU_INSTALL_SET 0x1
+
+#ifdef CONFIG_MMC_FFU
+#define MMC_FFU_ENABLE 0x0
+#define MMC_FFU_CONFIG 0x1
+#define MMC_FFU_SUPPORTED_MODES 0x1
+#define MMC_FFU_FEATURES 0x1
+
+#define FFU_ENABLED(ffu_enable)	(ffu_enable & MMC_FFU_CONFIG)
+#define FFU_SUPPORTED_MODE(ffu_sup_mode) \
+	(ffu_sup_mode && MMC_FFU_SUPPORTED_MODES) #define
+FFU_CONFIG(ffu_config) (ffu_config & MMC_FFU_CONFIG) #define
+FFU_FEATURES(ffu_fetures) (ffu_fetures & MMC_FFU_FEATURES)
+
+int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
+	u8 *data, int buf_bytes);
+int mmc_ffu_install(struct mmc_card *card); #else static inline int 
+mmc_ffu_download(struct mmc_card *card,
+	struct mmc_command *cmd, u8 *data, int buf_bytes) {
+	return -ENOSYS;
+}
+static inline int mmc_ffu_install(struct mmc_card *card) {
+	return -ENOSYS;
+}
+
+#endif
+#endif /* FFU_H_ */
+
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index 50bcde3..bf29e52 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -272,6 +272,9 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_FFU_STATUS		26	/* R */
+#define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
+#define EXT_CSD_MODE_CONFIG		30	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
@@ -290,6 +293,7 @@ struct _mmc_csd {
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_RPMB_MULT		168	/* RO */
+#define EXT_CSD_FW_CONFIG		169	/* R/W */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -325,6 +329,11 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
+#define EXT_CSD_NUM_OF_FW_SEC_PROG	302	/* RO */
+#define EXT_CSD_FFU_ARG			487	/* RO, 4 bytes */
+#define EXT_CSD_OPERATION_CODE_TIMEOUT	491	/* RO */
+#define EXT_CSD_FFU_FEATURES		492	/* RO */
+#define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
 #define EXT_CSD_MAX_PACKED_WRITES	500	/* RO */


