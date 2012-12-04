From: Kyungsik Lee <kyungsik.lee@lge.com>
Subject: [PATCH] mmc: debugfs: Fix incorrect size of string allocation
Date: Tue,  4 Dec 2012 17:15:12 +0900
Message-ID: <1354608912-544-1-git-send-email-kyungsik.lee@lge.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:55642 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2LDIPt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 03:15:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Felipe Balbi <balbi@ti.com>, raphael.andy.lee@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungsik Lee <kyungsik.lee@lge.com>

It is usually accepted that code should explain itself.
The max size of string is 1025(512*2 + 1) bytes so there is
no point to add one more byte for string allocation.

This patch is intended to fix incorrect size for string allocation
and make code more readable.

Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
---
 drivers/mmc/core/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 35c2f85..5008149 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -281,7 +281,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	u8 *ext_csd;
 	int err, i;
 
-	buf = kmalloc(EXT_CSD_STR_LEN + 1, GFP_KERNEL);
+	buf = kmalloc(EXT_CSD_STR_LEN, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-- 
1.8.0

