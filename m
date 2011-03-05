From: Andrei Warkentin <andreiw@motorola.com>
Subject: [[RFC] 2/5] MMC: Add block quirks support.
Date: Fri,  4 Mar 2011 21:21:11 -0600
Message-ID: <1299295274-32130-3-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-2-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:57182 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1CEChP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 21:37:15 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p252bTLW007107
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:37:29 -0500 (EST)
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com [209.85.213.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p252bSaS007102
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:37:29 -0500 (EST)
Received: by yxi11 with SMTP id 11so1626190yxi.15
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 18:37:12 -0800 (PST)
In-Reply-To: <1299295274-32130-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Quirks are card-specific workarounds. Usually they involve
tuning mmcblk parameters at mmc_blk_probe time.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig        |    7 ++++
 drivers/mmc/card/Makefile       |    1 +
 drivers/mmc/card/blk.h          |   70 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/block-quirks.c |   51 ++++++++++++++++++++++++++++
 drivers/mmc/card/block.c        |   22 ++++--------
 5 files changed, 137 insertions(+), 14 deletions(-)
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
index 0000000..3e7b8e6
--- /dev/null
+++ b/drivers/mmc/card/blk.h
@@ -0,0 +1,70 @@
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
+#define MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, _rev_start, _rev_end, _probe) \
+	{							\
+		.name = (_name),				\
+		.manfid = (_manfid),				\
+		.oemid = (_oemid),				\
+		.rev_start = (_rev_start),			\
+		.rev_end = (_rev_end),				\
+		.probe = (_probe),				\
+	}
+
+#define MMC_BLK_QUIRK(_name, _manfid, _oemid, _probe) \
+	MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, 0, -1ull, _probe)
+
+extern struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card);
+#else
+static inline struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card)
+{
+	return NULL;
+}
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
+
+struct mmc_blk_quirk {
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
+};
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
+	unsigned int	write_align_limit;
+};
+
+#endif
diff --git a/drivers/mmc/card/block-quirks.c b/drivers/mmc/card/block-quirks.c
new file mode 100644
index 0000000..e122a74
--- /dev/null
+++ b/drivers/mmc/card/block-quirks.c
@@ -0,0 +1,51 @@
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
+   Caveat: Because this list is just looked up with a linear
+   search, take care that either overlapping revision ranges
+   don't exist, or that returning the first quirk that matches
+   a given revision has the desired effect.
+*/
+struct mmc_blk_quirk mmc_blk_quirks[] = {
+};
+
+static int mmc_blk_quirk_cmp(const struct mmc_blk_quirk *quirk,
+			      const struct mmc_card *card)
+{
+	u64 rev = mmc_blk_qrev_card(card);
+
+	if (quirk->manfid == card->cid.manfid &&
+	    quirk->oemid == card->cid.oemid &&
+	    !strcmp(quirk->name, card->cid.prod_name) &&
+	    rev >= quirk->rev_start &&
+	    rev <= quirk->rev_end)
+		return 0;
+
+	return -1;
+}
+
+struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card)
+{
+	unsigned index;
+
+	for (index = 0; index < ARRAY_SIZE(mmc_blk_quirks); index++)
+		if (!mmc_blk_quirk_cmp(&mmc_blk_quirks[index], card))
+			return &mmc_blk_quirks[index];
+
+	return NULL;
+}
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9d44480..8640902 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -42,6 +42,7 @@
 #include <asm/uaccess.h>
 
 #include "queue.h"
+#include "blk.h"
 
 MODULE_ALIAS("mmc:block");
 
@@ -53,20 +54,6 @@ MODULE_ALIAS("mmc:block");
 
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
-	unsigned int	write_align_limit;
-};
-
 static DEFINE_MUTEX(open_lock);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
@@ -732,6 +719,7 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md;
+	struct mmc_blk_quirk *quirk;
 	int err;
 
 	char cap_str[10];
@@ -750,6 +738,12 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (err)
 		goto out;
 
+	quirk = mmc_blk_quirk_find(card);
+	if (quirk && quirk->probe)
+		err = quirk->probe(md, card);
+	if (err)
+		goto out;
+
 	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 	printk(KERN_INFO "%s: %s %s %s %s\n",
-- 
1.7.0.4

