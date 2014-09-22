From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] mmc: block: add newline to sysfs display of force_ro
Date: Mon, 22 Sep 2014 10:12:51 +0300
Message-ID: <f7fa9dd28f967c578a07333d92eba159f3f63863.1411369971.git.baruch@tkos.co.il>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:49720 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbaIVHVS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 03:21:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Baruch Siach <baruch@tkos.co.il>, Andrei Warkentin <andreiw@motorola.com>

Make force_ro consistent with other sysfs entries.

Fixes: 371a689f64b0d ('mmc: MMC boot partitions support')
Cc: Andrei Warkentin <andreiw@motorola.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/mmc/card/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ede41f05c392..dad364b09952 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -260,7 +260,7 @@ static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
 	int ret;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 
-	ret = snprintf(buf, PAGE_SIZE, "%d",
+	ret = snprintf(buf, PAGE_SIZE, "%d\n",
 		       get_disk_ro(dev_to_disk(dev)) ^
 		       md->read_only);
 	mmc_blk_put(md);
-- 
2.1.0

