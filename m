From: yalin wang <yalin.wang2010@gmail.com>
Subject: [PATCH] mmc: change to use kmalloc
Date: Wed, 11 Nov 2015 12:23:11 +0800
Message-ID: <1447215791-19429-1-git-send-email-yalin.wang2010@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33269 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbKKEXW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2015 23:23:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, ben@decadent.org.uk, jh80.chung@samsung.com, asaf.vertz@tandemg.com, tklauser@distanz.ch, jonathanh@nvidia.com, JBottomley@Odin.com, grundler@chromium.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yalin wang <yalin.wang2010@gmail.com>

Use kmalloc instead of kzalloc, zero the memory is not needed.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/mmc/card/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 23b6c8e..975cd3e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -365,7 +365,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 	if (!idata->buf_bytes)
 		return idata;
 
-	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
+	idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
 	if (!idata->buf) {
 		err = -ENOMEM;
 		goto idata_err;
-- 
1.9.1

