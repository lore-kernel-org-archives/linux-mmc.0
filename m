From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: core: properly init drv_type
Date: Thu, 30 Nov 2017 15:49:10 +0100
Message-ID: <20171130144910.4320-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:58675 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbdK3Otc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 30 Nov 2017 09:49:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>

When the latest version of parsing the new eMMC bindings was moved from
core.c to mmc.c, it was overlooked that drv_type could be used
uninitialized. Fix it!

Fixes: 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")
Reported-by: Colin Ian King <colin.king@canonical.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a552f61060d212..0d1c6b025ca596 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1290,7 +1290,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 static void mmc_select_driver_type(struct mmc_card *card)
 {
-	int card_drv_type, drive_strength, drv_type;
+	int card_drv_type, drive_strength, drv_type = 0;
 	int fixed_drv_type = card->host->fixed_drv_type;
 
 	card_drv_type = card->ext_csd.raw_driver_strength |
-- 
2.11.0

