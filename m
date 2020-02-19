Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86696C3404D
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE724656
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBSIb7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:31:59 -0500
Received: from inva021.nxp.com ([92.121.34.21]:38518 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgBSIbw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C9BF920054C;
        Wed, 19 Feb 2020 09:31:50 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E2522031A5;
        Wed, 19 Feb 2020 09:31:47 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 97EBA402ED;
        Wed, 19 Feb 2020 16:31:41 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 10/14] mmc: sdhci-esdhc-imx: Add an new esdhc_soc_data for i.MX8MM
Date:   Wed, 19 Feb 2020 16:25:53 +0800
Message-Id: <1582100757-20683-5-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add new esdhc_soc_data, with compatible string "fsl,imx8mm-usdhc".

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 98b91b6ff2a9..100c081cfcae 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -255,6 +255,14 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
 };
 
+static struct esdhc_soc_data usdhc_imx8mm_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_CQHCI
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -304,6 +312,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
 	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
+	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
-- 
2.17.1

