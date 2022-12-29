Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7493C46467
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiL2UEy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2UEx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 15:04:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25013F88
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:04:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so19875444pjd.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THu9QMNuJA2VLaqG7RBOupd/FwlnEsHSPzLMTF3bhmM=;
        b=E+kP4To4Zqmzj4VnzgJ7fPeHfDNzUJ5kN99ndY4qRVSFbjiMwEBPI0CMuh5MA9ITBZ
         Lo6LeHpg8JxUxDp+pO+NFqh1DHjCHvP4cytZpfyuC7zp/lxvftZZuACyM4B08QArfUzx
         a1+UHy8ikaWM2TrhR4qSGZvAuWh+9KvMhlynA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THu9QMNuJA2VLaqG7RBOupd/FwlnEsHSPzLMTF3bhmM=;
        b=SZs+B7zYpymsEE2KYxt2quuijMmHACpwW6vZ30Z5OhVg0CcKXNnoO+duxmMZeknf8c
         uAmy9sTPsVqrqdllsrDe8OhWkLD5G9n8eU5NvMqaGNNzYwg7s87PS8MKabQbBMXCBJ7g
         lhmGadbvZ0p55BK+KFna2hAEfUdRaEYL+u7dpXgdQ+KQw5fgAyjsFAnDsnzwlKyFuktY
         FvBJ4aIvyl44HQh9fFL6U6LIuxHdTI9IVFFF0ljazkQhrutrh5VQlBOimgM3drqhmANe
         5+7Ib22a1POPXhhnDHWgzp7beAv1zEliWSKCeHc4Fy8vjCD4rs32LZlmIC+TTjmE06rQ
         5SfA==
X-Gm-Message-State: AFqh2kp/3jTcJ80J+gzg5H3L+4bps9XWf/6IX4DRDgBwaKj/rRbT4441
        o33fl0CsBBjxItwck/p9kdH1Itxeyo+/ljtPYjZxIA==
X-Google-Smtp-Source: AMrXdXuXmlyeuQYOw90K/c3dIQQ7TFZ/gllINgDBn4Z8lOCzZ0Nd+Wwljgg+hiODBHHeoT5T6huhzQ==
X-Received: by 2002:a17:902:c10a:b0:188:bc62:276f with SMTP id 10-20020a170902c10a00b00188bc62276fmr31841494pli.3.1672344291243;
        Thu, 29 Dec 2022 12:04:51 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm13438589plg.124.2022.12.29.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:04:50 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 1/8] mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
Date:   Thu, 29 Dec 2022 12:04:04 -0800
Message-Id: <20221229200411.295339-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
References: <20221229200411.295339-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a new compatible string for the version 1 controller used in the
PXA168, along with necessary quirks. Use a separate ops struct in
preparation for a silicon bug workaround only necessary on V1.

Signed-off-by: Doug Brown <doug@schmorgal.com>
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

