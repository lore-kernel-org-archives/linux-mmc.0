From: "Liu, Changcheng" <changcheng.liu@intel.com>
Subject: [PATCH] mm/block: logical error fix to avoid memory leak
Date: Thu, 14 Dec 2017 13:03:05 +0800
Message-ID: <20171214050305.GA135779@sofia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37747 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdLNFEO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Dec 2017 00:04:14 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, changcheng.liu@intel.com

function:  mmc_ext_csd_open
{
+-- 33 lines: struct mmc_card *card = inode->i_private;--
    if (n != EXT_CSD_STR_LEN) {
        err = -EINVAL;
        goto out_free;  //==>should free ext_csd firstly.
    }
+--  2 lines: filp->private_data = buf;------------------
    kfree(ext_csd);
    return 0;

out_free:
    kfree(buf);
    return err;
}

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ccfa98a..b737a95 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2623,6 +2623,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 
 	if (n != EXT_CSD_STR_LEN) {
 		err = -EINVAL;
+		kfree(ext_csd);
 		goto out_free;
 	}
 
-- 
2.7.4

