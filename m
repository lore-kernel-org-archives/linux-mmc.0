From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mmc: core: Re-use DEFINE_SHOW_ATTRIBUTE() macro
Date: Wed, 14 Feb 2018 17:45:12 +0200
Message-ID: <20180214154512.53739-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43191 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031596AbeBNPpQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Feb 2018 10:45:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 0f4a7d7b2626..c51e0c044a3e 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -196,18 +196,7 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int mmc_ios_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mmc_ios_show, inode->i_private);
-}
-
-static const struct file_operations mmc_ios_fops = {
-	.open		= mmc_ios_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mmc_ios);
 
 static int mmc_clock_opt_get(void *data, u64 *val)
 {
-- 
2.15.1

