From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: block: Init sysfs attr to fix lockdep warnings
Date: Wed, 1 Feb 2012 16:31:56 +0100
Message-ID: <1328110316-7593-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:45325 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754375Ab2BAPcL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 10:32:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>

From: Rabin Vincent <rabin.vincent@stericsson.com>

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/card/block.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 176b78e..a7c75d8 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1705,6 +1705,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 
 		md->power_ro_lock.show = power_ro_lock_show;
 		md->power_ro_lock.store = power_ro_lock_store;
+		sysfs_attr_init(&md->power_ro_lock.attr);
 		md->power_ro_lock.attr.mode = mode;
 		md->power_ro_lock.attr.name =
 					"ro_lock_until_next_power_on";
-- 
1.7.5.4

