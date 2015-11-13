From: Holger Schurig <holgerschurig@gmail.com>
Subject: [PATCH 6/6] mmc: eMMC Field Firmware Update support
Date: Fri, 13 Nov 2015 15:56:12 +0100
Message-ID: <1447426572-11756-7-git-send-email-holgerschurig@gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avi.shchislowski@sandisk.com, alex.lemberg@sandisk.com
Cc: Holger Schurig <holgerschurig@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The Field Firmware Update (FFU) feature is in the eMMC 5.0 spec, see
http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc)

This adds a new ioctl MMC_FFU_INVOKE to transfer the new Firmware data from
user space (via udev firmware request) to the eMMC device and install the
new firmware.

This solution allows to:
- complete FFU as an atomic operation, without being interrupted by other IO
  requests (theoretically the firmware update could be done completely from
  userspace, just not atomic)
- not limited in firmware data size because it's using multiple write operations
- support of both EXT_CSD_MODE_OPERATION_CODES modes

Almost completely taken from Avi Shchislowsk/Alex Lemberg patch
"[PATCH 3/3]mmc: Support-FFU-for-eMMC-v5.0".

Signed-off-by: Holger Schurig <holgerschurig@gmail.com>
---
 drivers/mmc/card/Kconfig   |  11 +
 drivers/mmc/card/Makefile  |   1 +
 drivers/mmc/card/block.c   |   5 +
 drivers/mmc/card/mmc_ffu.c | 487 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |   1 +
 include/linux/mmc/core.h   |  22 ++
 include/linux/mmc/mmc.h    |   6 +
 7 files changed, 533 insertions(+)
 create mode 100644 drivers/mmc/card/mmc_ffu.c

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 5562308..b37937b 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -57,6 +57,17 @@ config SDIO_UART
 	  SDIO function driver for SDIO cards that implements the UART
 	  class, as well as the GPS class which appears like a UART.
 
+config MMC_FFU
+	bool "Field Firmware Update support"
+	depends on MMC != n
+	help
+	  Some eMMC 5.0 devices allow to update their firmware "in the
+	  field". This option enables support for this.
+
+	  If this is compiled in, you can use the mmc utility to request
+	  that the kernel loads the firmware via udev and writes it
+	  to the eMMC.
+
 config MMC_TEST
 	tristate "MMC host test driver"
 	help
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index c73b406..99a01e8 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
+obj-$(CONFIG_MMC_FFU)		+= mmc_ffu.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 23b6c8e..a49cfea 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -486,6 +486,11 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	cmd.arg = idata->ic.arg;
 	cmd.flags = idata->ic.flags;
 
+	if (idata->ic.opcode == MMC_FFU_INVOKE_OP) {
+		err = mmc_ffu_invoke(card, idata->buf);
+		goto cmd_done;
+	}
+
 	if (idata->buf_bytes) {
 		data.sg = &sg;
 		data.sg_len = 1;
diff --git a/drivers/mmc/card/mmc_ffu.c b/drivers/mmc/card/mmc_ffu.c
new file mode 100644
index 0000000..8501460
--- /dev/null
+++ b/drivers/mmc/card/mmc_ffu.c
@@ -0,0 +1,487 @@
+/*
+ *  Copyright 2007-2008 Pierre Ossman
+ *
+ *  Modified by SanDisk Corp., Copyright (c) 2014 SanDisk Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program includes bug.h, card.h, host.h, mmc.h, scatterlist.h,
+ * slab.h, ffu.h & swap.h header files
+ * The original, unmodified version of this program - the mmc_test.c
+ * file - is obtained under the GPL v2.0 license that is available via
+ * http://www.gnu.org/licenses/,
+ * or http://www.opensource.org/licenses/gpl-2.0.php
+ */
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/firmware.h>
+
+/**
+ * struct mmc_ffu_pages - pages allocated by 'alloc_pages()'.
+ * @page: first page in the allocation
+ * @order: order of the number of pages allocated
+ */
+struct mmc_ffu_pages {
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
+	struct mmc_ffu_mem mem;
+	struct sg_table sgtable;
+};
+
+/*
+ * Map memory into a scatterlist.
+ */
+static unsigned int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, int size,
+				struct scatterlist *sglist)
+{
+	struct scatterlist *sg = sglist;
+	unsigned int i;
+	unsigned long sz = size;
+	unsigned int sctr_len = 0;
+	unsigned long len;
+
+	for (i = 0; i < mem->cnt && sz; i++, sz -= len) {
+		len = PAGE_SIZE << mem->arr[i].order;
+
+		if (len > sz) {
+			len = sz;
+			sz = 0;
+		}
+
+		sg_set_page(sg, mem->arr[i].page, len, 0);
+		sg = sg_next(sg);
+		sctr_len++;
+	}
+
+	return sctr_len;
+}
+
+static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem)
+{
+	if (!mem)
+		return;
+
+	while (mem->cnt--)
+		__free_pages(mem->arr[mem->cnt].page, mem->arr[mem->cnt].order);
+
+	kfree(mem->arr);
+}
+
+/*
+ * Cleanup struct mmc_ffu_area.
+ */
+static int mmc_ffu_area_cleanup(struct mmc_ffu_area *area)
+{
+	sg_free_table(&area->sgtable);
+	mmc_ffu_free_mem(&area->mem);
+	return 0;
+}
+
+/*
+ * Allocate a lot of memory, preferably max_sz but at least min_sz. In case
+ * there isn't much memory do not exceed 1/16th total low mem pages. Also do
+ * not exceed a maximum number of segments and try not to make segments much
+ * bigger than maximum segment size.
+ */
+static int mmc_ffu_alloc_mem(struct mmc_ffu_area *area, unsigned long min_sz)
+{
+	unsigned long max_page_cnt = DIV_ROUND_UP(area->max_tfr, PAGE_SIZE);
+	unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
+	unsigned long max_seg_page_cnt =
+		DIV_ROUND_UP(area->max_seg_sz, PAGE_SIZE);
+	unsigned long page_cnt = 0;
+	/* divide to not allocate unnecessary memory */
+	unsigned long limit = nr_free_buffer_pages() >> 4;
+
+	gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN | __GFP_NORETRY;
+
+	if (max_page_cnt > limit) {
+		max_page_cnt = limit;
+		area->max_tfr = max_page_cnt * PAGE_SIZE;
+	}
+
+	if (min_page_cnt > max_page_cnt)
+		min_page_cnt = max_page_cnt;
+
+	if (area->max_segs * max_seg_page_cnt > max_page_cnt)
+		area->max_segs = DIV_ROUND_UP(max_page_cnt, max_seg_page_cnt);
+
+	area->mem.arr = kcalloc(area->max_segs, sizeof(struct mmc_ffu_pages),
+				GFP_KERNEL);
+	area->mem.cnt = 0;
+	if (!area->mem.arr)
+		goto out_free;
+
+	while (max_page_cnt) {
+		struct page *page;
+		unsigned int order;
+
+		order = get_order(max_seg_page_cnt << PAGE_SHIFT);
+
+		do {
+			page = alloc_pages(flags, order);
+		} while (!page && order--);
+
+		if (!page)
+			goto out_free;
+
+		area->mem.arr[area->mem.cnt].page = page;
+		area->mem.arr[area->mem.cnt].order = order;
+		area->mem.cnt++;
+		page_cnt += 1UL << order;
+		if (max_page_cnt <= (1UL << order))
+			break;
+		max_page_cnt -= 1UL << order;
+	}
+
+	if (page_cnt < min_page_cnt)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	mmc_ffu_free_mem(&area->mem);
+	return -ENOMEM;
+}
+
+/*
+ * Initialize an area for data transfers.
+ * Copy the data to the allocated pages.
+ */
+static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_card *card,
+			const u8 *data)
+{
+	int ret;
+	int i;
+	unsigned int length = 0, page_length;
+
+	ret = mmc_ffu_alloc_mem(area, 1);
+	for (i = 0; i < area->mem.cnt; i++) {
+		if (length > area->max_tfr) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+		page_length = PAGE_SIZE << area->mem.arr[i].order;
+		memcpy(page_address(area->mem.arr[i].page), data + length,
+			min(area->max_tfr - length, page_length));
+		length += page_length;
+	}
+
+	ret = sg_alloc_table(&area->sgtable, area->mem.cnt, GFP_KERNEL);
+	if (ret)
+		goto out_free;
+
+	area->sg_len = mmc_ffu_map_sg(&area->mem, area->max_tfr,
+				area->sgtable.sgl);
+
+
+	return 0;
+
+out_free:
+	mmc_ffu_free_mem(&area->mem);
+	return ret;
+}
+
+static int mmc_ffu_write(struct mmc_card *card, const u8 *src, u32 arg,
+			int size)
+{
+	int rc;
+	struct mmc_ffu_area area = {0};
+	int block_size = card->ext_csd.data_sector_size;
+
+	area.max_segs = card->host->max_segs;
+	area.max_seg_sz = card->host->max_seg_size & ~(block_size - 1);
+
+	do {
+		area.max_tfr = size;
+		if (area.max_tfr >> 9 > card->host->max_blk_count)
+			area.max_tfr = card->host->max_blk_count << 9;
+		if (area.max_tfr > card->host->max_req_size)
+			area.max_tfr = card->host->max_req_size;
+		if (DIV_ROUND_UP(area.max_tfr, area.max_seg_sz) > area.max_segs)
+			area.max_tfr = area.max_segs * area.max_seg_sz;
+
+		rc = mmc_ffu_area_init(&area, card, src);
+		if (rc != 0)
+			goto exit;
+
+		rc = mmc_simple_transfer(card, area.sgtable.sgl, area.sg_len,
+			arg, area.max_tfr / block_size, block_size, 1);
+		mmc_ffu_area_cleanup(&area);
+		if (rc != 0) {
+			pr_err("%s mmc_ffu_simple_transfer %d\n", __func__, rc);
+			goto exit;
+		}
+		src += area.max_tfr;
+		size -= area.max_tfr;
+
+	} while (size > 0);
+
+exit:
+	return rc;
+}
+
+/*
+ * Flush all scheduled work from the MMC work queue.
+ * and initialize the MMC device
+ */
+static int mmc_ffu_restart(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	int err = 0;
+
+	err = mmc_power_save_host(host);
+	if (err) {
+		pr_warn("%s: going to sleep failed (%d)!!!\n",
+			__func__, err);
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
+static int mmc_ffu_switch_mode(struct mmc_card *card, int mode)
+{
+	int err = 0;
+	int offset;
+
+	switch (mode) {
+	case MMC_FFU_MODE_SET:
+	case MMC_FFU_MODE_NORMAL:
+		offset = EXT_CSD_MODE_CONFIG;
+		break;
+	case MMC_FFU_INSTALL_SET:
+		offset = EXT_CSD_MODE_OPERATION_CODES;
+		mode = 0x1;
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	if (err == 0) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				offset, mode,
+				card->ext_csd.generic_cmd6_time);
+	}
+
+	return err;
+}
+
+static int mmc_ffu_install(struct mmc_card *card, u8 *ext_csd)
+{
+	int err;
+	u32 timeout;
+
+	/* check mode operation */
+	if (!card->ext_csd.ffu_mode_op) {
+		/* host switch back to work in normal MMC Read/Write commands */
+		err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
+		if (err) {
+			pr_err("FFU: %s: switch to normal mode error %d:\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+
+		/* restart the eMMC */
+		err = mmc_ffu_restart(card);
+		if (err) {
+			pr_err("FFU: %s: install error %d:\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+	} else {
+		timeout = ext_csd[EXT_CSD_OPERATION_CODE_TIMEOUT];
+		if (timeout == 0 || timeout > 0x17) {
+			timeout = 0x17;
+			pr_warn("FFU: %s: operation timeout out of range, using max timeout.\n",
+				mmc_hostname(card->host));
+		}
+
+		/* timeout is at millisecond resolution */
+		timeout = DIV_ROUND_UP((100 * (1 << timeout)), 1000);
+
+		/* set ext_csd to install mode */
+		err = mmc_ffu_switch_mode(card, MMC_FFU_INSTALL_SET);
+		if (err) {
+			pr_err("FFU: %s: error %d setting install mode\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+	}
+
+	/* read ext_csd */
+	err =  mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD,
+				ext_csd, 512);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+			mmc_hostname(card->host), err);
+		return err;
+	}
+
+	/* return status */
+	err = ext_csd[EXT_CSD_FFU_STATUS];
+	if (err) {
+		pr_err("FFU: %s: error %d FFU install:\n",
+			mmc_hostname(card->host), err);
+		return  -EINVAL;
+	}
+
+	return 0;
+}
+
+int mmc_ffu_invoke(struct mmc_card *card, const char *name)
+{
+	u8 ext_csd[512];
+	int err;
+	u32 arg;
+	u32 fw_prog_bytes;
+	const struct firmware *fw;
+	int block_size = card->ext_csd.data_sector_size;
+
+	/* Check if FFU is supported */
+	if (!card->ext_csd.ffu_capable) {
+		pr_err("FFU: %s: error FFU is not supported %d rev %d\n",
+			mmc_hostname(card->host), card->ext_csd.ffu_capable,
+			card->ext_csd.rev);
+		return -EOPNOTSUPP;
+	}
+
+	if (strlen(name) > 512) {
+		pr_err("FFU: %s: %.20s is not a valid argument\n",
+			mmc_hostname(card->host), name);
+		return -EINVAL;
+	}
+
+	/* setup FW data buffer */
+	err = request_firmware(&fw, name, &card->dev);
+	if (err) {
+		pr_err("FFU: %s: Firmware request failed %d\n",
+			mmc_hostname(card->host), err);
+		return err;
+	}
+	if ((fw->size % block_size)) {
+		pr_warn("FFU: %s: Warning %zd firmware data size not aligned!\n",
+			mmc_hostname(card->host), fw->size);
+	}
+
+	mmc_get_card(card);
+
+	/* trigger flushing*/
+	err = mmc_flush_cache(card);
+	if (err) {
+		pr_err("FFU: %s: error %d flushing data\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* Read the EXT_CSD */
+	err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD,
+				ext_csd, 512);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* set CMD ARG */
+	arg = ext_csd[EXT_CSD_FFU_ARG] |
+		ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
+		ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
+		ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
+
+	/* set device to FFU mode */
+	err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_SET);
+	if (err) {
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	err = mmc_ffu_write(card, fw->data, arg, fw->size);
+	if (err) {
+		pr_err("FFU: %s: write error %d\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+	/* payload  will be checked only in op_mode supported */
+	if (card->ext_csd.ffu_mode_op) {
+		/* Read the EXT_CSD */
+		err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD,
+					ext_csd, 512);
+		if (err) {
+			pr_err("FFU: %s: error %d sending ext_csd\n",
+				mmc_hostname(card->host), err);
+			goto exit;
+		}
+
+		/* check that the eMMC has received the payload */
+		fw_prog_bytes = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG] |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
+
+		/*
+		 * convert sectors to bytes: multiply by -512B or 4KB as
+		 * required by the card
+		 */
+		fw_prog_bytes *=
+			block_size << (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] * 3);
+		if (fw_prog_bytes != fw->size) {
+			err = -EINVAL;
+			pr_err("FFU: programmed sectors incorrect %d %zd\n",
+				fw_prog_bytes, fw->size);
+			goto exit;
+		}
+	}
+
+	err = mmc_ffu_install(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error firmware install %d\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+exit:
+	if (err != 0) {
+		/* switch back to normal MMC read/write commands */
+		mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
+	}
+	release_firmware(fw);
+	mmc_put_card(card);
+	return err;
+}
+EXPORT_SYMBOL(mmc_ffu_invoke);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151b..5b7e236 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -89,6 +89,7 @@ struct mmc_ext_csd {
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
 	bool			ffu_capable;	/* Firmware upgrade support */
+	bool			ffu_mode_op;	/* FFU mode operation */
 #define MMC_FIRMWARE_LEN 8
 	u8			fwrev[MMC_FIRMWARE_LEN];  /* FW version */
 	u8			raw_exception_status;	/* 54 */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b0e0f15..27cbe75 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -230,4 +230,26 @@ struct device_node;
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
+/*
+ * eMMC5.0 Field Firmware Update (FFU) opcodes
+*/
+#define MMC_FFU_INVOKE_OP 302
+
+#define MMC_FFU_MODE_SET 0x1
+#define MMC_FFU_MODE_NORMAL 0x0
+#define MMC_FFU_INSTALL_SET 0x2
+
+#ifdef CONFIG_MMC_FFU
+#define MMC_FFU_FEATURES 0x1
+#define FFU_FEATURES(ffu_features) (ffu_features & MMC_FFU_FEATURES)
+
+int mmc_ffu_invoke(struct mmc_card *card, const char *name);
+
+#else
+static inline int mmc_ffu_invoke(struct mmc_card *card, const char *name)
+{
+	return -ENOSYS;
+}
+#endif
+
 #endif /* LINUX_MMC_CORE_H */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 15f2c4a..bb40ebd 100644
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
@@ -330,6 +333,9 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_NUM_OF_FW_SEC_PROG	302	/* RO, 4 bytes */
+#define EXT_CSD_FFU_ARG			487	/* RO, 4 bytes */
+#define EXT_CSD_OPERATION_CODE_TIMEOUT	491	/* RO */
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
-- 
2.1.4
