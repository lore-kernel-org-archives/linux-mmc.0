Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E5C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 18:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391324AbiDUSbR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391321AbiDUSbR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 14:31:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241AEDFAE;
        Thu, 21 Apr 2022 11:28:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s137so5342462pgs.5;
        Thu, 21 Apr 2022 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CPKL6PLS2hyZUn/37pC34jEUL96YEezJ4fK6yAcdz3U=;
        b=cGu4y6MRjciJ6naClINARIrx1X6zxQzq3dzW52WNR/jIO2DdeoPq1k7LZvqqXwV823
         jmaB57elHt0VHSI+g+zUgiJpc57J0wE9TkVlO5OQIQtZK+1/Lmi/qQKAKFwqRCSwrF8S
         q765lMNfqmh4hM+COy+yzpMqwSsbVIa+qoXEjtfJ81weTbyESIUFvIvKj28rDJlgDH+S
         Tx9ZFENSZ5nl6IeZGNgwVGX2VW4N2bCpgW4kO9zjEPpQhlBOSdVCnUetpVGxQPijHB3E
         LRCnGv+1lWM7Rm08VUR0zIztC14IBbAW3Wp6QBqI4y/Wzc1xryjp8+tQu4CjRIdLyndW
         k1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CPKL6PLS2hyZUn/37pC34jEUL96YEezJ4fK6yAcdz3U=;
        b=V4OxQi/UYflLLFl4K17VkO0mPNwjOhro+f5l0r5KvJIy2GXwbCU7iYQO6AW7UapTmV
         Xf+04DZlz9ddfi9Bavqp1a9H1+fiPfRRiyaPIYPmWphRouWYunbx1lWmvI4JmPh2L9Vv
         jZEdK21Vqdf5f+iUET7ktckiqpWs/ztZZfjmRerrMTU7hSzSVa5GW2iAxzYwY1a2s9tb
         qHFV/tdY6jh1NIXGz5HMDb/0+tiQ5Vpx5a25Ry22cvHDooTCRE1BEK6LQ7C6i82QkrtX
         25DkZjpwIWRB+5tEFuinxhySlC6x/GwP+1Lc7XCFZvExfBJUfZ4lW2dedZ7Pcsfsbdwx
         3Omg==
X-Gm-Message-State: AOAM532t2bT65cCAkaPZHayuC31IttYvZFDptvaq+H1Sf9cyMC/7PtIi
        RhNmgNDG8WK/t3TuMyYuH7k=
X-Google-Smtp-Source: ABdhPJwHtpFLhF3JV7jb9ZgaqCrRrg4VaK87LgaEVhBuj9pyzUfRaR01TvE4rjLhQobLXHL/JoV60Q==
X-Received: by 2002:a65:5c48:0:b0:382:2c7:28e9 with SMTP id v8-20020a655c48000000b0038202c728e9mr646700pgr.472.1650565706727;
        Thu, 21 Apr 2022 11:28:26 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id s62-20020a635e41000000b003a9eb7f65absm6509333pgb.85.2022.04.21.11.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:28:26 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 2/5] mmc: sdhci-brcmstb: Re-organize flags
Date:   Thu, 21 Apr 2022 14:28:00 -0400
Message-Id: <20220421182803.6495-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421182803.6495-1-kdasu.kdev@gmail.com>
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

Re-organize the flags by basing the bit names on the flag that they
apply to. Also change the "flags" member in the "brcmstb_match_priv"
struct to const.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 11037cd14cfa..f32aa045c26d 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -18,20 +18,22 @@
 #define SDHCI_VENDOR 0x78
 #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
 
-#define BRCMSTB_PRIV_FLAGS_NO_64BIT		BIT(0)
-#define BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT	BIT(1)
+#define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
+#define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
+
+#define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
-	bool has_cqe;
+	unsigned int flags;
 };
 
 struct brcmstb_match_priv {
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
 	struct sdhci_ops *ops;
-	unsigned int flags;
+	const unsigned int flags;
 };
 
 static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -134,13 +136,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 };
 
 static struct brcmstb_match_priv match_priv_7425 = {
-	.flags = BRCMSTB_PRIV_FLAGS_NO_64BIT |
-	BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
+	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
+	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
 	.ops = &sdhci_brcmstb_ops,
 };
 
 static struct brcmstb_match_priv match_priv_7445 = {
-	.flags = BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
 	.ops = &sdhci_brcmstb_ops,
 };
 
@@ -176,7 +178,7 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
 	bool dma64;
 	int ret;
 
-	if (!priv->has_cqe)
+	if ((priv->flags & BRCMSTB_PRIV_FLAGS_HAS_CQE) == 0)
 		return sdhci_add_host(host);
 
 	dev_dbg(mmc_dev(host->mmc), "CQE is enabled\n");
@@ -225,7 +227,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_brcmstb_priv *priv;
 	struct sdhci_host *host;
 	struct resource *iomem;
-	bool has_cqe = false;
 	struct clk *clk;
 	int res;
 
@@ -244,10 +245,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 		return res;
 
 	memset(&brcmstb_pdata, 0, sizeof(brcmstb_pdata));
-	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
-		has_cqe = true;
-		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
-	}
 	brcmstb_pdata.ops = match_priv->ops;
 	host = sdhci_pltfm_init(pdev, &brcmstb_pdata,
 				sizeof(struct sdhci_brcmstb_priv));
@@ -258,7 +255,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->has_cqe = has_cqe;
+	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
+		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
+		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
+	}
 
 	/* Map in the non-standard CFG registers */
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -287,14 +287,14 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	 * properties through mmc_of_parse().
 	 */
 	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_NO_64BIT)
+	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_NO_64BIT)
 		host->caps &= ~SDHCI_CAN_64BIT;
 	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
 
-	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT)
+	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	res = sdhci_brcmstb_add_host(host, priv);
-- 
2.17.1

