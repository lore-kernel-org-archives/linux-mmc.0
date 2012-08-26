From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v4 7/9] mmc: dw_mmc: prepare functions in dw_mmc-pltfm for reuse
Date: Sun, 26 Aug 2012 17:22:05 +0530
Message-ID: <1345981927-26359-8-git-send-email-thomas.abraham@linaro.org>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33063 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab2HZLe1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Aug 2012 07:34:27 -0400
In-reply-to: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

Platform implementations of dw-mshc controller may choose to extend the features
of the standard dw-mshc controller such as adding additional clocking options or
modifying the bus interface. Support for such implementation specific extensions
can be incorporated into dw_mmc-pltfm, but including multiple such platform
specific implementations would convolute the existing dw_mmc-pltfm code.

Instead, it would be better to create implementation specific platform drivers
to support implementation specific features. Such platforms drivers can reuse
the existing infrastructure in dw_mmc-pltfm for resource identification and
controller registration and provide support for implementation specific
features. So, allow the infrastructure in dw_mmc-pltfm to be reused by other
implementation specific platform drivers.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   14 +++++++++++---
 drivers/mmc/host/dw_mmc-pltfm.h |   19 +++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mmc/host/dw_mmc-pltfm.h

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 25c5f11..57df3eb 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -23,7 +23,7 @@
 
 #include "dw_mmc.h"
 
-static int dw_mci_pltfm_probe(struct platform_device *pdev)
+int dw_mci_pltfm_register(struct platform_device *pdev)
 {
 	struct dw_mci *host;
 	struct resource	*regs;
@@ -52,8 +52,14 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 	ret = dw_mci_probe(host);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
+
+static int dw_mci_pltfm_probe(struct platform_device *pdev)
+{
+	return dw_mci_pltfm_register(pdev);
+}
 
-static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
+int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
@@ -61,6 +67,7 @@ static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
 	dw_mci_remove(host);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
 
 #ifdef CONFIG_PM_SLEEP
 /*
@@ -94,7 +101,8 @@ static int dw_mci_pltfm_resume(struct device *dev)
 #define dw_mci_pltfm_resume	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
+SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
new file mode 100644
index 0000000..5618608
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -0,0 +1,19 @@
+/*
+ * Synopsys DesignWare Multimedia Card Interface Platform driver
+ *
+ * Copyright (C) 2012, Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _DW_MMC_PLTFM_H_
+#define _DW_MMC_PLTFM_H_
+
+extern int dw_mci_pltfm_register(struct platform_device *pdev);
+extern int __exit dw_mci_pltfm_remove(struct platform_device *pdev);
+extern const struct dev_pm_ops dw_mci_pltfm_pmops;
+
+#endif /* _DW_MMC_PLTFM_H_ */
-- 
1.6.6.rc2

