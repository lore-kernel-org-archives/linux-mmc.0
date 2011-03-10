From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 1/5] MMC: Extends card quicks with MMC/SD quirks matching the CID.
Date: Wed,  9 Mar 2011 18:54:05 -0600
Message-ID: <1299718449-15172-2-git-send-email-andreiw@motorola.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:37578 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1CJAKl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:10:41 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A09LdK017006
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:21 -0500 (EST)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A08SW6016828
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:20 -0500 (EST)
Received: by mail-gw0-f42.google.com with SMTP id 17so348331gwb.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:10:39 -0800 (PST)
In-Reply-To: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

The current mechanism is SDIO-only.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/quirks.c |  130 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 98 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 4fb16ac..f795b8d 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -13,41 +13,95 @@
 #include <linux/mmc/card.h>
 #include <linux/mod_devicetable.h>
 
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
+
+
 /*
  *  The world is not perfect and supplies us with broken mmc/sdio devices.
  *  For at least a part of these bugs we need a work-around
  */
 
 struct mmc_fixup {
-	u16 vendor, device;	/* You can use SDIO_ANY_ID here of course */
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
 	void (*vendor_fixup)(struct mmc_card *card, int data);
 	int data;
 };
 
-/*
- * This hook just adds a quirk unconditionnally
- */
-static void __maybe_unused add_quirk(struct mmc_card *card, int data)
-{
-	card->quirks |= data;
-}
+#define CID_MANFID_ANY (-1ul)
+#define CID_OEMID_ANY ((unsigned short) -1)
+#define CID_NAME_ANY (NULL)
 
-/*
- * This hook just removes a quirk unconditionnally
- */
-static void __maybe_unused remove_quirk(struct mmc_card *card, int data)
-{
-	card->quirks &= ~data;
-}
+#define END_FIXUP { 0 }
 
-/*
- * This hook just adds a quirk for all sdio devices
- */
-static void add_quirk_for_sdio_devices(struct mmc_card *card, int data)
-{
-	if (mmc_card_sdio(card))
-		card->quirks |= data;
-}
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
+ /*
+  * This hook just adds a quirk unconditionnally
+  */
+ static void __maybe_unused add_quirk(struct mmc_card *card, int data)
+ {
+	 card->quirks |= data;
+ }
+
+ /*
+  * This hook just removes a quirk unconditionnally
+  */
+ static void __maybe_unused remove_quirk(struct mmc_card *card, int data)
+ {
+	 card->quirks &= ~data;
+ }
 
 #ifndef SDIO_VENDOR_ID_TI
 #define SDIO_VENDOR_ID_TI		0x0097
@@ -58,24 +112,36 @@ static void add_quirk_for_sdio_devices(struct mmc_card *card, int data)
 #endif
 
 static const struct mmc_fixup mmc_fixup_methods[] = {
+
 	/* by default sdio devices are considered CLK_GATING broken */
 	/* good cards will be whitelisted as they are tested */
-	{ SDIO_ANY_ID, SDIO_ANY_ID,
-		add_quirk_for_sdio_devices, MMC_QUIRK_BROKEN_CLK_GATING },
-	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
-		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
-	{ 0 }
+	SDIO_FIXUP(SDIO_ANY_ID, SDIO_ANY_ID,
+		   add_quirk, MMC_QUIRK_BROKEN_CLK_GATING),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		   remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING),
+
+	END_FIXUP
 };
 
 void mmc_fixup_device(struct mmc_card *card)
 {
 	const struct mmc_fixup *f;
+	u64 rev = cid_rev_card(card);
 
 	for (f = mmc_fixup_methods; f->vendor_fixup; f++) {
-		if ((f->vendor == card->cis.vendor
-		     || f->vendor == (u16) SDIO_ANY_ID) &&
-		    (f->device == card->cis.device
-		     || f->device == (u16) SDIO_ANY_ID)) {
+		if ((f->manfid == CID_MANFID_ANY
+		     || f->manfid == card->cid.manfid) &&
+		    (f->oemid == CID_OEMID_ANY
+		     || f->oemid == card->cid.oemid) &&
+		    (f->name == CID_NAME_ANY
+		     || !strcmp(f->name, card->cid.prod_name)) &&
+		    (f->cis_vendor == card->cis.vendor
+		     || f->cis_vendor == (u16) SDIO_ANY_ID) &&
+		    (f->cis_device == card->cis.device
+		    || f->cis_device == (u16) SDIO_ANY_ID) &&
+		    rev >= f->rev_start &&
+		    rev <= f->rev_end)	{
 			dev_dbg(&card->dev, "calling %pF\n", f->vendor_fixup);
 			f->vendor_fixup(card, f->data);
 		}
-- 
1.7.0.4

