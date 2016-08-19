From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] mmc-block: Use memdup_user() rather than duplicating its
 implementation
Date: Fri, 19 Aug 2016 23:10:07 +0200
Message-ID: <10db7d07-0cee-041f-8755-de412a12bc81@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <68870228-c6a0-5de9-daee-2522a1303857@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68870228-c6a0-5de9-daee-2522a1303857@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@fb.com>, Jon Hunter <jonathanh@nvidia.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 Aug 2016 22:46:38 +0200

* Reuse existing functionality from memdup_user() instead of keeping
  duplicate source code.

  This issue was detected by using the Coccinelle software.

* Delete the integer variable "err" then because the pointer
  variable "idata" should be sufficient to handle return values alone
  in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/card/block.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48a5dd7..6ce9492 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -337,22 +337,21 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 	struct mmc_ioc_cmd __user *user)
 {
 	struct mmc_blk_ioc_data *idata;
-	int err;
 
 	idata = kmalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
-		err = -ENOMEM;
+		idata = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
 	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
-		err = -EFAULT;
+		idata = ERR_PTR(-EFAULT);
 		goto idata_err;
 	}
 
 	idata->buf_bytes = (u64) idata->ic.blksz * idata->ic.blocks;
 	if (idata->buf_bytes > MMC_IOC_MAX_BYTES) {
-		err = -EOVERFLOW;
+		idata = ERR_PTR(-EOVERFLOW);
 		goto idata_err;
 	}
 
@@ -361,26 +360,19 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 		return idata;
 	}
 
-	idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
-	if (!idata->buf) {
-		err = -ENOMEM;
+	idata->buf = memdup_user((void __user *)(unsigned long)
+				 idata->ic.data_ptr,
+				 idata->buf_bytes);
+	if (IS_ERR(idata->buf)) {
+		idata = (void *) idata->buf;
 		goto idata_err;
 	}
-
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
-	return ERR_PTR(err);
+	return idata;
 }
 
 static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
-- 
2.9.3
