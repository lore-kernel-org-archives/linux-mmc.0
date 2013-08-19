From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC 3/3] mmc: dw_mmc: exynos: add a quirk for SMU.
Date: Mon, 19 Aug 2013 12:06:16 +0530
Message-ID: <1376894176-2702-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1376894176-2702-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55788 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab3HSGhH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2013 02:37:07 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so4705359pdj.11
        for <linux-mmc@vger.kernel.org>; Sun, 18 Aug 2013 23:37:07 -0700 (PDT)
In-Reply-To: <1376894176-2702-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, thomas.ab@samsung.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Exynos5420 Mobile Storage Host controller has Security Management Unit
(SMU) for channel 0 and channel 1 (mainly for eMMC).This patch adds a
quirk to bypass SMU as it is not being used yet.

This patch is on top of the below patch by Doug Anderson.
mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   41 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c        |    3 +++
 include/linux/mmc/dw_mmc.h       |    2 ++
 3 files changed, 46 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 19c845b..5d82c45 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -35,6 +35,25 @@
 #define EXYNOS4210_FIXED_CIU_CLK_DIV	2
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
+/* Block number in eMMC */
+#define DWMCI_BLOCK_NUM			0xFFFFFFFF
+
+#define SDMMC_EMMCP_BASE		0x1000
+#define SDMMC_MPSECURITY		(SDMMC_EMMCP_BASE + 0x0010)
+#define SDMMC_MPSBEGIN0			(SDMMC_EMMCP_BASE + 0x0200)
+#define SDMMC_MPSEND0			(SDMMC_EMMCP_BASE + 0x0204)
+#define SDMMC_MPSCTRL0			(SDMMC_EMMCP_BASE + 0x020C)
+
+/* SMU control bits */
+#define DWMCI_MPSCTRL_SECURE_READ_BIT		BIT(7)
+#define DWMCI_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
+#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
+#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
+#define DWMCI_MPSCTRL_USE_FUSE_KEY		BIT(3)
+#define DWMCI_MPSCTRL_ECB_MODE			BIT(2)
+#define DWMCI_MPSCTRL_ENCRYPTION		BIT(1)
+#define DWMCI_MPSCTRL_VALID			BIT(0)
+
 /* Variations in Exynos specific dw-mshc controller */
 enum dw_mci_exynos_type {
 	DW_MCI_TYPE_EXYNOS4210,
@@ -74,6 +93,17 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 &&
+		host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU) {
+			mci_writel(host, MPSBEGIN0, 0);
+			mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
+			mci_writel(host, MPSCTRL0,
+			DWMCI_MPSCTRL_SECURE_WRITE_BIT |
+			DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
+			DWMCI_MPSCTRL_VALID |
+			DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
+	}
+
 	return 0;
 }
 
@@ -106,7 +136,18 @@ static int dw_mci_exynos_suspend(struct device *dev)
 static int dw_mci_exynos_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
+	struct dw_mci_exynos_priv_data *priv = host->priv;
 
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 &&
+		host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU) {
+			mci_writel(host, MPSBEGIN0, 0);
+			mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
+			mci_writel(host, MPSCTRL0,
+			DWMCI_MPSCTRL_SECURE_WRITE_BIT |
+			DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
+			DWMCI_MPSCTRL_VALID |
+			DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
+	}
 	return dw_mci_resume(host);
 }
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0c0cada..49df69f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2107,6 +2107,9 @@ static struct dw_mci_of_quirks {
 	}, {
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
+	}, {
+		.quirk	= "bypass-smu",
+		.id	= DW_MCI_QUIRK_BYPASS_SMU,
 	},
 };
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 198f0fa..2d3f83f 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -209,6 +209,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+/*Bypass the Security management unit*/
+#define DW_MCI_QUIRK_BYPASS_SMU			BIT(4)
 
 /* Slot level quirks */
 /* This slot has no write protect */
-- 
1.7.9.5

