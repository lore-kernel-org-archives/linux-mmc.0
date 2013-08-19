From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] mmc: jz4740: simplify use of SIMPLE_DEV_PM_OPS
Date: Mon, 19 Aug 2013 17:16:40 +0100
Message-ID: <1376929000-12573-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:41726 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab3HSQQy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Aug 2013 12:16:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: James Hogan <james.hogan@imgtec.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Commit 5d5c035 (mmc: jz4740: Use SIMPLE_DEV_PM_OPS) converted jz4740_mmc
to use SIMPLE_DEV_PM_OPS, but it did so within the #ifdef
CONFIG_PM_SLEEP. SIMPLE_DEV_PM_OPS already handles when CONFIG_PM_SLEEP
is disabled, so move it out of the ifdef and remove the
JZ4740_MMC_PM_OPS indirection.

Compile tested with CONFIG_PM_SLEEP enabled and disabled.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/jz4740_mmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0308c9f..28af392 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -898,13 +898,10 @@ static int jz4740_mmc_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
 	jz4740_mmc_resume);
-#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
-#else
-#define JZ4740_MMC_PM_OPS NULL
-#endif
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
@@ -912,7 +909,7 @@ static struct platform_driver jz4740_mmc_driver = {
 	.driver = {
 		.name = "jz4740-mmc",
 		.owner = THIS_MODULE,
-		.pm = JZ4740_MMC_PM_OPS,
+		.pm = &jz4740_mmc_pm_ops,
 	},
 };
 
-- 
1.8.1.2


