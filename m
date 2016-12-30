From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 19/21] mmc: core: Move public functions from card.h to private headers
Date: Fri, 30 Dec 2016 13:47:32 +0100
Message-ID: <1483102054-1752-20-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36548 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbcL3Mso (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:44 -0500
Received: by mail-lf0-f49.google.com with SMTP id t196so236789474lff.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:43 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

A significant amount of functions and other definitions are available
through the public mmc card.h header file. Let's slim down this public mmc
interface, as to prevent users from abusing it, by moving some of the
functions/definitions to private mmc header files.

This change concentrates on moving the functions into private mmc headers,
following changes may continue with additional clean-ups.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c    |   2 +
 drivers/mmc/core/bus.c      |   1 +
 drivers/mmc/core/bus.h      |  14 ++-
 drivers/mmc/core/card.h     | 223 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.c     |   1 +
 drivers/mmc/core/debugfs.c  |   1 +
 drivers/mmc/core/mmc.c      |  13 +++
 drivers/mmc/core/mmc_test.c |   2 +
 drivers/mmc/core/queue.c    |   1 +
 drivers/mmc/core/quirks.c   |   2 +
 drivers/mmc/core/sd.c       |   1 +
 drivers/mmc/core/sdio.c     |   1 +
 drivers/mmc/core/sdio_bus.c |   1 +
 drivers/mmc/core/sdio_io.c  |   1 +
 drivers/mmc/core/sdio_irq.c |   1 +
 include/linux/mmc/card.h    | 240 --------------------------------------------
 16 files changed, 263 insertions(+), 242 deletions(-)
 create mode 100644 drivers/mmc/core/card.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7246995..095a0f0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -48,6 +48,8 @@
 #include "queue.h"
 #include "block.h"
 #include "core.h"
+#include "card.h"
+#include "bus.h"
 #include "mmc_ops.h"
 #include "sd_ops.h"
 
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c64266f..3be2e6a 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -23,6 +23,7 @@
 #include <linux/mmc/host.h>
 
 #include "core.h"
+#include "card.h"
 #include "sdio_cis.h"
 #include "bus.h"
 
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index 93b516a..72b0ef0 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -11,9 +11,10 @@
 #ifndef _MMC_CORE_BUS_H
 #define _MMC_CORE_BUS_H
 
+#include <linux/device.h>
+
 struct mmc_host;
 struct mmc_card;
-struct device_type;
 
 #define MMC_DEV_ATTR(name, fmt, args...)					\
 static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
@@ -31,5 +32,14 @@ struct mmc_card *mmc_alloc_card(struct mmc_host *host,
 int mmc_register_bus(void);
 void mmc_unregister_bus(void);
 
-#endif
+struct mmc_driver {
+	struct device_driver drv;
+	int (*probe)(struct mmc_card *card);
+	void (*remove)(struct mmc_card *card);
+	void (*shutdown)(struct mmc_card *card);
+};
 
+int mmc_register_driver(struct mmc_driver *drv);
+void mmc_unregister_driver(struct mmc_driver *drv);
+
+#endif
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
new file mode 100644
index 0000000..95e8fc5
--- /dev/null
+++ b/drivers/mmc/core/card.h
@@ -0,0 +1,223 @@
+/*
+ * Private header for the mmc subsystem
+ *
+ * Copyright (C) 2016 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef _MMC_CORE_CARD_H
+#define _MMC_CORE_CARD_H
+
+#include <linux/mmc/card.h>
+
+#define mmc_card_name(c)	((c)->cid.prod_name)
+#define mmc_card_id(c)		(dev_name(&(c)->dev))
+#define mmc_dev_to_card(d)	container_of(d, struct mmc_card, dev)
+
+/* Card states */
+#define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
+#define MMC_STATE_READONLY	(1<<1)		/* card is read-only */
+#define MMC_STATE_BLOCKADDR	(1<<2)		/* card uses block-addressing */
+#define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
+#define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
+#define MMC_STATE_DOING_BKOPS	(1<<5)		/* card is doing BKOPS */
+#define MMC_STATE_SUSPENDED	(1<<6)		/* card is suspended */
+
+#define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
+#define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
+#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
+#define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
+#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
+#define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
+
+#define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
+#define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
+#define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
+#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
+#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
+#define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
+#define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
+#define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
+
+/*
+ * The world is not perfect and supplies us with broken mmc/sdio devices.
+ * For at least some of these bugs we need a work-around.
+ */
+struct mmc_fixup {
+	/* CID-specific fields. */
+	const char *name;
+
+	/* Valid revision range */
+	u64 rev_start, rev_end;
+
+	unsigned int manfid;
+	unsigned short oemid;
+
+	/* SDIO-specific fields. You can use SDIO_ANY_ID here of course */
+	u16 cis_vendor, cis_device;
+
+	/* for MMC cards */
+	unsigned int ext_csd_rev;
+
+	void (*vendor_fixup)(struct mmc_card *card, int data);
+	int data;
+};
+
+#define CID_MANFID_ANY (-1u)
+#define CID_OEMID_ANY ((unsigned short) -1)
+#define CID_NAME_ANY (NULL)
+
+#define EXT_CSD_REV_ANY (-1u)
+
+#define CID_MANFID_SANDISK      0x2
+#define CID_MANFID_TOSHIBA      0x11
+#define CID_MANFID_MICRON       0x13
+#define CID_MANFID_SAMSUNG      0x15
+#define CID_MANFID_KINGSTON     0x70
+#define CID_MANFID_HYNIX	0x90
+
+#define END_FIXUP { NULL }
+
+#define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
+		   _cis_vendor, _cis_device,				\
+		   _fixup, _data, _ext_csd_rev)				\
+	{						\
+		.name = (_name),			\
+		.manfid = (_manfid),			\
+		.oemid = (_oemid),			\
+		.rev_start = (_rev_start),		\
+		.rev_end = (_rev_end),			\
+		.cis_vendor = (_cis_vendor),		\
+		.cis_device = (_cis_device),		\
+		.vendor_fixup = (_fixup),		\
+		.data = (_data),			\
+		.ext_csd_rev = (_ext_csd_rev),		\
+	}
+
+#define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,	\
+		      _fixup, _data, _ext_csd_rev)			\
+	_FIXUP_EXT(_name, _manfid,					\
+		   _oemid, _rev_start, _rev_end,			\
+		   SDIO_ANY_ID, SDIO_ANY_ID,				\
+		   _fixup, _data, _ext_csd_rev)				\
+
+#define MMC_FIXUP(_name, _manfid, _oemid, _fixup, _data) \
+	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data,	\
+		      EXT_CSD_REV_ANY)
+
+#define MMC_FIXUP_EXT_CSD_REV(_name, _manfid, _oemid, _fixup, _data,	\
+			      _ext_csd_rev)				\
+	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data,	\
+		      _ext_csd_rev)
+
+#define SDIO_FIXUP(_vendor, _device, _fixup, _data)			\
+	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,			\
+		    CID_OEMID_ANY, 0, -1ull,				\
+		   _vendor, _device,					\
+		   _fixup, _data, EXT_CSD_REV_ANY)			\
+
+#define cid_rev(hwrev, fwrev, year, month)	\
+	(((u64) hwrev) << 40 |			\
+	 ((u64) fwrev) << 32 |			\
+	 ((u64) year) << 16 |			\
+	 ((u64) month))
+
+#define cid_rev_card(card)			\
+	cid_rev(card->cid.hwrev,		\
+		    card->cid.fwrev,		\
+		    card->cid.year,		\
+		    card->cid.month)
+
+/*
+ * Unconditionally quirk add/remove.
+ */
+static inline void __maybe_unused add_quirk(struct mmc_card *card, int data)
+{
+	card->quirks |= data;
+}
+
+static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
+{
+	card->quirks &= ~data;
+}
+
+/*
+ * Quirk add/remove for MMC products.
+ */
+static inline void __maybe_unused add_quirk_mmc(struct mmc_card *card, int data)
+{
+	if (mmc_card_mmc(card))
+		card->quirks |= data;
+}
+
+static inline void __maybe_unused remove_quirk_mmc(struct mmc_card *card,
+						   int data)
+{
+	if (mmc_card_mmc(card))
+		card->quirks &= ~data;
+}
+
+/*
+ * Quirk add/remove for SD products.
+ */
+static inline void __maybe_unused add_quirk_sd(struct mmc_card *card, int data)
+{
+	if (mmc_card_sd(card))
+		card->quirks |= data;
+}
+
+static inline void __maybe_unused remove_quirk_sd(struct mmc_card *card,
+						   int data)
+{
+	if (mmc_card_sd(card))
+		card->quirks &= ~data;
+}
+
+static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_LENIENT_FN0;
+}
+
+static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
+}
+
+static inline int mmc_card_disable_cd(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_DISABLE_CD;
+}
+
+static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
+}
+
+static inline int mmc_card_broken_byte_mode_512(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_BYTE_MODE_512;
+}
+
+static inline int mmc_card_long_read_time(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_LONG_READ_TIME;
+}
+
+static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_IRQ_POLLING;
+}
+
+static inline int mmc_card_broken_hpi(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_HPI;
+}
+
+void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table);
+
+#endif
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1076b9d..3720d41 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -40,6 +40,7 @@
 #include <trace/events/mmc.h>
 
 #include "core.h"
+#include "card.h"
 #include "bus.h"
 #include "host.h"
 #include "sdio_bus.h"
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 30623b8..2843e6a 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -20,6 +20,7 @@
 #include <linux/mmc/host.h>
 
 #include "core.h"
+#include "card.h"
 #include "mmc_ops.h"
 
 #ifdef CONFIG_FAIL_MMC_REQUEST
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c0e2507..d526625 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/mmc.h>
 
 #include "core.h"
+#include "card.h"
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
@@ -307,6 +308,18 @@ static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_csd)
 	}
 }
 
+static void mmc_part_add(struct mmc_card *card, unsigned int size,
+			 unsigned int part_cfg, char *name, int idx, bool ro,
+			 int area_type)
+{
+	card->part[card->nr_parts].size = size;
+	card->part[card->nr_parts].part_cfg = part_cfg;
+	sprintf(card->part[card->nr_parts].name, name, idx);
+	card->part[card->nr_parts].force_ro = ro;
+	card->part[card->nr_parts].area_type = area_type;
+	card->nr_parts++;
+}
+
 static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 {
 	int idx;
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 9f1c05d4..46adb04 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -23,6 +23,8 @@
 #include <linux/module.h>
 
 #include "core.h"
+#include "card.h"
+#include "bus.h"
 
 #define RESULT_OK		0
 #define RESULT_FAIL		1
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 8be0a63..0538aa5 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -21,6 +21,7 @@
 #include "queue.h"
 #include "block.h"
 #include "core.h"
+#include "card.h"
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index ca9cade..bf25a9c 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -15,6 +15,8 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio_ids.h>
 
+#include "card.h"
+
 #ifndef SDIO_VENDOR_ID_TI
 #define SDIO_VENDOR_ID_TI		0x0097
 #endif
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index a614f37..d66b08d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -22,6 +22,7 @@
 #include <linux/mmc/sd.h>
 
 #include "core.h"
+#include "card.h"
 #include "bus.h"
 #include "mmc_ops.h"
 #include "sd.h"
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ecbc529..558ddfc 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -20,6 +20,7 @@
 #include <linux/mmc/sdio_ids.h>
 
 #include "core.h"
+#include "card.h"
 #include "bus.h"
 #include "sd.h"
 #include "sdio_bus.h"
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 86f5b32..e992a7f 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 
 #include "core.h"
+#include "card.h"
 #include "sdio_cis.h"
 #include "sdio_bus.h"
 
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 76fe6d5..74195d7 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -17,6 +17,7 @@
 
 #include "sdio_ops.h"
 #include "core.h"
+#include "card.h"
 
 /**
  *	sdio_claim_host - exclusively claim a bus for a certain SDIO function
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index d084635..d29faf2 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -28,6 +28,7 @@
 
 #include "sdio_ops.h"
 #include "core.h"
+#include "card.h"
 
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index ca64f5b..29d00c9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -248,13 +248,6 @@ struct mmc_card {
 #define MMC_TYPE_SDIO		2		/* SDIO card */
 #define MMC_TYPE_SD_COMBO	3		/* SD combo (IO+mem) card */
 	unsigned int		state;		/* (our) card state */
-#define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
-#define MMC_STATE_READONLY	(1<<1)		/* card is read-only */
-#define MMC_STATE_BLOCKADDR	(1<<2)		/* card uses block-addressing */
-#define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
-#define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
-#define MMC_STATE_DOING_BKOPS	(1<<5)		/* card is doing BKOPS */
-#define MMC_STATE_SUSPENDED	(1<<6)		/* card is suspended */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -273,7 +266,6 @@ struct mmc_card {
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 
-
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
@@ -309,245 +301,13 @@ struct mmc_card {
 	unsigned int    nr_parts;
 };
 
-/*
- * This function fill contents in mmc_part.
- */
-static inline void mmc_part_add(struct mmc_card *card, unsigned int size,
-			unsigned int part_cfg, char *name, int idx, bool ro,
-			int area_type)
-{
-	card->part[card->nr_parts].size = size;
-	card->part[card->nr_parts].part_cfg = part_cfg;
-	sprintf(card->part[card->nr_parts].name, name, idx);
-	card->part[card->nr_parts].force_ro = ro;
-	card->part[card->nr_parts].area_type = area_type;
-	card->nr_parts++;
-}
-
 static inline bool mmc_large_sector(struct mmc_card *card)
 {
 	return card->ext_csd.data_sector_size == 4096;
 }
 
-/*
- *  The world is not perfect and supplies us with broken mmc/sdio devices.
- *  For at least some of these bugs we need a work-around.
- */
-
-struct mmc_fixup {
-	/* CID-specific fields. */
-	const char *name;
-
-	/* Valid revision range */
-	u64 rev_start, rev_end;
-
-	unsigned int manfid;
-	unsigned short oemid;
-
-	/* SDIO-specfic fields. You can use SDIO_ANY_ID here of course */
-	u16 cis_vendor, cis_device;
-
-	/* for MMC cards */
-	unsigned int ext_csd_rev;
-
-	void (*vendor_fixup)(struct mmc_card *card, int data);
-	int data;
-};
-
-#define CID_MANFID_ANY (-1u)
-#define CID_OEMID_ANY ((unsigned short) -1)
-#define CID_NAME_ANY (NULL)
-
-#define EXT_CSD_REV_ANY (-1u)
-
-#define CID_MANFID_SANDISK      0x2
-#define CID_MANFID_TOSHIBA      0x11
-#define CID_MANFID_MICRON       0x13
-#define CID_MANFID_SAMSUNG      0x15
-#define CID_MANFID_KINGSTON     0x70
-#define CID_MANFID_HYNIX	0x90
-
-#define END_FIXUP { NULL }
-
-#define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
-		   _cis_vendor, _cis_device,				\
-		   _fixup, _data, _ext_csd_rev)				\
-	{						   \
-		.name = (_name),			   \
-		.manfid = (_manfid),			   \
-		.oemid = (_oemid),			   \
-		.rev_start = (_rev_start),		   \
-		.rev_end = (_rev_end),			   \
-		.cis_vendor = (_cis_vendor),		   \
-		.cis_device = (_cis_device),		   \
-		.vendor_fixup = (_fixup),		   \
-		.data = (_data),			   \
-		.ext_csd_rev = (_ext_csd_rev),		   \
-	 }
-
-#define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,	\
-		      _fixup, _data, _ext_csd_rev)			\
-	_FIXUP_EXT(_name, _manfid,					\
-		   _oemid, _rev_start, _rev_end,			\
-		   SDIO_ANY_ID, SDIO_ANY_ID,				\
-		   _fixup, _data, _ext_csd_rev)				\
-
-#define MMC_FIXUP(_name, _manfid, _oemid, _fixup, _data) \
-	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data,	\
-		      EXT_CSD_REV_ANY)
-
-#define MMC_FIXUP_EXT_CSD_REV(_name, _manfid, _oemid, _fixup, _data,	\
-			      _ext_csd_rev)				\
-	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data,	\
-		      _ext_csd_rev)
-
-#define SDIO_FIXUP(_vendor, _device, _fixup, _data)			\
-	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,			\
-		    CID_OEMID_ANY, 0, -1ull,				\
-		   _vendor, _device,					\
-		   _fixup, _data, EXT_CSD_REV_ANY)			\
-
-#define cid_rev(hwrev, fwrev, year, month)	\
-	(((u64) hwrev) << 40 |                  \
-	 ((u64) fwrev) << 32 |                  \
-	 ((u64) year) << 16 |                   \
-	 ((u64) month))
-
-#define cid_rev_card(card)		  \
-	cid_rev(card->cid.hwrev,	  \
-		    card->cid.fwrev,      \
-		    card->cid.year,	  \
-		    card->cid.month)
-
-/*
- * Unconditionally quirk add/remove.
- */
-
-static inline void __maybe_unused add_quirk(struct mmc_card *card, int data)
-{
-	card->quirks |= data;
-}
-
-static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
-{
-	card->quirks &= ~data;
-}
-
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
 
-#define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
-#define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
-#define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
-#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
-#define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
-#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
-#define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
-
-#define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
-#define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
-#define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
-#define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
-#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
-#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
-#define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
-#define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
-#define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
-
-/*
- * Quirk add/remove for MMC products.
- */
-
-static inline void __maybe_unused add_quirk_mmc(struct mmc_card *card, int data)
-{
-	if (mmc_card_mmc(card))
-		card->quirks |= data;
-}
-
-static inline void __maybe_unused remove_quirk_mmc(struct mmc_card *card,
-						   int data)
-{
-	if (mmc_card_mmc(card))
-		card->quirks &= ~data;
-}
-
-/*
- * Quirk add/remove for SD products.
- */
-
-static inline void __maybe_unused add_quirk_sd(struct mmc_card *card, int data)
-{
-	if (mmc_card_sd(card))
-		card->quirks |= data;
-}
-
-static inline void __maybe_unused remove_quirk_sd(struct mmc_card *card,
-						   int data)
-{
-	if (mmc_card_sd(card))
-		card->quirks &= ~data;
-}
-
-static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_LENIENT_FN0;
-}
-
-static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
-}
-
-static inline int mmc_card_disable_cd(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_DISABLE_CD;
-}
-
-static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
-}
-
-static inline int mmc_card_broken_byte_mode_512(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_BROKEN_BYTE_MODE_512;
-}
-
-static inline int mmc_card_long_read_time(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_LONG_READ_TIME;
-}
-
-static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_BROKEN_IRQ_POLLING;
-}
-
-static inline int mmc_card_broken_hpi(const struct mmc_card *c)
-{
-	return c->quirks & MMC_QUIRK_BROKEN_HPI;
-}
-
-#define mmc_card_name(c)	((c)->cid.prod_name)
-#define mmc_card_id(c)		(dev_name(&(c)->dev))
-
-#define mmc_dev_to_card(d)	container_of(d, struct mmc_card, dev)
-
-/*
- * MMC device driver (e.g., Flash card, I/O card...)
- */
-struct mmc_driver {
-	struct device_driver drv;
-	int (*probe)(struct mmc_card *);
-	void (*remove)(struct mmc_card *);
-	void (*shutdown)(struct mmc_card *);
-};
-
-extern int mmc_register_driver(struct mmc_driver *);
-extern void mmc_unregister_driver(struct mmc_driver *);
-
-extern void mmc_fixup_device(struct mmc_card *card,
-			     const struct mmc_fixup *table);
-
 #endif /* LINUX_MMC_CARD_H */
-- 
1.9.1

