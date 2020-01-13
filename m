Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2CC33CAF
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774A24655
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imf2N9GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgAMVHz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:07:55 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39443 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgAMVHx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:07:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id e11so3275175pjt.4;
        Mon, 13 Jan 2020 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZCAEUSlUeHjJbOzhybZNdXvqq8RaBrp2R/gTbl2SsA4=;
        b=imf2N9GC3kHPqBbRGoBeoJtgVzok4YeYS3x1fRz8ck7RDWL0pktxyfg99w0VH067cP
         CuA2T30U80nscFo4jgx2jWiI/QlhO0N5HJT7ZMMQb0YlILKo6DefBL+DtkTB7cAybz5H
         scXKuPGm9p+ULT6R1oiWMTPz8YFxw531D4gNlI1L5MZpdlWBx6CweB+22+w5BEyO1YBs
         k6DN0vyNhFKzvzkEHcw+aXvF7FFB++6iDxB4GqfEOKNn8MxkQrsIEaEe/eKCw+lNDBmQ
         3RNOhrmOVYsoAsuDwf4Hw2as4TLZaeKD3WSGcxtHsEFHaBFAQPgnm5A8NnzS66UeTjwn
         cU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZCAEUSlUeHjJbOzhybZNdXvqq8RaBrp2R/gTbl2SsA4=;
        b=sNNK/WJPsZTPrgbxJ7I/YNrR/BFae+eQiNpfilcyXIjVrapq8OBRf2b4tALmKmY579
         mZRKSEDP5/FVIKLJxlpSR9B2+hoXZf8ItRIC3c7yec6btmG+GXVjzQhH52/oRqXjBL98
         Uev8tJgnza9q5oTh6BJe1C1C4CpFNM0KLrkZtZO9SpCg1hjRPt1D8Y/5bgx0MaSN1c0m
         V7DUEPZAwV1jBAFgJKFkqWSAeU1V3F7LqsJXfU0cZ3eCYMwoY8RFnfzS+7cjliWrMEub
         92XCr86iAzpKIp9euJyT/U6rAMDfZCulYbw8xVtgvlbn7OylppsceCLq3eBqAb4U7HdR
         n/RQ==
X-Gm-Message-State: APjAAAUv9XIcXDXwKkIUwt5JQyMVVjYx7pzW4qm4XsoZLpDzYrIpaNNi
        FceynvwIACcKNimjQxXCT+pcoppjXL/mpA==
X-Google-Smtp-Source: APXvYqyErGp9uGm8FttvDm8IHO5klXLdH9nJDmcvZ44xGfQ3O2sLApMIAp/CiMUrsi0IV/v10P7o5g==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr15616765plm.69.1578949672068;
        Mon, 13 Jan 2020 13:07:52 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:07:51 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 2/6] mmc: sdhci-brcmstb: Add ability to use HS400ES transfer mode
Date:   Mon, 13 Jan 2020 16:07:02 -0500
Message-Id: <20200113210706.11972-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The latest eMMC JEDEC specification version 5.1 added a new
transfer mode, HS400 with enhanced strobe (HS400ES). This mode
will be selected if both the host controller and eMMC device
support it. The latest Arasan 5.1 controller in the 7216a0
supports this mode. The "Host Controller Specification" has
not been updated so the controller register bit used to enable
this mode is not specified and varies the with controller vendor.
The Linux SDHCI driver supplies a callback for enabling HS400ES
mode and that callback will be used to supply a routine that
will set the proper bit in the Arasan Vendor register.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 97 ++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 73bb440aaf93..daa89ca232a2 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -9,9 +9,41 @@
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/bitops.h>
 
 #include "sdhci-pltfm.h"
 
+#define SDHCI_VENDOR 0x78
+#define  SDHCI_VENDOR_ENHANCED_STRB 0x1
+
+#define BRCMSTB_PRIV_FLAGS_NO_64BIT		BIT(0)
+#define BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT	BIT(1)
+
+struct sdhci_brcmstb_priv {
+	void __iomem *cfg_regs;
+};
+
+struct brcmstb_match_priv {
+	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
+	unsigned int flags;
+};
+
+static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	u32 reg;
+
+	dev_dbg(mmc_dev(mmc), "%s(): Setting HS400-Enhanced-Strobe mode\n",
+		__func__);
+	reg = readl(host->ioaddr + SDHCI_VENDOR);
+	if (ios->enhanced_strobe)
+		reg |= SDHCI_VENDOR_ENHANCED_STRB;
+	else
+		reg &= ~SDHCI_VENDOR_ENHANCED_STRB;
+	writel(reg, host->ioaddr + SDHCI_VENDOR);
+}
+
 static const struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -23,13 +55,40 @@ static const struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static const struct brcmstb_match_priv match_priv_7425 = {
+	.flags = BRCMSTB_PRIV_FLAGS_NO_64BIT |
+	BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
+};
+
+static const struct brcmstb_match_priv match_priv_7445 = {
+	.flags = BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
+};
+
+static const struct brcmstb_match_priv match_priv_7216 = {
+	.hs400es = sdhci_brcmstb_hs400es,
+};
+
+static const struct of_device_id sdhci_brcm_of_match[] = {
+	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
+	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
+	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
+	{},
+};
+
 static int sdhci_brcmstb_probe(struct platform_device *pdev)
 {
-	struct sdhci_host *host;
+	const struct brcmstb_match_priv *match_priv;
 	struct sdhci_pltfm_host *pltfm_host;
+	const struct of_device_id *match;
+	struct sdhci_brcmstb_priv *priv;
+	struct sdhci_host *host;
+	struct resource *iomem;
 	struct clk *clk;
 	int res;
 
+	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
+	match_priv = match->data;
+
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "Clock not found in Device Tree\n");
@@ -39,36 +98,57 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		return res;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_brcmstb_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_brcmstb_pdata,
+				sizeof(struct sdhci_brcmstb_priv));
 	if (IS_ERR(host)) {
 		res = PTR_ERR(host);
 		goto err_clk;
 	}
 
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	/* Map in the non-standard CFG registers */
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	priv->cfg_regs = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(priv->cfg_regs)) {
+		res = PTR_ERR(priv->cfg_regs);
+		goto err;
+	}
+
 	sdhci_get_of_property(pdev);
 	res = mmc_of_parse(host->mmc);
 	if (res)
 		goto err;
 
+	/*
+	 * If the chip has enhanced strobe and it's enabled, add
+	 * callback
+	 */
+	if (match_priv->hs400es &&
+	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
+		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
+
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
 	 * will allow these modes to be specified by device tree
 	 * properties through mmc_of_parse().
 	 */
 	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-	if (of_device_is_compatible(pdev->dev.of_node, "brcm,bcm7425-sdhci"))
+	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_NO_64BIT)
 		host->caps &= ~SDHCI_CAN_64BIT;
 	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			SDHCI_SUPPORT_DDR50);
-	host->quirks |= SDHCI_QUIRK_MISSING_CAPS |
-		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
+
+	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT)
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	res = sdhci_add_host(host);
 	if (res)
 		goto err;
 
-	pltfm_host = sdhci_priv(host);
 	pltfm_host->clk = clk;
 	return res;
 
@@ -79,11 +159,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	return res;
 }
 
-static const struct of_device_id sdhci_brcm_of_match[] = {
-	{ .compatible = "brcm,bcm7425-sdhci" },
-	{ .compatible = "brcm,bcm7445-sdhci" },
-	{},
-};
 MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 
 static struct platform_driver sdhci_brcmstb_driver = {
-- 
2.17.1

