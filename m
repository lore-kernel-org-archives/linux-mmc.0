From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 3/3] mmc: dw_mmc: exynos: move definitions to header file
Date: Mon, 22 Dec 2014 17:42:04 +0530
Message-ID: <1419250324-11743-4-git-send-email-alim.akhtar@samsung.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15484 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbaLVMUE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 07:20:04 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGZ0069ZGXEYX00@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Dec 2014 21:20:02 +0900 (KST)
In-reply-to: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, linux-arm-kernel@lists.infradead.org

From: Seungwon Jeon <tgih.jun@samsung.com>

Move exynos related definition to header file. And this
also changes some of the registers name to match the standard
naming convention.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
[Alim: updated the commit message]
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   48 ++++----------------------------
 drivers/mmc/host/dw_mmc-exynos.h |   56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 42 deletions(-)
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.h

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 556663f..f936704 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -21,43 +21,7 @@
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
-
-#define NUM_PINS(x)			(x + 2)
-
-#define SDMMC_CLKSEL			0x09C
-#define SDMMC_CLKSEL64			0x0A8
-#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
-#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
-#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
-#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
-#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
-					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
-					SDMMC_CLKSEL_CCLK_DIVIDER(z))
-#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
-
-#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
-#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
-
-/* Block number in eMMC */
-#define DWMCI_BLOCK_NUM		0xFFFFFFFF
-
-#define SDMMC_EMMCP_BASE	0x1000
-#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
-#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
-#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
-#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
-
-/* SMU control bits */
-#define DWMCI_MPSCTRL_SECURE_READ_BIT		BIT(7)
-#define DWMCI_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
-#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
-#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
-#define DWMCI_MPSCTRL_USE_FUSE_KEY		BIT(3)
-#define DWMCI_MPSCTRL_ECB_MODE			BIT(2)
-#define DWMCI_MPSCTRL_ENCRYPTION		BIT(1)
-#define DWMCI_MPSCTRL_VALID			BIT(0)
-
-#define EXYNOS_CCLKIN_MIN	50000000	/* unit: HZ */
+#include "dw_mmc-exynos.h"
 
 /* Variations in Exynos specific dw-mshc controller */
 enum dw_mci_exynos_type {
@@ -114,11 +78,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
 		mci_writel(host, MPSBEGIN0, 0);
-		mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
-		mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
-			   DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
-			   DWMCI_MPSCTRL_VALID |
-			   DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
+		mci_writel(host, MPSEND0, SDMMC_ENDING_SEC_NR_MAX);
+		mci_writel(host, MPSCTRL0, SDMMC_MPSCTRL_SECURE_WRITE_BIT |
+			   SDMMC_MPSCTRL_NON_SECURE_READ_BIT |
+			   SDMMC_MPSCTRL_VALID |
+			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
 	}
 
 	return 0;
diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
new file mode 100644
index 0000000..7872ce5
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-exynos.h
@@ -0,0 +1,56 @@
+/*
+ * Exynos Specific Extensions for Synopsys DW Multimedia Card Interface driver
+ *
+ * Copyright (C) 2012-2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _DW_MMC_EXYNOS_H_
+#define _DW_MMC_EXYNOS_H_
+
+/* Extended Register's Offset */
+#define SDMMC_CLKSEL			0x09C
+#define SDMMC_CLKSEL64			0x0A8
+
+/* CLKSEL register defines */
+#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
+#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
+#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
+#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
+#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
+					 SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
+					 SDMMC_CLKSEL_CCLK_DIVIDER(z))
+#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
+
+/* Protector Register */
+#define SDMMC_EMMCP_BASE	0x1000
+#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
+#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
+#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
+#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
+
+/* SMU control defines */
+#define SDMMC_MPSCTRL_SECURE_READ_BIT		BIT(7)
+#define SDMMC_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
+#define SDMMC_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
+#define SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
+#define SDMMC_MPSCTRL_USE_FUSE_KEY		BIT(3)
+#define SDMMC_MPSCTRL_ECB_MODE			BIT(2)
+#define SDMMC_MPSCTRL_ENCRYPTION		BIT(1)
+#define SDMMC_MPSCTRL_VALID			BIT(0)
+
+/* Maximum number of Ending sector */
+#define SDMMC_ENDING_SEC_NR_MAX	0xFFFFFFFF
+
+/* Fixed clock divider */
+#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
+#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
+
+/* Minimal required clock frequency for cclkin, unit: HZ */
+#define EXYNOS_CCLKIN_MIN	50000000
+
+#endif /* _DW_MMC_EXYNOS_H_ */
-- 
1.7.9.5

