From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 12/15] mmc: core: Use mmc_get_ext_csd() instead of mmc_send_ext_csd()
Date: Tue, 21 Oct 2014 19:19:10 +0200
Message-ID: <1413911953-19012-13-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:38333 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185AbaJURTn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:43 -0400
Received: by mail-la0-f42.google.com with SMTP id gf13so1653101lab.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:40 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

By using mmc_get_ext_csd() in favor of mmc_send_ext_csd, we decrease
code duplication.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    | 17 +++--------------
 drivers/mmc/core/debugfs.c |  9 +--------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f26a5f1..4b9fe01 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -709,27 +709,16 @@ int mmc_read_bkops_status(struct mmc_card *card)
 	int err;
 	u8 *ext_csd;
 
-	/*
-	 * In future work, we should consider storing the entire ext_csd.
-	 */
-	ext_csd = kmalloc(512, GFP_KERNEL);
-	if (!ext_csd) {
-		pr_err("%s: could not allocate buffer to receive the ext_csd.\n",
-		       mmc_hostname(card->host));
-		return -ENOMEM;
-	}
-
 	mmc_claim_host(card->host);
-	err = mmc_send_ext_csd(card, ext_csd);
+	err = mmc_get_ext_csd(card, &ext_csd);
 	mmc_release_host(card->host);
 	if (err)
-		goto out;
+		return err;
 
 	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
 	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXP_EVENTS_STATUS];
-out:
 	kfree(ext_csd);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(mmc_read_bkops_status);
 
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 91eb162..e914210 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -291,14 +291,8 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	if (!buf)
 		return -ENOMEM;
 
-	ext_csd = kmalloc(512, GFP_KERNEL);
-	if (!ext_csd) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-
 	mmc_get_card(card);
-	err = mmc_send_ext_csd(card, ext_csd);
+	err = mmc_get_ext_csd(card, &ext_csd);
 	mmc_put_card(card);
 	if (err)
 		goto out_free;
@@ -314,7 +308,6 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 
 out_free:
 	kfree(buf);
-	kfree(ext_csd);
 	return err;
 }
 
-- 
1.9.1

