From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/9] mmc: core: Remove redundant code in mmc_send_cid()
Date: Thu,  8 Jun 2017 15:27:42 +0200
Message-ID: <1496928465-25004-7-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33858 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdFHN2P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:28:15 -0400
Received: by mail-lf0-f53.google.com with SMTP id v20so18057044lfa.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:28:14 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mmc_send_cid() is never called using non SPI mode. Thus, let's remove
the redundant code dealing with this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f79d680..9994840 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -339,13 +339,6 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 	int ret, i;
 	__be32 *cid_tmp;
 
-	if (!mmc_host_is_spi(host)) {
-		if (!host->card)
-			return -EINVAL;
-		return mmc_send_cxd_native(host, host->card->rca << 16,
-				cid, MMC_SEND_CID);
-	}
-
 	cid_tmp = kzalloc(16, GFP_KERNEL);
 	if (!cid_tmp)
 		return -ENOMEM;
-- 
2.7.4

