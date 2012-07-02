From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mmc: Report failure reasons for all cases in sdhci_add_host()
Date: Mon,  2 Jul 2012 14:26:15 +0100
Message-ID: <1341235575-17553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48007 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751173Ab2GBN0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 09:26:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

For most error conditions sdhci_add_host() will print a diagnostic
message indicating why it failed but there are a few cases where this
does not happen. Add error messages in these cases to aid diagnosis.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index caba999..acbc420 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3031,8 +3031,11 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
 		mmc_hostname(mmc), host);
-	if (ret)
+	if (ret) {
+		pr_err("%s: Failed to request IRQ %d: %d\n",
+		       mmc_hostname(mmc), host->irq, ret);
 		goto untasklet;
+	}
 
 	sdhci_init(host, 0);
 
@@ -3049,8 +3052,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->led.brightness_set = sdhci_led_control;
 
 	ret = led_classdev_register(mmc_dev(mmc), &host->led);
-	if (ret)
+	if (ret) {
+		pr_err("%s: Failed to register LED device: %d\n",
+		       mmc_hostname(mmc), ret);
 		goto reset;
+	}
 #endif
 
 	mmiowb();
-- 
1.7.10

