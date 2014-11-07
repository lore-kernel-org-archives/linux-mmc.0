From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v2] mmc: atmel-mci: adopt pinctrl support
Date: Fri, 7 Nov 2014 08:48:13 +0800
Message-ID: <1415321293-17521-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:26934 "EHLO
	DVREDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbaKGAvm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 19:51:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, chris@printf.net
Cc: khilman@kernel.org, nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wenyou.yang@atmel.com

Amend the atmel mci pin controller to optionally take a pin control
handle and set the state of the pins to:
- "default" on boot, resume and before performing an transfer.
- "sleep" on suspend().

This should make it possible to optimize energy usage for the pins
both for the suspend/resume cycle.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
Hi Ulf,

Thanks a lot.

According to your advice, remove pinctrl_pm_select_default_state(&pdev->dev) from the _probe function.

Best Regards,
Wenyou Yang

 drivers/mmc/host/atmel-mci.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 4df1599..a7b59ba 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -39,6 +39,7 @@
 #include <linux/atmel_pdc.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/cacheflush.h>
 #include <asm/io.h>
@@ -2568,6 +2569,8 @@ static int atmci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->mck);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -2575,6 +2578,8 @@ static int atmci_runtime_resume(struct device *dev)
 {
 	struct atmel_mci *host = dev_get_drvdata(dev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	return clk_prepare_enable(host->mck);
 }
 #endif
-- 
1.7.9.5

