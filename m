From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] mmc: debugfs: fix memory leak for mmc_ext_csd_open
Date: Tue, 22 Sep 2015 09:18:33 +0800
Message-ID: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:43300 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbbIVBU1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2015 21:20:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

buf allocated isn't been freed before return, so we fix it.

Fixes: 736bb6bb01a ("mmc: Add Extended CSD register to debugfs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index e914210..b2ab936 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -304,6 +304,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = buf;
 	kfree(ext_csd);
+	kfree(buf);
 	return 0;
 
 out_free:
-- 
2.3.7


