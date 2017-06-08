From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 8/9] mmc: core: Drop mmc_all_send_cid() and use mmc_send_cxd_native() instead
Date: Thu,  8 Jun 2017 15:27:44 +0200
Message-ID: <1496928465-25004-9-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36303 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbdFHN2H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:28:07 -0400
Received: by mail-lf0-f44.google.com with SMTP id o83so18028701lff.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:28:07 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 50571a6..b60b4da 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -207,24 +207,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return err;
 }
 
-static int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
-{
-	int err;
-	struct mmc_command cmd = {};
-
-	cmd.opcode = MMC_ALL_SEND_CID;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R2 | MMC_CMD_BCR;
-
-	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
-	if (err)
-		return err;
-
-	memcpy(cid, cmd.resp, sizeof(u32) * 4);
-
-	return 0;
-}
-
 int mmc_set_relative_addr(struct mmc_card *card)
 {
 	struct mmc_command cmd = {};
@@ -360,7 +342,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 	if (mmc_host_is_spi(host))
 		return mmc_spi_send_cid(host, cid);
 
-	return mmc_all_send_cid(host, cid);
+	return mmc_send_cxd_native(host, 0, cid, MMC_ALL_SEND_CID);
 }
 
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
-- 
2.7.4

