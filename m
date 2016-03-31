From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: exynos: add the function for controlling SMU
Date: Thu, 31 Mar 2016 14:53:18 +0900
Message-ID: <1459403598-5256-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36747 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbcCaFxW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2016 01:53:22 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O4W01JOH30VO480@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Mar 2016 14:53:19 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Some of Exynos has the Security management Unit(SMU).
This patch adds the function for controlling SMU.

In future, if exynos needs to control SMU, it can be implemented
in "config_smu" function, not "init" function.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 8790f2a..0e989eb 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -91,10 +91,14 @@ static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
 		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL)) + 1;
 }
 
-static int dw_mci_exynos_priv_init(struct dw_mci *host)
+static void dw_mci_exynos_config_smu(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
+	/*
+	 * If Exynos is provided the Security management,
+	 * set for non-ecryption mode at this time.
+	 */
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
 		mci_writel(host, MPSBEGIN0, 0);
@@ -104,6 +108,13 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 			   SDMMC_MPSCTRL_VALID |
 			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
 	}
+}
+
+static int dw_mci_exynos_priv_init(struct dw_mci *host)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+
+	dw_mci_exynos_config_smu(host);
 
 	if (priv->ctrl_type >= DW_MCI_TYPE_EXYNOS5420) {
 		priv->saved_strobe_ctrl = mci_readl(host, HS400_DLINE_CTRL);
@@ -169,7 +180,7 @@ static int dw_mci_exynos_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
-	dw_mci_exynos_priv_init(host);
+	dw_mci_exynos_config_smu(host);
 	return dw_mci_resume(host);
 }
 
-- 
1.9.1

