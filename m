Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97010C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiD0SNL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbiD0SM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 14:12:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C19F40932;
        Wed, 27 Apr 2022 11:09:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r83so2071471pgr.2;
        Wed, 27 Apr 2022 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3ZPy72isW7ZeQco5IszI5xB15RJ/hq79xgf0sAxg2Q=;
        b=ZNZb9yYVRp907PC/hNoiB8mJwf8khL5iRjNByuh7CnsHcFskVirxwKO76kNBfc1Fx+
         fqtI7gTHStyrva6LL8r/Vwy9NSPwjQYIB/aP4XH64DZrJ2gvGKdsiKKAlnmIKeGUtzL7
         NJ1PbX/kW/L4ayZ/FZ0GrVoxZiu5qbKuxyW5TZEJdUgHWY7eG3x8zH5ANcUQvKHcqCBP
         L178BI5nTE0N7lHIF9Zno/7wBu3fzTSNeADyaB9heZSizW8+0MppfWsLDYdL6Q7E/NHf
         gQHkiHDI5PjBtBuhfasXF/+6SK+ZW+/UmeMfSqRBDJg1abCxCWYTWhMbkE5/HqB1l2PB
         MLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g3ZPy72isW7ZeQco5IszI5xB15RJ/hq79xgf0sAxg2Q=;
        b=NWr6SXMFg6pWjpsO8z/dcOMcsxJy4C0IoX9QW6JogcOl+oPnxDp/p+tN0v8uVR5Ezm
         SV5QhVpSFZ96YGMWResLnmlqrLu5y3eqh99iI1BrEaesZ3GooJ+0ojLA6TVMVLymOZEl
         PNE7hynTmZxSzPYW2AWjRdWNv1kPqYLaxNx1XKked/dQPYLLqqmk/aN6Eb0DNeudDHYo
         pXi2D1lwJB1OVqh3GanH01coVZlj6EJJa/Cmh0N9nGipUJ4zDsaaA3CVNhFOy6aQNzAL
         eXA3l3EPJdg3n3BCunWk3RIeKen8uctajYfDWGQr8kzzfwAwUnGjbgPI5/8HtQWe7khS
         z7GQ==
X-Gm-Message-State: AOAM532mzNT7djcCGJKN3WoL/LCEttiKlcdZUOBmYM0ufYdo3/Y2GVzh
        XmwtrJ5QKNLvtODvvQzq+yY=
X-Google-Smtp-Source: ABdhPJy2dGvu08NyuZWfqZFsBJjlHr2Q0lInD5fNyMMCV69XyoFCx9L+5NSkmmqjj5NVeDW5u8mKQQ==
X-Received: by 2002:a05:6a00:1da0:b0:50d:4d87:566e with SMTP id z32-20020a056a001da000b0050d4d87566emr12449745pfw.13.1651082974661;
        Wed, 27 Apr 2022 11:09:34 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm19076859pfm.158.2022.04.27.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:09:34 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 1/4] mmc: sdhci-brcmstb: Re-organize flags
Date:   Wed, 27 Apr 2022 14:08:50 -0400
Message-Id: <20220427180853.35970-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427180853.35970-1-kdasu.kdev@gmail.com>
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

Re-organize the flags by basing the bit names on the flag that they
apply to. Also change the "flags" member in the "brcmstb_match_priv"
struct to const.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f24623aac2db..244780481193 100644
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

