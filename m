From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] mmc: slot-gpio: Don't override con_id when request descriptor
Date: Mon,  2 Jan 2017 14:05:25 +0200
Message-ID: <20170102120525.178212-2-andriy.shevchenko@linux.intel.com>
References: <20170102120525.178212-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47240 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbdABMF2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Jan 2017 07:05:28 -0500
In-Reply-To: <20170102120525.178212-1-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The caller may supply connection ID, index, or both. All combinations are
possible and mmc framework should not make any assumption on what exactly
caller wants.

Remove con_id override conditionals in mmc_gpiod_request_ro() and
mmc_gpiod_request_cd().

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/slot-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index babe591aea96..a8450a8701e4 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -235,9 +235,6 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 	struct gpio_desc *desc;
 	int ret;
 
-	if (!con_id)
-		con_id = ctx->cd_label;
-
 	desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
@@ -289,9 +286,6 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 	struct gpio_desc *desc;
 	int ret;
 
-	if (!con_id)
-		con_id = ctx->ro_label;
-
 	desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
-- 
2.11.0

