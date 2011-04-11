From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH] MMC: Extends card quicks with MMC/SD quirks matching the CID.
Date: Mon, 11 Apr 2011 17:02:15 -0500
Message-ID: <1302559335-9998-1-git-send-email-andreiw@motorola.com>
References: <m339lobj8j.fsf@pullcord.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:33257 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1DKVXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:23:18 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BLLTLb014022
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:21:30 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BLLFD7013922
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:21:29 -0400 (EDT)
Received: by mail-gy0-f170.google.com with SMTP id 11so4166187gyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 14:23:16 -0700 (PDT)
In-Reply-To: <m339lobj8j.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

From: Chris Ball <cjb@laptop.org>

The current mechanism is SDIO-only. This allows us to create
function-specific quirks, without creating messy Kconfig dependencies,
or polluting core/ with function-specific code.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/core.h   |    2 -
 drivers/mmc/core/quirks.c |   93 ++++++++++++++++++++------------------------
 drivers/mmc/core/sdio.c   |    2 +-
 include/linux/mmc/card.h  |   91 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 133 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 20b1c08..ca1fdde 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -61,8 +61,6 @@ int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
 
-void mmc_fixup_device(struct mmc_card *card);
-
 /* Module parameters */
 extern int use_spi_crc;
 
diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index a4c42ed..3a59621 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -1,7 +1,8 @@
 /*
- *  This file contains work-arounds for many known sdio hardware
- *  bugs.
+ *  This file contains work-arounds for many known SD/MMC
+ *  and SDIO hardware bugs.
  *
+ *  Copyright (c) 2011 Andrei Warkentin <andreiw@motorola.com>
  *  Copyright (c) 2011 Pierre Tardy <tardyp@gmail.com>
  *  Inspired from pci fixup code:
  *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
@@ -11,34 +12,14 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mmc/card.h>
-#include <linux/mod_devicetable.h>
 
-/*
- *  The world is not perfect and supplies us with broken mmc/sdio devices.
- *  For at least a part of these bugs we need a work-around
- */
-
-struct mmc_fixup {
-	u16 vendor, device;	/* You can use SDIO_ANY_ID here of course */
-	void (*vendor_fixup)(struct mmc_card *card, int data);
-	int data;
-};
-
-/*
- * This hook just adds a quirk unconditionnally
- */
-static void __maybe_unused add_quirk(struct mmc_card *card, int data)
-{
-	card->quirks |= data;
-}
+#ifndef SDIO_VENDOR_ID_TI
+#define SDIO_VENDOR_ID_TI		0x0097
+#endif
 
-/*
- * This hook just removes a quirk unconditionnally
- */
-static void __maybe_unused remove_quirk(struct mmc_card *card, int data)
-{
-	card->quirks &= ~data;
-}
+#ifndef SDIO_DEVICE_ID_TI_WL1271
+#define SDIO_DEVICE_ID_TI_WL1271	0x4076
+#endif
 
 /*
  * This hook just adds a quirk for all sdio devices
@@ -49,37 +30,47 @@ static void add_quirk_for_sdio_devices(struct mmc_card *card, int data)
 		card->quirks |= data;
 }
 
-#ifndef SDIO_VENDOR_ID_TI
-#define SDIO_VENDOR_ID_TI		0x0097
-#endif
-
-#ifndef SDIO_DEVICE_ID_TI_WL1271
-#define SDIO_DEVICE_ID_TI_WL1271	0x4076
-#endif
-
 static const struct mmc_fixup mmc_fixup_methods[] = {
 	/* by default sdio devices are considered CLK_GATING broken */
 	/* good cards will be whitelisted as they are tested */
-	{ SDIO_ANY_ID, SDIO_ANY_ID,
-		add_quirk_for_sdio_devices, MMC_QUIRK_BROKEN_CLK_GATING },
-	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
-		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
-	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
-		add_quirk, MMC_QUIRK_NONSTD_FUNC_IF },
-	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
-		add_quirk, MMC_QUIRK_DISABLE_CD },
-	{ 0 }
+	SDIO_FIXUP(SDIO_ANY_ID, SDIO_ANY_ID,
+		   add_quirk_for_sdio_devices,
+		   MMC_QUIRK_BROKEN_CLK_GATING),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		   remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		   add_quirk, MMC_QUIRK_DISABLE_CD),
+
+	END_FIXUP
 };
 
-void mmc_fixup_device(struct mmc_card *card)
+void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
 {
 	const struct mmc_fixup *f;
+	u64 rev = cid_rev_card(card);
+
+	/* Non-core specific workarounds. */
+	if (!table)
+		table = mmc_fixup_methods;
 
-	for (f = mmc_fixup_methods; f->vendor_fixup; f++) {
-		if ((f->vendor == card->cis.vendor
-		     || f->vendor == (u16) SDIO_ANY_ID) &&
-		    (f->device == card->cis.device
-		     || f->device == (u16) SDIO_ANY_ID)) {
+	for (f = table; f->vendor_fixup; f++) {
+		if ((f->manfid == CID_MANFID_ANY ||
+		     f->manfid == card->cid.manfid) &&
+		    (f->oemid == CID_OEMID_ANY ||
+		     f->oemid == card->cid.oemid) &&
+		    (f->name == CID_NAME_ANY ||
+		     !strncmp(f->name, card->cid.prod_name,
+			      sizeof(card->cid.prod_name))) &&
+		    (f->cis_vendor == card->cis.vendor ||
+		     f->cis_vendor == (u16) SDIO_ANY_ID) &&
+		    (f->cis_device == card->cis.device ||
+		     f->cis_device == (u16) SDIO_ANY_ID) &&
+		    rev >= f->rev_start && rev <= f->rev_end) {
 			dev_dbg(&card->dev, "calling %pF\n", f->vendor_fixup);
 			f->vendor_fixup(card, f->data);
 		}
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index a5840c0..1e60959 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -472,7 +472,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 
 		card = oldcard;
 	}
-	mmc_fixup_device(card);
+	mmc_fixup_device(card, NULL);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
 		err = mmc_sd_setup_card(host, card, oldcard != NULL);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2a7e549..c651317 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -11,6 +11,7 @@
 #define LINUX_MMC_CARD_H
 
 #include <linux/mmc/core.h>
+#include <linux/mod_devicetable.h>
 
 struct mmc_cid {
 	unsigned int		manfid;
@@ -157,7 +158,92 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 };
 
-void mmc_fixup_device(struct mmc_card *dev);
+/*
+ *  The world is not perfect and supplies us with broken mmc/sdio devices.
+ *  For at least some of these bugs we need a work-around.
+ */
+
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
+	/* SDIO-specfic fields. You can use SDIO_ANY_ID here of course */
+	u16 cis_vendor, cis_device;
+
+	void (*vendor_fixup)(struct mmc_card *card, int data);
+	int data;
+};
+
+#define CID_MANFID_ANY (-1ul)
+#define CID_OEMID_ANY ((unsigned short) -1)
+#define CID_NAME_ANY (NULL)
+
+#define END_FIXUP { 0 }
+
+#define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
+		   _cis_vendor, _cis_device,				\
+		   _fixup, _data)					\
+	{						   \
+		.name = (_name),			   \
+		.manfid = (_manfid),			   \
+		.oemid = (_oemid),			   \
+		.rev_start = (_rev_start),		   \
+		.rev_end = (_rev_end),			   \
+		.cis_vendor = (_cis_vendor),		   \
+		.cis_device = (_cis_device),		   \
+		.vendor_fixup = (_fixup),		   \
+		.data = (_data),			   \
+	 }
+
+#define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,	\
+		      _fixup, _data)					\
+	_FIXUP_EXT(_name, _manfid,					\
+		   _oemid, _rev_start, _rev_end,			\
+		   SDIO_ANY_ID, SDIO_ANY_ID,				\
+		   _fixup, _data)					\
+
+#define MMC_FIXUP(_name, _manfid, _oemid, _fixup, _data) \
+	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data)
+
+#define SDIO_FIXUP(_vendor, _device, _fixup, _data)			\
+	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,			\
+		    CID_OEMID_ANY, 0, -1ull,				\
+		   _vendor, _device,					\
+		   _fixup, _data)					\
+
+#define cid_rev(hwrev, fwrev, year, month)	\
+	(((u64) hwrev) << 40 |                  \
+	 ((u64) fwrev) << 32 |                  \
+	 ((u64) year) << 16 |                   \
+	 ((u64) month))
+
+#define cid_rev_card(card)		  \
+	cid_rev(card->cid.hwrev,	  \
+		    card->cid.fwrev,      \
+		    card->cid.year,	  \
+		    card->cid.month)
+
+/*
+ * This hook just adds a quirk unconditionally.
+ */
+static inline void __maybe_unused add_quirk(struct mmc_card *card, int data)
+{
+	card->quirks |= data;
+}
+
+/*
+ * This hook just removes a quirk unconditionally.
+ */
+static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
+{
+	card->quirks &= ~data;
+}
 
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
@@ -218,4 +304,7 @@ struct mmc_driver {
 extern int mmc_register_driver(struct mmc_driver *);
 extern void mmc_unregister_driver(struct mmc_driver *);
 
+extern void mmc_fixup_device(struct mmc_card *card,
+			     const struct mmc_fixup *table);
+
 #endif
-- 
1.7.0.4

