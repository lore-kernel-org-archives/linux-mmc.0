From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 2/3] MMC: Add block quirks support.
Date: Tue,  1 Mar 2011 16:09:03 -0600
Message-ID: <1299017344-25361-3-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:52221 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939Ab1CAVsG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 16:48:06 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p21LNOoG012131
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:23:24 -0500 (EST)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p21LNNFh012117
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:23:23 -0500 (EST)
Received: by ywh1 with SMTP id 1so3057180ywh.15
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2011 13:24:35 -0800 (PST)
In-Reply-To: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Quirks are card-specific workarounds. Usually they involve
tuning mmcblk parameters at mmc_blk_probe time, but can
involve affecting the way mmcblk I/O requests are handled.
The later is necessary to handle Sandisk out-of-spec discard support,
and the small-writes reliability workaround for Toshiba.

Change-Id: Ia5e56d7a2803daba4b9085f2ca12afeadc7d9095
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig        |    7 +++
 drivers/mmc/card/Makefile       |    1 +
 drivers/mmc/card/blk.h          |   58 ++++++++++++++++++++
 drivers/mmc/card/block-quirks.c |  111 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/block.c        |   30 ++++++-----
 5 files changed, 194 insertions(+), 13 deletions(-)
 create mode 100644 drivers/mmc/card/blk.h
 create mode 100644 drivers/mmc/card/block-quirks.c

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 86948f9..063fa16 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -14,6 +14,13 @@ config MMC_BLOCK
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.
 
+config MMC_BLOCK_QUIRKS
+       tristate "MMC block device quirks"
+       depends on MMC_BLOCK
+       default y
+       help
+         Say Y here to enable various workarounds for known cards.
+
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
 	depends on MMC_BLOCK
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index 0d40751..fcd3f45 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -7,6 +7,7 @@ ifeq ($(CONFIG_MMC_DEBUG),y)
 endif
 
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
+obj-$(CONFIG_MMC_BLOCK_QUIRKS)  += block-quirks.o
 mmc_block-objs			:= block.o queue.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 
diff --git a/drivers/mmc/card/blk.h b/drivers/mmc/card/blk.h
new file mode 100644
index 0000000..a45a37f
--- /dev/null
+++ b/drivers/mmc/card/blk.h
@@ -0,0 +1,58 @@
+#ifndef MMC_BLK_H
+#define MMC_BLK_H
+
+struct gendisk;
+
+#ifdef CONFIG_MMC_BLOCK_QUIRKS
+struct mmc_blk_data;
+
+#define mmc_blk_qrev(hwrev, fwrev, year, month) \
+	(((u64) hwrev) << 40 |                  \
+	 ((u64) fwrev) << 32 |                  \
+	 ((u64) year) << 16 |                   \
+	 ((u64) month))
+
+#define mmc_blk_qrev_card(card)       \
+	mmc_blk_qrev(card->cid.hwrev, \
+		     card->cid.fwrev, \
+		     card->cid.year,  \
+		     card->cid.month)
+
+struct mmc_blk_quirk {
+	struct rb_node rb_node;
+	const char *name;
+
+	/* First valid revision */
+	u64 rev_start;
+
+	/* Last valid revision */
+	u64 rev_end;
+
+	unsigned int manfid;
+	unsigned short oemid;
+	int (*probe)(struct mmc_blk_data *, struct mmc_card *);
+	int (*adjust)(struct mmc_queue *, struct request *, struct mmc_request *);
+};
+
+
+struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card);
+int mmc_blk_quirk_register(struct mmc_blk_quirk *quirk, bool is_mmc);
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
+
+/*
+ * There is one mmc_blk_data per slot.
+ */
+struct mmc_blk_data {
+	spinlock_t	lock;
+	struct gendisk	*disk;
+	struct mmc_queue queue;
+
+	unsigned int	usage;
+	unsigned int	read_only;
+	unsigned int	write_align_size;
+#ifdef CONFIG_MMC_BLOCK_QUIRKS
+	struct mmc_blk_quirk *quirk;
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
+};
+
+#endif
diff --git a/drivers/mmc/card/block-quirks.c b/drivers/mmc/card/block-quirks.c
new file mode 100644
index 0000000..ceae70c
--- /dev/null
+++ b/drivers/mmc/card/block-quirks.c
@@ -0,0 +1,111 @@
+/*
+ * linux/drivers/mmc/card/block-quirks.c
+ *
+ * Copyright (C) 2010 Andrei Warkentin <andreiw@motorola.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/semaphore.h>
+#include <linux/mmc/card.h>
+
+#include "queue.h"
+#include "blk.h"
+
+/*
+   Since the goal is to support quirks in removable media, ideally
+   such quirks would be always built into a kernel, hence we need
+   a smarter way to search.
+*/
+static struct rb_root quirk_tree[2] = { RB_ROOT, RB_ROOT };
+
+static int mmc_blk_quirk_cmp(const struct mmc_blk_quirk *quirk,
+			     const struct mmc_blk_quirk *cquirk)
+{
+	int ret;
+
+	if (quirk->manfid > cquirk->manfid)
+		return 1;
+	else if (quirk->manfid < cquirk->manfid)
+		return -1;
+
+	if (quirk->oemid > cquirk->oemid)
+		return 1;
+	else if (quirk->oemid < cquirk->oemid)
+		return -1;
+
+	ret = strcmp(quirk->name, cquirk->name);
+	if (!ret)
+		return ret;
+
+	if (quirk->rev_start > cquirk->rev_end)
+		return 1;
+	else if (quirk->rev_end < cquirk->rev_start)
+		return -1;
+
+	/* Overlap in revs or equal. */
+	return 0;
+}
+
+static int mmc_blk_quirk_cmpc(const struct mmc_blk_quirk *quirk,
+			      const struct mmc_card *card)
+{
+	struct mmc_blk_quirk cquirk;
+	cquirk.name = card->cid.prod_name;
+	cquirk.rev_start = mmc_blk_qrev_card(card);
+	cquirk.rev_end = cquirk.rev_start;
+	cquirk.manfid = card->cid.manfid;
+	cquirk.oemid = card->cid.oemid;
+	return mmc_blk_quirk_cmp(quirk, &cquirk);
+}
+
+struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card)
+{
+	int ret;
+	struct mmc_blk_quirk *quirk;
+	struct rb_node *node = quirk_tree[!mmc_card_mmc(card)].rb_node;
+
+	while (node) {
+		quirk = container_of(node, struct mmc_blk_quirk, rb_node);
+		ret = mmc_blk_quirk_cmpc(quirk,	card);
+
+		if (ret < 0)
+			node = node->rb_left;
+		else if (ret > 0)
+			node = node->rb_right;
+		else
+			return quirk;
+	}
+
+	return NULL;
+}
+
+int mmc_blk_quirk_register(struct mmc_blk_quirk *quirk, bool is_mmc)
+{
+	int ret;
+	struct mmc_blk_quirk *cq;
+	struct rb_node **new = &(quirk_tree[!is_mmc].rb_node), *parent = NULL;
+
+	while (*new) {
+		cq = container_of(*new, struct mmc_blk_quirk, rb_node);
+
+		ret = mmc_blk_quirk_cmp(quirk, cq);
+
+		parent = *new;
+		if (ret < 0)
+			new = &(parent->rb_left);
+		else if(ret > 0)
+			new = &(parent->rb_right);
+		else
+			/* Overlap */
+			return -EINVAL;
+
+	}
+
+	rb_link_node(&quirk->rb_node, parent, new);
+	rb_insert_color(&quirk->rb_node, &quirk_tree[!is_mmc]);
+	return 0;
+}
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 498c439..8b72407 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -42,6 +42,7 @@
 #include <asm/uaccess.h>
 
 #include "queue.h"
+#include "blk.h"
 
 MODULE_ALIAS("mmc:block");
 
@@ -53,19 +54,6 @@ MODULE_ALIAS("mmc:block");
 
 static DECLARE_BITMAP(dev_use, MMC_NUM_MINORS);
 
-/*
- * There is one mmc_blk_data per slot.
- */
-struct mmc_blk_data {
-	spinlock_t	lock;
-	struct gendisk	*disk;
-	struct mmc_queue queue;
-
-	unsigned int	usage;
-	unsigned int	read_only;
-	unsigned int	write_align_size;
-};
-
 static DEFINE_MUTEX(open_lock);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
@@ -421,6 +409,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		brq.data.sg = mq->sg;
 		brq.data.sg_len = mmc_queue_map_sg(mq);
 
+#ifdef CONFIG_MMC_BLOCK_QUIRKS
+		if (md->quirk && md->quirk->adjust)
+			md->quirk->adjust(mq, req, &brq.mrq);
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
+
 		/*
 		 * Adjust the sg list so it is the same size as the
 		 * request.
@@ -727,6 +720,9 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md;
+#ifdef CONFIG_MMC_BLOCK_QUIRKS
+	struct mmc_blk_quirk *quirk;
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
 	int err;
 
 	char cap_str[10];
@@ -745,6 +741,14 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (err)
 		goto out;
 
+#ifdef CONFIG_MMC_BLOCK_QUIRKS
+	md->quirk = mmc_blk_quirk_find(card);
+	if (md->quirk && md->quirk->probe)
+		err = quirk->probe(md, card);
+	if (err)
+		goto out;
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
+
 	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 	printk(KERN_INFO "%s: %s %s %s %s\n",
-- 
1.7.0.4

