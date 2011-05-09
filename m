From: Vladimir Motyka <vladimir.motyka@gmail.com>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference
 'idata'
Date: Mon, 09 May 2011 22:37:40 +0200
Message-ID: <4DC85094.4050401@gmail.com>
References: <4DC7F4AB.90607@gmail.com> <Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk> <4DC802C0.9040302@gmail.com> <Pine.LNX.4.64.1105091713080.15483@pc-004.diku.dk> <4DC8117C.7060200@gmail.com> <Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: cjb@laptop.org, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When allocation of idata failed there was a null dereference. Also avoid
calling kfree where it is needn't.

---
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 407836d..126c7f4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -237,24 +237,24 @@ static struct mmc_blk_ioc_data
*mmc_blk_ioctl_copy_from_user(
 	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
 		err = -ENOMEM;
-		goto copy_err;
+		goto out;
 	}

 	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
 		err = -EFAULT;
-		goto copy_err;
+		goto idata_err;
 	}

 	idata->buf_bytes = (u64) idata->ic.blksz * idata->ic.blocks;
 	if (idata->buf_bytes > MMC_IOC_MAX_BYTES) {
 		err = -EOVERFLOW;
-		goto copy_err;
+		goto idata_err;
 	}

 	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
 	if (!idata->buf) {
 		err = -ENOMEM;
-		goto copy_err;
+		goto idata_err;
 	}

 	if (copy_from_user(idata->buf, (void __user *)(unsigned long)
@@ -267,9 +267,10 @@ static struct mmc_blk_ioc_data
*mmc_blk_ioctl_copy_from_user(

 copy_err:
 	kfree(idata->buf);
+idata_err:
 	kfree(idata);
+out:
 	return ERR_PTR(err);
-
 }

 static int mmc_blk_ioctl_cmd(struct block_device *bdev,
