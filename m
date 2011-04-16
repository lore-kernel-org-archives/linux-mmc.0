From: Andrei Warkentin <andreiw@motorola.com>
Subject: [patchv3 1/5] MMC: Add/remove quirks conditional support.
Date: Sat, 16 Apr 2011 05:40:54 -0500
Message-ID: <1302950458-1969-2-git-send-email-andreiw@motorola.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:41661 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1DPKCh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 06:02:37 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GA2xj2006158
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:03:00 -0400 (EDT)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GA2x6X006150
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:02:59 -0400 (EDT)
Received: by yib12 with SMTP id 12so2355953yib.15
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 03:02:35 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arindam.nath@amd.com, Andrei Warkentin <andreiw@motorola.com>, cjb@laptop.org

Conditional add/remove quirks for MMC and SD.

Cc: cjb@laptop.org
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 include/linux/mmc/card.h |   40 ++++++++++++++++++++++++++++++++++++----
 1 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 72a9868..6a4ed2a 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -233,16 +233,14 @@ struct mmc_fixup {
 		    card->cid.month)
 
 /*
- * This hook just adds a quirk unconditionally.
+ * Unconditionally quirk add/remove.
  */
+
 static inline void __maybe_unused add_quirk(struct mmc_card *card, int data)
 {
 	card->quirks |= data;
 }
 
-/*
- * This hook just removes a quirk unconditionally.
- */
 static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 {
 	card->quirks &= ~data;
@@ -264,6 +262,40 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 
+/*
+ * Quirk add/remove for MMC products.
+ */
+
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
+
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
 static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_LENIENT_FN0;
-- 
1.7.0.4

