Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4E9C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 18:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiD0SNM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbiD0SNJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 14:13:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E783B865;
        Wed, 27 Apr 2022 11:09:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k29so2035790pgm.12;
        Wed, 27 Apr 2022 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kh0Z24nrRo8CulmjggTjYpsy8ADRv1RHCAkzggFzOqo=;
        b=YO+hX3FejKiIUcQuPKn3jM/NlPS0bWPcFDmA0FyymXXFEDz5EBkuVvoiTMZysYoIzx
         aTu3yjhUia/vlFzbv0uCGKYFDGhrmxay5qwqEc5wv+AbaQL3TwtllZS3bQUZjcxnAoRG
         mTqBeu2U6nqsTDriKcR0efkJAgXSgXnISpvQIRbgrOH/coQIr13tfBF2LEZqCqwQeXj3
         9l54DNeS1HmS5JjbXKxtyrHkLOJoE8vJWKzP5RpHQ3g/sX18sRKJ0dnirmH54255xZQw
         LSaDP8KjXx3hIigZMm4tD00baD9061wnVRHVrJ2DN3AUBPqsgyfH9zp3/2DV6XySEJ7J
         /i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kh0Z24nrRo8CulmjggTjYpsy8ADRv1RHCAkzggFzOqo=;
        b=wPCPf1DSwsh+Y1YKsS2zDBABy2mR7A0xqmH1lsuzbMubeH4mU01kV3PepnLu6EOt4T
         zPdqjROMDPQnkWjr1r0C7bhB1YXc1BSxNAPXOkxobLBsSXZacPwgLArsYqzdDI0q3fZo
         oYdvQroIs+hDJ/qRt2h+EHerrX/Mvs6dO/weVgAL4CmkZUoG5cUiOaaAuHHBX3TBxJfF
         xlnVywArAbCJoNQj1n0UdsVFaUfvw4Vtrkk+SGXXQOm7kEOQYFJIGa/996SXjCRtxSkV
         +Z/oLuW1UUE3QDASeA28AV1cXbQ3+63fFGuNa8RpQc5OmLqlIBsbkhTzsQmK2xPvxW2L
         vQDw==
X-Gm-Message-State: AOAM532IDIY7ocG2IiqN5M3GpXWuMbRi7+6/0b+SttU7YREGQ4388x23
        YHvPWAbL+fL2V4deRnPHp+fo+JBJoVg=
X-Google-Smtp-Source: ABdhPJzTXl8P7AReCze57oFAZkussRWXMGswCH8kafFEZ+A1oHWoazDMMoQdqoPoYoo1f2sn7V11Tg==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr31215863pfb.84.1651082979701;
        Wed, 27 Apr 2022 11:09:39 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm19076859pfm.158.2022.04.27.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:09:39 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 2/4] mmc: sdhci-brcmstb: Enable Clock Gating to save power
Date:   Wed, 27 Apr 2022 14:08:51 -0400
Message-Id: <20220427180853.35970-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427180853.35970-1-kdasu.kdev@gmail.com>
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 35 +++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 244780481193..683d0c685748 100644
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

