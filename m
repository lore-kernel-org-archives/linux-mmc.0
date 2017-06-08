From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6 v3] mmc: debugfs: No blocklayer = no card status and extcsd
Date: Thu,  8 Jun 2017 10:53:59 +0200
Message-ID: <20170608085403.11795-3-linus.walleij@linaro.org>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33792 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdFHIyT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 04:54:19 -0400
Received: by mail-lf0-f46.google.com with SMTP id v20so15272755lfa.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 01:54:18 -0700 (PDT)
In-Reply-To: <20170608085403.11795-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

If we don't have the block layer enabled, we do not present card
status and extcsd in the debugfs.

Debugfs is not ABI, and maintaining files of no relevance for
non-block devices comes at a high maintenance cost if we shall
support it with the block layer compiled out.

The expected number of debugfs users utilizing these two
debugfs files is already low as there is an ioctl() to get the
same information using the mmc-tools, and of these few users
the expected number of people using it on SDIO or combo cards
are expected to be zero.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes just resending
---
 drivers/mmc/core/debugfs.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index a1fba5732d66..b176932b8092 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -281,6 +281,8 @@ void mmc_remove_host_debugfs(struct mmc_host *host)
 	debugfs_remove_recursive(host->debugfs_root);
 }
 
+#if IS_ENABLED(CONFIG_MMC_BLOCK)
+
 static int mmc_dbg_card_status_get(void *data, u64 *val)
 {
 	struct mmc_card	*card = data;
@@ -360,6 +362,32 @@ static const struct file_operations mmc_dbg_ext_csd_fops = {
 	.llseek		= default_llseek,
 };
 
+static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
+{
+	if (mmc_card_mmc(card) || mmc_card_sd(card)) {
+		if (!debugfs_create_file("status", S_IRUSR, root, card,
+					 &mmc_dbg_card_status_fops))
+			return -EIO;
+	}
+
+	if (mmc_card_mmc(card)) {
+		if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
+					 &mmc_dbg_ext_csd_fops))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+#else /* !IS_ENABLED(CONFIG_MMC_BLOCK) */
+
+static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
+{
+	return 0;
+}
+
+#endif
+
 void mmc_add_card_debugfs(struct mmc_card *card)
 {
 	struct mmc_host	*host = card->host;
@@ -382,15 +410,8 @@ void mmc_add_card_debugfs(struct mmc_card *card)
 	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
 		goto err;
 
-	if (mmc_card_mmc(card) || mmc_card_sd(card))
-		if (!debugfs_create_file("status", S_IRUSR, root, card,
-					&mmc_dbg_card_status_fops))
-			goto err;
-
-	if (mmc_card_mmc(card))
-		if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
-					&mmc_dbg_ext_csd_fops))
-			goto err;
+	if (mmc_add_block_debugfs(card, root))
+		goto err;
 
 	return;
 
-- 
2.9.4

