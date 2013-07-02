From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Tue,  2 Jul 2013 12:53:01 +0200
Message-ID: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:56476 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab3GBKxJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jul 2013 06:53:09 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so3227365lbv.13
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jul 2013 03:53:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
Oops in the shutdown sequence for SDIO.

The drv pointer, does not exist for SDIO since the probing of the SDIO
card from the mmc_bus perspective is expected to fail by returning
-ENODEV.

This patch adds the proper check for the pointer before calling it.

Reported-by: Stephen Warren <swarren@wwwdotorg.org>
Reported-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 4c0decf..d4b99bb 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -129,7 +129,8 @@ static void mmc_bus_shutdown(struct device *dev)
 	struct mmc_host *host = card->host;
 	int ret;
 
-	drv->shutdown(card);
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(card);
 
 	if (host->bus_ops->shutdown) {
 		ret = host->bus_ops->shutdown(host);
-- 
1.7.10

