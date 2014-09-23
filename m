From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/6] mmc: Fix use of wrong device in mmc_gpiod_free_cd()
Date: Tue, 23 Sep 2014 23:00:25 +0300
Message-ID: <1411502430-25535-2-git-send-email-adrian.hunter@intel.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41324 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768AbaIWUBz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 16:01:55 -0400
In-Reply-To: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
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

