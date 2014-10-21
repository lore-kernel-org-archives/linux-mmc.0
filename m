From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/15] mmc: core: Export mmc_get_ext_csd()
Date: Tue, 21 Oct 2014 19:19:08 +0200
Message-ID: <1413911953-19012-11-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45762 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbaJURTi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:38 -0400
Received: by mail-lb0-f172.google.com with SMTP id b6so1433629lbj.31
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:37 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Callers of mmc_send_ext_csd() will be able to decrease code duplication
by using mmc_get_ext_csd() instead. Let's make it available.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     | 31 -------------------------------
 drivers/mmc/core/mmc_ops.c | 29 +++++++++++++++++++++++++++++
 include/linux/mmc/core.h   |  1 +
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 55757fe..1e022fa 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -177,37 +177,6 @@ static int mmc_decode_csd(struct mmc_card *card)
 	return 0;
 }
 
-/*
- * Read extended CSD.
- */
-static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
-{
-	int err;
-	u8 *ext_csd;
-
-	if (!card || !new_ext_csd)
-		return -EINVAL;
-
-	if (!mmc_can_ext_csd(card))
-		return -EOPNOTSUPP;
-
-	/*
-	 * As the ext_csd is so large and mostly unused, we don't store the
-	 * raw block in mmc_card.
-	 */
-	ext_csd = kmalloc(512, GFP_KERNEL);
-	if (!ext_csd)
-		return -ENOMEM;
-
-	err = mmc_send_ext_csd(card, ext_csd);
-	if (err)
-		kfree(ext_csd);
-	else
-		*new_ext_csd = ext_csd;
-
-	return err;
-}
-
 static void mmc_select_card_type(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1db60be4..72e1f9b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -385,6 +385,35 @@ int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
 }
 EXPORT_SYMBOL_GPL(mmc_send_ext_csd);
 
+int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
+{
+	int err;
+	u8 *ext_csd;
+
+	if (!card || !new_ext_csd)
+		return -EINVAL;
+
+	if (!mmc_can_ext_csd(card))
+		return -EOPNOTSUPP;
+
+	/*
+	 * As the ext_csd is so large and mostly unused, we don't store the
+	 * raw block in mmc_card.
+	 */
+	ext_csd = kmalloc(512, GFP_KERNEL);
+	if (!ext_csd)
+		return -ENOMEM;
+
+	err = mmc_send_ext_csd(card, ext_csd);
+	if (err)
+		kfree(ext_csd);
+	else
+		*new_ext_csd = ext_csd;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mmc_get_ext_csd);
+
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp)
 {
 	struct mmc_command cmd = {0};
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f206e29..0a77d35 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -155,6 +155,7 @@ extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
 			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
+extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
-- 
1.9.1

