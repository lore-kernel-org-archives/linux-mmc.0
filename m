Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB1C4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 10:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFKk7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 05:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKFKk7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 05:40:59 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11134FA;
        Mon,  6 Nov 2023 02:40:53 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3A6AeZRI049532;
        Mon, 6 Nov 2023 18:40:35 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SP76T0Zynz2M0tVJ;
        Mon,  6 Nov 2023 18:35:45 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 6 Nov
 2023 18:40:33 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <zhang.lyra@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH] mmc: sdhci-sprd: Fix the clock switch
Date:   Mon, 6 Nov 2023 18:40:18 +0800
Message-ID: <20231106104018.29179-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 3A6AeZRI049532
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some SOCs have a "1x_enable" clock that needs to be turned on and off
in probe, remove and runtime pm.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6b84ba27e6ab..3367f924dc5b 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -83,6 +83,7 @@ struct sdhci_sprd_host {
 	u32 version;
 	struct clk *clk_sdio;
 	struct clk *clk_enable;
+	struct clk *clk_1x_enable;
 	struct clk *clk_2x_enable;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_uhs;
@@ -784,6 +785,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	}
 	sprd_host->clk_enable = clk;
 
+	clk = devm_clk_get(&pdev->dev, "1x_enable");
+	if (!IS_ERR(clk))
+		sprd_host->clk_1x_enable = clk;
+
 	clk = devm_clk_get(&pdev->dev, "2x_enable");
 	if (!IS_ERR(clk))
 		sprd_host->clk_2x_enable = clk;
@@ -793,12 +798,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		goto pltfm_free;
 
 	ret = clk_prepare_enable(sprd_host->clk_enable);
+	if (ret)
+		goto clk_sdio_disable;
+
+	ret = clk_prepare_enable(sprd_host->clk_1x_enable);
 	if (ret)
 		goto clk_disable;
 
 	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
 	if (ret)
-		goto clk_disable2;
+		goto clk_1x_disable;
 
 	sdhci_sprd_init_config(host);
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
@@ -858,10 +867,13 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
-clk_disable2:
-	clk_disable_unprepare(sprd_host->clk_enable);
+clk_1x_disable:
+	clk_disable_unprepare(sprd_host->clk_1x_enable);
 
 clk_disable:
+	clk_disable_unprepare(sprd_host->clk_enable);
+
+clk_sdio_disable:
 	clk_disable_unprepare(sprd_host->clk_sdio);
 
 pltfm_free:
@@ -878,6 +890,7 @@ static void sdhci_sprd_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
+	clk_disable_unprepare(sprd_host->clk_1x_enable);
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	sdhci_pltfm_free(pdev);
@@ -900,6 +913,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
+	clk_disable_unprepare(sprd_host->clk_1x_enable);
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	return 0;
@@ -915,10 +929,14 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(sprd_host->clk_enable);
+	ret = clk_prepare_enable(sprd_host->clk_1x_enable);
 	if (ret)
 		goto clk_2x_disable;
 
+	ret = clk_prepare_enable(sprd_host->clk_enable);
+	if (ret)
+		goto clk_1x_disable;
+
 	ret = clk_prepare_enable(sprd_host->clk_sdio);
 	if (ret)
 		goto clk_disable;
@@ -931,6 +949,9 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 clk_disable:
 	clk_disable_unprepare(sprd_host->clk_enable);
 
+clk_1x_disable:
+	clk_disable_unprepare(sprd_host->clk_1x_enable);
+
 clk_2x_disable:
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
-- 
2.17.1

