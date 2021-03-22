Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F1C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A2C61974
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCVJOE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 05:14:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56488 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhCVJNq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 05:13:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B2A9B1A48C0;
        Mon, 22 Mar 2021 10:13:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FF891A05C6;
        Mon, 22 Mar 2021 10:13:42 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D6634402B0;
        Mon, 22 Mar 2021 10:13:37 +0100 (CET)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH] mmc: sdhci-esdhc-imx: make sure ipg clock enabled during suspend/resume
Date:   Mon, 22 Mar 2021 16:59:59 +0800
Message-Id: <1616403599-29650-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

During suspend/resume, need to access usdhc register, so need to enable
IPG clock to avoid bus error.

Find this issue when both enable CONFIG_PM and CONFIG_PM_SLEEP, which
means both support PM and Runtime PM. If the card slot do not insert
a card, then after system boot up, will do sdhci_esdhc_runtime_suspend(),
disable all clocks, include the ipg clock. In this case, when suspend the
system, due to no card present, sdhci_esdhc_runtime_resume() will not be
called before sdhci_esdhc_suspend(), so will meet system hung or bus err
once access usdhc register.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 94327988da91..a48b977ca13f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1695,10 +1695,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	ret = clk_prepare_enable(imx_data->clk_ipg);
+	if (ret)
+		return ret;
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(host->mmc);
 		if (ret)
-			return ret;
+			goto disable_ipg_clk;
 	}
 
 	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
@@ -1712,38 +1716,52 @@ static int sdhci_esdhc_suspend(struct device *dev)
 
 	ret = sdhci_suspend_host(host);
 	if (ret)
-		return ret;
+		goto disable_ipg_clk;
 
 	ret = pinctrl_pm_select_sleep_state(dev);
 	if (ret)
-		return ret;
+		goto disable_ipg_clk;
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
+disable_ipg_clk:
+	clk_disable_unprepare(imx_data->clk_ipg);
+
 	return ret;
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
 	if (ret)
 		return ret;
 
+	ret = clk_prepare_enable(imx_data->clk_ipg);
+	if (ret)
+		return ret;
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
 	ret = sdhci_resume_host(host);
 	if (ret)
-		return ret;
+		goto disable_ipg_clk;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-	if (!ret)
-		ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	if (ret)
+		goto disable_ipg_clk;
+
+	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+
+disable_ipg_clk:
+	clk_disable_unprepare(imx_data->clk_ipg);
 
 	return ret;
 }
-- 
2.17.1

