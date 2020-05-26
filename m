Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25989C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F177B20776
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 08:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEZIlC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 04:41:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33854 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEZIlC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 04:41:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 450B2200043;
        Tue, 26 May 2020 10:41:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7403E2002F8;
        Tue, 26 May 2020 10:40:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 85C3E402BC;
        Tue, 26 May 2020 16:40:51 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: add wakeup feature for GPIO CD pin
Date:   Tue, 26 May 2020 16:30:39 +0800
Message-Id: <1590481839-28603-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When use the specific GPIO to detect the card insert/remove, we can
also add the GPIO as a wakeup source. When system suspend, insert or
remove the card can wakeup the system.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5398af4824c3..7af9d87d4245 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1599,6 +1599,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
+
+		/* GPIO CD can be set as a wakeup source */
+		host->mmc->caps |= MMC_CAP_CD_WAKE;
+		device_init_wakeup(&pdev->dev, true);
+
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
@@ -1734,8 +1739,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 
 	ret = sdhci_suspend_host(host);
-	if (!ret)
-		return pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
+
+	if (device_may_wakeup(dev))
+		ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
 	return ret;
 }
@@ -1759,6 +1771,9 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
+	if (!ret && device_may_wakeup(dev))
+		ret = mmc_gpio_set_cd_wake(host->mmc, false);
+
 	return ret;
 }
 #endif
-- 
2.17.1

