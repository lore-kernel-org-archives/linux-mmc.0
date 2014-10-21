From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 15/15] mmc: core: Convert to use kzalloc() for CXD register buffers
Date: Tue, 21 Oct 2014 19:19:13 +0200
Message-ID: <1413911953-19012-16-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:56417 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933196AbaJURTs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:48 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so1497838lab.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:47 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

While allocating buffers for CXD data, let's use kzalloc() to make sure
those are zeroed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index e04008f..23aa3a3 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -315,7 +315,7 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 		return mmc_send_cxd_native(card->host, card->rca << 16,
 				csd, MMC_SEND_CSD);
 
-	csd_tmp = kmalloc(16, GFP_KERNEL);
+	csd_tmp = kzalloc(16, GFP_KERNEL);
 	if (!csd_tmp)
 		return -ENOMEM;
 
@@ -343,7 +343,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 				cid, MMC_SEND_CID);
 	}
 
-	cid_tmp = kmalloc(16, GFP_KERNEL);
+	cid_tmp = kzalloc(16, GFP_KERNEL);
 	if (!cid_tmp)
 		return -ENOMEM;
 
@@ -374,7 +374,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	 * As the ext_csd is so large and mostly unused, we don't store the
 	 * raw block in mmc_card.
 	 */
-	ext_csd = kmalloc(512, GFP_KERNEL);
+	ext_csd = kzalloc(512, GFP_KERNEL);
 	if (!ext_csd)
 		return -ENOMEM;
 
-- 
1.9.1

