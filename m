From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/27] mmc: jz4740: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:32 +0200
Message-ID: <1380207292-16968-8-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:58967 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab3IZOz0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 10:55:26 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so599684eek.39
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 07:55:24 -0700 (PDT)
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/jz4740_mmc.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6651633..de2139c 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -880,8 +880,6 @@ static int jz4740_mmc_suspend(struct device *dev)
 {
 	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
 
-	mmc_suspend_host(host->mmc);
-
 	jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 
 	return 0;
@@ -893,8 +891,6 @@ static int jz4740_mmc_resume(struct device *dev)
 
 	jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 
-	mmc_resume_host(host->mmc);
-
 	return 0;
 }
 
-- 
1.7.9.5

