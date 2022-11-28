Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52833C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK1CpD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiK1Co5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:44:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45011478
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p24so5126723plw.1
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmieg4CE/yoWW/WbGieBOpB3jed5cPBDcr27QQC3wwY=;
        b=j08gU2WeURSZo53HKsrDD3F+UwpgZCpHsM0JNBKzw2rqwUKSx2cgEbWfpcscSPe0cI
         x7psbdN4gH4vVgsbQ5cOxtUM/x+MA/loIOmD0qwgid2RrfzeRCfDj2MaziblPJx3dSpK
         FSj+ULhc6NlDCmpju0lwOFO1wU6wGjeuxTWQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmieg4CE/yoWW/WbGieBOpB3jed5cPBDcr27QQC3wwY=;
        b=C8HpltjipYXSqXXRDwTnd6UmfZrO2obEE+z35lir7mTUtV6FnMuRPHCT7pOnHp/qjb
         u0LVvIgl9W4fkXU2i/G4+al/riqZ8g1J1JTpliWP007aEmOi0Wv/L40L3fm4wS3YQWfx
         R4b+TsZtNcq3+PvmZYkrtqBkctpwDl3foCJSsmusrjTiJCdUqsSYa2jLKQA9J5dkCrAG
         fwyZ4Cn1LJBbww/+wG+AYu9jq/yLOj9uCfxKrtl7N9M3l1Yv57Rcc5cyr3kh9ZdyXIfo
         NuxObyn6u8Tz0sC8l23aMp31O5SIJzbYS9jXMnQJZfisQE46q8Wk9nPWAgggaNkqiae0
         RmBw==
X-Gm-Message-State: ANoB5pnjOgg4G6zRzVBxpR5im92mmqPOTiizfB45J3uWVf5GEcG4Di29
        L+ER5YtYzd2WClHU8uyHMEQEvw==
X-Google-Smtp-Source: AA0mqf7LHYFLOyGdWhwGPyihDaFmJjsXwiN/hxawjLBy+DITiSop8QdyRAdyrn9GBIk3a1Zw+Dk25w==
X-Received: by 2002:a17:90a:8a07:b0:20a:c032:da66 with SMTP id w7-20020a17090a8a0700b0020ac032da66mr56668781pjn.19.1669603494767;
        Sun, 27 Nov 2022 18:44:54 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:44:54 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 5/8] mmc: sdhci-pxav2: add optional core clock
Date:   Sun, 27 Nov 2022 18:44:04 -0800
Message-Id: <20221128024407.224393-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128024407.224393-1-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
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
index a0c882d03d0b..4996d72c6d23 100644
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
@@ -179,6 +183,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxav2_host *pxav2_host;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	const struct of_device_id *match;
@@ -186,11 +191,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
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
@@ -207,6 +213,15 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
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
@@ -243,17 +258,34 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
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
@@ -262,7 +294,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove		= sdhci_pxav2_remove,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
-- 
2.34.1

