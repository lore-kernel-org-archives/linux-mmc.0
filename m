Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8DCC4167B
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKQS1h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiKQS1d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669618223B;
        Thu, 17 Nov 2022 10:27:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v17so3791465edc.8;
        Thu, 17 Nov 2022 10:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjUGr7WKyo0YyM9ct/ewI14Ht6+vUBDtL7iXa+tGFX0=;
        b=VE68DQNUA9fgfeoMtnDgLEvCxZz0nqb41vOxQQTq3Xukd/rKzPcOYZBnOFTssKsy45
         gCNmF4edoyHWMBd0+s6VjZISHBYFD3bgvWW8mQMI/LXx6LtfxYSiurKh4e+3DmFcoXXk
         uSPJNaG4TSlH4O9CpZM4wi3C4zL/u1rTturVS+qeGNjvFGnN6ACRS3BAMmSpFZmwkHWC
         7k2RTRemeRZn0KaPVRS1eKUxBGsC7IYqJAA5hmEnS1AbUerqnM69kuzvRRvIDgAvm0Nc
         1dy5SoIYEjQ+7Nuf5M1/TIfZLIl+UlWggt3165VMGaf7Lwz/TF6GTJGbY9isv+4ftnqQ
         MZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjUGr7WKyo0YyM9ct/ewI14Ht6+vUBDtL7iXa+tGFX0=;
        b=VePBZxg8b1VlF9Y3jJk+TCBg50pkRs1pAx8twbDDQ5wlI/JOxjKnciNPbbcpqZnEmo
         qvuYNwnC43C8NgstFvgBMnsdQSM8hs83pbqhgKPfjdLnzLodtAzQYGfASYjT/3RwXxUp
         r+LJivFUIkmzk+VtAq+UV+1/7iu/WOJEqYWdWVxtmHVo2NykRmUj3KeApEzHXkwEJ1bo
         AKTaqABjdQNYYBMoKTNwHBK+whCQF2xVc2cYEqvyqIV3HGZvA/qNSGwFV8h6KCgA+S/b
         gutf3hoJEHAMxKVsJkq/XlEJGR59jkOx2b7HR0YDKNObOdkFEIwH8PfDNpetn1ykJXUX
         2ujw==
X-Gm-Message-State: ANoB5pkQpEpi2u1yVzjNUeBxUSeT2krix1luUNv6eNsN5fzX0JHRIT/F
        Bsb0cwQhv216eUSGpaag1uQ=
X-Google-Smtp-Source: AA0mqf4pn3jkO2iFdyU1c2oeforNLqsajAxZI2ywZE8W88J8+PmEZ11WKha9e8CnVPvpFbdkXSe6Iw==
X-Received: by 2002:a05:6402:b50:b0:461:5d0a:78e1 with SMTP id bx16-20020a0564020b5000b004615d0a78e1mr3257910edb.425.1668709649394;
        Thu, 17 Nov 2022 10:27:29 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t5-20020a1709066bc500b007ad94422cf6sm670064ejs.198.2022.11.17.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:28 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v11 5/6] mmc: sdhci-tegra: Add support to program MC stream ID
Date:   Thu, 17 Nov 2022 19:27:19 +0100
Message-Id: <20221117182720.2290761-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117182720.2290761-1-thierry.reding@gmail.com>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

SMMU clients are supposed to program stream ID from
their respective address spaces instead of MC override.
Define NVQUIRK_PROGRAM_STREAMID and use it to program
SMMU stream ID from the SDMMC client address space.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bbe2bc238171..1cb7fd3afa7e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -11,6 +12,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/ktime.h>
 #include <linux/mmc/card.h>
@@ -96,6 +98,8 @@
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
 
+#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
@@ -123,6 +127,7 @@
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
 #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -179,6 +184,7 @@ struct sdhci_tegra {
 	bool enable_hwcq;
 	unsigned long curr_clk_rate;
 	u8 tuned_tap_delay;
+	u32 stream_id;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -1566,6 +1572,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
 		    NVQUIRK_HAS_TMCLK,
 	.min_tap_delay = 95,
 	.max_tap_delay = 111,
@@ -1632,6 +1639,19 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
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
@@ -1692,6 +1712,12 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
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
@@ -1777,6 +1803,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_add_host;
 
+	sdhci_tegra_program_stream_id(host);
+
 	return 0;
 
 err_add_host:
@@ -1873,6 +1901,8 @@ static int sdhci_tegra_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	sdhci_tegra_program_stream_id(host);
+
 	ret = sdhci_resume_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.38.1

