From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] mmc/core/block: Use memdup_user() rather than duplicating its
 implementation
Date: Mon, 5 Mar 2018 13:08:03 +0100
Message-ID: <4eca7388-cb2d-31e0-b64d-afb30818f53e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 11:33:21 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/block.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20135a5de748..4b09c7380e70 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -375,22 +375,15 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 		return idata;
 	}
 
-	idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
-	if (!idata->buf) {
-		err = -ENOMEM;
+	idata->buf = memdup_user((void __user *)(unsigned long)
+				 idata->ic.data_ptr, idata->buf_bytes);
+	if (IS_ERR(idata->buf)) {
+		err = PTR_ERR(idata->buf);
 		goto idata_err;
 	}
 
-	if (copy_from_user(idata->buf, (void __user *)(unsigned long)
-					idata->ic.data_ptr, idata->buf_bytes)) {
-		err = -EFAULT;
-		goto copy_err;
-	}
-
 	return idata;
 
-copy_err:
-	kfree(idata->buf);
 idata_err:
 	kfree(idata);
 out:
-- 
2.16.2
