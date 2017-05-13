From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] mmc: block: use memdup_user
Date: Sat, 13 May 2017 11:15:58 +0800
Message-ID: <b379dcae31767ca644693366c6131304523dcf23.1494578464.git.geliangtang@gmail.com>
References: <908fa521decaf3703e172c3734c0d498741f3ddb.1494580404.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <908fa521decaf3703e172c3734c0d498741f3ddb.1494580404.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jens Axboe <axboe@fb.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use memdup_user() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/mmc/core/block.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8273b07..47ccb2a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -342,21 +342,15 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
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
 	kfree(idata->buf);
 idata_err:
 	kfree(idata);
-- 
2.9.3
