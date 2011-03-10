From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 2/5] MMC: Allow function-specific quirks.
Date: Wed,  9 Mar 2011 18:54:06 -0600
Message-ID: <1299718449-15172-3-git-send-email-andreiw@motorola.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:60732 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1CJAKm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:10:42 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A09Mr1017020
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:22 -0500 (EST)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A08XKc016878
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:22 -0500 (EST)
Received: by mail-gx0-f170.google.com with SMTP id 1so735736gxk.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:10:40 -0800 (PST)
In-Reply-To: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

This allows us to create quirks for block devices, without
creating messy Kconfig dependencies, or polluting core/ with
function-specific code.

Change-Id: I0fd466f115718a23edd0636e1e73d91c77b63887
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/core.h   |    2 -
 drivers/mmc/core/quirks.c |  100 +++-----------------------------------------
 drivers/mmc/core/sdio.c   |    2 +-
 include/linux/mmc/card.h  |   92 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 97 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index a2a956b..406a50f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -59,8 +59,6 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr);
 int mmc_attach_sd(struct mmc_host *host, u32 ocr);
 int mmc_attach_sdio(struct mmc_host *host, u32 ocr);
 
-void mmc_fixup_device(struct mmc_card *card);
-
 /* Module parameters */
 extern int use_spi_crc;
 extern int mmc_assume_removable;
diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index f795b8d..4816c1f 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -11,97 +11,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mmc/card.h>
-#include <linux/mod_devicetable.h>
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
-
-
-/*
- *  The world is not perfect and supplies us with broken mmc/sdio devices.
- *  For at least a part of these bugs we need a work-around
- */
-
-struct mmc_fixup {
-
-	/* CID-specific fields. */
-	const char *name;
-
-	/* Valid revision range */
-	u64 rev_start, rev_end;
-
-	unsigned int manfid;
-	unsigned short oemid;
-
-       /* SDIO-specfic fields. You can use SDIO_ANY_ID here of course */
-	u16 cis_vendor, cis_device;
-
-	void (*vendor_fixup)(struct mmc_card *card, int data);
-	int data;
-};
-
-#define CID_MANFID_ANY (-1ul)
-#define CID_OEMID_ANY ((unsigned short) -1)
-#define CID_NAME_ANY (NULL)
-
-#define END_FIXUP { 0 }
-
-#define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
-		   _cis_vendor, _cis_device,				\
-		   _fixup, _data)					\
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
-	 }
-
-#define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,	\
-		      _fixup, _data)					\
-	_FIXUP_EXT(_name, _manfid,					\
-		   _oemid, _rev_start, _rev_end,			\
-		   SDIO_ANY_ID, SDIO_ANY_ID,				\
-		   _fixup, _data)					\
-
-#define MMC_FIXUP(_name, _manfid, _oemid, _fixup, _data) \
-	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data)
-
-#define SDIO_FIXUP(_vendor, _device, _fixup, _data)			\
-	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,			\
-		    CID_OEMID_ANY, 0, -1ull,				\
-		   _vendor, _device,					\
-		   _fixup, _data)					\
-
- /*
-  * This hook just adds a quirk unconditionnally
-  */
- static void __maybe_unused add_quirk(struct mmc_card *card, int data)
- {
-	 card->quirks |= data;
- }
-
- /*
-  * This hook just removes a quirk unconditionnally
-  */
- static void __maybe_unused remove_quirk(struct mmc_card *card, int data)
- {
-	 card->quirks &= ~data;
- }
 
 #ifndef SDIO_VENDOR_ID_TI
 #define SDIO_VENDOR_ID_TI		0x0097
@@ -124,12 +33,17 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
 	END_FIXUP
 };
 
-void mmc_fixup_device(struct mmc_card *card)
+void mmc_fixup_device(struct mmc_card *card,
+	const struct mmc_fixup *table)
 {
 	const struct mmc_fixup *f;
 	u64 rev = cid_rev_card(card);
 
-	for (f = mmc_fixup_methods; f->vendor_fixup; f++) {
+	/* Non-core specific workarounds. */
+	if (!table)
+		table = mmc_fixup_methods;
+
+	for (f = table; f->vendor_fixup; f++) {
 		if ((f->manfid == CID_MANFID_ANY
 		     || f->manfid == card->cid.manfid) &&
 		    (f->oemid == CID_OEMID_ANY
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 50749f5..d3ec4dc 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -480,7 +480,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		card = oldcard;
 		return 0;
 	}
-	mmc_fixup_device(card);
+	mmc_fixup_device(card, NULL);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
 		err = mmc_sd_setup_card(host, card, oldcard != NULL);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index fe9d7be..00fdeb9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -11,6 +11,7 @@
 #define LINUX_MMC_CARD_H
 
 #include <linux/mmc/core.h>
+#include <linux/mod_devicetable.h>
 
 struct mmc_cid {
 	unsigned int		manfid;
@@ -149,7 +150,93 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 };
 
-void mmc_fixup_device(struct mmc_card *dev);
+/*
+ *  The world is not perfect and supplies us with broken mmc/sdio devices.
+ *  For at least a part of these bugs we need a work-around
+ */
+
+struct mmc_fixup {
+
+	/* CID-specific fields. */
+	const char *name;
+
+	/* Valid revision range */
+	u64 rev_start, rev_end;
+
+	unsigned int manfid;
+	unsigned short oemid;
+
+       /* SDIO-specfic fields. You can use SDIO_ANY_ID here of course */
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
+ * This hook just adds a quirk unconditionnally
+ */
+static inline void __maybe_unused add_quirk(struct mmc_card *card, int data)
+{
+	card->quirks |= data;
+}
+
+/*
+ * This hook just removes a quirk unconditionnally
+ */
+static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
+{
+	card->quirks &= ~data;
+}
 
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
@@ -196,4 +283,7 @@ struct mmc_driver {
 extern int mmc_register_driver(struct mmc_driver *);
 extern void mmc_unregister_driver(struct mmc_driver *);
 
+extern void mmc_fixup_device(struct mmc_card *card,
+			     const struct mmc_fixup *table);
+
 #endif
-- 
1.7.0.4

