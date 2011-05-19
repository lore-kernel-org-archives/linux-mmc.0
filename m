From: Andrei Warkentin <andreiw@motorola.com>
Subject: [v5 1/5] MMC: Add/remove quirks conditional support.
Date: Thu, 19 May 2011 16:46:26 -0500
Message-ID: <1305841590-26963-2-git-send-email-andreiw@motorola.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:52688 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab1ESVMo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 17:12:44 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4JLDCGe024964
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:13:12 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4JLDBYB024949
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:13:12 -0400 (EDT)
Received: by gwb17 with SMTP id 17so1482109gwb.15
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 14:12:41 -0700 (PDT)
In-Reply-To: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>, malchev@google.com

Conditional add/remove quirks for MMC and SD.

Cc: cjb@laptop.org
Cc: malchev@google.com
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 include/linux/mmc/card.h |   40 ++++++++++++++++++++++++++++++++++++----
 1 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4910dec..7190aa2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -273,16 +273,14 @@ struct mmc_fixup {
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
@@ -308,6 +306,40 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 
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

