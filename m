From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 08/22] mmc: dw_mmc: exynos: configure SMU in exynos5420
Date: Sat, 31 Aug 2013 00:12:35 +0900
Message-ID: <000b01cea593$5bccff60$1366fe20$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38528 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab3H3PMh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:12:37 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00MY1NKZZRP0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:12:36 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>

Exynos5420 Mobile Storage Host controller has Security Management
Unit (SMU) for channel 0 and channel 1 (mainly for eMMC).
This time, SMU configuration is set for non-encryption mode.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 37bad61..83405bd 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -35,12 +35,32 @@
 #define EXYNOS4210_FIXED_CIU_CLK_DIV	2
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
+/* Block number in eMMC */
+#define DWMCI_BLOCK_NUM		0xFFFFFFFF
+
+#define SDMMC_EMMCP_BASE	0x1000
+#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
+#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
+#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
+#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
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
 	DW_MCI_TYPE_EXYNOS4412,
 	DW_MCI_TYPE_EXYNOS5250,
 	DW_MCI_TYPE_EXYNOS5420,
+	DW_MCI_TYPE_EXYNOS5420_SMU,
 };
 
 /* Exynos implementation specific driver private data */
@@ -67,6 +87,9 @@ static struct dw_mci_exynos_compatible {
 	}, {
 		.compatible	= "samsung,exynos5420-dw-mshc",
 		.ctrl_type	= DW_MCI_TYPE_EXYNOS5420,
+	}, {
+		.compatible	= "samsung,exynos5420-dw-mshc-smu",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS5420_SMU,
 	},
 };
 
@@ -74,6 +97,15 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU) {
+		mci_writel(host, MPSBEGIN0, 0);
+		mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
+		mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
+			   DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
+			   DWMCI_MPSCTRL_VALID |
+			   DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
+	}
+
 	return 0;
 }
 
@@ -82,7 +114,8 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250 ||
-		priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420)
+	    priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 ||
+	    priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU)
 		host->bus_hz /= (priv->ciu_div + 1);
 	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
 		host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
@@ -104,6 +137,7 @@ static int dw_mci_exynos_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
+	dw_mci_exynos_priv_init(host);
 	return dw_mci_resume(host);
 }
 
@@ -222,6 +256,8 @@ static const struct of_device_id dw_mci_exynos_match[] = {
 			.data = &exynos_drv_data, },
 	{ .compatible = "samsung,exynos5420-dw-mshc",
 			.data = &exynos_drv_data, },
+	{ .compatible = "samsung,exynos5420-dw-mshc-smu",
+			.data = &exynos_drv_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
-- 
1.7.0.4


