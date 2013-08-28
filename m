From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC V3 4/4] mmc: dw_mmc: exynos: configure SMU in exynos5420.
Date: Wed, 28 Aug 2013 17:38:51 +0530
Message-ID: <1377691731-7226-5-git-send-email-yuvaraj.cd@samsung.com>
References: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, alim.akhtar@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Exynos5420 Mobile Storage Host controller has Security Management Unit
(SMU) for channel 0 and channel 1 (mainly for eMMC).This patch configures
SMU for exynos5420.

This patch is on top of the below patch by Doug Anderson.
mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT

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
 drivers/mmc/host/dw_mmc-exynos.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 19c845b..db28f10 100644
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
@@ -74,6 +93,15 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420) {
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
 
@@ -107,6 +135,7 @@ static int dw_mci_exynos_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
+	dw_mci_exynos_priv_init(host);
 	return dw_mci_resume(host);
 }
 
-- 
1.7.9.5
