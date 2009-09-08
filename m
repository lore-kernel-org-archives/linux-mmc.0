From: thomas.ab@samsung.com
Subject: [PATCH 3/8] s3c6410: sdhci: Set parent clock, source clock and sdhci module speed.
Date: Tue,  8 Sep 2009 15:51:26 +0900
Message-ID: <1252392686-31135-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:46833 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbZIHHCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 03:02:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch sets the parent clock, source clock and sdhci module
clock speed for 6410 sdhci controller.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 50997d2..db1bb93 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -22,6 +22,8 @@
 
 #include <plat/sdhci.h>
 #include <plat/regs-sdhci.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
 
 #include "sdhci.h"
 
@@ -221,6 +223,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_s3c *sc;
 	struct resource *res;
+	struct clk *clk_mmc, *clk_parent;
 	int ret, irq, ptr, clks;
 
 	if (!pdata) {
@@ -240,6 +243,16 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	/* Set the SDHCI controller clock rate */
+	clk_mmc = clk_get(dev, pdata->clk_source_name);
+	clk_parent = clk_get(dev, pdata->clk_parent_name);
+        if (!clk_mmc || !clk_parent) {
+                dev_err(dev, "could not obtain clock information");
+                return -ENXIO;
+        }
+	clk_set_parent(clk_mmc, clk_parent);
+	clk_set_rate(clk_mmc, pdata->clk_speed);
+
 	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
 	if (IS_ERR(host)) {
 		dev_err(dev, "sdhci_alloc_host() failed\n");
-- 
1.5.3.4

