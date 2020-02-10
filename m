Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D58C3B185
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 09:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D8D2080C
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 09:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBJJBy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:01:54 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46136 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgBJJBy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Feb 2020 04:01:54 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 99E051BC62B;
        Mon, 10 Feb 2020 10:01:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2840F1BC60C;
        Mon, 10 Feb 2020 10:01:49 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 989F0402CF;
        Mon, 10 Feb 2020 17:01:44 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v3 02/14] mmc: sdhci-esdhc-imx: no fail when no pinctrl available
Date:   Mon, 10 Feb 2020 16:56:17 +0800
Message-Id: <1581324979-31084-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581324979-31084-1-git-send-email-haibo.chen@nxp.com>
References: <1581324979-31084-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When using jailhouse to support two Linux on i.MX8MQ EVK, we use the
1st Linux to configure pinctrl for the 2nd Linux. Then the 2nd Linux
could use the mmc without pinctrl driver.

So give a warning message when no pinctrl available, but no fail probe.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 382f25b2fa45..8c802681ad2c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1488,7 +1488,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err = PTR_ERR(imx_data->pinctrl);
-		goto disable_ahb_clk;
+		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
 	}
 
 	if (esdhc_is_usdhc(imx_data)) {
-- 
2.17.1

