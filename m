Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A724C4321E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiLBP1F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiLBP06 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B81D20BB;
        Fri,  2 Dec 2022 07:26:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id td2so12328829ejc.5;
        Fri, 02 Dec 2022 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUewn1AUNXCDBruRDFsIE2JVfskfTWK9MuOJPLZRYu4=;
        b=YSfn9CZ+iPnRjoD7FvrtKCcEI201HWqkaAShkXgrw5hhzs86vVLEldXbjzsCO/XOK4
         9cBcXgjU91/iNYAweTU8cyix01yDGjmLZ4JynBQDj1/1EmJc3q9EhaKqqwtVjA1qdOZX
         YuFHSA3VW6apeEMJA6jYHaA4GYg45YkVK2HylNYT9wFq5ZssmPz4pEEVMTntXhlEa+WR
         z7wl1qUSSs60B8hwaFoqZGiR+g+ujN9PC3ZF8WsxQPAn36RGPbyV2/n50bDaMNcwyRhY
         NjjBOrrQtkUMIT29lYBujjBADDnj1RZhgRTdMV/zv1WmE6p8mHtydEc03kWW/MXt0nW8
         wyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUewn1AUNXCDBruRDFsIE2JVfskfTWK9MuOJPLZRYu4=;
        b=e5aoB38p4ZgWL3FoC0SQteHcW+mrXKWM9S9YMFRwVB1jpWGpH8J07THUVfgIWFUMzN
         6Mty5tdQBMyTh3gx4J9Kp2QvatieZMeu3BPKdw5f0OtBj9mS4/Ca+nR1rwfPaF1Ru570
         qYQ2eQzzVcclcieoB3XCh8Vm1aBafo5t5Ygc2wW93MlzdaEnycfiB9KZGfkFW3aus0vf
         AxDSz1qIJEeNkwFRphjsmW3FbVbv/gCjW8b05DVbOMcAHr78Biuj7Vf21m1YcvCHuIwj
         37RMnEKvn6G4yj7W5lco6erJvmy/XdVBcoU4VxzxQT+h2T+1M4Q+euwy1/MfXGOhOAqy
         vREg==
X-Gm-Message-State: ANoB5pnu57dekNFLeFnsV28DZ6OO53LGUY5eeHIMGoN+UDqJWP8+McSn
        iijfFBMkeWFVEup8uK2bnb8=
X-Google-Smtp-Source: AA0mqf5FnUj8gBTFrpkAkp5Y6sXADRVjcNARijz6JjiUjFT1/xTC76FbssvYEjEq5ls46zjhXj/Dtg==
X-Received: by 2002:a17:906:a157:b0:7a5:7e25:5b11 with SMTP id bu23-20020a170906a15700b007a57e255b11mr59867283ejb.254.1669994815018;
        Fri, 02 Dec 2022 07:26:55 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dn11-20020a05640222eb00b00462bd673453sm3073741edb.39.2022.12.02.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:54 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v12 5/6] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Fri,  2 Dec 2022 16:26:43 +0100
Message-Id: <20221202152644.29450-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202152644.29450-1-thierry.reding@gmail.com>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
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
index f3f5a4abcafb..c17700fa9899 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2010 Google, Inc.
  */
 
+#include <linux/bitops.h>
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

