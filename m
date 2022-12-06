Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BFC352A1
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiLFQ74 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiLFQ74 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0528E0F;
        Tue,  6 Dec 2022 08:59:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so7748100ejc.3;
        Tue, 06 Dec 2022 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPp9Cr/5MTANMw37JK8xns8WX2phSmr1abYF48ABHTA=;
        b=I2U3B96fMxRAZX8Pf44Ji3P8g484nV4dry9i9zkDsFLeff3UDygTegjEFdxZbSMG7s
         vo+6iC9v/wK/BPe0LRjsKVELItZhFTE0e7BrkmGD2e5LXglAd5jNCJBJlE6ZXiU5Vo5Z
         0UU3N7SDaaaiFSskMGklB3mTCZTxKmezkeRANGMdGOMBYuAv1w8+fAg5ubLJCwoFGiyJ
         TZF+faveqOuCXO+ik4FhcWSgoH6dUOZ2fwE255aFGePN2elCu9G81KP/D/FX3b06RHrm
         D2tZUYRHLiOA2prRX/DeB+mfxxpSQBW/9kLnsO+TZ695jxYdJyt9a7wGJyLWkFyitAb7
         KBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPp9Cr/5MTANMw37JK8xns8WX2phSmr1abYF48ABHTA=;
        b=A0vxTiU3R/9cwGJJy60Upjy8oXuFk2vkHTAoQmulva4buAt3dXBUghnW6vKoFvQI9n
         T6TuvOUS9mpXP6wAUVR1dRof64c8PPf1A84HE/3zB4LRfRGEprlWjCg0wmqkvTTHv7YM
         cootRYHQ6Ice24EAOzdm9zqRC283kL+SkH3pfooltXWvF32AdVGIz42vMsp509AwoIcW
         JjBEjeJJX10BprP6aIDHZ+5I3su43ZgNUJgsmYCIFBA0vBQHOnRQHAno8fMleOKrrxQu
         TY8X7t90jAboDNMgZoWJv8hArjSBJPvsLEiWocyjiZbWN3ZuaXIM1lWuHZzMYQQ1DivN
         bA4Q==
X-Gm-Message-State: ANoB5pkKjx8Q8AQeOtetGFloR2VsADSMCi0Rh3escFlZPHVlYYmwfkPq
        Vi0uBs1f3xI6RDmLMzmANSc=
X-Google-Smtp-Source: AA0mqf6zC4JgWZrt/cpXpmXgBwbWub+NRW62wYFOlq4bE3A2txLO4s5Ea0MdrkQNv+ndH0ccfkRisA==
X-Received: by 2002:a17:906:64e:b0:7b7:c1b9:8cb4 with SMTP id t14-20020a170906064e00b007b7c1b98cb4mr58027663ejb.96.1670345993458;
        Tue, 06 Dec 2022 08:59:53 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bo7-20020a0564020b2700b00463597d2c25sm1181892edb.74.2022.12.06.08.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:53 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v13 5/6] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Tue,  6 Dec 2022 17:59:44 +0100
Message-Id: <20221206165945.3551774-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

SMMU clients are supposed to program stream ID from their respective
address spaces instead of MC override. Define NVQUIRK_PROGRAM_STREAMID
and use it to program SMMU stream ID from the SDMMC client address
space.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f3f5a4abcafb..fb3823c87cb8 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2010 Google, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -10,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/ktime.h>
 #include <linux/mmc/card.h>
@@ -95,6 +97,8 @@
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
 
+#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
@@ -122,6 +126,7 @@
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
 #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -178,6 +183,7 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+	u32 stream_id;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1561,6 +1567,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1627,6 +1634,19 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+/* Program MC streamID for DMA transfers */
+static void sdhci_tegra_program_stream_id(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
+		tegra_sdhci_writel(host, FIELD_PREP(GENMASK(15, 8), tegra_host->stream_id) |
+					 FIELD_PREP(GENMASK( 7, 0), tegra_host->stream_id),
+					 SDHCI_TEGRA_CIF2AXI_CTRL_0);
+	}
+}
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct sdhci_tegra_soc_data *soc_data;
@@ -1687,6 +1707,12 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	tegra_sdhci_parse_dt(host);
 
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID &&
+	    !tegra_dev_iommu_get_stream_id(&pdev->dev, &tegra_host->stream_id)) {
+		dev_warn(mmc_dev(host->mmc), "missing IOMMU stream ID\n");
+		tegra_host->stream_id = 0x7f;
+	}
+
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
 	if (IS_ERR(tegra_host->power_gpio)) {
@@ -1772,6 +1798,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	sdhci_tegra_program_stream_id(host);
+
 	return 0;
 
 err_add_host:
@@ -1868,6 +1896,8 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	sdhci_tegra_program_stream_id(host);
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.38.1

