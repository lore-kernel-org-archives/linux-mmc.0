From: "Liu, Changcheng" <changcheng.liu@intel.com>
Subject: Re: [PATCH v2] mmc: block: fix logical error to avoid memory leak
Date: Sat, 16 Dec 2017 23:15:45 +0800
Message-ID: <20171216151545.GA138678@sofia>
References: <20171214050305.GA135779@sofia>
 <f9294d5a-bd24-8b95-3666-fa75d681bec1@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17524 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756729AbdLPPQx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 16 Dec 2017 10:16:53 -0500
Content-Disposition: inline
In-Reply-To: <f9294d5a-bd24-8b95-3666-fa75d681bec1@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linus.walleij@linaro.org
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, changcheng.liu@intel.com

If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
ext_csd must be freed, but in one case it was not. Fix that.

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
