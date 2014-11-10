From: Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: =?UTF-8?q??=
Date: Mon, 10 Nov 2014 19:32:41 +0200
Message-ID: <1415640775-9952-1-git-send-email-avi.shchislowski@sandisk.com>
References: <n>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <n>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: avi.shchislowski@sandisk.com, cjb@laptop.org, linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, gwendal@google.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Subject: [PATCH 3/3] v1] mmc: Support FFU for eMMC v5.0

Add support of FFU for eMMC v5.0

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>

---

v1:
remove unnecesary slash's

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 5562308..19ba729 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -68,3 +68,11 @@ config MMC_TEST
=20
 	  This driver is only of interest to those developing or
 	  testing a host driver. Most people should say N here.
+
+config MMC_FFU
+	bool "FFU SUPPORT"
+	depends on MMC !=3D n
+	help
+	  This is an option to run firmware update on eMMC 5.0.
+	  Field firmware updates (FFU) enables features enhancment
+	  in the field.
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ede41f0..68997f2 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -480,6 +480,11 @@ static int mmc_blk_ioctl_cmd(struct block_device *=
bdev,
 		goto cmd_done;
 	}
=20
+	if (idata->ic.opcode =3D=3D MMC_FFU_INVOKE_OP) {
+		err =3D mmc_ffu_invoke(card, idata->buf);
+		goto cmd_done;
+	}
+
 	cmd.opcode =3D idata->ic.opcode;
 	cmd.arg =3D idata->ic.arg;
 	cmd.flags =3D idata->ic.flags;
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 38ed210..f2fdfd4 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -10,3 +10,4 @@ mmc_core-y			:=3D core.o bus.o host.o \
 				   quirks.o slot-gpio.o
=20
 mmc_core-$(CONFIG_DEBUG_FS)	+=3D debugfs.o
+obj-$(CONFIG_MMC_FFU)		+=3D mmc_ffu.o
diff --git a/drivers/mmc/core/mmc_ffu.c b/drivers/mmc/core/mmc_ffu.c
new file mode 100644
index 0000000..a7cf98b
--- /dev/null
+++ b/drivers/mmc/core/mmc_ffu.c
@@ -0,0 +1,487 @@
+/*
+ * *  ffu.c
+ *
+ *  Copyright 2007-2008 Pierre Ossman
+ *
+ *  Modified by SanDisk Corp., Copyright =C2=A9 2013 SanDisk Corp.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or (=
at
+ * your option) any later version.
+ *
+ * This program includes bug.h, card.h, host.h, mmc.h, scatterlist.h,
+ * slab.h, ffu.h & swap.h header files
+ * The original, unmodified version of this program =E2=80=93 the mmc_=
test.c
+ * file =E2=80=93 is obtained under the GPL v2.0 license that is avail=
able via
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
+	struct scatterlist *sglist)
+{
+	struct scatterlist *sg =3D sglist;
+	unsigned int i;
+	unsigned long sz =3D size;
+	unsigned int sctr_len =3D 0;
+	unsigned long len;
+
+	for (i =3D 0; i < mem->cnt && sz; i++, sz -=3D len) {
+		len =3D PAGE_SIZE << mem->arr[i].order;
+
+		if (len > sz) {
+			len =3D sz;
+			sz =3D 0;
+		}
+
+		sg_set_page(sg, mem->arr[i].page, len, 0);
+		sg =3D sg_next(sg);
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
+ * Allocate a lot of memory, preferably max_sz but at least min_sz. In=
 case
+ * there isn't much memory do not exceed 1/16th total low mem pages. A=
lso do
+ * not exceed a maximum number of segments and try not to make segment=
s much
+ * bigger than maximum segment size.
+ */
+static int mmc_ffu_alloc_mem(struct mmc_ffu_area *area, unsigned long =
min_sz)
+{
+	unsigned long max_page_cnt =3D DIV_ROUND_UP(area->max_tfr, PAGE_SIZE)=
;
+	unsigned long min_page_cnt =3D DIV_ROUND_UP(min_sz, PAGE_SIZE);
+	unsigned long max_seg_page_cnt =3D
+		DIV_ROUND_UP(area->max_seg_sz, PAGE_SIZE);
+	unsigned long page_cnt =3D 0;
+	/* we divide by 16 to ensure we will not allocate a big amount
+	 * of unnecessary pages */
+	unsigned long limit =3D nr_free_buffer_pages() >> 4;
+
+	gfp_t flags =3D GFP_KERNEL | GFP_DMA | __GFP_NOWARN | __GFP_NORETRY;
+
+	if (max_page_cnt > limit) {
+		max_page_cnt =3D limit;
+		area->max_tfr =3D max_page_cnt * PAGE_SIZE;
+	}
+
+	if (min_page_cnt > max_page_cnt)
+		min_page_cnt =3D max_page_cnt;
+
+	if (area->max_segs * max_seg_page_cnt > max_page_cnt)
+		area->max_segs =3D DIV_ROUND_UP(max_page_cnt, max_seg_page_cnt);
+
+	area->mem.arr =3D kzalloc(sizeof(struct mmc_ffu_pages) * area->max_se=
gs,
+		GFP_KERNEL);
+	area->mem.cnt =3D 0;
+	if (!area->mem.arr)
+		goto out_free;
+
+	while (max_page_cnt) {
+		struct page *page;
+		unsigned int order;
+
+		order =3D get_order(max_seg_page_cnt << PAGE_SHIFT);
+
+		do {
+			page =3D alloc_pages(flags, order);
+		} while (!page && order--);
+
+		if (!page)
+			goto out_free;
+
+		area->mem.arr[area->mem.cnt].page =3D page;
+		area->mem.arr[area->mem.cnt].order =3D order;
+		area->mem.cnt++;
+		page_cnt +=3D 1UL << order;
+		if (max_page_cnt <=3D (1UL << order))
+			break;
+		max_page_cnt -=3D 1UL << order;
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
+static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_car=
d *card,
+	const u8 *data)
+{
+	int ret;
+	int i;
+	unsigned int length =3D 0, page_length;
+
+	ret =3D mmc_ffu_alloc_mem(area, 1);
+	for (i =3D 0; i < area->mem.cnt; i++) {
+		if (length > area->max_tfr) {
+			ret =3D -EINVAL;
+			goto out_free;
+		}
+		page_length =3D PAGE_SIZE << area->mem.arr[i].order;
+		memcpy(page_address(area->mem.arr[i].page), data + length,
+			min(area->max_tfr - length, page_length));
+		length +=3D page_length;
+	}
+
+	ret =3D sg_alloc_table(&area->sgtable, area->mem.cnt, GFP_KERNEL);
+	if (ret)
+		goto out_free;
+
+	area->sg_len =3D mmc_ffu_map_sg(&area->mem, area->max_tfr,
+		area->sgtable.sgl);
+
+
+	return 0;
+
+out_free:
+	mmc_ffu_free_mem(&area->mem);
+	return ret;
+}
+
+static int mmc_ffu_write(struct mmc_card *card, const u8 *src, u32 arg=
,
+	int size)
+{
+	int rc;
+	struct mmc_ffu_area area =3D {0};
+	int block_size =3D card->ext_csd.data_sector_size;
+
+	area.max_segs =3D card->host->max_segs;
+	area.max_seg_sz =3D card->host->max_seg_size & ~(block_size - 1);
+
+	do {
+		area.max_tfr =3D size;
+		if (area.max_tfr >> 9 > card->host->max_blk_count)
+			area.max_tfr =3D card->host->max_blk_count << 9;
+		if (area.max_tfr > card->host->max_req_size)
+			area.max_tfr =3D card->host->max_req_size;
+		if (DIV_ROUND_UP(area.max_tfr, area.max_seg_sz) > area.max_segs)
+			area.max_tfr =3D area.max_segs * area.max_seg_sz;
+
+		rc =3D mmc_ffu_area_init(&area, card, src);
+		if (rc !=3D 0)
+			goto exit;
+
+		rc =3D mmc_simple_transfer(card, area.sgtable.sgl, area.sg_len,
+			arg, area.max_tfr / block_size, block_size, 1);
+		mmc_ffu_area_cleanup(&area);
+		if (rc !=3D 0) {
+			pr_err("%s mmc_ffu_simple_transfer %d\n", __func__, rc);
+			goto exit;
+		}
+		src +=3D area.max_tfr;
+		size -=3D area.max_tfr;
+
+	} while (size > 0);
+
+exit:
+	return rc;
+}
+
+/* Flush all scheduled work from the MMC work queue.
+ * and initialize the MMC device */
+static int mmc_ffu_restart(struct mmc_card *card)
+{
+	struct mmc_host *host =3D card->host;
+	int err =3D 0;
+
+	err =3D mmc_power_save_host(host);
+	if (err) {
+		pr_warn("%s: going to sleep failed (%d)!!!\n",
+			__func__ , err);
+		goto exit;
+	}
+
+	err =3D mmc_power_restore_host(host);
+
+exit:
+
+	return err;
+}
+
+static int mmc_ffu_switch_mode(struct mmc_card *card , int mode)
+{
+	int err =3D 0;
+	int offset;
+
+	switch (mode) {
+	case MMC_FFU_MODE_SET:
+	case MMC_FFU_MODE_NORMAL:
+		offset =3D EXT_CSD_MODE_CONFIG;
+		break;
+	case MMC_FFU_INSTALL_SET:
+			offset =3D EXT_CSD_MODE_OPERATION_CODES;
+			mode =3D 0x1;
+			break;
+	default:
+		err =3D -EINVAL;
+		break;
+	}
+
+	if (err =3D=3D 0) {
+		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			offset, mode,
+			card->ext_csd.generic_cmd6_time);
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
+		err =3D mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
+		if (err) {
+			pr_err("FFU: %s: switch to normal mode error %d:\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+
+		/* restart the eMMC */
+		err =3D mmc_ffu_restart(card);
+		if (err) {
+			pr_err("FFU: %s: install error %d:\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+	} else {
+		timeout =3D ext_csd[EXT_CSD_OPERATION_CODE_TIMEOUT];
+		if (timeout =3D=3D 0 || timeout > 0x17) {
+			timeout =3D 0x17;
+			pr_warn("FFU: %s: operation code timeout is out "
+				"of range. Using maximum timeout.\n",
+				mmc_hostname(card->host));
+		}
+
+		/* timeout is at millisecond resolution */
+		timeout =3D DIV_ROUND_UP((100 * (1 << timeout)), 1000);
+
+		/* set ext_csd to install mode */
+		err =3D mmc_ffu_switch_mode(card, MMC_FFU_INSTALL_SET);
+		if (err) {
+			pr_err("FFU: %s: error %d setting install mode\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+	}
+
+	/* read ext_csd */
+	err =3D mmc_send_ext_csd(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+			mmc_hostname(card->host), err);
+		return err;
+	}
+
+	/* return status */
+	err =3D ext_csd[EXT_CSD_FFU_STATUS];
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
+	int block_size =3D card->ext_csd.data_sector_size;
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
+	err =3D request_firmware(&fw, name, &card->dev);
+	if (err) {
+		pr_err("FFU: %s: Firmware request failed %d\n",
+			mmc_hostname(card->host), err);
+		return err;
+	}
+	if ((fw->size % block_size)) {
+		pr_warn("FFU: %s: Warning %zd firmware data size "\
+			"is not aligned!!!\n", mmc_hostname(card->host),
+			fw->size);
+	}
+
+	mmc_get_card(card);
+
+	/* trigger flushing*/
+	err =3D mmc_flush_cache(card);
+	if (err) {
+		pr_err("FFU: %s: error %d flushing data\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* Read the EXT_CSD */
+	err =3D mmc_send_ext_csd(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+				mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* set CMD ARG */
+	arg =3D ext_csd[EXT_CSD_FFU_ARG] |
+		ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
+		ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
+		ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
+
+	/* set device to FFU mode */
+	err =3D mmc_ffu_switch_mode(card, MMC_FFU_MODE_SET);
+	if (err) {
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	err =3D mmc_ffu_write(card, fw->data, arg, fw->size);
+	if (err) {
+		pr_err("FFU: %s: write error %d\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+	/* payload  will be checked only in op_mode supported */
+	if (card->ext_csd.ffu_mode_op) {
+		/* Read the EXT_CSD */
+		err =3D mmc_send_ext_csd(card, ext_csd);
+		if (err) {
+			pr_err("FFU: %s: error %d sending ext_csd\n",
+				mmc_hostname(card->host), err);
+			goto exit;
+		}
+
+		/* check that the eMMC has received the payload */
+		fw_prog_bytes =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG] |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
+
+		/* convert sectors to bytes: multiply by -512B or 4KB as
+		   required by the card */
+		 fw_prog_bytes *=3D
+			block_size << (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] * 3);
+		if (fw_prog_bytes !=3D fw->size) {
+			err =3D -EINVAL;
+			pr_err("FFU: %s: error %d number of programmed fw sector "\
+				"incorrect %d %zd\n", __func__, err,
+				fw_prog_bytes, fw->size);
+			goto exit;
+		}
+	}
+
+	err =3D mmc_ffu_install(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error firmware install %d\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+exit:
+	if (err !=3D 0) {
+	   /* host switch back to work in normal MMC
+	    * Read/Write commands */
+		mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
+	}
+	release_firmware(fw);
+	mmc_put_card(card);
+	return err;
+}
+EXPORT_SYMBOL(mmc_ffu_invoke);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 92540d0..44fea6d 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -220,4 +220,26 @@ struct device_node;
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
=20
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
+static inline int mmc_ffu_invoke(struct mmc_card *card, const char *na=
me)
+{
+	return -ENOSYS;
+}
+#endif
+
 #endif /* LINUX_MMC_CORE_H */
--=20
1.7.9.5
