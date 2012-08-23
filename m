From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/5] mmc: dw-mmc: add the header file for exynos specific code.
Date: Thu, 23 Aug 2012 20:31:51 +0900
Message-ID: <503614A7.3050004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22746 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab2HWLcK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 07:32:10 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M97003JZHD7JN00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:07 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9700DAAHDIFX10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:07 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/mmc/exynos-dw_mmc.h |   55 +++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/mmc/exynos-dw_mmc.h

diff --git a/include/linux/mmc/exynos-dw_mmc.h b/include/linux/mmc/exynos-dw_mmc.h
new file mode 100644
index 0000000..03444c2
--- /dev/null
+++ b/include/linux/mmc/exynos-dw_mmc.h
@@ -0,0 +1,55 @@
+/*
+ * Synopsys DesignWare Multimedia Card Interface driver
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header file for Exynos specific register
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _EXYNOS_DW_MMC_H
+#define _EXYNOS_DW_MMC_H
+#include <linux/mmc/dw_mmc.h>
+#include <linux/mmc/host.h>
+
+#define SDMMC_EXYNOS_CLKSEL	0x09C
+
+#define SDMMC_GET_CLK_DRV(x)		((x) >> 16 & 0x7)
+#define SDMMC_GET_CLK_SAMPLE(x)		((x) & 0x7)
+#define SDMMC_CLK_RESET_DRV_SAMPLE	(0x00070007);
+
+#define mci_readl(dev, reg)			\
+	__raw_readl((dev)->regs + SDMMC_##reg)
+#define mci_writel(dev, reg, value)			\
+	__raw_writel((value), (dev)->regs + SDMMC_##reg)
+
+static inline int exynos_get_clk_drv(struct dw_mci *host)
+{
+	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
+}
+
+static inline int exynos_get_clk_sample(struct dw_mci *host)
+{
+	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
+}
+
+static inline void exynos_set_clk_drv_sample(struct dw_mci *host,
+		struct mmc_ios *ios)
+{
+	u32 regs;
+
+	regs = mci_readl(host, EXYNOS_CLKSEL);
+	regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
+	if (ios->timing == MMC_TIMING_UHS_DDR50)
+		regs |= host->pdata->ddr_timing;
+	else
+		regs |= host->pdata->sdr_timing;
+
+	mci_writel(host, EXYNOS_CLKSEL, regs);
+}
+
+#endif /* _EXYNOS_DW_MMC_H */
-- 
1.7.4.1
