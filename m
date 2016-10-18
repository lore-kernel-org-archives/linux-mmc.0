From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 2/8] mmc: debugfs: remove BUG_ON from mmc_ext_csd_open
Date: Tue, 18 Oct 2016 20:03:57 +0800
Message-ID: <1476792237-6347-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59013 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbcJRL6N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:58:13 -0400
In-Reply-To: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Return error value for file_operations callback instead
of triggering BUG_ON which is meaningless. Personally I
don't believe n != EXT_CSD_STR_LEN could happen. Anyway,
propagate the error to the caller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c8451ce..30623b8 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -321,7 +321,11 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	for (i = 0; i < 512; i++)
 		n += sprintf(buf + n, "%02x", ext_csd[i]);
 	n += sprintf(buf + n, "\n");
-	BUG_ON(n != EXT_CSD_STR_LEN);
+
+	if (n != EXT_CSD_STR_LEN) {
+		err = -EINVAL;
+		goto out_free;
+	}
 
 	filp->private_data = buf;
 	kfree(ext_csd);
-- 
2.3.7


