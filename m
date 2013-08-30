From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC V4 4/4] mmc: dw_mmc: exynos: configure SMU in exynos5420.
Date: Fri, 30 Aug 2013 15:17:43 +0530
Message-ID: <1377856063-3391-5-git-send-email-yuvaraj.cd@samsung.com>
References: <1377856063-3391-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54119 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab3H3JsO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 05:48:14 -0400
In-Reply-To: <1377856063-3391-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, alim.akhtar@samsung.com, dianders@chromium.org, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Exynos5420 Mobile Storage Host controller has Security Management Unit
(SMU) for channel 0 and channel 1 (mainly for eMMC).This patch configures
SMU for exynos5420.

This patch is on top of the below patches 
[1]mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT.
[2]ARM: dts: Add dwmmc DT nodes for exynos5420 SOC. 

changes since V3:
	1.Added new compatible string "samsung,exynos5420-dw-mshc-smu" for
	  the host with SMU.
	2.Used compatible string "samsung,exynos5420-dw-mshc-smu"
	  for controller instance which has SMU.
	3.Used compatible string "samsung,exynos5420-dw-mshc"
	  for controller instance which does not have SMU.

changes since V2:
	1.Droppped the bypass-smu quirk.
	2.Changed the subject line for this patch
	  add a quirk for SMU -> configure SMU in exynos5420

changes since V1:
	1.avoid code duplication by calling dw_mci_exynos_priv_init in
	  resume path.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 19c845b..2f6ac82 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -35,12 +35,32 @@
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
+			DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
+			DWMCI_MPSCTRL_VALID |
+			DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
+	}
+
 	return 0;
 }
 
@@ -82,7 +114,8 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250 ||
-		priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420)
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU)
 		host->bus_hz /= (priv->ciu_div + 1);
 	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
 		host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
@@ -107,6 +140,7 @@ static int dw_mci_exynos_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
+	dw_mci_exynos_priv_init(host);
 	return dw_mci_resume(host);
 }
 
@@ -226,6 +260,8 @@ static const struct of_device_id dw_mci_exynos_match[] = {
 			.data = &exynos_drv_data, },
 	{ .compatible = "samsung,exynos5420-dw-mshc",
 			.data = &exynos_drv_data, },
+	{ .compatible = "samsung,exynos5420-dw-mshc-smu",
+			.data = &exynos_drv_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
-- 
1.7.9.5

