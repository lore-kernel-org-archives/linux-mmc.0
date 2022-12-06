Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03673C3A5A7
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiLFQ75 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiLFQ7z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B72A241;
        Tue,  6 Dec 2022 08:59:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vp12so7705744ejc.8;
        Tue, 06 Dec 2022 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCJXfYzTI2dyLGbCy2BhHsRfkj/QAMNTLWYIlL2SJZ0=;
        b=HinPoVulLWiuMrle00EXPBrMG8A9+Sk8uxVoxrXc0/0vV3dDhXyhjXB2qTNL1sVrlV
         Cpc103HnzTl3Ocdvf0KQD3PfZlWi17u8ic4bnJltjvNDvicHOhDszJx1nXihGs8QWJwS
         PtCjY0ZluvNVkZMBkG+0NvXSNeGdO6glkJYS8f986N8tgMjl1gdUpvCgscDOruHnaFOv
         vKg6vtBFAW4PiC6ErBWZjJ6dWagnQAo8UvlihTVII+KT/NUgz0ceCl/2cfgFHg8TdCPL
         UjWMlkoYEsDfff+OYTjKVce1W2vkHPOo681MiS4D3GM2VYJIKfd4uAWOhtFMpJf+kEW3
         HDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCJXfYzTI2dyLGbCy2BhHsRfkj/QAMNTLWYIlL2SJZ0=;
        b=3gp//EsQ+bII/zib7qC8oUsaPxHboBRI8TsyeEoPr/El62d9IXfhq33kz9bGKHjuiq
         2TS4zkz4yc4CGS9CbnWolvapS8LN79DFACmz729VqTbbnWCjq8jfUuKbomlmjSw9F0YM
         0KD8SmbkIdnckPmW5wP/4P256cZu54v0tnJxNbrmYBL7NuHQpODbBkNqxwbT+A14bLMW
         Qbv053Hsf6Jb/D53qILTzRS7RfPYb4sODKSsq2if0V3NW5eynqrtMy8up9iMFh75+X/7
         EPOtap8i3FXD3OJ+rM/uGqHlOtxI4nXHKzqVHj7roNKWsSBkJ6f5OcJwM7Pc6mlC/nLE
         hmIg==
X-Gm-Message-State: ANoB5pnzEylxbwCBo3SCsTFhhuh56MvtpcFQXUYjeL9sqayvmsEeiVMC
        xDUga437ZXyFBG+23PjChQQ=
X-Google-Smtp-Source: AA0mqf5vcNP3TAUSeQz0iBOLEYKUJ1Pdk8Ld1sRW+14zAs+Oz19IfFCQud0l4ORoeb5io1a5Ap0SfA==
X-Received: by 2002:a17:906:2854:b0:7ae:3684:84b0 with SMTP id s20-20020a170906285400b007ae368484b0mr65120459ejc.622.1670345992538;
        Tue, 06 Dec 2022 08:59:52 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i4-20020a056402054400b0046c64b0efdbsm1199909edx.33.2022.12.06.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:52 -0800 (PST)
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
Subject: [PATCH v13 4/6] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Tue,  6 Dec 2022 17:59:43 +0100
Message-Id: <20221206165945.3551774-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

Create new SoC data structure for Tegra234 platforms. Additional
features, tap value configurations are added/updated for Tegra234
platform hence separate Tegra194 and Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index afa9cbf9cb6f..f3f5a4abcafb 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1553,7 +1553,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.max_tap_delay = 139,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-- 
2.38.1

