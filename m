From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 1/1] mmc: sdhci-s3c: Use mmc_gpio_request_cd function
Date: Wed, 11 Dec 2013 14:51:39 +0900
Message-ID: <52A7FD6B.6090406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61782 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3LKFyn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 00:54:43 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXM0046FOF6KI20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 Dec 2013 14:54:42 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>


This patch use mmc_gpio_request_cd function.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   56 +++++++++++-------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6debda9..975411b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>

 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>

 #include "sdhci-s3c-regs.h"
 #include "sdhci.h"
@@ -400,44 +401,6 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 	}
 }

-static irqreturn_t sdhci_s3c_gpio_card_detect_thread(int irq, void *dev_id)
-{
-	struct sdhci_s3c *sc = dev_id;
-	int status = gpio_get_value(sc->ext_cd_gpio);
-	if (sc->pdata->ext_cd_gpio_invert)
-		status = !status;
-	sdhci_s3c_notify_change(sc->pdev, status);
-	return IRQ_HANDLED;
-}
-
-static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
-{
-	struct s3c_sdhci_platdata *pdata = sc->pdata;
-	struct device *dev = &sc->pdev->dev;
-
-	if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") == 0) {
-		sc->ext_cd_gpio = pdata->ext_cd_gpio;
-		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
-		if (sc->ext_cd_irq &&
-		    request_threaded_irq(sc->ext_cd_irq, NULL,
-					 sdhci_s3c_gpio_card_detect_thread,
-					 IRQF_TRIGGER_RISING |
-					 IRQF_TRIGGER_FALLING |
-					 IRQF_ONESHOT,
-					 dev_name(dev), sc) == 0) {
-			int status = gpio_get_value(sc->ext_cd_gpio);
-			if (pdata->ext_cd_gpio_invert)
-				status = !status;
-			sdhci_s3c_notify_change(sc->pdev, status);
-		} else {
-			dev_warn(dev, "cannot request irq for card detect\n");
-			sc->ext_cd_irq = 0;
-		}
-	} else {
-		dev_err(dev, "cannot request gpio for card detect\n");
-	}
-}
-
 #ifdef CONFIG_OF
 static int sdhci_s3c_parse_dt(struct device *dev,
 		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
@@ -699,8 +662,14 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
 		pdata->ext_cd_init(&sdhci_s3c_notify_change);
 	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
-	    gpio_is_valid(pdata->ext_cd_gpio))
-		sdhci_s3c_setup_card_detect_gpio(sc);
+	    gpio_is_valid(pdata->ext_cd_gpio)) {
+		ret = mmc_gpio_request_cd(host->mmc, pdata->ext_cd_gpio, 0);
+		if (ret) {
+			dev_err(dev,
+				"failed to reqeust card detect gpio\n");
+			goto err_req_cd;
+		}
+	}

 #ifdef CONFIG_PM_RUNTIME
 	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
@@ -708,6 +677,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 #endif
 	return 0;

+ err_req_cd:
+	sdhci_remove_host(host, 1);
+
  err_req_regs:
 #ifndef CONFIG_PM_RUNTIME
 	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
@@ -731,8 +703,8 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
 		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);

-	if (sc->ext_cd_irq)
-		free_irq(sc->ext_cd_irq, sc);
+	if (pdata->ext_cd_gpio)
+		mmc_gpio_free_cd(host->mmc);

 #ifdef CONFIG_PM_RUNTIME
 	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
-- 
1.7.9.5

-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., Software Center, Samsung Electronics
