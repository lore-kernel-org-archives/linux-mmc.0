From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/4] sdhci-s3c: add regulator support
Date: Wed, 28 Jul 2010 16:19:57 +0200
Message-ID: <1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54157 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab0G1OUK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 10:20:10 -0400
In-reply-to: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com

This patch adds support for regulator API to sdhci-s3c driver. Regulators
can be used to disable power in suspended state to reduce dissipated
energy.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 606e695..b9d46a5 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/mmc/host.h>
 
@@ -50,6 +51,7 @@ struct sdhci_s3c {
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
+	struct regulator	*vmmc;
 };
 
 static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
@@ -309,6 +311,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
+	sc->vmmc = regulator_get(dev, "vmmc");
+	if (IS_ERR(sc->vmmc)) {
+		dev_warn(dev, "no vmmc regulator found\n");
+		sc->vmmc = NULL;
+	} else
+		regulator_enable(sc->vmmc);
+
 	sc->clk_io = clk_get(dev, "hsmmc");
 	if (IS_ERR(sc->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
@@ -482,6 +491,11 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable(sc->clk_io);
 	clk_put(sc->clk_io);
 
+	if (sc->vmmc) {
+		regulator_disable(sc->vmmc);
+		regulator_put(sc->vmmc);
+	}
+
 	iounmap(host->ioaddr);
 	release_resource(sc->ioarea);
 	kfree(sc->ioarea);
@@ -496,15 +510,29 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 
 static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
 {
+	int ret = 0;
 	struct sdhci_host *host = platform_get_drvdata(dev);
+	struct sdhci_s3c *sc = sdhci_priv(host);
 
 	sdhci_suspend_host(host, pm);
-	return 0;
+
+	if (sc->vmmc)
+		ret = regulator_disable(sc->vmmc);
+
+	return ret;
 }
 
 static int sdhci_s3c_resume(struct platform_device *dev)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
+	struct sdhci_s3c *sc = sdhci_priv(host);
+
+	if (sc->vmmc) {
+		int ret = regulator_disable(sc->vmmc);
+		if (ret)
+			return ret;
+		mdelay(2);
+	}
 
 	sdhci_resume_host(host);
 	return 0;
-- 
1.7.1.569.g6f426

