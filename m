Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281F1C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 18:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391345AbiDUSbX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391321AbiDUSbV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 14:31:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B422BCC;
        Thu, 21 Apr 2022 11:28:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ga4-20020a17090b038400b001d4b33c74ccso4587858pjb.1;
        Thu, 21 Apr 2022 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mxxHlhYNIG4dd3FIR1DSmPfxfi0MyzRVrwtk2D5SO70=;
        b=RxdLGeE8XYHgxJljVAm+AWBFmD6aB+WctKzs5SaWM9HH6YMPD57YSpgi2WhuGj0DyV
         rYTmYoSpypPiAgLZAhv2X+engz8F0b8tJgc/ENDdxvCb1rM2oITYT/YdtirU2z4EN0Wk
         BTaGwTlzC1KkH3g36aJxOztz57jTwJyR67WCCuMNLuGnZ1OQJLjWbHo5bymacR+hSXL2
         o+gFDfdoUetYeQVQev3rhKrOvqJAih9s79BiHHIrxnd/tRL6RPRJimpkbwxgmYhZUpx2
         BYHmwy+iYPGDbF6L/cO7XpzBFO7NJzo1fEDAVWi8a8bEFmrRI9V4k3VWcfgUFc6KJtO2
         NIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mxxHlhYNIG4dd3FIR1DSmPfxfi0MyzRVrwtk2D5SO70=;
        b=XUCV9c+lSOapFQDosRtL+n9K6YwWGigKudhq+MYZ6HAxgCeI/1dMsE8/ciL+RZmXIt
         Eg0hXg++RjgNulnQ69wCcdK1XQVCaHxwdWRSGWuYA5rlTSkSNlkocGtA27/NqO5ToLxU
         6gT8wSSINPHmi4f/bzAW9alx6jXw3UbN7/WrRa6Wfn89s0ORTyX80Xqp/r73qdyK2log
         /OTgd8bxIWwm6h0wWBrIJv5cTQdqftTWjpGG6raXxJ4m0geSosL2e3Qu/JZDwM7+PAob
         wpRBK5D0XmxCVYMPeKqKxDPOOxonHWoPoeYcmStP43WKM4Q+ReuMAVsIZBHkxeILAc2m
         9ZKQ==
X-Gm-Message-State: AOAM533gthB5FwcCDwjI2hS+o1U+KfqCrjq/Q2QEfN18s2xfNYvVmFVV
        jG6CGWWNhBI7tL/RM+wytzY=
X-Google-Smtp-Source: ABdhPJzW3IkNZoDdc/BOxTkma8VNnnhslQRkNi+B8JWEvOJx88gT6NPVZcuQ6DRdIkxKs0aAQEhUvg==
X-Received: by 2002:a17:902:7088:b0:156:1aa9:79eb with SMTP id z8-20020a170902708800b001561aa979ebmr677193plk.71.1650565710635;
        Thu, 21 Apr 2022 11:28:30 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id s62-20020a635e41000000b003a9eb7f65absm6509333pgb.85.2022.04.21.11.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:28:30 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 3/5] mmc: sdhci-brcmstb: Enable Clock Gating to save power
Date:   Thu, 21 Apr 2022 14:28:01 -0400
Message-Id: <20220421182803.6495-4-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421182803.6495-1-kdasu.kdev@gmail.com>
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

Enabling this feature will allow the controller to stop the bus
clock when the bus is idle. The feature is not part of the standard
and is unique to newer Arasan cores and is enabled with a bit in a
vendor specific register. This feature will only be enabled for
non-removable devices because they don't switch the voltage and
clock gating breaks SD Card volatge switching.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 35 +++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f32aa045c26d..d5cb3e8978b2 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -17,11 +17,14 @@
 
 #define SDHCI_VENDOR 0x78
 #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
+#define  SDHCI_VENDOR_GATE_SDCLK_EN 0x2
 
 #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
+#define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
+#define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
@@ -36,6 +39,27 @@ struct brcmstb_match_priv {
 	const unsigned int flags;
 };
 
+static inline void enable_clock_gating(struct sdhci_host *host)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHCI_VENDOR);
+	reg |= SDHCI_VENDOR_GATE_SDCLK_EN;
+	sdhci_writel(host, reg, SDHCI_VENDOR);
+}
+
+void brcmstb_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_reset(host, mask);
+
+	/* Reset will clear this, so re-enable it */
+	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
+		enable_clock_gating(host);
+}
+
 static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -131,7 +155,7 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = brcmstb_reset,
 	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
 };
 
@@ -147,6 +171,7 @@ static struct brcmstb_match_priv match_priv_7445 = {
 };
 
 static const struct brcmstb_match_priv match_priv_7216 = {
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_7216,
 };
@@ -273,6 +298,14 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		goto err;
 
+	/*
+	 * Automatic clock gating does not work for SD cards that may
+	 * voltage switch so only enable it for non-removable devices.
+	 */
+	if ((match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE) &&
+	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
+		priv->flags |= BRCMSTB_PRIV_FLAGS_GATE_CLOCK;
+
 	/*
 	 * If the chip has enhanced strobe and it's enabled, add
 	 * callback
-- 
2.17.1

