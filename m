From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/15] mmc: core: Let's callers of from mmc_get_ext_csd() do error handling
Date: Tue, 21 Oct 2014 19:19:06 +0200
Message-ID: <1413911953-19012-9-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:60229 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135AbaJURTe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:34 -0400
Received: by mail-la0-f52.google.com with SMTP id hz20so1482135lab.11
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:33 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

The callers of mmc_get_ext_csd() need the flexibility to handle errors
themselves, because they behave differently.

Let's clean up mmc_get_ext_csd() with its friends and adopt the error
handling as stated above.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 70 ++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f10f932..755019d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -188,10 +188,8 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	BUG_ON(!card);
 	BUG_ON(!new_ext_csd);
 
-	*new_ext_csd = NULL;
-
 	if (!mmc_can_ext_csd(card))
-		return 0;
+		return -EOPNOTSUPP;
 
 	/*
 	 * As the ext_csd is so large and mostly unused, we don't store the
@@ -202,32 +200,9 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 		return -ENOMEM;
 
 	err = mmc_send_ext_csd(card, ext_csd);
-	if (err) {
+	if (err)
 		kfree(ext_csd);
-		*new_ext_csd = NULL;
-
-		/* If the host or the card can't do the switch,
-		 * fail more gracefully. */
-		if ((err != -EINVAL)
-		 && (err != -ENOSYS)
-		 && (err != -EFAULT))
-			return err;
-
-		/*
-		 * High capacity cards should have this "magic" size
-		 * stored in their CSD.
-		 */
-		if (card->csd.capacity == (4096 * 512)) {
-			pr_err("%s: unable to read EXT_CSD "
-				"on a possible high capacity card. "
-				"Card will be ignored.\n",
-				mmc_hostname(card->host));
-		} else {
-			pr_warn("%s: unable to read EXT_CSD, performance might suffer\n",
-				mmc_hostname(card->host));
-			err = 0;
-		}
-	} else
+	else
 		*new_ext_csd = ext_csd;
 
 	return err;
@@ -395,9 +370,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 	BUG_ON(!card);
 
-	if (!ext_csd)
-		return 0;
-
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
 	if (card->csd.structure == 3) {
@@ -631,12 +603,36 @@ out:
 
 static int mmc_read_ext_csd(struct mmc_card *card)
 {
-	u8 *ext_csd = NULL;
+	u8 *ext_csd;
 	int err;
 
+	if (!mmc_can_ext_csd(card))
+		return 0;
+
 	err = mmc_get_ext_csd(card, &ext_csd);
-	if (err)
+	if (err) {
+		/* If the host or the card can't do the switch,
+		 * fail more gracefully. */
+		if ((err != -EINVAL)
+		 && (err != -ENOSYS)
+		 && (err != -EFAULT))
+			return err;
+
+		/*
+		 * High capacity cards should have this "magic" size
+		 * stored in their CSD.
+		 */
+		if (card->csd.capacity == (4096 * 512)) {
+			pr_err("%s: unable to read EXT_CSD on a possible high capacity card. Card will be ignored.\n",
+				mmc_hostname(card->host));
+		} else {
+			pr_warn("%s: unable to read EXT_CSD, performance might suffer\n",
+				mmc_hostname(card->host));
+			err = 0;
+		}
+
 		return err;
+	}
 
 	err = mmc_decode_ext_csd(card, ext_csd);
 	kfree(ext_csd);
@@ -652,11 +648,8 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 		return 0;
 
 	err = mmc_get_ext_csd(card, &bw_ext_csd);
-
-	if (err || bw_ext_csd == NULL) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (err)
+		return err;
 
 	/* only compare read only fields */
 	err = !((card->ext_csd.raw_partition_support ==
@@ -715,7 +708,6 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 	if (err)
 		err = -EINVAL;
 
-out:
 	kfree(bw_ext_csd);
 	return err;
 }
-- 
1.9.1

