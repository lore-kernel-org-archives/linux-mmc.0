From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/6] mmc: sdhci-pltfm: move .h-file into apropriate subdir
Date: Tue, 28 Sep 2010 14:36:42 +0200
Message-ID: <1285677406-3359-3-git-send-email-w.sang@pengutronix.de>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54510 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0I1MhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:37:15 -0400
In-Reply-To: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

Make use of the mmc-directory.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-cns3xxx.c |    2 +-
 drivers/mmc/host/sdhci-pltfm.c   |    2 +-
 drivers/mmc/host/sdhci-pltfm.h   |    2 +-
 include/linux/mmc/sdhci-pltfm.h  |   35 +++++++++++++++++++++++++++++++++++
 include/linux/sdhci-pltfm.h      |   35 -----------------------------------
 5 files changed, 38 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/mmc/sdhci-pltfm.h
 delete mode 100644 include/linux/sdhci-pltfm.h

diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index b7050b3..9ebd1d7 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -15,7 +15,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
-#include <linux/sdhci-pltfm.h>
+#include <linux/mmc/sdhci-pltfm.h>
 #include <mach/cns3xxx.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bf522a1..ff0271c 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -30,7 +30,7 @@
 #include <linux/mmc/host.h>
 
 #include <linux/io.h>
-#include <linux/sdhci-pltfm.h>
+#include <linux/mmc/sdhci-pltfm.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 1f96864..9a6f8a9 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -12,7 +12,7 @@
 #define _DRIVERS_MMC_SDHCI_PLTFM_H
 
 #include <linux/clk.h>
-#include <linux/sdhci-pltfm.h>
+#include <linux/mmc/sdhci-pltfm.h>
 
 struct sdhci_pltfm_host {
 	struct clk *clk;
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
new file mode 100644
index 0000000..0239bd7
--- /dev/null
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -0,0 +1,35 @@
+/*
+ * Platform data declarations for the sdhci-pltfm driver.
+ *
+ * Copyright (c) 2010 MontaVista Software, LLC.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#ifndef _SDHCI_PLTFM_H
+#define _SDHCI_PLTFM_H
+
+struct sdhci_ops;
+struct sdhci_host;
+
+/**
+ * struct sdhci_pltfm_data - SDHCI platform-specific information & hooks
+ * @ops: optional pointer to the platform-provided SDHCI ops
+ * @quirks: optional SDHCI quirks
+ * @init: optional hook that is called during device probe, before the
+ *        driver tries to access any SDHCI registers
+ * @exit: optional hook that is called during device removal
+ */
+struct sdhci_pltfm_data {
+	struct sdhci_ops *ops;
+	unsigned int quirks;
+	int (*init)(struct sdhci_host *host);
+	void (*exit)(struct sdhci_host *host);
+};
+
+#endif /* _SDHCI_PLTFM_H */
diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
deleted file mode 100644
index 0239bd7..0000000
--- a/include/linux/sdhci-pltfm.h
+++ /dev/null
@@ -1,35 +0,0 @@
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
-struct sdhci_host;
-
-/**
- * struct sdhci_pltfm_data - SDHCI platform-specific information & hooks
- * @ops: optional pointer to the platform-provided SDHCI ops
- * @quirks: optional SDHCI quirks
- * @init: optional hook that is called during device probe, before the
- *        driver tries to access any SDHCI registers
- * @exit: optional hook that is called during device removal
- */
-struct sdhci_pltfm_data {
-	struct sdhci_ops *ops;
-	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
-	void (*exit)(struct sdhci_host *host);
-};
-
-#endif /* _SDHCI_PLTFM_H */
-- 
1.7.1

