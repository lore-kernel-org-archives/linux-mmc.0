From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/13] mmc: Fix use of wrong device in mmc_gpiod_free_cd()
Date: Mon, 22 Sep 2014 13:17:32 +0300
Message-ID: <1411381064-1703-2-git-send-email-adrian.hunter@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4573 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbaIVKT1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:27 -0400
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

mmc_gpiod_free_cd() is paired with mmc_gpiod_request_cd()
and both must reference the same device which is the
actual host controller device not the mmc_host class
device.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index e3fce44..06616cd 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -392,7 +392,7 @@ void mmc_gpiod_free_cd(struct mmc_host *host)
 		host->slot.cd_irq = -EINVAL;
 	}
 
-	devm_gpiod_put(&host->class_dev, ctx->cd_gpio);
+	devm_gpiod_put(host->parent, ctx->cd_gpio);
 
 	ctx->cd_gpio = NULL;
 }
-- 
1.8.3.2

