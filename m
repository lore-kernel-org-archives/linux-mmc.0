Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178BDC432BE
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE026610A7
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHRLjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:39:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41152 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235627AbhHRLjW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 07:39:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90887205147;
        Wed, 18 Aug 2021 13:38:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58A1C201500;
        Wed, 18 Aug 2021 13:38:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9841183AD05;
        Wed, 18 Aug 2021 19:38:45 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/6] mmc: host: sdhci-esdhc-imx.c: disable auto-tuning when necessary
Date:   Wed, 18 Aug 2021 19:16:53 +0800
Message-Id: <1629285415-7495-4-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add a method to enable/disable auto-tuning function. auto-tuning function
is conflict with sdio interrupt. For sdio device with sdio interrupt,
need to disable auto-tuning function.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f18d169bc8ff..3af6519c561b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -226,6 +226,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	bool broken_auto_tuning;	/* Disable the auto tuning circuit */
 };
 
 struct esdhc_soc_data {
@@ -672,8 +673,10 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
-				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-				usdhc_auto_tuning_mode_sel(host);
+				if (!imx_data->boarddata.broken_auto_tuning) {
+					usdhc_auto_tuning_mode_sel(host);
+					m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+				}
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -1041,13 +1044,16 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 
 static void esdhc_post_tuning(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 reg;
 
-	usdhc_auto_tuning_mode_sel(host);
-
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+	if (!imx_data->boarddata.broken_auto_tuning) {
+		usdhc_auto_tuning_mode_sel(host);
+		reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+	}
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
@@ -1522,7 +1528,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
 	of_property_read_u32(np, "fsl,tuning-start-tap",
 			     &boarddata->tuning_start_tap);
-
+	if (of_property_read_bool(np, "fsl,broken-auto-tuning"))
+		boarddata->broken_auto_tuning = true;
 	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
 				&boarddata->strobe_dll_delay_target);
 	if (of_find_property(np, "no-1-8-v", NULL))
-- 
2.17.1

