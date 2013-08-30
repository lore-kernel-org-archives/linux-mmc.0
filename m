From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 02/22] mmc: dw_mmc: Add exynos resume_noirq callback to clear
 WAKEUP_INT
Date: Sat, 31 Aug 2013 00:11:21 +0900
Message-ID: <000501cea593$2f8f0240$8ead06c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38433 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3H3PLX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:11:23 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00MXHNIYZRP0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:11:22 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Doug Anderson <dianders@chromium.org>

If the WAKEUP_INT is asserted at wakeup and not cleared, we'll end up
looping around forever.  This has been seen to happen on exynos5420
silicon despite the fact that we haven't enabled any wakeup events due
to a silicon errata.  It is safe to do on all exynos variants.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   53 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 6a1fa21..2f28dd8 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -30,6 +30,7 @@
 #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
 					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
 					SDMMC_CLKSEL_CCLK_DIVIDER(z))
+#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
 
 #define EXYNOS4210_FIXED_CIU_CLK_DIV	2
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
@@ -105,6 +106,49 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int dw_mci_exynos_suspend(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+
+	return dw_mci_suspend(host);
+}
+
+static int dw_mci_exynos_resume(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+
+	return dw_mci_resume(host);
+}
+
+/**
+ * dw_mci_exynos_resume_noirq - Exynos-specific resume code
+ *
+ * On exynos5420 there is a silicon errata that will sometimes leave the
+ * WAKEUP_INT bit in the CLKSEL register asserted.  This bit is 1 to indicate
+ * that it fired and we can clear it by writing a 1 back.  Clear it to prevent
+ * interrupts from going off constantly.
+ *
+ * We run this code on all exynos variants because it doesn't hurt.
+ */
+
+static int dw_mci_exynos_resume_noirq(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	u32 clksel;
+
+	clksel = mci_readl(host, CLKSEL);
+	if (clksel & SDMMC_CLKSEL_WAKEUP_INT)
+		mci_writel(host, CLKSEL, clksel);
+
+	return 0;
+}
+#else
+#define dw_mci_exynos_suspend		NULL
+#define dw_mci_exynos_resume		NULL
+#define dw_mci_exynos_resume_noirq	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
 	/*
@@ -194,13 +238,20 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
+const struct dev_pm_ops dw_mci_exynos_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
+	.resume_noirq = dw_mci_exynos_resume_noirq,
+	.thaw_noirq = dw_mci_exynos_resume_noirq,
+	.restore_noirq = dw_mci_exynos_resume_noirq,
+};
+
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
 	.remove		= __exit_p(dw_mci_pltfm_remove),
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.of_match_table	= dw_mci_exynos_match,
-		.pm		= &dw_mci_pltfm_pmops,
+		.pm		= &dw_mci_exynos_pmops,
 	},
 };
 
-- 
1.7.0.4


