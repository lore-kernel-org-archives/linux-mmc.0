Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA8C3A5A7
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLBDOG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiLBDOE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:14:04 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1580D49E0
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:14:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 124so3772981pfy.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y22VghNPhGNaubNRJ5w1ZU32tCEMhbhW0ElXOX2vO5Y=;
        b=YSOZoUj6dUY2q541u96Cd/bKtl0KdB811jY/M6Nd488IqnCelmEkJJTx9VKhUi6vw7
         CVYM35cIqoOWwpQJq10e/CY27Bn0mk+0n6aPjv/LKi4jVUu0RkF750tm/Ofb5oEcGJin
         NKQLEzmePRJH5RZSQpPaIaszm3KY24aCCISnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y22VghNPhGNaubNRJ5w1ZU32tCEMhbhW0ElXOX2vO5Y=;
        b=aMzOxGl7Oa1eCJ2avgT2QiLFHX9kST/h7s+ySH6cMbAGem9SjheCdS16UGxDc4P76E
         Md7dFuGrvw4b/oQDqG+8IXg3n2Wempt+nXZV4eTVFEtg9exALuzwmGSnM1qA68LY0zoP
         De7vHBko1T59QekwyYaheKLubpm6lFNJZmXHVf7CQd8Akv9okAgZGTWrYaBZWdeabRCh
         FANFgsFrcU3zr7876IaUCFE3etQHxTzBgOeQRg1C3k6owTcl5KVfFtFwfMowjbQvQDov
         Nb+DZ/dFW/LmIDXi4f+UTdKFCS9ls63RYs6eV9zmuTmIC/RYdgNY0L/tWHaD9Rv2NAg8
         Fr0Q==
X-Gm-Message-State: ANoB5pleqAQvJNeOnmSdj66Unx8OpUJBL1uNlzQ5LknqQlF5jyIv9yqV
        5pc/ZdNPStYHHPvN/E0HzwAgNplQB4PJaRA8BWZNtw==
X-Google-Smtp-Source: AA0mqf50WxAzOBiAl90lZP0H57EBaa1OL/+5YTZY6Ox6TPRTIYzjNWEahEJlYdwknl4uBYMNHjpQ8g==
X-Received: by 2002:a63:f201:0:b0:478:50c9:a6d with SMTP id v1-20020a63f201000000b0047850c90a6dmr12270928pgh.485.1669950841170;
        Thu, 01 Dec 2022 19:14:01 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:14:00 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 5/8] mmc: sdhci-pxav2: add optional core clock
Date:   Thu,  1 Dec 2022 19:13:27 -0800
Message-Id: <20221202031330.94130-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202031330.94130-1-doug@schmorgal.com>
References: <20221202031330.94130-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add ability to have an optional core clock just like the pxav3 driver.
The PXA168 needs this because its SDHC controllers have separate core
and io clocks that both need to be enabled. This also correctly matches
the documented devicetree bindings for this driver.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 40 ++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 509ba5dd4a4a..1f0c3028987a 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -41,6 +41,10 @@
 #define MMC_CARD		0x1000
 #define MMC_WIDTH		0x0100
 
+struct sdhci_pxav2_host {
+	struct clk *clk_core;
+};
+
 static void pxav2_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
@@ -176,6 +180,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxav2_host *pxav2_host;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	const struct of_device_id *match;
@@ -183,11 +188,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	int ret;
 	struct clk *clk;
 
-	host = sdhci_pltfm_init(pdev, NULL, 0);
+	host = sdhci_pltfm_init(pdev, NULL, sizeof(*pxav2_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
+	pxav2_host = sdhci_pltfm_priv(pltfm_host);
 
 	clk = devm_clk_get(dev, "io");
 	if (IS_ERR(clk))
@@ -204,6 +210,15 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	pxav2_host->clk_core = devm_clk_get(dev, "core");
+	if (!IS_ERR(pxav2_host->clk_core)) {
+		ret = clk_prepare_enable(pxav2_host->clk_core);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable core clock\n");
+			goto disable_io_clk;
+		}
+	}
+
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
@@ -240,17 +255,34 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto disable_clk;
+		goto disable_core_clk;
 
 	return 0;
 
-disable_clk:
+disable_core_clk:
+	if (!IS_ERR(pxav2_host->clk_core))
+		clk_disable_unprepare(pxav2_host->clk_core);
+disable_io_clk:
 	clk_disable_unprepare(clk);
 free:
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
+static int sdhci_pxav2_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxav2_host *pxav2_host = sdhci_pltfm_priv(pltfm_host);
+
+	int ret = sdhci_pltfm_unregister(pdev);
+
+	if (!IS_ERR(pxav2_host->clk_core))
+		clk_disable_unprepare(pxav2_host->clk_core);
+
+	return ret;
+}
+
 static struct platform_driver sdhci_pxav2_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav2",
@@ -259,7 +291,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove		= sdhci_pxav2_remove,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
-- 
2.34.1

