Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF9C47083
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Jun 2021 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C36613F3
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Jun 2021 19:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFBTbH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:31:07 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:43734 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhFBTbH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jun 2021 15:31:07 -0400
Received: by mail-pg1-f171.google.com with SMTP id e22so3088835pgv.10;
        Wed, 02 Jun 2021 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzS7P5N5k8NA+I80eCjz5cao0sI4VjQkYkjsy3xGV2s=;
        b=XcmgsIbVOf1QZ7uTKgEMHSEjQ/6DN5FscfTVPa5dfmC9xGud8OWTtoQAmFp+yvb6GV
         rrgTaYQfEUwx1J19VajRnvPqP4cWtj3l2EJ9eb5Omx6+4k6XCpbK5daqPgiRuceV4x3t
         UIj5IgTSA7/0vU0CRrJYc5i9Hf3uPNH0+oGGjWtTRBZOC4dva5uHfKic/fOnmH2wUbgo
         uqAsaSBMeMYlCQZ6Sv2rytprJh5h8UES/7GU0N4Xy2VSya1yCix2S4Z3OrF8OSiymw/F
         9uw7qPSSvZ5hqprNEK3CAUKyhvLQhPheW5C20N2nFy7j1jF+QnTLIN8yTj8bUpWZFYcm
         73LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzS7P5N5k8NA+I80eCjz5cao0sI4VjQkYkjsy3xGV2s=;
        b=HCIeYiU0xwImUquIxfzyvQKUdtgRPvCLZmmMUvd87diLLuCAXEkGYAGs+w7Z8Lhmn8
         6tT2Bb+tuDmZBlOwnSXLCCd1ok8SP/00IhzBFrHn2y5yNA+6nVHtdZKgQBScAYUVYqiq
         iVtx89sqAMKOZKglo/pU/eDnu+2yX78PnM8+bUpQl1WWKfdwDwXpvTfoA37JAtB/c8X2
         hGcs6Od0fx+Fo8i5D4hDtojAuxxB+26AkLBcC6Ya8ISiCufk3YL2i4NT8jEFHupjSopZ
         Qq1ZjwVZ6NrJsRM0IVCpzrp2jIrAS+JRyEXpoMQH+4odG8sh1kbIGYFOEMwCuUPn/lLe
         5/0g==
X-Gm-Message-State: AOAM533l9m/4/lbDNjlEXMyb1eTSFVgdTQ7+btwcLWu6Nz+i45Nv25FN
        EfTDHFU4rHSfr4bZQUNz6aUPS/Fa65/kriUw
X-Google-Smtp-Source: ABdhPJzuX7PTrVxOwtB9BNIY51BbJrzkNV8t51Kl5odDi2X2XBDtb7Ecu3lYfyLom7NDDesosLlwyA==
X-Received: by 2002:a63:5a19:: with SMTP id o25mr35092339pgb.122.1622662103231;
        Wed, 02 Jun 2021 12:28:23 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m134sm349882pfd.148.2021.06.02.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:28:22 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211
Date:   Wed,  2 Jun 2021 15:27:58 -0400
Message-Id: <20210602192758.38735-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602192758.38735-1-alcooperx@gmail.com>
References: <20210602192758.38735-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for the legacy Arasan sdhci controller on the BCM7211 and
related SoC's. This includes adding a .shutdown callback to increase
the power savings during S5.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/Kconfig       |  2 +-
 drivers/mmc/host/sdhci-iproc.c | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h       |  2 ++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a4d4c757eea0..561184fa7eb9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -412,7 +412,7 @@ config MMC_SDHCI_MILBEAUT
 
 config MMC_SDHCI_IPROC
 	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
-	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
+	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || ARCH_BRCMSTB || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	depends on OF || ACPI
 	default ARCH_BCM_IPROC
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index ddeaf8e1f72f..cce390fe9cf3 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -286,11 +286,35 @@ static const struct sdhci_iproc_data bcm2711_data = {
 	.mmc_caps = MMC_CAP_3_3V_DDR,
 };
 
+static const struct sdhci_pltfm_data sdhci_bcm7211a0_pltfm_data = {
+	.quirks = SDHCI_QUIRK_MISSING_CAPS |
+		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		SDHCI_QUIRK_BROKEN_DMA |
+		SDHCI_QUIRK_BROKEN_ADMA,
+	.ops = &sdhci_iproc_ops,
+};
+
+#define BCM7211A0_BASE_CLK_MHZ 100
+static const struct sdhci_iproc_data bcm7211a0_data = {
+	.pdata = &sdhci_bcm7211a0_pltfm_data,
+	.caps = ((BCM7211A0_BASE_CLK_MHZ / 2) << SDHCI_TIMEOUT_CLK_SHIFT) |
+		(BCM7211A0_BASE_CLK_MHZ << SDHCI_CLOCK_BASE_SHIFT) |
+		((0x2 << SDHCI_MAX_BLOCK_SHIFT)
+			& SDHCI_MAX_BLOCK_MASK) |
+		SDHCI_CAN_VDD_330 |
+		SDHCI_CAN_VDD_180 |
+		SDHCI_CAN_DO_SUSPEND |
+		SDHCI_CAN_DO_HISPD,
+	.caps1 = SDHCI_DRIVER_TYPE_C |
+		 SDHCI_DRIVER_TYPE_D,
+};
+
 static const struct of_device_id sdhci_iproc_of_match[] = {
 	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
 	{ .compatible = "brcm,bcm2711-emmc2", .data = &bcm2711_data },
 	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
 	{ .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
+	{ .compatible = "brcm,bcm7211a0-sdhci", .data = &bcm7211a0_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
@@ -384,6 +408,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void sdhci_iproc_shutdown(struct platform_device *pdev)
+{
+	sdhci_pltfm_suspend(&pdev->dev);
+}
+
 static struct platform_driver sdhci_iproc_driver = {
 	.driver = {
 		.name = "sdhci-iproc",
@@ -394,6 +423,7 @@ static struct platform_driver sdhci_iproc_driver = {
 	},
 	.probe = sdhci_iproc_probe,
 	.remove = sdhci_pltfm_unregister,
+	.shutdown = sdhci_iproc_shutdown,
 };
 module_platform_driver(sdhci_iproc_driver);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0770c036e2ff..c35ed4be75b7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -201,8 +201,10 @@
 
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK		GENMASK(5, 0)
+#define  SDHCI_TIMEOUT_CLK_SHIFT 0
 #define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
 #define  SDHCI_CLOCK_BASE_MASK		GENMASK(13, 8)
+#define  SDHCI_CLOCK_BASE_SHIFT	8
 #define  SDHCI_CLOCK_V3_BASE_MASK	GENMASK(15, 8)
 #define  SDHCI_MAX_BLOCK_MASK	0x00030000
 #define  SDHCI_MAX_BLOCK_SHIFT  16
-- 
2.17.1

