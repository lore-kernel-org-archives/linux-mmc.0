From: Peter Chen <peter.chen@freescale.com>
Subject: [PATCH 1/1] mmc: core: pwrseq_simple: remove unused header file
Date: Wed, 6 Jan 2016 11:34:10 +0800
Message-ID: <1452051250-17163-1-git-send-email-peter.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0139.outbound.protection.outlook.com ([157.56.110.139]:20928
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752011AbcAFDgW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jan 2016 22:36:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Peter Chen <peter.chen@freescale.com>

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/mmc/core/pwrseq_simple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index d10538b..f42a956 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 
 #include <linux/mmc/host.h>
-- 
1.9.1

