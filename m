From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] mmc-block: Rename jump labels in
 mmc_blk_ioctl_copy_from_user()
Date: Fri, 19 Aug 2016 23:12:05 +0200
Message-ID: <6b8e8d4b-3c82-af57-1bad-b143654a8d70@users.sourceforge.net>
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
Date: Fri, 19 Aug 2016 22:52:50 +0200

Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/card/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 6ce9492..0d83c56 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -346,13 +346,13 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 
 	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
 		idata = ERR_PTR(-EFAULT);
-		goto idata_err;
+		goto free_idata;
 	}
 
 	idata->buf_bytes = (u64) idata->ic.blksz * idata->ic.blocks;
 	if (idata->buf_bytes > MMC_IOC_MAX_BYTES) {
 		idata = ERR_PTR(-EOVERFLOW);
-		goto idata_err;
+		goto free_idata;
 	}
 
 	if (!idata->buf_bytes) {
@@ -365,11 +365,11 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 				 idata->buf_bytes);
 	if (IS_ERR(idata->buf)) {
 		idata = (void *) idata->buf;
-		goto idata_err;
+		goto free_idata;
 	}
 	return idata;
 
-idata_err:
+free_idata:
 	kfree(idata);
 out:
 	return idata;
-- 
2.9.3
