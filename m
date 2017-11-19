From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mmc: core/block.c: fix comment typos
Date: Sat, 18 Nov 2017 18:01:18 -0800
Message-ID: <cc03c62b-881d-62bd-f0ec-21fc66df4ee9@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdKSCBV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Nov 2017 21:01:21 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix comment typos.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/block.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-414.orig/drivers/mmc/core/block.c
+++ lnx-414/drivers/mmc/core/block.c
@@ -2033,8 +2033,8 @@ static struct mmc_blk_data *mmc_blk_allo
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
 		/*
-		 * We get -ENOSPC because there are no more any available
-		 * devidx. The reason may be that, either userspace haven't yet
+		 * We get -ENOSPC because there are not any available devidx
+		 * entries. The reason may be that, either userspace hasn't yet
 		 * unmounted the partitions, which postpones mmc_blk_release()
 		 * from being called, or the device has more partitions than
 		 * what we support.

