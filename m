From: Andrei Warkentin <andreiw@motorola.com>
Subject: [[v4] 1/5] MMC: Add/remove quirks conditional support.
Date: Tue, 26 Apr 2011 21:10:31 -0500
Message-ID: <1303870235-29041-2-git-send-email-andreiw@motorola.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:42651 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab1D0CLF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 22:11:05 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R294WS011350
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:09:04 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R288vf011004
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:09:03 -0400 (EDT)
Received: by mail-gw0-f42.google.com with SMTP id 17so637044gwb.15
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 19:11:03 -0700 (PDT)
In-Reply-To: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, cjb@laptop.org

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

