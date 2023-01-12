Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD49C46467
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjALCYq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjALCYo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:24:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFD4565B
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:43 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id dw9so16307497pjb.5
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03eAFj9VhLKHE3IgtLCemPDAW1kmJII0gHscpQ7Af5w=;
        b=NaeGT+ZHNnDqVq6wHYwLgqS3MCHmyUtekrP6W+D8fY4wOOETOwqwh9ivS1bP4rnmBj
         pDiu6GOUTHXLIBlINQmoVEwxJdzkei277kLCuTn2AjBapRmjGBnvcXGg8j0eAf6LR3xy
         s92HZ1KtwO2AYF5hKZShi69Xs6r7tSYGQblQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03eAFj9VhLKHE3IgtLCemPDAW1kmJII0gHscpQ7Af5w=;
        b=xjkuVY70EDokhUTfMH/625AfEnnKR482VfWYHfOUkvxk1nbqHogGTc7Sd7NkQFV6NC
         y5AgmjRMc/0Pt3XbVRkNtCzVMC4PCazND/uh12e6q096eZ2eWZlq8a+qQwod7YmRszGD
         IBVTkkh3CYijsOU/gcGyKKzTaIqpm9ldosdY9E6WOC30Vkc2JncuFl4g3vtBZQIGVYqa
         iU1uJhWtIxCirHKEyigzgDvxOFdnNPnH/9inmPpPJZ44g2VShbP9iOdKrVJSgJKjy7Pt
         xATOSseKr7vnBRYyvAyLBari0fQuIwL8VnK30CiAd5d/IyKsDhkk0zlqLfwKxOIjwL0f
         PoXA==
X-Gm-Message-State: AFqh2kpgpiz9M1Bl5mqJGjWKGhDn6LkXH2gRNBGf1saR18OLxS3SASNL
        RPJgdj4DJCoiW/4zGof5aBt70g==
X-Google-Smtp-Source: AMrXdXueLe3ArJ0YcRr4V8ldwL628GLgmHIiB/vcHzF0uEqhpfYdwI+1U07Nt4oSzbXFLjKReQUcHg==
X-Received: by 2002:a17:902:bb97:b0:193:24bf:345e with SMTP id m23-20020a170902bb9700b0019324bf345emr14901419pls.62.1673490283094;
        Wed, 11 Jan 2023 18:24:43 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm10759135pln.294.2023.01.11.18.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:24:42 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 1/8] mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
Date:   Wed, 11 Jan 2023 18:24:09 -0800
Message-Id: <20230112022416.8474-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112022416.8474-1-doug@schmorgal.com>
References: <20230112022416.8474-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a new compatible string for the version 1 controller used in the
PXA168, along with necessary quirks. Use a separate ops struct in
preparation for a silicon bug workaround only necessary on V1.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 40 +++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index f18906b5575f..5707d597ecae 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -101,6 +101,24 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
 }
 
+struct sdhci_pxa_variant {
+	const struct sdhci_ops *ops;
+	unsigned int extra_quirks;
+};
+
+static const struct sdhci_ops pxav1_sdhci_ops = {
+	.set_clock     = sdhci_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width = pxav2_mmc_set_bus_width,
+	.reset         = pxav2_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_pxa_variant __maybe_unused pxav1_variant = {
+	.ops = &pxav1_sdhci_ops,
+	.extra_quirks = SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE,
+};
+
 static const struct sdhci_ops pxav2_sdhci_ops = {
 	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -109,11 +127,14 @@ static const struct sdhci_ops pxav2_sdhci_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pxa_variant pxav2_variant = {
+	.ops = &pxav2_sdhci_ops,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id sdhci_pxav2_of_match[] = {
-	{
-		.compatible = "mrvl,pxav2-mmc",
-	},
+	{ .compatible = "mrvl,pxav1-mmc", .data = &pxav1_variant, },
+	{ .compatible = "mrvl,pxav2-mmc", .data = &pxav2_variant, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
@@ -157,7 +178,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
-	const struct of_device_id *match;
+	const struct sdhci_pxa_variant *variant;
 
 	int ret;
 	struct clk *clk;
@@ -185,10 +206,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 
-	match = of_match_device(of_match_ptr(sdhci_pxav2_of_match), &pdev->dev);
-	if (match) {
+	variant = of_device_get_match_data(dev);
+	if (variant)
 		pdata = pxav2_get_mmc_pdata(dev);
-	}
+	else
+		variant = &pxav2_variant;
+
 	if (pdata) {
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
 			/* on-chip device */
@@ -208,7 +231,8 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 	}
 
-	host->ops = &pxav2_sdhci_ops;
+	host->quirks |= variant->extra_quirks;
+	host->ops = variant->ops;
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
2.34.1

