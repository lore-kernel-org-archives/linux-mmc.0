Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA601C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 12:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BDC20714
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 12:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EAmZMQal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgG0Mrz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:47:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6334 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgG0Mrz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2020 08:47:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1ecced0000>; Mon, 27 Jul 2020 05:47:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 05:47:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 27 Jul 2020 05:47:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 12:47:50 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 27 Jul 2020 12:47:49 +0000
Received: from anrao-ubunu.nvidia.com (Not Verified[10.19.64.172]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1eccf30000>; Mon, 27 Jul 2020 05:47:49 -0700
From:   Aniruddha Rao <anrao@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniruddha Rao <anrao@nvidia.com>
Subject: [PATCH] mmc: tegra: Add Runtime PM callbacks
Date:   Mon, 27 Jul 2020 18:17:16 +0530
Message-ID: <1595854036-15434-1-git-send-email-anrao@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595854061; bh=WolOPBz9JWl3X6ZBkIVDpzlgxsusBYvfIi2mntwl+KQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=EAmZMQalbqRHt8kWeKYXB79Kyel8mpZ5PuJchcHsMew/Zdqw/8wIbKC2a+716oZkA
         RGBF5aIcRQpgQNOVIoa6h28tme8O7bCdh/fGIKbGyxrGoZh0mWSHpypk4D1H14nOwC
         qqpuyC3fSfFpkN4tPyiCZnTjiuWPY2350MqFu4SGHhgOwhFqrx19J7iCkwX2JTm//K
         N0/aBTC499JgNzz8s36S7IWo4/ejabUapWdO4P8gunZq4jnErlTrPCyqP5FUlWiKs8
         0x0Rmbu6F5J2zjl9egkH1HFN183MT3+/UcsEqdOxi7bo33mk0XwLBbf0cQ0Ni7ahQZ
         iDYFFe4xWuLqQ==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add runtime suspend/resume callbacks to save power
when the bus is not in use.
In runtime suspend
- Turn off the SDMMC host CAR clock.
- Turn off the trimmer/DLL circuit(BG) power supply(VREG).
- Turn off the SDMMC host internal clocks.

Re-enable all the disabled clocks/regulators in runtime resume.

Signed-off-by: Aniruddha Rao <anrao@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 149 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0a3f9d0..1b4b245 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -23,6 +23,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
+#include <linux/pm_runtime.h>
 
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -36,6 +37,7 @@
 #define SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE		BIT(5)
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
+#define SDHCI_CLOCK_CTRL_SDMMC_CLK			BIT(0)
 
 #define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
 #define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
@@ -51,6 +53,9 @@
 #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
 #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
 
+#define SDHCI_TEGRA_VENDOR_IO_TRIM_CTRL_0		0x1AC
+#define SDHCI_TEGRA_IO_TRIM_CTRL_0_SEL_VREG_MASK	0x4
+
 #define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
 #define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
 
@@ -113,6 +118,9 @@
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
 
+#define SDHCI_TEGRA_FALLBACK_CLK_HZ			400000
+#define SDHCI_TEGRA_RTPM_MSEC_TMOUT			10
+
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u64 dma_mask;
@@ -743,6 +751,24 @@ static void tegra_sdhci_parse_dt(struct sdhci_host *host)
 	tegra_sdhci_parse_tap_and_trim(host);
 }
 
+static void tegra_sdhci_set_bg_trimmer_supply(struct sdhci_host *host,
+					      bool enable)
+{
+	unsigned int misc_ctrl;
+
+	misc_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_IO_TRIM_CTRL_0);
+	if (enable) {
+		misc_ctrl &= ~(SDHCI_TEGRA_IO_TRIM_CTRL_0_SEL_VREG_MASK);
+		sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_IO_TRIM_CTRL_0);
+		udelay(3);
+		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	} else {
+		misc_ctrl |= (SDHCI_TEGRA_IO_TRIM_CTRL_0_SEL_VREG_MASK);
+		sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_IO_TRIM_CTRL_0);
+		udelay(1);
+	}
+}
+
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -780,6 +806,57 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+static int tegra_sdhci_set_host_clock(struct sdhci_host *host, bool enable)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	u8 vndr_ctrl;
+	int err;
+
+	if (!enable) {
+		dev_dbg(mmc_dev(host->mmc), "Disabling clk\n");
+
+		/*
+		 * Power down BG trimmer supply(VREG).
+		 * Ensure SDMMC host internal clocks are
+		 * turned off before calling this function.
+		 */
+		tegra_sdhci_set_bg_trimmer_supply(host, false);
+
+		/* Update SDMMC host CAR clock status */
+		vndr_ctrl = sdhci_readb(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+		vndr_ctrl &= ~SDHCI_CLOCK_CTRL_SDMMC_CLK;
+		sdhci_writeb(host, vndr_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
+		/* Disable SDMMC host CAR clock */
+		clk_disable_unprepare(pltfm_host->clk);
+	} else {
+		dev_dbg(mmc_dev(host->mmc), "Enabling clk\n");
+
+		/* Enable SDMMC host CAR clock */
+		err = clk_prepare_enable(pltfm_host->clk);
+		if (err) {
+			dev_err(mmc_dev(host->mmc),
+				"clk enable failed %d\n", err);
+			return err;
+		}
+
+		/* Reset SDMMC host CAR clock status */
+		vndr_ctrl = sdhci_readb(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+		vndr_ctrl |= SDHCI_CLOCK_CTRL_SDMMC_CLK;
+		sdhci_writeb(host, vndr_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
+		/*
+		 * Power up BG trimmer supply(VREG).
+		 * Ensure SDMMC host internal clocks are
+		 * turned off before calling this function.
+		 */
+		tegra_sdhci_set_bg_trimmer_supply(host, true);
+	}
+
+	return 0;
+}
+
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1622,7 +1699,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 		goto err_clk_get;
 	}
-	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
 	tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
@@ -1645,16 +1721,29 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	usleep_range(2000, 4000);
 
+	pm_runtime_enable(&pdev->dev);
+	rc = pm_runtime_get_sync(&pdev->dev);
+	if (rc < 0)
+		goto pm_disable;
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 SDHCI_TEGRA_RTPM_MSEC_TMOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
 	rc = sdhci_tegra_add_host(host);
 	if (rc)
 		goto err_add_host;
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err_add_host:
 	reset_control_assert(tegra_host->rst);
+	pm_runtime_put_autosuspend(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
 err_rst_get:
-	clk_disable_unprepare(pltfm_host->clk);
 err_clk_get:
 err_power_req:
 err_parse_dt:
@@ -1679,6 +1768,41 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int sdhci_tegra_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	/* Disable SDMMC internal clock */
+	sdhci_set_clock(host, 0);
+
+	/* Disable SDMMC host CAR clock and BG trimmer supply */
+	return tegra_sdhci_set_host_clock(host, false);
+}
+
+static int sdhci_tegra_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	unsigned int clk;
+	int err = 0;
+
+	/* Clock enable should be invoked with a non-zero freq */
+	if (host->clock)
+		clk = host->clock;
+	else if (host->mmc->ios.clock)
+		clk = host->mmc->ios.clock;
+	else
+		clk = SDHCI_TEGRA_FALLBACK_CLK_HZ;
+
+	/* Enable SDMMC host CAR clock and BG trimmer supply */
+	err = tegra_sdhci_set_host_clock(host, true);
+	if (!err) {
+		/* Re-enable SDMMC internal clock */
+		sdhci_set_clock(host, clk);
+	}
+
+	return err;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
 {
@@ -1686,6 +1810,12 @@ static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
+	if (pm_runtime_status_suspended(dev)) {
+		ret = tegra_sdhci_set_host_clock(host, true);
+		if (ret)
+			return ret;
+	}
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(host->mmc);
 		if (ret)
@@ -1698,8 +1828,7 @@ static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(pltfm_host->clk);
-	return 0;
+	return tegra_sdhci_set_host_clock(host, false);
 }
 
 static int __maybe_unused sdhci_tegra_resume(struct device *dev)
@@ -1708,7 +1837,7 @@ static int __maybe_unused sdhci_tegra_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
-	ret = clk_prepare_enable(pltfm_host->clk);
+	ret = tegra_sdhci_set_host_clock(host, true);
 	if (ret)
 		return ret;
 
@@ -1727,13 +1856,15 @@ static int __maybe_unused sdhci_tegra_resume(struct device *dev)
 suspend_host:
 	sdhci_suspend_host(host);
 disable_clk:
-	clk_disable_unprepare(pltfm_host->clk);
-	return ret;
+	return tegra_sdhci_set_host_clock(host, false);
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
-			 sdhci_tegra_resume);
+const struct dev_pm_ops sdhci_tegra_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_tegra_suspend, sdhci_tegra_resume)
+	SET_RUNTIME_PM_OPS(sdhci_tegra_runtime_suspend,
+			   sdhci_tegra_runtime_resume, NULL)
+};
 
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
-- 
2.7.4

