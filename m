From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH] mmc: fix refcount leak in power_ro_lock_show
Date: Sun, 28 Apr 2013 09:06:49 +0900
Message-ID: <1367107609-2586-1-git-send-email-linkinjeon@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:58945 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3D1AHD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Apr 2013 20:07:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Vivek Trivedi <t.vivek@samsung.com>

From: Namjae Jeon <namjae.jeon@samsung.com>

when user does
cat /sys/block/mmcblk0boot0/ro_lock_until_next_power_on

power_ro_lock_show increments md->usage by calling mmc_blk_get
but it forgets to call mmc_blk_put to restore md->usage

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
---
 drivers/mmc/card/block.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e12a03c..ae8e1de 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -201,6 +201,7 @@ static ssize_t power_ro_lock_show(struct device *dev,
 		locked = 1;
 
 	ret = snprintf(buf, PAGE_SIZE, "%d\n", locked);
+	mmc_blk_put(md);
 
 	return ret;
 }
-- 
1.7.9.5

