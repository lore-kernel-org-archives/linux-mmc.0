From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/6] mmc: sdhci-pltfm: move .h-file into apropriate subdir
Date: Wed, 29 Sep 2010 22:08:00 +0200
Message-ID: <1285790884-3516-3-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34109 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab0I2UIW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 16:08:22 -0400
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

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
index 095ca9d..e95b454 100644
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
index 93a0319..562b929 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -13,7 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/types.h>
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

