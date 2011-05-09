From: Vladimir Motyka <vladimir.motyka@gmail.com>
Subject: [PATCH] drivers/mmc/card/block.c: fix potential null dereference
 'idata'
Date: Mon, 09 May 2011 16:05:31 +0200
Message-ID: <4DC7F4AB.90607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When allocation of idata fails there was a null dereferece.

Signed-off-by: Vladimir Motyka <vladimir.motyka@gmail.com>

---
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 407836d..3dec493 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -266,10 +266,10 @@ static struct mmc_blk_ioc_data
*mmc_blk_ioctl_copy_from_user(
 	return idata;

 copy_err:
-	kfree(idata->buf);
+	if(idata)
+		kfree(idata->buf);
 	kfree(idata);
 	return ERR_PTR(err);
-
 }

 static int mmc_blk_ioctl_cmd(struct block_device *bdev,
