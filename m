Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44911C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276C36328B
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhHPNAy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:00:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58256 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhHPNAx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 09:00:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 937D52027D2;
        Mon, 16 Aug 2021 15:00:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B5A02027C4;
        Mon, 16 Aug 2021 15:00:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C6650183AC8B;
        Mon, 16 Aug 2021 21:00:18 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code for manual tuning
Date:   Mon, 16 Aug 2021 20:38:23 +0800
Message-Id: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

For manual tuning method, already call esdhc_prepare_tuning()
config the necessary registers, so remove the redundant code
in esdhc_writew_le() for SDHCI_HOST_CONTROL2.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 57b19ca1ad6d..a49fac719fca 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -628,17 +628,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		else
 			new_val &= ~ESDHC_VENDOR_SPEC_VSELECT;
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
-		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
-			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			if (val & SDHCI_CTRL_TUNED_CLK) {
-				new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
-				new_val |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-			} else {
-				new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-				new_val &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-			}
-			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
-		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			if (val & SDHCI_CTRL_TUNED_CLK) {
-- 
2.17.1

