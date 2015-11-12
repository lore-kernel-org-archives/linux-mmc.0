From: yalin wang <yalin.wang2010@gmail.com>
Subject: [PATCH V2] mmc: change to use kmalloc
Date: Thu, 12 Nov 2015 19:27:11 +0800
Message-ID: <1447327631-26947-1-git-send-email-yalin.wang2010@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34999 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbbKLL1W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2015 06:27:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, akpm@linux-foundation.org, tklauser@distanz.ch, yalin.wang2010@gmail.com, JBottomley@Odin.com, ben@decadent.org.uk, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, justin.wang@spreadtrum.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Use kmalloc instead of kzalloc, zero the memory is not needed.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/mmc/card/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c742cfd..c3fd4c8 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -345,7 +345,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 	struct mmc_blk_ioc_data *idata;
 	int err;
 
-	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
+	idata = kmalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
 		err = -ENOMEM;
 		goto out;
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

