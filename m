From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 4/4] mmc: sdhci: merge two sdhci-pltfm.h into one
Date: Wed, 25 May 2011 19:01:54 +0800
Message-ID: <1306321314-2493-5-git-send-email-shawn.guo@linaro.org>
References: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:48633 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab1EYK7Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 06:59:25 -0400
In-Reply-To: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <cbouatmailru@gmail.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The structure sdhci_pltfm_data is not necessarily to be in a public
header like include/linux/mmc/sdhci-pltfm.h, so the patch moves it
into drivers/mmc/host/sdhci-pltfm.h and eliminates the former one.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-cns3xxx.c   |    1 -
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 -
 drivers/mmc/host/sdhci-pltfm.h     |    6 +++++-
 include/linux/mmc/sdhci-pltfm.h    |   29 -----------------------------
 4 files changed, 5 insertions(+), 32 deletions(-)
 delete mode 100644 include/linux/mmc/sdhci-pltfm.h

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index ac4b26f..025d1a5 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sdhci-pltfm.h>
 #include <mach/cns3xxx.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e27ccbb..977f142 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -18,7 +18,6 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sdhci-pltfm.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
 #include <mach/hardware.h>
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index fe27b83..fd72694 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -14,9 +14,13 @@
 #include <linux/clk.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
-#include <linux/mmc/sdhci-pltfm.h>
 #include <linux/mmc/sdhci.h>
 
+struct sdhci_pltfm_data {
+	struct sdhci_ops *ops;
+	unsigned int quirks;
+};
+
 struct sdhci_pltfm_host {
 	struct clk *clk;
 	void *priv; /* to handle quirks across io-accessor calls */
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
deleted file mode 100644
index f1c2ac3..0000000
--- a/include/linux/mmc/sdhci-pltfm.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Platform data declarations for the sdhci-pltfm driver.
- *
- * Copyright (c) 2010 MontaVista Software, LLC.
- *
- * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- */
-
-#ifndef _SDHCI_PLTFM_H
-#define _SDHCI_PLTFM_H
-
-struct sdhci_ops;
-
-/**
- * struct sdhci_pltfm_data - SDHCI platform-specific information & hooks
- * @ops: optional pointer to the platform-provided SDHCI ops
- * @quirks: optional SDHCI quirks
- */
-struct sdhci_pltfm_data {
-	struct sdhci_ops *ops;
-	unsigned int quirks;
-};
-
-#endif /* _SDHCI_PLTFM_H */
-- 
1.7.4.1


