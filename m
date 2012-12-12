From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Support MMC_PM_KEEP_POWER
Date: Wed, 12 Dec 2012 14:13:40 +0100
Message-ID: <1355318020-8169-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:58743 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751517Ab2LLNOM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 08:14:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Add MMC_PM_KEEP_POWER to pm_caps so SDIO clients are able
to use this option to prevent power off in suspend.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..2fe532e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/log2.h>
+#include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/amba/bus.h>
@@ -1386,6 +1387,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	mmc->caps = plat->capabilities;
 	mmc->caps2 = plat->capabilities2;
 
+	/* We support these PM capabilities. */
+	mmc->pm_caps = MMC_PM_KEEP_POWER;
+
 	/*
 	 * We can do SGIO
 	 */
-- 
1.7.10

